Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945E72F1176
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbhAKL3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:29:10 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:29200 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbhAKL3K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:29:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610364530; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mg/9TY2PeXTXYCrJie9qWxAY7rXGLEsqFoYplIalncQ=; b=hIg8JsPEnJLgF14QXkisB+m0WDcAJU5RE6kIvzr1xSUfLLJV/RZ3O1624zb9KosGXHbuv95t
 RSqTtLakVnLzKEsthRDPphJ7DdnwpfCbUFOJj8j7wxVCzAidRMVi76L6BixbhZl8ZKrjbGPr
 obeQx6Dbdmkm2bikZhCnI3yHOI8=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ffc36584104d9478d5d7b5a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:28:24
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 297FCC43462; Mon, 11 Jan 2021 11:28:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01BEFC433ED;
        Mon, 11 Jan 2021 11:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01BEFC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 10/13] wcn36xx: Add GTK offload info to WoWLAN resume
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
        <20201228162839.369156-11-bryan.odonoghue@linaro.org>
Date:   Mon, 11 Jan 2021 13:28:20 +0200
In-Reply-To: <20201228162839.369156-11-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 28 Dec 2020 16:28:36 +0000")
Message-ID: <874kjnlnl7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> Having enabled GTK rekey in suspend, we need to extract the replay counter
> from the firmware on resume and perform a ieee80211_gtk_rekey_notify() so
> that the STA remains verified from the perspective of the AP.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/hal.h  |  4 +-
>  drivers/net/wireless/ath/wcn36xx/main.c |  5 +-
>  drivers/net/wireless/ath/wcn36xx/smd.c  | 72 +++++++++++++++++++++++++
>  drivers/net/wireless/ath/wcn36xx/smd.h  |  3 ++
>  4 files changed, 81 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
> index 1f3c2e840232..455143c4164e 100644
> --- a/drivers/net/wireless/ath/wcn36xx/hal.h
> +++ b/drivers/net/wireless/ath/wcn36xx/hal.h
> @@ -4919,7 +4919,7 @@ struct wcn36xx_hal_gtk_offload_rsp_msg {
>  struct wcn36xx_hal_gtk_offload_get_info_req_msg {
>  	struct wcn36xx_hal_msg_header header;
>  	u8 bss_index;
> -};
> +} __packed;
>  
>  struct wcn36xx_hal_gtk_offload_get_info_rsp_msg {
>  	struct wcn36xx_hal_msg_header header;
> @@ -4943,7 +4943,7 @@ struct wcn36xx_hal_gtk_offload_get_info_rsp_msg {
>  	u32 igtk_rekey_count;
>  
>  	u8 bss_index;
> -};
> +} __packed;

Why __packed? Commit log mentions nothing about that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
