Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A592D3BBF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 07:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgLIG6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 01:58:11 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:44986 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgLIG6K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 01:58:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607497070; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=C2+xYoctQQS9tcuK+/MAYk2X0Bk6vkGPfvQPX+BJffI=; b=wVL9k7iHlyWu6GZiqjNZR1mkWF2E1ZQufI3HU9sLZ9x5cXhTLVNBvbhCOWeFqZONczSQYlne
 s/oAdXIt0R91HNxVfv7LfbZeWzMDeFyrVxtuB8bA1uFfoQD49i1lkDORtu5ZOTgL6jIfzia/
 eGZLQtM+b5KyFPiR8aZP4hrEMCY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fd075526d5c2f1d20ab3418 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 06:57:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1116EC43461; Wed,  9 Dec 2020 06:57:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 402CAC433CA;
        Wed,  9 Dec 2020 06:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 402CAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] ath11k: fix rmmod failure if qmi sequence fails
References: <1606916215-24643-1-git-send-email-akolli@codeaurora.org>
Date:   Wed, 09 Dec 2020 08:57:17 +0200
In-Reply-To: <1606916215-24643-1-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Wed, 2 Dec 2020 19:06:55 +0530")
Message-ID: <877dprcvqq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> QMI sequence fails if caldata file is not available.
> It is observed that 'rmmod ath11k' fails if qmi message fails.
> With this patch rmmod/insmod is working.
>
> Logs:
> Direct firmware load for IPQ8074/caldata.bin failed with error -2
> Falling back to user helper
> qmi failed to load CAL: IPQ8074/caldata.bin
> qmi failed to load board data file:-11
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01699-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

[...]

> @@ -2637,6 +2643,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
>  					      event_work);
>  	struct ath11k_qmi_driver_event *event;
>  	struct ath11k_base *ab = qmi->ab;
> +	int ret = 0;
>  
>  	spin_lock(&qmi->event_lock);
>  	while (!list_empty(&qmi->event_list)) {
> @@ -2650,19 +2657,20 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
>  
>  		switch (event->type) {
>  		case ATH11K_QMI_EVENT_SERVER_ARRIVE:
> -			ath11k_qmi_event_server_arrive(qmi);
> +			ret = ath11k_qmi_event_server_arrive(qmi);
>  			break;
>  		case ATH11K_QMI_EVENT_SERVER_EXIT:
>  			set_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>  			set_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags);
>  			break;
>  		case ATH11K_QMI_EVENT_REQUEST_MEM:
> -			ath11k_qmi_event_mem_request(qmi);
> +			ret = ath11k_qmi_event_mem_request(qmi);
>  			break;
>  		case ATH11K_QMI_EVENT_FW_MEM_READY:
> -			ath11k_qmi_event_load_bdf(qmi);
> +			ret = ath11k_qmi_event_load_bdf(qmi);
>  			break;
>  		case ATH11K_QMI_EVENT_FW_READY:
> +			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
>  			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
>  				ath11k_hal_dump_srng_stats(ab);
>  				queue_work(ab->workqueue, &ab->restart_work);
> @@ -2688,6 +2696,9 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
>  			break;
>  		}
>  		kfree(event);
> +		if (ret < 0)
> +			set_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
> +

In the pending branch I moved the error handling after the function
calls to make it more visible. Here readibility is more important than
reducing lines of code.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
