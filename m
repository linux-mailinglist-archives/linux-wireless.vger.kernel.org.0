Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883E010C592
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfK1JDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 04:03:02 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:34168
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726656AbfK1JDC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 04:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574931781;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=7+3WfUDThcy5JFaqGDBpXisep+WN4mgfduC/GpSjWXo=;
        b=LJ34YoU3fslYFuNlFgu5uZgoWuwQ4uXlnittt7MlmTHXliu6lf5Ip8M6IawDd0p7
        LsmVM+jCTa0NUjZYdoz46sWDqwsxzNmQpJ6d6yi3FbWabHHFOACFoYz2XR72nVgD1Bz
        HEVJZtcA6YZvWAL1NhRg84W5y48m8Wox9GOa4G7M=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574931781;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=7+3WfUDThcy5JFaqGDBpXisep+WN4mgfduC/GpSjWXo=;
        b=fhyo/0GoX6uRQwrhpV+OD66hwosje4UcQkBrrODU/Zgvb1OLE5MdTVaxjqNiDrZj
        zSsaYnctVBkeRj/iZgcqae2FVQOl5NeMyY8nHF0JO4gkyDErhsQXBqCH0eBnBvh7jGi
        nbbcIOd744AeylbVkZ1N1O438ReMVQIPAroBBsTw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        SUBJ_BRKN_WORDNUMS autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDF55C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: nFrom 964f1808c8512d0e99baf48cfa45cf5ee6b41952 Mon Sep 17 00:00:00 2001
References: <0101016eb11a0ada-a650c6a4-f82e-4298-8a5f-a5d16ffa9c4a-000000@us-west-2.amazonses.com>
Date:   Thu, 28 Nov 2019 09:03:01 +0000
In-Reply-To: <0101016eb11a0ada-a650c6a4-f82e-4298-8a5f-a5d16ffa9c4a-000000@us-west-2.amazonses.com>
        (Kalle Valo's message of "Thu, 28 Nov 2019 08:21:44 +0000")
Message-ID: <0101016eb13fd6b4-26288c40-ff2d-49ed-ad3b-5659649c32f6-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.28-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Here's fourth, and last, round of ath11k patches from
> ath11k-post-bringup branch[1] which got queued while ath11k was in
> review.
>
> This time there are various fixes.
>
> Please review.
>
> Kalle
>
>
> John Crispin (1):
>   ath11k: fix indentation in ath11k_mac_prepare_he_mode()
>
> Manikanta Pubbisetty (1):
>   ath11k: fix vht guard interval mapping
>
> Miles Hu (1):
>   ath11k: fix memory leak in monitor mode
>
> Sriram R (1):
>   ath11k: Update tx and rx chain count properly on drv_set_antenna
>
> Vasanthakumar Thiagarajan (2):
>   ath11k: Move mac80211 hw allocation before wmi_init command
>   ath11k: Setup REO destination ring before sending wmi_init command
>
> Venkateswara Naralasetty (3):
>   ath11k: Advertise MPDU start spacing as no restriction
>   ath11k: update tx duration in station info
>   ath11k: Skip update peer stats for management packets

Oops, I had accidentaly added character 'n' to the beginning of the
cover letter and that's why the odd subject. It was supposed to be
'[PATCH 0/9] ath11k: fourth round of post-bringup patches'.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
