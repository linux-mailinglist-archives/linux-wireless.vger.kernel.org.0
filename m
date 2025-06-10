Return-Path: <linux-wireless+bounces-23939-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9320EAD38DA
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B31A2014B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC095246BB8;
	Tue, 10 Jun 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IKnSGPeD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E81246BA6
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560510; cv=none; b=O4Sqgi0qILUx8AnsrtHUqoc5YW5GdmaMOaHJNBokQZuxXAiZlx88xlpW+NmHIusprHHlogaHq170ncs16MFspc1N8wNQ3Lw/BOnjY9IqT04TWyUkIfh3W8rZNJ/D1+oPR8Md1QJZqxr01cqIarB5cHVIgaOTOVpF9ac5RVU52oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560510; c=relaxed/simple;
	bh=TF2GGFXOnaf1Y6Rs4pRCqvlWuK8YzGDXczL8UeoA/Sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtzD2/O4LyhRXwAMh83e88GVplMCOIyxwEwABCHeSLYpgfQNqx4qG1tF/E0196D2yD+bUcwu5oVs//GYRpWXo4VVFXZGTTuQxK4fM/ygecbYYxLpPLqUkDyQgQ++MyW8oY1/AD+PGib5BFMxHKSNF0VZ4szoH8na6l2v+fLIpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IKnSGPeD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1kppE2995883, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560506; bh=J4midFrFSQ1xxnI6LO0Rzzu9L2YhgBSMHLl+wmj+SxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IKnSGPeDukC510gzgW/wdIsJD2ISrtlATTF1xRIxCaItlgS83dIsbXFgMnW0psiz5
	 sOLBhjfKiL/S5usrmy0E8lrG1nUu/A/Mj1HkC4TUyHHouXrNXstbHx8eQ+aNfpsvaI
	 MW8RLctHNrAf4O58dqwRY540WH8kZ8niPaJLczpAoaGsxR0jDU/QHNcEOv3F4zsPH7
	 o+p8eSNvmkkjqCc5U87j/LOxn+Wjqr0PkrvXggooHziw4aeWqqSpTH7s4KgkbtjkaX
	 lmfOliTXs0FFDtu5Y1Sz83D/r7gU8t99p7eilDItSiuRoJzXRh8YLqhiXZzMB8yfAC
	 yGpDLVQBQ0zDQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1kppE2995883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:47 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 12/12] wifi: rtw89: scan abort when assign/unassign_vif
Date: Tue, 10 Jun 2025 21:00:34 +0800
Message-ID: <20250610130034.14692-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

If scan happen during start_ap, the register which control TX might be
turned off during scan. Additionally, if set_channel occurs during scan
will backup this register and set to firmware after set_channel done.
When scan complete, firmware will also set TX by this register, causing
TX to be disabled and beacon can't be TX. Therefore, in assign/unassign_vif
call scan abort before set_channel to avoid scan racing with set_channel.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 2a77b1978c38..2d4d730c8195 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2910,6 +2910,9 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 	rtwvif_link->chanctx_assigned = true;
 	cfg->ref_count++;
 
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
 	if (list_empty(&rtwvif->mgnt_entry))
 		list_add_tail(&rtwvif->mgnt_entry, &mgnt->active_list);
 
@@ -2949,6 +2952,9 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 	rtwvif_link->chanctx_assigned = false;
 	cfg->ref_count--;
 
+	if (rtwdev->scanning)
+		rtw89_hw_scan_abort(rtwdev, rtwdev->scan_info.scanning_vif);
+
 	if (!rtw89_vif_is_active_role(rtwvif))
 		list_del_init(&rtwvif->mgnt_entry);
 
-- 
2.25.1


