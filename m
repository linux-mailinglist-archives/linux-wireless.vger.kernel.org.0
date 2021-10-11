Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166BF42888D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhJKIWr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 04:22:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52489 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235010AbhJKIWp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 04:22:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633940445; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=qxmSLdyNolPiCCXEjjGqh6sRGjLf8GR45MclK36iiVg=; b=uWcc/J7lzTm+O3CWiuyWN32S0FLy/wjTSgVmSRlxvVkbt/MEZByck3Fv+GExfG6IB2Up+ru/
 OTZJckKCc5iGNlJhcGFhoRAvoE+CLHVa6YWGqYL0BjLaA2yamnc3PBaOokaX9QU8vBBP9UMI
 qC4ly+bWKQS2F/z3SRR044Vz3hQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6163f3c4446c6db0cbd669ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:20:20
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83B7AC4338F; Mon, 11 Oct 2021 08:20:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3983DC4360D;
        Mon, 11 Oct 2021 08:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3983DC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH 0/3] ath11k: add feature for device recovery
Date:   Mon, 11 Oct 2021 04:19:35 -0400
Message-Id: <20211011081938.30327-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for device recovery.

Wen Gong (3):
  ath11k: add ath11k_qmi_free_resource() for recovery
  ath11k: add support for device recovery for QCA6390
  ath11k: add synchronization operation between reconfigure of mac80211
    and ath11k_base

 drivers/net/wireless/ath/ath11k/core.c | 119 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/core.h |  18 ++++
 drivers/net/wireless/ath/ath11k/mac.c  |  41 +++++++++
 drivers/net/wireless/ath/ath11k/mhi.c  |  33 +++++++
 drivers/net/wireless/ath/ath11k/pci.c  |   3 +
 drivers/net/wireless/ath/ath11k/qmi.c  |   5 ++
 drivers/net/wireless/ath/ath11k/qmi.h  |   1 +
 7 files changed, 212 insertions(+), 8 deletions(-)

-- 
2.31.1

