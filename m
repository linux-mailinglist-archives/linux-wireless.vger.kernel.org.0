Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E271711857E
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 11:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLJKtD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 05:49:03 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:33116
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbfLJKtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 05:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575974942;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=ZTvrnw66vZ5mdkgMjuRv+ZgzgvVfK3L4RpvS9nWZjNE=;
        b=kSqdAzYk6TOq6A8bMa3OxvSF+Ys1SlACS4E4ImCKm9Z7oXS+9i9ZPDEMHXAJyz7x
        AWoGgfuZGPJn4/QBCL1i6aM0bSPi7aLlH+lUygHW2ju/gMjb2PWUxma+Amu5pKj6dLU
        df3GS1yVkAYdNyIh7favlPJ38HtoHfPq9+RmRCNc=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575974942;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=ZTvrnw66vZ5mdkgMjuRv+ZgzgvVfK3L4RpvS9nWZjNE=;
        b=SnfZ/RzdSBGXGOmKEqZG3xf+9wuk3BFYsG4qiXMcUQWktVbiOAKPUT78Vf+kN8Ei
        7bGmZ5B++6GjeKrwcT4fVzhlSQD6ju3+prN2KwS/qdVWMGWceHuTVj7o4tuvkyFQCUR
        CKNBCG+eYsplVbYNvPkJey5a6nLMgI4TZ2d8Adcs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F0E3C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] mt76: use AC specific reorder timeout
References: <20191209211527.13977-1-markus.theil@tu-ilmenau.de>
Date:   Tue, 10 Dec 2019 10:49:02 +0000
In-Reply-To: <20191209211527.13977-1-markus.theil@tu-ilmenau.de> (Markus
        Theil's message of "Mon, 9 Dec 2019 22:15:27 +0100")
Message-ID: <0101016eef6d37ca-3ecafc5d-7b76-4c84-85e9-8c1388723603-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.10-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Theil <markus.theil@tu-ilmenau.de> writes:

> Before this patch, mt76 handled rx traffic for all TIDs  equally,
> when released from reorder buffer early. This patch uses an AC specific
> reorder timeout, in order to release partial aggregated frames for voice
> or video ACs earlier. For example, ath10k also uses AC specific reorder
> timeouts (reported by firmware in that case).
>
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>

[...]

> +static unsigned long mt76_aggr_tid_to_timeo(u8 tidno)
> +{
> +	const int ieee802_1d_to_ac[8] = {

static const?

> +		IEEE80211_AC_BE,
> +		IEEE80211_AC_BK,
> +		IEEE80211_AC_BK,
> +		IEEE80211_AC_BE,
> +		IEEE80211_AC_VI,
> +		IEEE80211_AC_VI,
> +		IEEE80211_AC_VO,
> +		IEEE80211_AC_VO
> +	};
> +	const int ac_to_timeout[] = {

static const?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
