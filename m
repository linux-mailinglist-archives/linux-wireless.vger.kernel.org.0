Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9F625F6F6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgIGJ70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:59:26 -0400
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:47006
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728404AbgIGJ7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599472765;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=JzInqYm9ZUQLcviyOpBOXQUG0ckLcRTiW4b6IAeYMZQ=;
        b=RXUO+dMVOCfNlGjxjWVLMPBtBH/pBT8hJT6LxWuVn1l8HW5xMX73QKRygLm+RyfB
        cnCeUPCK8vcd0GL3Jmhl5tIqIexbJO/lP/OYvEU+78GtAyvOVqa8+Xju9rpn8kz0QcG
        JWZADDhRs4NPfU5qskrgr+P0qLCr+d1h45wK5gTE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599472765;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=JzInqYm9ZUQLcviyOpBOXQUG0ckLcRTiW4b6IAeYMZQ=;
        b=icdCRBdXrcea8RikHURXOZXRq5vE0l6EShCn7jdJIztHBihudJS1FKDgy/8v3vtG
        2YPLabriUlnJpVlgq60Tissdgd96JtKBwUpaysWQSj/QgmOk8VaMMvqSIp2kmKs9Emf
        XwP4/WJ16KDXgPB8KqDejrMUQGUJv840CYOsuNQw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9496C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath11k: copy ce service configs to hw_params
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
        <1598287470-1871-3-git-send-email-akolli@codeaurora.org>
Date:   Mon, 7 Sep 2020 09:59:25 +0000
In-Reply-To: <1598287470-1871-3-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Mon, 24 Aug 2020 22:14:29 +0530")
Message-ID: <0101017468018910-6fa654eb-b251-444b-8d31-b66411d18efb-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> No functional changes, added target ce service configurations to hw_params.
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -812,12 +812,6 @@ int ath11k_core_init(struct ath11k_base *ab)
>  		return ret;
>  	}
>  
> -	ret = ath11k_init_hw_params(ab);
> -	if (ret) {
> -		ath11k_err(ab, "failed to get hw params %d\n", ret);
> -		return ret;
> -	}

This is very suspicious.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
