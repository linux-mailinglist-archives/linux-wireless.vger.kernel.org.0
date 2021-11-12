Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B909044E351
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 09:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhKLIi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 03:38:26 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:25227 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhKLIi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 03:38:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636706135; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zDBZZqPDeuoxjm1KFejo7u0R55YpZgn4I6H6JDOqu2o=; b=xRw49EO7aFAVmnxw5eH/KAHQh4zAScGJyF/ZKYbltGaQgs4zMW0fpvlCgM1ky6wDG+FERiUp
 P7ZnP9s66tHL6SdCrsiqbzJSY8RcfdUbKa84QKtXQqc5EXTv2TMYTUXmlM9ZFS83FtpS6W8L
 KlqgZtPyYaPT5/ApkXrf31XIn/s=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 618e2757a445961e72b06b66 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 08:35:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63E33C4338F; Fri, 12 Nov 2021 08:35:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D354C4361A;
        Fri, 12 Nov 2021 08:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8D354C4361A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     P Praneesh <ppranees@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: Re: [PATCH v3 03/12] ath11k: modify dp_rx desc access wrapper calls inline
References: <1630560820-21905-1-git-send-email-ppranees@codeaurora.org>
        <1630560820-21905-4-git-send-email-ppranees@codeaurora.org>
Date:   Fri, 12 Nov 2021 10:35:30 +0200
In-Reply-To: <1630560820-21905-4-git-send-email-ppranees@codeaurora.org> (P.
        Praneesh's message of "Thu, 2 Sep 2021 11:03:31 +0530")
Message-ID: <87wnldixf1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P Praneesh <ppranees@codeaurora.org> writes:

> In data path, to reduce the CPU cycles spending on descriptor access
> wrapper function, changed those functions as static inline.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 114 +++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 9a22481..b84c2db 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -20,13 +20,15 @@
>  
>  #define ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
>  
> -static u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
> +static inline
> +u8 *ath11k_dp_rx_h_80211_hdr(struct ath11k_base *ab, struct hal_rx_desc *desc)
>  {
>  	return ab->hw_params.hw_ops->rx_desc_get_hdr_status(desc);
>  }

The compiler does not optimise small static functions like this
automatically to inline? I'm surprised. Or are you using some really old
compiler?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
