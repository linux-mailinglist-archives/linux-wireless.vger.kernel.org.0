Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B31122BF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 07:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLDGCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 01:02:15 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:55238
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbfLDGCO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 01:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575439333;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=DxpPdjalFpCycBaHghtsGIpjsociEMklCJCMREUb6dU=;
        b=XcOV7XI3GTpBqAmCPHoxRpOaLY1jitt+pJ1GaZtYThmIcxB6UtFif75RZ+mr46qT
        uAnLlthTRiGP7K8e2LCKFnUnfn0XAk6k3lIiuOlGdHMA6BeD0PGb63CwT7Tn+WMSzAe
        c19MWPqri1KaAbl7FrIdpQXcP8kHb+Ml7iD8LDXc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575439333;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=DxpPdjalFpCycBaHghtsGIpjsociEMklCJCMREUb6dU=;
        b=B3BCj8dxFKIjWKqX8VPUr5Nn+ixSS5NtkM5vTfMfQIQpzSwx0LQP+QIMhJK/10J3
        uZNQng3fykLkrdFxCpsYFkWZl4RUaWtW1GYtf0KGHNAim8oqjtJyxriy30zSNW3MUGZ
        ZniAyaalIUQg7RhBmCRG2b/0lerEPnJ6tC7SS9WM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 4 Dec 2019 06:02:12 +0000
From:   vthiagar@codeaurora.org
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless-owner@vger.kernel.org
Subject: Re: [RESEND 9/9] ath11k: optimize ath11k_hal_tx_status_parse
In-Reply-To: <20191204053713.3064-10-john@phrozen.org>
References: <20191204053713.3064-1-john@phrozen.org>
 <20191204053713.3064-10-john@phrozen.org>
Message-ID: <0101016ecf807633-d2b1f4c4-7fbe-4a82-a337-1add17ec852b-000000@us-west-2.amazonses.com>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.12.04-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-04 11:07, John Crispin wrote:
> Moving the function into dp_tx.c allows gcc to optimize the code better
> and also avoid chace invalidates and context switches.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp.h     |  2 +-
>  drivers/net/wireless/ath/ath11k/dp_tx.c  | 38 +++++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/hal_tx.c | 43 ------------------------
>  drivers/net/wireless/ath/ath11k/hal_tx.h |  4 ---
>  4 files changed, 37 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.h
> b/drivers/net/wireless/ath/ath11k/dp.h
> index d4011f902930..2f0980f2c762 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.h
> +++ b/drivers/net/wireless/ath/ath11k/dp.h
> @@ -57,7 +57,7 @@ struct dp_rxdma_ring {
>  	int bufs_max;
>  };
> 
> -#define ATH11K_TX_COMPL_NEXT(x)	((x + 1) % DP_TX_COMP_RING_SIZE)
> +#define ATH11K_TX_COMPL_NEXT(x)	(((x) + 1) % DP_TX_COMP_RING_SIZE)
> 
>  struct dp_tx_ring {
>  	u8 tcl_data_ring_id;
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c
> b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 5d6403cf99ab..828f8984235e 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -423,6 +423,37 @@ static void ath11k_dp_tx_complete_msdu(struct 
> ath11k *ar,
>  	rcu_read_unlock();
>  }
> 
> +static inline void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
> +					      struct hal_wbm_release_ring *desc,
> +					      struct hal_tx_status *ts)

The function naming may need to be changed to be consistent with the 
other
functions in the file.

Vasanth
