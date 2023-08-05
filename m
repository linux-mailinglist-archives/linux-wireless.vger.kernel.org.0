Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2249277111B
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHERqa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Aug 2023 13:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHERq2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Aug 2023 13:46:28 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 10:46:26 PDT
Received: from mx4.wp.pl (mx1.wp.pl [212.77.101.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36857DD
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 10:46:25 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 7276 invoked from network); 5 Aug 2023 19:39:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1691257183; bh=Wppj8yWeEKbOYFWsV6wOMKJcq3H5+375pJRqqdIxVW8=;
          h=From:To:Cc:Subject;
          b=gYuxQr4wgAqmz1/FzNFLES8NaCwd4OP+9YFiUYtiRw/6lnc+M+vj5ow1co7pmBkzA
           nmaQIXBUF9mrImRFDBQ5PDJIxibRvJdVNxSeVlmTgbiqLX1w27ToP90m1MaCHhYlg9
           9SUsKDQCSuZyo5AksudtRQ9Q94XrnuleaaQGF8XY=
Received: from 89-64-15-58.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.15.58])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <yangshiji66@outlook.com>; 5 Aug 2023 19:39:43 +0200
Date:   Sat, 5 Aug 2023 19:39:43 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>
Subject: Re: [PATCH] wifi: rt2x00: correct MAC_SYS_CTRL register RX mask in
 R-Calibration
Message-ID: <20230805173943.GA350454@wp.pl>
References: <TYAP286MB03150B571B67B896A504AC34BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB03150B571B67B896A504AC34BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-WP-MailID: b4bfe9dbfbd97f9b940656357d45391e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [YXLl]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 05, 2023 at 05:17:28PM +0800, Shiji Yang wrote:
> For MAC_SYS_CTRL register, Bit[2] controls MAC_TX_EN and Bit[3]
> controls MAC_RX_EN (Bit index starts from 0). Therefore, 0x08 is
> the correct mask for RX.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index ff891353c..28d7b4ea4 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -8583,7 +8583,7 @@ static void rt2800_r_calibration(struct rt2x00_dev *rt2x00dev)
>  		rt2x00_warn(rt2x00dev, "Wait MAC Tx Status to MAX !!!\n");
>  
>  	maccfg = rt2800_register_read(rt2x00dev, MAC_SYS_CTRL);
> -	maccfg &= (~0x04);
> +	maccfg &= (~0x08);
>  	rt2800_register_write(rt2x00dev, MAC_SYS_CTRL, maccfg);
>  
>  	if (unlikely(rt2800_wait_bbp_rf_ready(rt2x00dev, MAC_STATUS_CFG_BBP_RF_BUSY_RX)))
> -- 
> 2.39.2
> 
