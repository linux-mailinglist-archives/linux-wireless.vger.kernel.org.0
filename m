Return-Path: <linux-wireless+bounces-22610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B341AAB13D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6F27BB077
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247F32F6F8;
	Tue,  6 May 2025 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYEo+cyY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6B2D60FD;
	Mon,  5 May 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485357; cv=none; b=ndrH+TDQNHUDK6zPl8epGLABVCpJaYo9+9qAHTbaJJ5K826qaNXBf9lJaiCR9nk4onSs48Yef+EesdAU/eDilo7/FokIFSWhmXJCJFaHUfOL13VpgM8GtOOZ1IzTvT3HI6ryY/KtyNGawiMzE/CNKC1A8/Ovyn++S0PeUVIVRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485357; c=relaxed/simple;
	bh=jA/n9HSlhB7PQUXusTx5SZz37B/RI+8M5PtPwdFqV4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbvhe4TlwJJI3JiLa4PmvmqupAlHk+YfhBuUYFGVbh2LRn6xPip5ANlb2vBzduzxo0zMp+nApVKMxv4ms46v2HDEQN5Moqu0paAkPCqxkusetTL9CGUVdIrPb26cpT1V+DFz5OW3OLICs4pkpa0EB1fb2+AcSF7InrG/pmcjCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYEo+cyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A577CC4CEEE;
	Mon,  5 May 2025 22:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485356;
	bh=jA/n9HSlhB7PQUXusTx5SZz37B/RI+8M5PtPwdFqV4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYEo+cyYmdG+qF6jfXvZAXKakLRIjwFUpHiRb73k7F/ssYxrsF/8a9uZbTZrTsVzN
	 AXMiFlcwLenx2r/xU0sCHmLl5UwWwm3HCzhU4DSis+U6dTnIciOVXNmWMNWAt5QpAp
	 dij5UGW2Moj/EaPT4ZqOgHAzUjRABuCQnTol9N4Z8Kaqtc/8xPrXjcLpcRpQ5i4vGR
	 Rl1/dHKM/9KGAuG5ljxjg5/yZU8aJhqUiunRcfDukP8TX7yrbfHO3LamkOq6SVpi0w
	 bdS1qmehSNCdin3RkriTQfoVMaBGDUZ0QrDZ9KDswzy9tjZ4oWXy0UDK631pNMSBpW
	 kb/q9DUBFr9Gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 284/486] wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
Date: Mon,  5 May 2025 18:36:00 -0400
Message-Id: <20250505223922.2682012-284-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit 6be7544d19fcfcb729495e793bc6181f85bb8949 ]

Set the MCS maps and the highest rates according to the number of
spatial streams the chip has. For RTL8814AU that is 3.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/e86aa009-b5bf-4b3a-8112-ea5e3cd49465@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index bbdef38c7e341..2c81e4cae039e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1579,8 +1579,9 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 			     struct ieee80211_sta_vht_cap *vht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u16 mcs_map;
+	u16 mcs_map = 0;
 	__le16 highest;
+	int i;
 
 	if (efuse->hw_cap.ptcl != EFUSE_HW_CAP_IGNORE &&
 	    efuse->hw_cap.ptcl != EFUSE_HW_CAP_PTCL_VHT)
@@ -1603,21 +1604,15 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
-	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
-	if (efuse->hw_cap.nss > 1) {
-		highest = cpu_to_le16(780);
-		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
-	} else {
-		highest = cpu_to_le16(390);
-		mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << 2;
+	for (i = 0; i < 8; i++) {
+		if (i < efuse->hw_cap.nss)
+			mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2);
+		else
+			mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
+	highest = cpu_to_le16(390 * efuse->hw_cap.nss);
+
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest;
-- 
2.39.5


