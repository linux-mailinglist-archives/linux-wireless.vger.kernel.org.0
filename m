Return-Path: <linux-wireless+bounces-30220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11CCEBA2E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CEC93034A22
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07C31197A;
	Wed, 31 Dec 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="OmkklA8w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8C93112C2
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172066; cv=none; b=HD9YbxDlKXtjhCfhlpRaIShOQvYPdR1AX05orOSTUxTNHCTHp7fLt4gxNEtVlraqKrGHnRMzsNd6BJfQjqp8jDumVbTQptzByVLOc7QLMcZpb+sKuJ+K1N7I0taMl0rKcIyt2LtzGLJQSCHLm6AcDDWLOdQzXoPhlCe/Lwn7+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172066; c=relaxed/simple;
	bh=4pSB8h2tdO9cPEJ6ExeolyBD9ZnIyO1hOXHHggUtOr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChFtpJWsngzmw0GkgMQ7Zx9F42alhZzh+J3/c/nS4OBACefVjGnr9cBbQsMVXKxl3nHvAjnUTLZDmPy1RHHN8MUJ4A8sFsnaOLJo6mJTWV6pnk1VGoxWostUuvSfWpNpDBKg6hs6E6KF0fO7+HWwhs65khVrZ4LqeexO6069q0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=OmkklA8w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97gr26881251, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172062; bh=XOzYci4YYhffKZdM87HN/64GRCP50QNOqbS3I/787dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=OmkklA8wnwjHVlOOJo145aWCrbvBBomAmVd9Ua3StHbU8MEydNQQjgvJFij/OXHk5
	 ZbpKeLBgsw2Ca/x9A1BaV9ePIfJbVaXDMeBCYmvLsUrD8SwBw0uAXE8atoq3rPG215
	 L+FiHF6+v+wWudITAt3Sm5+2bX3x1M1+wMopo74TMngHI4MdxQ9cBc8HU1i9SzknAn
	 tBDTO24rW8eGyBXLTiZcDZPuLU20xue8N2GtJ+95QyQMhh+UOZA3Qo7IRVhLOzCMSO
	 DBw3Gi83mrvng52xqKN30oHxluZ/sxZVyZLJO4tm3sK9vnTTAj1B3tL7XvY6ziNfSy
	 B6xcgnDtn1DcQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97gr26881251
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:43 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:42 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/11] wifi: rtw89: refine mis-ordered entries in FW feature table
Date: Wed, 31 Dec 2025 17:06:43 +0800
Message-ID: <20251231090647.56407-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Make all entries in firmware feature table in increasing order of firmware
version.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 067f6f0ea101..4ba99e7078fe 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -884,8 +884,8 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
-	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
+	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER_TYPE_0),
@@ -898,12 +898,12 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 94, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 130, 0, SIM_SER_L0L1_BY_HALT_H2C),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 0, 0, 0, RFK_PRE_NOTIFY_V0),
-	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD_EXTRA_OP),
-	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 21, 0, SCAN_OFFLOAD_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 21, 0, SCAN_OFFLOAD_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 28, 0, RFK_IQK_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 31, 0, RFK_PRE_NOTIFY_V1),
-- 
2.25.1


