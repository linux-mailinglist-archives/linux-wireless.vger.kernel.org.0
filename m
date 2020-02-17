Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170FA160879
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2020 04:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgBQDIO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Feb 2020 22:08:14 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:51426 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgBQDIN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Feb 2020 22:08:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581908893; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=H9ZgjpDhAdTrDcgjf1mkGCtO9hr3+3vNw1oA8iEszis=; b=kO9aLeCgZ/BdC2qJWem90Ya2j+pc/auiruh8SCEEyAsM6SOyzylmJqjIMeKlwYj8wDr4SXXT
 HHidAdSe9erT7dro6HIuboBoiff1kJ24Qa9Lu06wJo13ND+sPImTQbecrLvUmFlF0rd7jl02
 mXK+3U74NScgfeg1J4tzfWxqDdg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a039c.7f4ace6fbed8-smtp-out-n01;
 Mon, 17 Feb 2020 03:08:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 52CDAC4479F; Mon, 17 Feb 2020 03:08:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26F20C43383;
        Mon, 17 Feb 2020 03:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26F20C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCHv2 0/2] Support hash based reo destination ring selection
Date:   Mon, 17 Feb 2020 08:37:51 +0530
Message-Id: <1581908873-14749-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, reo destination ring selection is based on pdev,
i.e each pdev is allocated a static reo destintaion ring and
rx packets for the pdev is always received on the ring.
This allows use of only 3 out of 4 reo destination rings at the
max when all pdev's are active and when only one pdev is active
we utilize only one ring and other 3 rings remain idle.
To make effective use of all the reo rings, this patchset enables
hash based reo destination ring selection where the hash is computed
based on the 5-tuple ( src/dst ip, src/dst port, protocol) info
from each packet and is used by hw for destination ring selection.

Also, current implementation of amsdu list based processing is replaced
with per msdu based handling since the received subframe could be
pushed to different rings after decap based on hash value computed.

This patchset is based on patchset "ath11k: offload PN verification to the HW"

Sriram R (2):
  ath11k: Configure hash based reo destination ring selection
  ath11k: Perform per-msdu rx processing

v2: Adding linux-wireless list

 drivers/net/wireless/ath/ath11k/ahb.c    |   5 -
 drivers/net/wireless/ath/ath11k/core.h   |   5 +-
 drivers/net/wireless/ath/ath11k/dp.c     |  35 ++-
 drivers/net/wireless/ath/ath11k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 511 +++++++++++++------------------
 drivers/net/wireless/ath/ath11k/dp_rx.h  |   4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h    |  12 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |  15 +-
 drivers/net/wireless/ath/ath11k/mac.c    |  10 +
 drivers/net/wireless/ath/ath11k/mac.h    |   1 +
 drivers/net/wireless/ath/ath11k/peer.c   |   3 +
 drivers/net/wireless/ath/ath11k/peer.h   |   2 +
 drivers/net/wireless/ath/ath11k/wmi.c    |  35 +++
 drivers/net/wireless/ath/ath11k/wmi.h    |  13 +
 15 files changed, 338 insertions(+), 319 deletions(-)

-- 
2.7.4
