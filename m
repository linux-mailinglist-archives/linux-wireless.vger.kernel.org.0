Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2710D20D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 08:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfK2Hsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 02:48:55 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:52926
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2Hsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 02:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575013734;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=LJ776+Y1QXpvCW3pDrKuYQJOJASENSQYXUKS6yMqPAc=;
        b=kIHBKkKJ4VqO8lJPgAWSUdtcxeXAzK9ihJUbSevRKZHDO6yXyOHXCHHuoWBzMhBg
        zujnPdCd6M6CXAITqFSoJ5/QVBoH/Gq1D/dAdT8H45VebuXHqhyIq00lDi7rdjbfnYc
        QYehlv7+sFn/jENPNUlFMqliIPxsxHLXZASAI2B0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575013734;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=LJ776+Y1QXpvCW3pDrKuYQJOJASENSQYXUKS6yMqPAc=;
        b=D+sVeIrfBjalnwlRS8Mbo4SVZ3Nnegckk1rY1wQraLsidYbVjAFdNEVwUNmIz0je
        nnt7POVgkNRcOFj5b31Tzyh28C5z+tBOnCImCf6Qa+5hEeFoT0KBfpl933uV7Jyhv+r
        1LrKe6jqvH/C/8aGBPqs40ctxsz9QDvC55wWlBjc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF4F2C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] ath11k: tracing: fix ath11k tracing
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ead3164f5-3135488d-f71b-4fc9-834f-08a735724e15-000000@us-west-2.amazonses.com>
References: <0101016ead3164f5-3135488d-f71b-4fc9-834f-08a735724e15-000000@us-west-2.amazonses.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb6225753-50268bf1-e1cd-45cc-8b65-7d678c5dce1f-000000@us-west-2.amazonses.com>
Date:   Fri, 29 Nov 2019 07:48:54 +0000
X-SES-Outgoing: 2019.11.29-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> Add missing tracing subsystem define.
> 
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

10 patches applied to ath-next branch of ath.git, thanks.

e8da3986570e ath11k: tracing: fix ath11k tracing
d6af906d8307 ath11k: qmi clean up ce and HTC service config update
0c408515cd3b ath11k: qmi clean up in ath11k_qmi_wlanfw_wlan_cfg_send()
d0f390eae072 ath11k: pktlog: fix sending/using the pdev id
f425078b449f ath11k: avoid burst time conversion logic
30679ec40918 ath11k: avoid use_after_free in ath11k_dp_rx_msdu_coalesce API
fe201947f8bd ath11k: update bawindow size in delba process
64f1d7e94daa ath11k: add support for controlling tx power to a station
ba47923974fb ath11k: unlock mutex during failure in qmi fw ready
1cb616a3b497 ath11k: add necessary peer assoc params in wmi dbg

-- 
https://patchwork.kernel.org/patch/11264127/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

