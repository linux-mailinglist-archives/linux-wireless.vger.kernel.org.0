Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0990E10B0DB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0OIq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:46 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:34200
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfK0OIq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863725;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=aIj7nzLay9iEOLJMRq4RsRPW9XMEtdFOI6JAYVZMHAs=;
        b=hgz5lKveQaiikRD7ksbtDAK1l5krrY9AXhJnXy5I9s0nUqbKmdevOW1k4rhjH+FW
        f1P10Mfbknyi9ue6cT8hfT0Iei3gN5FKCdIhXXqvPFRXGW668WGao6tGRUwc4CekONm
        MfxJojBz9nMLrK/hCgfsni+17zhX2ebHi3Jt2axo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863725;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=aIj7nzLay9iEOLJMRq4RsRPW9XMEtdFOI6JAYVZMHAs=;
        b=FYK2p8GA6LDfTG+6rSKxD+yivz4gkgh2WErNnDmhGdhUjtkhrCoPvtMfq0z8OzEB
        QNgel+YDjpUFFElq3hMrT6WfdKxQtLWQLVyHz6J9/bAeeZgktpl1swOUJHHvGgxg3xo
        P3bRFTnueVnloXffYMF+D+vmFXKAqxhee5we7Lno=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23AFBC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 00/10] ath11k: third round of post-bringup patches
Date:   Wed, 27 Nov 2019 14:08:45 +0000
Message-ID: <0101016ead3161dc-8576af35-5fd2-4ac5-805e-4791a3f7b65d-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2019.11.27-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here's third round of ath11k patches from ath11k-post-bringup
branch[1] which got queued while ath11k was in review.

Major features here are support for controlling tx power per station
and fixing tracing.

Please review.

Kalle

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-post-bringup


Anilkumar Kolli (4):
  ath11k: tracing: fix ath11k tracing
  ath11k: qmi clean up ce and HTC service config update
  ath11k: qmi clean up in ath11k_qmi_wlanfw_wlan_cfg_send()
  ath11k: pktlog: fix sending/using the pdev id

Govindaraj Saminathan (1):
  ath11k: unlock mutex during failure in qmi fw ready

Karthikeyan Periyasamy (2):
  ath11k: avoid burst time conversion logic
  ath11k: avoid use_after_free in ath11k_dp_rx_msdu_coalesce API

Maharaja Kennadyrajan (1):
  ath11k: add support for controlling tx power to a station

Sriram R (1):
  ath11k: add necessary peer assoc params in wmi dbg

Venkateswara Naralasetty (1):
  ath11k: update bawindow size in delba process

 drivers/net/wireless/ath/ath11k/ahb.c   |  9 +++----
 drivers/net/wireless/ath/ath11k/ce.h    |  9 +++++--
 drivers/net/wireless/ath/ath11k/core.c  |  1 +
 drivers/net/wireless/ath/ath11k/debug.h |  3 +++
 drivers/net/wireless/ath/ath11k/dp_rx.c | 46 +++++++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/mac.c   | 44 ++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/qmi.c   | 28 ++++++++++----------
 drivers/net/wireless/ath/ath11k/qmi.h   |  4 +--
 drivers/net/wireless/ath/ath11k/trace.h |  3 +++
 drivers/net/wireless/ath/ath11k/wmi.c   | 19 ++++++++++----
 10 files changed, 114 insertions(+), 52 deletions(-)

-- 
2.7.4

