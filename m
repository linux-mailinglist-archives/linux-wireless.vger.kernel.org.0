Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB6A47E2E3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348085AbhLWMIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50212 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbhLWMIE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8F05B81F6D
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10CAC36AE9;
        Thu, 23 Dec 2021 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261281;
        bh=0SYfLmsqObJWKnSDREgOPH4iuaGRWaut5goVdkRwr+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoR4R3mu4w2YD3PnHxiIVCyFCJc42lIUWrgN2rwti/7MVU78AVpVKgS6ZCXGaq2mF
         t28VHIHW9LlyaBuE0ylBosgTn9YWrIu9C0nNxUodebQKjFKYG+1XfjxnT+gF6YfI5s
         N+yFWkVE6sRFL/rXZ0KRSAAuP1jj0YZQuCgKrF+4k0UGcGw9xEQTscfjWgrV2jbpG9
         383gAf2qwSPryYekwkeR99wo1RYyXDzObv3vpMhG/ofRBxYLqXCM1u9dqPUNoxDC8H
         eE0k3iHaaiHFPFfPdect1VW1Y+U40L4vYtNXBPTc7+6EYUXGdOelCe/xMewna40tpM
         l4sZStdfN+ZNQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 01/15] mt76: mt7915: remove duplicated defs in mcu.h
Date:   Thu, 23 Dec 2021 13:07:29 +0100
Message-Id: <220fa1b7bde45635ffdd4a385a0db2917392ad2f.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove duplicated definitions in mt7915/mcu.h

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index c0cc592bda1c..aa05c6ceebb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -272,29 +272,6 @@ enum mcu_mmps_mode {
 	MCU_MMPS_DISABLE,
 };
 
-#define STA_TYPE_STA			BIT(0)
-#define STA_TYPE_AP			BIT(1)
-#define STA_TYPE_ADHOC			BIT(2)
-#define STA_TYPE_WDS			BIT(4)
-#define STA_TYPE_BC			BIT(5)
-
-#define NETWORK_INFRA			BIT(16)
-#define NETWORK_P2P			BIT(17)
-#define NETWORK_IBSS			BIT(18)
-#define NETWORK_WDS			BIT(21)
-
-#define CONNECTION_INFRA_STA		(STA_TYPE_STA | NETWORK_INFRA)
-#define CONNECTION_INFRA_AP		(STA_TYPE_AP | NETWORK_INFRA)
-#define CONNECTION_P2P_GC		(STA_TYPE_STA | NETWORK_P2P)
-#define CONNECTION_P2P_GO		(STA_TYPE_AP | NETWORK_P2P)
-#define CONNECTION_IBSS_ADHOC		(STA_TYPE_ADHOC | NETWORK_IBSS)
-#define CONNECTION_WDS			(STA_TYPE_WDS | NETWORK_WDS)
-#define CONNECTION_INFRA_BC		(STA_TYPE_BC | NETWORK_INFRA)
-
-#define CONN_STATE_DISCONNECT		0
-#define CONN_STATE_CONNECT		1
-#define CONN_STATE_PORT_SECURE		2
-
 enum {
 	SCS_SEND_DATA,
 	SCS_SET_MANUAL_PD_TH,
-- 
2.33.1

