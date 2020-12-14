Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAB2D9D9A
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLNRZu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Dec 2020 12:25:50 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:49782 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438728AbgLNRZQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Dec 2020 12:25:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607966689; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=PfZzYd5OxVNTd47txjIa81aRq7CRY9tpjogEf/fUdMs=; b=vLbgN+8vuXbGMvpThyFwV/6gYgYtFgLBpTEcoQMSIGR/779EgEr2/plvkvXjgDb75ih3FwiI
 tmHgGKXnbW1Z7GtTrOlMToEGz7YIyi4CDK6ZTozb8uNnBKMdV3w/aZcZIDG0NEmk+DgDD7cj
 Uz4vk0c7agXjpOf2ikJz1+f/rms=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fd79fe07e6bd85d22a13d2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Dec 2020 17:24:48
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63F14C43461; Mon, 14 Dec 2020 17:24:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-35-200-nat.elisa-mobile.fi [85.76.35.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A620AC433CA;
        Mon, 14 Dec 2020 17:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A620AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 0/5] ath9k: Safer key deletion to avoid unexpected behavior
Date:   Mon, 14 Dec 2020 19:21:13 +0200
Message-Id: <20201214172118.18100-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While earlier mac80211 commits like a0761a301746 ("mac80211: drop data
frames without key on encrypted links"), ce2e1ca70307 ("mac80211: Check
port authorization in the ieee80211_tx_dequeue() case"), and
b16798f5b907 ("mac80211: mark station unauthorized before key removal")
addressed the most visible and easiest to trigger cases where pending
frames from TX queues could potentially end up getting transmitted
without proper encryption, some similar cases could still remain in the
hardware TX queue. In such cases, clearing of the hardware key cache
entry could happen while there were remaining frames in the TX queues
with reference to the deleted key. That could end up transmitting such
frames without encryption. These issues are related to CVE-2020-3702.

It is not clear whether this can be triggered in the station mode after
the mac80211 changes, but it has been possible to come up with a test
setup where this could be triggered in the AP mode where the TX queue is
shared with multiple destinations and cannot be flushed when a single
station disconnects. Address such cases by not clearing the hardware key
cache entry immediately, but instead, temporarily leaving the key in
place and disabling RX processing for the key cache entry. Such a
postponed key deletion is completed once there are no remaining frames
referencing the particular key cache entry. This is done before handling
the next key cache operation to avoid having to perform heavy operations
during normal TX operations.

Jouni Malinen (5):
  ath: Use safer key clearing with key cache entries
  ath9k: Clear key cache explicitly on disabling hardware
  ath: Export ath_hw_keysetmac()
  ath: Modify ath_key_delete() to not need full key entry
  ath9k: Postpone key cache entry deletion for TXQ frames reference it

 drivers/net/wireless/ath/ath.h                |  3 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c |  2 +-
 drivers/net/wireless/ath/ath9k/hw.h           |  1 +
 drivers/net/wireless/ath/ath9k/main.c         | 95 ++++++++++++++++++-
 drivers/net/wireless/ath/key.c                | 41 ++++----
 6 files changed, 122 insertions(+), 22 deletions(-)

-- 
2.20.1

