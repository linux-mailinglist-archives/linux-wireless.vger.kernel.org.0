Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF476F6D9
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 03:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjHDBT2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 21:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDBT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 21:19:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B864204
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 18:19:25 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RH7Bg03gWzrRvm;
        Fri,  4 Aug 2023 09:18:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:19:23 +0800
Message-ID: <fae803e7-9131-11bb-ad2d-7a61e76dc9ce@huawei.com>
Date:   Fri, 4 Aug 2023 09:19:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] ath9k: Remove unnecessary ternary operators
Content-Language: en-US
To:     <toke@toke.dk>, <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>
References: <20230731124455.2039184-1-ruanjinjie@huawei.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230731124455.2039184-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping.

On 2023/7/31 20:44, Ruan Jinjie wrote:
> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/wireless/ath/ath9k/eeprom_9287.c  | 3 +--
>  drivers/net/wireless/ath/ath9k/hif_usb.c      | 2 +-
>  drivers/net/wireless/ath/ath9k/htc_drv_main.c | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/eeprom_9287.c b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
> index 3caa149b1013..fd5312c2a7e3 100644
> --- a/drivers/net/wireless/ath/ath9k/eeprom_9287.c
> +++ b/drivers/net/wireless/ath/ath9k/eeprom_9287.c
> @@ -572,8 +572,7 @@ static void ath9k_hw_set_ar9287_power_per_rate_table(struct ath_hw *ah,
>  	}
>  
>  	for (ctlMode = 0; ctlMode < numCtlModes; ctlMode++) {
> -		bool isHt40CtlMode =
> -			(pCtlMode[ctlMode] == CTL_2GHT40) ? true : false;
> +		bool isHt40CtlMode = pCtlMode[ctlMode] == CTL_2GHT40;
>  
>  		if (isHt40CtlMode)
>  			freq = centers.synth_center;
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
> index 27ff1ca2631f..e5414435b141 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
> @@ -1432,7 +1432,7 @@ static void ath9k_hif_usb_disconnect(struct usb_interface *interface)
>  {
>  	struct usb_device *udev = interface_to_usbdev(interface);
>  	struct hif_device_usb *hif_dev = usb_get_intfdata(interface);
> -	bool unplugged = (udev->state == USB_STATE_NOTATTACHED) ? true : false;
> +	bool unplugged = udev->state == USB_STATE_NOTATTACHED;
>  
>  	if (!hif_dev)
>  		return;
> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
> index 51766de5ec3b..44e02cfe2438 100644
> --- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
> @@ -719,7 +719,7 @@ static int ath9k_htc_tx_aggr_oper(struct ath9k_htc_priv *priv,
>  
>  	aggr.sta_index = ista->index;
>  	aggr.tidno = tid & 0xf;
> -	aggr.aggr_enable = (action == IEEE80211_AMPDU_TX_START) ? true : false;
> +	aggr.aggr_enable = action == IEEE80211_AMPDU_TX_START;
>  
>  	WMI_CMD_BUF(WMI_TX_AGGR_ENABLE_CMDID, &aggr);
>  	if (ret)
