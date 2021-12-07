Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A776146BBDE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 13:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhLGM6i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 07:58:38 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:42646 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231583AbhLGM6i (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 07:58:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638881707; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=b8/RwZjviMMUO+cE3eeI3pEdALkuCYSADWKbX+CD3n4=; b=kaJaGj9lSmoQZMgwn3kCiWmlnVows6/+tcLVq/gGb3+UT7zZLg2Na91J0VljAUQI/NvMI24e
 6jXW4EbTOY2yLed5lxEvqftGUlxHry0Zdz1kqkfVdogC2xRoI6S0in6RcjdHAcxvrgyHeulY
 ZwoqPje7KCGPE3L0EKiTiH5BFZ8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61af59ab4fca5da46dc0a354 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Dec 2021 12:55:07
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13406C43617; Tue,  7 Dec 2021 12:55:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B726C43616;
        Tue,  7 Dec 2021 12:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4B726C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 0/3] ath11k: add full monitor mode support for QCN9074
Date:   Tue,  7 Dec 2021 18:24:52 +0530
Message-Id: <1638881695-22155-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN9074 HW supports full monitor mode. The advantage with
full monitor mode is HW has status buffers available for
all the MPDUs in mon_dst_ring.

HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to FW
to enable the full monitor mode.

A new hw_param full_monitor_mode is added to enable full
monitor support for QCN9074.

In full monitor mode, monitor destination ring is read in
software monitor ring descriptor format instead of
reo_entrance_ring format. Add new sw_mon_ring descriptor.

In full monitor mode, monitor destination ring is read before
monitor status ring. mon_dst_ring has ppdu id, reap till the
end of ppdu. Add all the MPDUs to a list. Start processing the
status ring, if PPDU id in status ring is lagging behind, reap
the status ring, once the PPDU ID matches, deliver the msdu to
upper layer. If status PPDU id leading, reap the mon_dst_ring.

Anilkumar Kolli (3):
  ath11k: Add htt cmd to enable full monitor mode
  ath11k: add software monitor ring descriptor for full monitor
  ath11k: Process full monitor mode rx support

---
V2:
 - Rebased on ToT
 - Update commit log (kalle)
 - Tested on qca6390

 drivers/net/wireless/ath/ath11k/core.c     |   5 +
 drivers/net/wireless/ath/ath11k/dp.c       |   1 +
 drivers/net/wireless/ath/ath11k/dp.h       |  54 +++-
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 409 ++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.c    |  48 ++++
 drivers/net/wireless/ath/ath11k/dp_tx.h    |   2 +
 drivers/net/wireless/ath/ath11k/hal_desc.h |  19 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c   |  44 ++++
 drivers/net/wireless/ath/ath11k/hal_rx.h   |  17 ++
 drivers/net/wireless/ath/ath11k/hw.h       |   1 +
 10 files changed, 597 insertions(+), 3 deletions(-)

-- 
2.7.4

