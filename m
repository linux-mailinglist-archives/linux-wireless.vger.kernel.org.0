Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E52DFFAF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 19:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgLUS0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 13:26:45 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:50926 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLUS0o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 13:26:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608575180; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=boae/yFyzMFV2fHDNm4V+5RRF34ofFyV7fKG+W+/I6w=; b=mL+JpQfqs1tzka5Cqrfu/Ld3OfpSKbCo/Litmjmctb+m2tmqXDG/kS7ajUb1PqQRg1G82QYb
 g3IL4LJ3mCjnlZG3NE+3wrU5BB81XD3sDe71toMK2gf+YgtyXrkyWXRBmu3j2RUb/GJhVhoM
 rVfOPEtNXwpa4/tOJSiniBb/MxU=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fe0e8ad3ac69bd6b8afcb07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 18:25:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A6FEC433C6; Mon, 21 Dec 2020 18:25:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE30CC433ED;
        Mon, 21 Dec 2020 18:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE30CC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Isaac Hermida <isaac.hermida@digi.com>
Cc:     <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH][master/pending] ath10k: assign new interfaces type to parent type
References: <20190712100846.11158-1-isaac.hermida@digi.com>
Date:   Mon, 21 Dec 2020 20:25:44 +0200
In-Reply-To: <20190712100846.11158-1-isaac.hermida@digi.com> (Isaac Hermida's
        message of "Fri, 12 Jul 2019 12:08:46 +0200")
Message-ID: <87o8innhhz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Isaac Hermida <isaac.hermida@digi.com> writes:

> This is needed to have the AP mode working for SDIO.
> Tested with lastest master/pending code on a QCA6564 chip with firmware
> firmware-sdio-6.bin_WLAN.RMH.4.4.1-00011-QCARMSWP-2
>
> Signed-off-by: Isaac Hermida <isaac.hermida@digi.com>
> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index e43a566eef77..2c4f8da98b24 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -5150,6 +5150,9 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
>  	arvif->ar = ar;
>  	arvif->vif = vif;
>  
> +	// assign type of the new interface to the parent type (SDIO, PCI, etc)
> +	ar->dev_type = arvif->ar->bus_param.dev_type;

ar->dev_type is unused in ath10k, I don't understand how this patch
could change any functionality.

But I submitted a patch to remove ar->dev_type:

https://lore.kernel.org/ath10k/1608574994-30706-1-git-send-email-kvalo@codeaurora.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
