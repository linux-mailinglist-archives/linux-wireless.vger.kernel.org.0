Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5422F2039FE
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgFVOvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:51:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17396 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728937AbgFVOvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:51:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592837483; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IOa0t2oIcusYGci2TdyPAuYcm9Jhr9e0dw/UoRzbleY=; b=bWW7txvx9sJ1me7hG6uxpJr0TAkIMWqIJVHv8X4onZx1GrobBYidI7IrmAJByQlbwRGAxrKF
 w8H1GCex81OVX70OjRdPvMF9A46Kj90edikQJrQSWW8dyKifVfl9zkMU+2XsxgL1Y61ciugb
 lDCEn2T3t3UUTl4mVsoKnGboCBc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5ef0c56ae144dd511553026f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:51:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F921C433CA; Mon, 22 Jun 2020 14:51:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F1CEC433C6;
        Mon, 22 Jun 2020 14:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F1CEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH net-next] ath11k: fix uninitialized return in ath11k_spectral_process_data()
References: <20200619142922.GA267142@mwanda>
Date:   Mon, 22 Jun 2020 17:51:16 +0300
In-Reply-To: <20200619142922.GA267142@mwanda> (Dan Carpenter's message of
        "Fri, 19 Jun 2020 14:29:22 +0000 (UTC)")
Message-ID: <87a70vf923.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> There is a success path where "ret" isn't initialized where we never
> have a ATH11K_SPECTRAL_TAG_SCAN_SEARCH and then ret isn't initialized.
>
> Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> index 1c5d65bb411f..bfbf905f7507 100644
> --- a/drivers/net/wireless/ath/ath11k/spectral.c
> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> @@ -677,7 +677,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
>  	u32 data_len, i;
>  	u8 sign, tag;
>  	int tlv_len, sample_sz;
> -	int ret;
> +	int ret = 0;
>  	bool quit = false;

I try to avoid initialising ret variables so I would like find another
way. What about doing this (completely untested!) in the end of the
function:

        return 0;

err:
	kfree(fft_sample);
unlock:
	spin_unlock_bh(&ar->spectral.lock);
	return ret;

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
