Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DCB42E76D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 05:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhJOD5Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 23:57:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:53419 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhJOD5X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 23:57:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634270118; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=PqZ6qTJznNJhvuHlYwRdlrFeqJiXau1Qh7HXyhbQVcY=; b=aCyn4wufGBEpiTky/B4R4JFKuLTwGxm8DxI/qJvsBTc36WXfVMcNnIC6dO4dzvlgpw989gPy
 AZ1WjLK/smol6bfwfL3cbvto6fZnOFErv57sWTHkyicAP5iqQo5GxdSqkm83cleIOMzTxXCn
 OdkJyU22+YbWSbcn/GOg53MKLKY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6168fba2e77f9e0ee3c42628 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Oct 2021 03:55:14
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 90079C43616; Fri, 15 Oct 2021 03:55:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07AB9C4338F;
        Fri, 15 Oct 2021 03:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 07AB9C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 0/3] ath11k: add feature for device recovery
Date:   Thu, 14 Oct 2021 23:54:56 -0400
Message-Id: <20211015035459.14190-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

v3: remove time_left set but not used in
    "ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base"

v2: s/initilized/initialized in commit log of patch
    "ath11k: add synchronization operation between reconfigure of mac80211 and ath11k_base"

Add support for device recovery.

Wen Gong (3):
  ath11k: add ath11k_qmi_free_resource() for recovery
  ath11k: add support for device recovery for QCA6390
  ath11k: add synchronization operation between reconfigure of mac80211
    and ath11k_base

 drivers/net/wireless/ath/ath11k/core.c | 119 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  18 ++++
 drivers/net/wireless/ath/ath11k/mac.c  |  40 +++++++++
 drivers/net/wireless/ath/ath11k/mhi.c  |  33 +++++++
 drivers/net/wireless/ath/ath11k/pci.c  |   3 +
 drivers/net/wireless/ath/ath11k/qmi.c  |   5 ++
 drivers/net/wireless/ath/ath11k/qmi.h  |   1 +
 7 files changed, 211 insertions(+), 8 deletions(-)

-- 
2.31.1

