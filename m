Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F0A3149CE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBIH5L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 02:57:11 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:53818 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhBIH5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 02:57:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612857406; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=a9x1Xy4EoF2PpiXLDbY9DvFYd5BvzpK3/8L5V1Y4lv0=; b=xcQukn8zdSyaR5at5VxvmZKALaa5y/GlzFSCmKdhgCb/qNhYiuyQoXILdmKP4Hp5Hnllrg2k
 9kyjhIvHiAENW2AUQP2iN2tABky24046F1EJs8dRt0W79uFl1v3orPX0N5GF6Zw2gKSVry8f
 wP7t2+lWkskKpUYnW/YnU9bwvtE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60224023f112b7872ccfa58c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Feb 2021 07:56:19
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E51FFC433ED; Tue,  9 Feb 2021 07:56:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71B2AC433CA;
        Tue,  9 Feb 2021 07:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71B2AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Vsevolod Kozlov <zaba@mm.st>
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wilc1000: Fix use of void pointer as a wrong struct type
References: <YB7gI+c1X633KOde@Vsevolods-Mini.lan>
Date:   Tue, 09 Feb 2021 09:56:13 +0200
In-Reply-To: <YB7gI+c1X633KOde@Vsevolods-Mini.lan> (Vsevolod Kozlov's message
        of "Sat, 6 Feb 2021 20:29:55 +0200")
Message-ID: <871rdpk736.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vsevolod Kozlov <zaba@mm.st> writes:

> ac_classify() expects a struct sk_buff* as its second argument, which is
> a member of struct tx_complete_data. priv happens to be a pointer to
> struct tx_complete_data, so passing it directly to ac_classify() leads
> to wrong behaviour and occasional panics.

A perfect example why void pointers should be avoided.

> Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
> ---
>  drivers/net/wireless/microchip/wilc1000/wlan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
> index c12f27be9f79..04ed52c736ff 100644
> --- a/drivers/net/wireless/microchip/wilc1000/wlan.c
> +++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
> @@ -415,6 +415,7 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
>  	struct txq_entry_t *tqe;
>  	struct wilc_vif *vif = netdev_priv(dev);
>  	struct wilc *wilc;
> +	struct tx_complete_data *tx_data = priv;
>  	u8 q_num;
>  
>  	wilc = vif->wilc;
> @@ -437,7 +438,7 @@ int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buffer,
>  	tqe->priv = priv;
>  	tqe->vif = vif;
>  
> -	q_num = ac_classify(wilc, priv);
> +	q_num = ac_classify(wilc, tx_data->skb);

I think a safer fix would be to change wilc_wlan_txq_add_net_pkt() to
take that struct tx_complete_data *tx_data directly, and not use void
pointer at all. At the same time you could remove the ugly cast from the
caller:

netdev.c:740:   queue_count = wilc_wlan_txq_add_net_pkt(ndev, (void *)tx_data,

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
