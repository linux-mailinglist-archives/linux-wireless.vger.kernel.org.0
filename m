Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92B6373DF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 09:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKXI3H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 03:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXI3H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 03:29:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC997DED2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 00:29:06 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oy7bN-00076W-SS; Thu, 24 Nov 2022 09:28:57 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oy7bN-0006DA-A1; Thu, 24 Nov 2022 09:28:57 +0100
Date:   Thu, 24 Nov 2022 09:28:57 +0100
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     tony0620emma@gmail.com, kvalo@kernel.org, neo_jou@realtek.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw88: fix race condition when doing H2C command
Message-ID: <20221124082857.GA23682@pengutronix.de>
References: <20221124064442.28042-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124064442.28042-1-pkshih@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 24, 2022 at 02:44:42PM +0800, Ping-Ke Shih wrote:
> From: Ji-Pin Jou <neo_jou@realtek.com>
> 
> For SDIO/USB interface, since the tranferring speed is slower than
> that in PCIE, it may have race condition when the driver sets down
> H2C command to the FW.
> 
> In the function rtw_fw_send_h2c_command, before the patch, box_reg
> is written first, then box_ex_reg is written. FW starts to work and
> fetch the value of box_ex_reg,  when the most significant byte of
> box_reg(4 bytes) is written. Meanwhile, for SDIO/USB interface,
> since the transferring speed is slow, the driver is still in writing
> the new value of box_ex_reg through the bus, and FW may get the
> wrong value of box_ex_reg at the moment.
> 
> To prevent the above driver/FW racing situation, box_ex_reg is
> written first then box_reg. Furthermore, it is written in 4 bytes at
> a time, instead of written in one byte one by one. It can increase
> the speed for SDIO/USB interface.
> 
> Signed-off-by: Ji-Pin Jou <neo_jou@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

This solves the issue with the RTW88 USB patch set reported here:

https://lore.kernel.org/linux-wireless/20221122145527.GA29978@pengutronix.de/

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/net/wireless/realtek/rtw88/fw.c | 8 +++-----
>  drivers/net/wireless/realtek/rtw88/fw.h | 5 +++++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
> index 0b5f903c0f366..b290811d75e1c 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.c
> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
> @@ -311,10 +311,10 @@ EXPORT_SYMBOL(rtw_fw_c2h_cmd_isr);
>  static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
>  				    u8 *h2c)
>  {
> +	struct rtw_h2c_cmd *h2c_cmd = (struct rtw_h2c_cmd *)h2c;
>  	u8 box;
>  	u8 box_state;
>  	u32 box_reg, box_ex_reg;
> -	int idx;
>  	int ret;
>  
>  	rtw_dbg(rtwdev, RTW_DBG_FW,
> @@ -356,10 +356,8 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
>  		goto out;
>  	}
>  
> -	for (idx = 0; idx < 4; idx++)
> -		rtw_write8(rtwdev, box_reg + idx, h2c[idx]);
> -	for (idx = 0; idx < 4; idx++)
> -		rtw_write8(rtwdev, box_ex_reg + idx, h2c[idx + 4]);
> +	rtw_write32(rtwdev, box_ex_reg, le32_to_cpu(h2c_cmd->msg_ext));
> +	rtw_write32(rtwdev, box_reg, le32_to_cpu(h2c_cmd->msg));
>  
>  	if (++rtwdev->h2c.last_box_num >= 4)
>  		rtwdev->h2c.last_box_num = 0;
> diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
> index a5a965803a3cc..bca610dc99ab7 100644
> --- a/drivers/net/wireless/realtek/rtw88/fw.h
> +++ b/drivers/net/wireless/realtek/rtw88/fw.h
> @@ -81,6 +81,11 @@ struct rtw_c2h_adaptivity {
>  	u8 option;
>  } __packed;
>  
> +struct rtw_h2c_cmd {
> +	__le32 msg;
> +	__le32 msg_ext;
> +} __packed;
> +
>  enum rtw_rsvd_packet_type {
>  	RSVD_BEACON,
>  	RSVD_DUMMY,
> -- 
> 2.25.1
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
