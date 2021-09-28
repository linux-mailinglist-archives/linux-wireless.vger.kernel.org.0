Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15D541B2C0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 17:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbhI1PQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 11:16:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30682 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241542AbhI1PQu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 11:16:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632842111; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=JDk7dCPVVNhR9ZQSMtm5M00Z4sbXWA4AtO7xCSL/wXg=; b=N35cMXFSe53baRzlWRKUbdfYct4HAGv2LfOOHIVf3EjRZPwhEo4cFYD25HoHe/YhF3zhFGV+
 DBSRT9fPcn33t+gPeuIPO8wqPwMpGRVfKWhBF6+kQNKczIHjD+oNalLFGcrlquZS0ASVZYQv
 C0zUbtxF3nDHV57iA/qjEqfhfGw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6153303d713d5d6f969efcb7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 15:09:49
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17C8DC43460; Tue, 28 Sep 2021 15:09:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DADAC4338F;
        Tue, 28 Sep 2021 15:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8DADAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
Subject: Re: [PATCH 2/3] ath11k: change return buffer manager for QCA6390
References: <20210914163726.38604-1-jouni@codeaurora.org>
        <20210914163726.38604-2-jouni@codeaurora.org>
Date:   Tue, 28 Sep 2021 18:09:41 +0300
In-Reply-To: <20210914163726.38604-2-jouni@codeaurora.org> (Jouni Malinen's
        message of "Tue, 14 Sep 2021 19:37:25 +0300")
Message-ID: <87y27gpwi2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Baochen Qiang <bqiang@codeaurora.org>
>
> QCA6390 firmware uses HAL_RX_BUF_RBM_SW1_BM, not HAL_RX_BUF_RBM_SW3_BM.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -189,6 +189,14 @@ static const struct hal_srng_config hw_srng_config_template[] = {
>  	},
>  };
>  
> +const struct hal_param ath11k_hal_params_ipq8074 = {
> +	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
> +};
> +
> +const struct hal_param ath11k_hal_params_qca6390 = {
> +	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
> +};
> +
>  static int ath11k_hal_alloc_cont_rdp(struct ath11k_base *ab)
>  {
>  	struct ath11k_hal *hal = &ab->hal;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
> index 35ed3a14e200..1bf6e040120f 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.h
> +++ b/drivers/net/wireless/ath/ath11k/hal.h
> @@ -903,6 +903,13 @@ struct ath11k_hal {
>  	int num_shadow_reg_configured;
>  };
>  
> +struct hal_param {
> +	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
> +};
> +
> +extern const struct hal_param ath11k_hal_params_ipq8074;
> +extern const struct hal_param ath11k_hal_params_qca6390;

In the pending branch I renamed these to struct ath11k_hw_hal_params and
moved to hw.c and hw.h, respectively.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
