Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4610C4DE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfK1IVp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:45 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:54578
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfK1IVp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929304;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=icLdtYByDloZgHkYvLnZ8VPoHt3w2rm5nuzXNih0NGQ=;
        b=KwbejYjFTivtsRAD37yqd2bDKsLxOEO8zQVdUJ6EmxTj0hBwjrRs5cEbKIRjAGA+
        fhh4LOY8x+UIJdcfT/1xQXXOFI9q7v8Ffrl0kHVjv+5/N4+2kYo2tGoJz/rDryC5SFM
        M8LeXJlJFOrvsNKGDl9eg+CKLN/1c8AHghMFvU/s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929304;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=icLdtYByDloZgHkYvLnZ8VPoHt3w2rm5nuzXNih0NGQ=;
        b=SzRSQLy1InAjaX5ebkAtg3pG0J+kvLTRkMbRxc9wf3GzL51R/j3wGV2NBZ4+1d1m
        OVUtM/fLZYmNSi3GW2ZANOYMPkdln3mwmOpPKtvuNk9dRWyPCU8nGy3dF8m0dQyQuTe
        yYXuIwRyRPycDIxR5mDViCU+kP4DdOhjIdO3osF8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE9B1C447AB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: nFrom 964f1808c8512d0e99baf48cfa45cf5ee6b41952 Mon Sep 17 00:00:00 2001
Date:   Thu, 28 Nov 2019 08:21:44 +0000
Message-ID: <0101016eb11a0ada-a650c6a4-f82e-4298-8a5f-a5d16ffa9c4a-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2019.11.28-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here's fourth, and last, round of ath11k patches from
ath11k-post-bringup branch[1] which got queued while ath11k was in
review.

This time there are various fixes.

Please review.

Kalle


John Crispin (1):
  ath11k: fix indentation in ath11k_mac_prepare_he_mode()

Manikanta Pubbisetty (1):
  ath11k: fix vht guard interval mapping

Miles Hu (1):
  ath11k: fix memory leak in monitor mode

Sriram R (1):
  ath11k: Update tx and rx chain count properly on drv_set_antenna

Vasanthakumar Thiagarajan (2):
  ath11k: Move mac80211 hw allocation before wmi_init command
  ath11k: Setup REO destination ring before sending wmi_init command

Venkateswara Naralasetty (3):
  ath11k: Advertise MPDU start spacing as no restriction
  ath11k: update tx duration in station info
  ath11k: Skip update peer stats for management packets

 drivers/net/wireless/ath/ath11k/core.c   |  40 ++++++++---
 drivers/net/wireless/ath/ath11k/core.h   |   1 +
 drivers/net/wireless/ath/ath11k/dp.c     |  10 ++-
 drivers/net/wireless/ath/ath11k/dp.h     |   5 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  |  95 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath11k/dp_rx.h  |   2 +
 drivers/net/wireless/ath/ath11k/hal_rx.c |  16 ++++-
 drivers/net/wireless/ath/ath11k/hal_rx.h |   6 ++
 drivers/net/wireless/ath/ath11k/mac.c    | 116 ++++++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/mac.h    |   3 +-
 10 files changed, 211 insertions(+), 83 deletions(-)

-- 
2.7.4

