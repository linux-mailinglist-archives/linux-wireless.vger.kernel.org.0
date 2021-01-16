Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728482F8D63
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jan 2021 13:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbhAPMxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jan 2021 07:53:23 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36246 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhAPMxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jan 2021 07:53:23 -0500
Received: from legolas.fritz.box (unknown [84.174.243.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 27CBF58008D;
        Sat, 16 Jan 2021 13:52:04 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/4] rfkill: update rfkill.h
Date:   Sat, 16 Jan 2021 13:51:44 +0100
Message-Id: <20210116125146.31932-3-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
References: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 rfkill.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/rfkill.h b/rfkill.h
index 058757f..03e8af8 100644
--- a/rfkill.h
+++ b/rfkill.h
@@ -59,6 +59,8 @@ enum rfkill_type {
  * @RFKILL_OP_DEL: a device was removed
  * @RFKILL_OP_CHANGE: a device's state changed -- userspace changes one device
  * @RFKILL_OP_CHANGE_ALL: userspace changes all devices (of a type, or all)
+ *	into a state, also updating the default state used for devices that
+ *	are hot-plugged later.
  */
 enum rfkill_operation {
 	RFKILL_OP_ADD = 0,
@@ -67,6 +69,16 @@ enum rfkill_operation {
 	RFKILL_OP_CHANGE_ALL,
 };
 
+/**
+ * enum rfkill_hard_block_reasons - hard block reasons
+ * @RFKILL_HARD_BLOCK_SIGNAL: the hardware rfkill signal is active
+ * @RFKILL_HARD_BLOCK_NOT_OWNER: the NIC is not owned by the host
+ */
+enum rfkill_hard_block_reasons {
+	RFKILL_HARD_BLOCK_SIGNAL	= 1 << 0,
+	RFKILL_HARD_BLOCK_NOT_OWNER	= 1 << 1,
+};
+
 /**
  * struct rfkill_event - events for userspace on /dev/rfkill
  * @idx: index of dev rfkill
@@ -74,6 +86,8 @@ enum rfkill_operation {
  * @op: operation code
  * @hard: hard state (0/1)
  * @soft: soft state (0/1)
+ * @hard_block_reasons: valid if hard is set. One or several reasons from
+ *	&enum rfkill_hard_block_reasons.
  *
  * Structure used for userspace communication on /dev/rfkill,
  * used for events from the kernel and control to the kernel.
@@ -82,7 +96,9 @@ struct rfkill_event {
 	__u32 idx;
 	__u8  type;
 	__u8  op;
-	__u8  soft, hard;
+	__u8  soft;
+	__u8  hard;
+	__u8  hard_block_reasons;
 } __attribute__((packed));
 
 /*
-- 
2.30.0

