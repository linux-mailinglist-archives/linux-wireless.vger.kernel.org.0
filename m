Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23A68188254
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 12:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgCQLh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 07:37:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24295 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgCQLh0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 07:37:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584445045; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=cbsv/sUVRfI608+x6RodMTAma5IsBTv39YdbuPmjgoQ=; b=gN8PE+g6Y5OK3MVjPguP6sb251pjnmkhiAcJe1jrOpgIa5KUEbfzoijSQyHyXPWo/VjGn4lP
 JIECV800AYBbUxm6tj/bdXMvqH/NLAanw/319ra7uMaX+nmZ15sUTpaC+Zy6a/2oOUFq/ebn
 +hZsCmJxOMlw58jx5Hv/v6D9S6c=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e70b66f.7fc1b7a3c8f0-smtp-out-n04;
 Tue, 17 Mar 2020 11:37:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C421DC433D2; Tue, 17 Mar 2020 11:37:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FC10C433CB;
        Tue, 17 Mar 2020 11:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FC10C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [PATCHv4,0/2] Support hash based reo destination ring selection
Date:   Tue, 17 Mar 2020 17:07:01 +0530
Message-Id: <1584445023-17384-1-git-send-email-srirrama@codeaurora.org>
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

v4: Rebased on top of latest master

Sriram R (2):
  ath11k: Configure hash based reo destination ring selection
  ath11k: Perform per-msdu rx processing

 drivers/net/wireless/ath/ath11k/ahb.c    |   5 -
 drivers/net/wireless/ath/ath11k/core.h   |   5 +-
 drivers/net/wireless/ath/ath11k/dp.c     |  35 ++-
 drivers/net/wireless/ath/ath11k/dp.h     |   4 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 513 +++++++++++++------------------
 drivers/net/wireless/ath/ath11k/dp_rx.h  |   4 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c  |   2 +-
 drivers/net/wireless/ath/ath11k/hal.h    |  12 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c |  15 +-
 drivers/net/wireless/ath/ath11k/mac.c    |  12 +-
 drivers/net/wireless/ath/ath11k/mac.h    |   1 +
 drivers/net/wireless/ath/ath11k/peer.c   |   3 +
 drivers/net/wireless/ath/ath11k/peer.h   |   2 +
 drivers/net/wireless/ath/ath11k/wmi.c    |  35 +++
 drivers/net/wireless/ath/ath11k/wmi.h    |  14 +-
 15 files changed, 339 insertions(+), 323 deletions(-)

-- 
2.7.4
