Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EDE25F71E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 12:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgIGKBj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 06:01:39 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:47228
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgIGKBh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599472890;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=82ErSy+nZe31zzLveuOJieHO+e9Ew5NN3AtYSeccm8M=;
        b=LSeyHwlWMtHH+NuCUws7Z6jrjc2xIbrmlMZv5/SAsRf2SgJrYrV5pWB+7OM6O5Bp
        ryKhR0fx3uSFFaauitC1ZU+ZZ3ykGRIzOJxkNKMVhkCNDXFZu27gHzbViDa0mShoy8i
        kJQyR7vjtWB4a4QGlqfJ0ZjPNm46VHXYGOQ4V/Go=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599472890;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=82ErSy+nZe31zzLveuOJieHO+e9Ew5NN3AtYSeccm8M=;
        b=ftNYd6dadruWe8PdZlUBwsA7zW0b3nIQGXuyfhSwCkIAFe1fxF6BMaUpq0EbI/+T
        2b2+5euEiEZTxCCvatC2KUTXMNoJ+Ifi2bvn+G9eLfZZ5qdBlvPdLs3A7uT2F+U6K3A
        H6jLzl2pic8TIkst370A9vihc092cfV35mGVPNwA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE819C4344B
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath11k: add IPQ6018 support
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
        <1598287470-1871-4-git-send-email-akolli@codeaurora.org>
Date:   Mon, 7 Sep 2020 10:01:30 +0000
In-Reply-To: <1598287470-1871-4-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Mon, 24 Aug 2020 22:14:30 +0530")
Message-ID: <0101017468037386-257bc211-f06b-4c45-87ea-aba74c7c68e7-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> IPQ6018 has one 5G and one 2G radio with 2x2,
> shares ipq8074 configurations.
>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>

[...]

> @@ -890,9 +995,15 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
>  		goto err_hal_srng_deinit;
>  	}
>  
> -	ab->hw_params.svc_to_ce_map_len =
> +	if (ab->hw_rev == ATH11K_HW_IPQ8074) {
> +		ab->hw_params.svc_to_ce_map_len =
>  			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
> -	ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
> +		ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
> +	} else if (ab->hw_rev == ATH11K_HW_IPQ6018) {
> +		ab->hw_params.svc_to_ce_map_len =
> +			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq6018);
> +		ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq6018;
> +	}

The idea of having ab->hw_params is to avoid the need for hw_rev
sprinkled all over the code, this here defeats the purpose. I recommend
checking if my proposal from an earlier version is implementable:

"You could copy the map arrays to hw.c, as an example see how
 ath11k_hw_ring_mask_ipq8074 is implemented. That way we don't need any
 new hw_rev checks."


-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
