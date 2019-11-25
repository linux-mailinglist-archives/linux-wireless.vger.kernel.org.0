Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B371091F0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfKYQgS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:18 -0500
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:34188
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfKYQgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699777;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=hWnueyYXGFK6CrjdtYOICZC/mOdRn+S+oHfieQyu6E4=;
        b=BwONv8DGrgSYcZh5+LMdkWhQ1vQ8oN7GtBYHTkZsNhTewj6igZ/rDUeG9as8oO51
        OrWuM3xsyOhe2vByDtsDXfcIUuCzAvwALHNjp3Lb0PeY2WBGsVFJdytwaU+dHEsvNfN
        82XJEmAV5ud2oyni57ZBGsUggCR/y+C/x77bxw/c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699776;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=hWnueyYXGFK6CrjdtYOICZC/mOdRn+S+oHfieQyu6E4=;
        b=Z1xEQ+alfKUZBzSDox/n/qp4MliqmRhFQ0lLWRhaEJ7XcsAsmsntFDhAQ7VLEtjY
        krqk/lIUqxdz2DDpxbOCDmzVcLKcm8i8WmVe6v0CpuTpH3k55DSXz75oS2+/Zx+wCrF
        LtJ9efEpB007FGds2yDGd6AHvev2XZftrPz9tqOU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2E02C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 0/8] ath11k: first round of post-bringup patches
Date:   Mon, 25 Nov 2019 16:36:16 +0000
Message-ID: <0101016ea36bbb6a-f2383214-ab5a-461b-8b8e-ab608b983ea0-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2019.11.25-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here's first of round of ath11k patches from ath11k-post-bringup
branch[1] which got queued while ath11k was in review. Major features
here are HE and TWT support.

Please review.

Kalle

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-post-bringup


John Crispin (6):
  ath11k: add RX stats support for radiotap
  ath11k: ignore event 0x6017
  ath11k: convert message from info to dbg
  ath11k: add HE support
  ath11k: add TWT support
  ath11k: add spatial reuse support

Tamizh chelvam (2):
  ath11k: fix missed bw conversion in tx completion
  ath11k: Remove dead code while handling amsdu packets

 drivers/net/wireless/ath/ath11k/core.h        |   2 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  51 ++---
 drivers/net/wireless/ath/ath11k/mac.c         | 309 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/mac.h         |   1 +
 drivers/net/wireless/ath/ath11k/reg.c         |   1 +
 drivers/net/wireless/ath/ath11k/wmi.c         | 133 ++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h         | 105 ++++++++-
 8 files changed, 558 insertions(+), 46 deletions(-)

-- 
2.7.4

