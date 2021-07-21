Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C31D3D14FA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 19:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhGUQjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 12:39:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21235 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhGUQjP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 12:39:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626887992; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=xD7sUyBOQgIC7r+VcldJp0iMM/C0O7dJy5HBTETTP/0=; b=QgPhKYEje7KREuGDOk1AwBH00TOXvg1/IE2vKtjeskL21z4BTQfGhdMnT27r0RkIyme3tzuY
 Ajc2uZHcaLD9wE/d7eta+WTt+C+RbxAq467RXfnzWUVSeeRNTEAKqlXNqGhIgcLzjoOYpCbB
 G68/0ow74uKt0taITSwEulfw+j8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60f8572ee31d882d181de35a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 17:19:42
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3DFBDC43460; Wed, 21 Jul 2021 17:19:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96035C4338A;
        Wed, 21 Jul 2021 17:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96035C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 0/3] ath11k: add full monitor mode support for QCN9074
Date:   Wed, 21 Jul 2021 20:19:02 +0300
Message-Id: <20210721171905.61838-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

QCN9074 hardware supports full monitor mode. The advantage with
full monitor mode is hardware has status buffers available for
all the MPDUs in mon_dst_ring.

HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to firmware
to enable the full monitor mode.

A new hw_param full_monitor_mode is added to enable full
monitor support for QCN9074.

In full monitor mode, monitor destination ring is read in
software monitor ring descriptor format instead of
reo_entrance_ring format. Add new sw_mon_ring descriptor.

In full monitor mode, monitor destination ring is read before
monitor status ring. mon_dst_ring has PPDU id, reap till the
end of PPDU. Add all the MPDUs to a list. Start processing the
status ring, if PPDU id in status ring is lagging behind, reap
the status ring, once the PPDU ID matches, deliver the MSDU to
upper layer. If status PPDU id leading, reap the mon_dst_ring.

Anilkumar Kolli (3):
  ath11k: Add htt cmd to enable full monitor mode
  ath11k: add software monitor ring descriptor for full monitor
  ath11k: Process full monitor mode rx support

---
Depends-On: "ath11k: monitor mode clean up to use separate APIs"
Depends-On: "ath11k: add separate APIs for monitor mode"
Depends-On: "ath11k: move static function ath11k_mac_vdev_setup_sync to top"

 drivers/net/wireless/ath/ath11k/core.c     |   4 +
 drivers/net/wireless/ath/ath11k/dp.c       |   1 +
 drivers/net/wireless/ath/ath11k/dp.h       | 100 ++++++-
 drivers/net/wireless/ath/ath11k/dp_rx.c    | 413 ++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.c    |  48 ++++
 drivers/net/wireless/ath/ath11k/dp_tx.h    |   2 +
 drivers/net/wireless/ath/ath11k/hal_desc.h |  19 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c   |  44 +++
 drivers/net/wireless/ath/ath11k/hal_rx.h   |  17 ++
 drivers/net/wireless/ath/ath11k/hw.h       |   1 +
 10 files changed, 645 insertions(+), 4 deletions(-)

-- 
2.7.4

