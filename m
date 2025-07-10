Return-Path: <linux-wireless+bounces-25160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E7AFF80A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA13B1C475C4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6E206F27;
	Thu, 10 Jul 2025 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ehAnKgTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB132F3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121547; cv=none; b=NZFAVLIh4IyaenWqdxym6q3eT9LzGpeaZIel30Bqfg/aZb9xlaeTSI0L93eqGckoWhK315wMFSlIQV2vtzOnf94PFhAMf9mcNSijczXoa/Wi+nXAYdMiSRXgv500gmQIYimj4UPHaKDxEPxT9jq/oM+5QZa4FC3LupfJS8ZLXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121547; c=relaxed/simple;
	bh=KzYTSOueOflNfFViryPWbXK290F7+FpWq2y7lCL9qGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTCzL9A1DRqk0zVngaXC0MjlnP+gnGmu1pXNzTlJYHWedLQDRx/5FpkeBJQj/K7Wr0nTrEOFO5vhhXMSTZ98FHcDYqakPSOmcr/AFmrxjVXNxTYGVgeeTajtLDoKT3I72kT+X3qn5MOvbp7RryzL8xjCDwNi+CB8B9qeOQnNo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ehAnKgTr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PizM62455875, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121544; bh=0gZb8rB5zOyqY2nDq2pHSbPA+7Kdm6yhOZaC6LFGUS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ehAnKgTrCPGbWJMEZdWgJLu+ONNpFxryyHcVkH/nNUZOT8v9pC0RROGXdSnZh0YGR
	 6VE5zk1QRBboK4FbiySpkN1EM/ZCyBOOCsMxVTWYqORzheqidZRUyrBicB7KqryjiS
	 Y9ZMJByMp6mrUfAUo7ZGRCb71D1vRK2tSl6XPxQjBvmg7pICYsw2wIid9iz0ct22Km
	 kLdYmcTMhiiSoclyLqNBESET2df9AVtOFLWtF/8KEAEe8WOImXvSST55ugxzP2T12l
	 talfu0haP0v0kzXROA58FPQIo3h0vbK1VJYYOlwDKeFs9t8590tdcCIYQV0nB4Ddyq
	 CZ1XkFECbqwEQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PizM62455875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 11/14] wifi: rtw89: 8852bt: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
Date: Thu, 10 Jul 2025 12:24:20 +0800
Message-ID: <20250710042423.73617-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

After v0.29.127.0, RTL8852BT FW supports SCAN_OFFLOAD_EXTRA_OP feature.
With it, FW can do back-op and TX NULL frames on the second connection.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 6b94445577fd..0b0d1fd7b02b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -834,6 +834,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, SCAN_OFFLOAD_EXTRA_OP),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
-- 
2.25.1


