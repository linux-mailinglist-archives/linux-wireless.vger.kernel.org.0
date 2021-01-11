Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05882F118D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbhAKLf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:35:57 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:49655 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbhAKLf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:35:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610364933; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=x07+Lq+l+F1IjdXb5xvPCFybbsvjOFso+jA6YcRC+YI=; b=TW4LRBSr5gy1Bi0rbUYcRpCXHuY7kLLTFsMZSpnkwHcCp2dujXbVH3cXrpsw8QIqUkregRsv
 GUfC1yGWWgLo77YMu3kaYUz0LndpjGiUCuOvL+QWqdFEEVvzDKFwe6D/YJDOfIGeL5V6Jr1a
 fzqaSpXX5tkD4nJvCTtddSY25KE=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ffc37e6e53eb5da8c29a59d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:35:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E629FC43462; Mon, 11 Jan 2021 11:35:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EACAAC433CA;
        Mon, 11 Jan 2021 11:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EACAAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 11/13] wcn36xx: Do not suspend if scan in progress
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
        <20201228162839.369156-12-bryan.odonoghue@linaro.org>
Date:   Mon, 11 Jan 2021 13:34:57 +0200
In-Reply-To: <20201228162839.369156-12-bryan.odonoghue@linaro.org> (Bryan
        O'Donoghue's message of "Mon, 28 Dec 2020 16:28:37 +0000")
Message-ID: <87sg77k8pq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> If a scan is in progress do not attempt to enter into suspend. Allow the
> scan process to quiesce before proceeding.
>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[...]

> +bool wcn36xx_smd_is_scanning(struct wcn36xx *wcn)
> +{
> +	bool scanning;
> +
> +	mutex_lock(&wcn->hal_mutex);
> +	scanning = wcn->scanning;
> +	mutex_unlock(&wcn->hal_mutex);
> +
> +	return scanning;
> +}

Instead of having a bool you could use SET_BIT() & co, that way you
don't need this extra function. For example see dev_flags in ath10k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
