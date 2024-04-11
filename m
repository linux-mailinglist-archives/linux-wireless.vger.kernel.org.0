Return-Path: <linux-wireless+bounces-6194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D318A1D3D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D271B1C240D0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546694C602;
	Thu, 11 Apr 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9A7Af92"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B2502AD
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854522; cv=none; b=O1UBW1cFjeRAadjX8A9smmty0jff4QnNDnq5Gs8Cv7iDrQEgRUb0vBrR6hm9cGQVnyvqE1PPesDQ9VS/S3LGpWkmy6jTjkBGxQJZplLPnizX6QktmtsoPHEiQcIvml0rtm2DBgunkTGvWEw4H3TygLt5LSHPGTh+xTdOdRNAjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854522; c=relaxed/simple;
	bh=PIuzyiawecI9ZT/F/gvfPSL47CLIFp0J4d/wSzhLX9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hutWYHUo3ReaffMP3oCjZA8M+u1owStjH6nFlyM2bDNPVee6XJRNked4XjxcvkhJYkqgQFN5FuNw6/sf1uhLQkq7KP0wQPswISx4SNhIjkLMqTsyboBBBVDKnPlAbhq6hrB9GxcFaDRoBA/OandSIkGtwxopnh7pbMZPEQsK5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9A7Af92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B1C113CD;
	Thu, 11 Apr 2024 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854521;
	bh=PIuzyiawecI9ZT/F/gvfPSL47CLIFp0J4d/wSzhLX9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r9A7Af92CnZJEYonTzgi1InBB2PCMyMBAtCQe+Q5mpUPxayatA4Yy7eYPs/Xxwn5v
	 YDcdnfplC8Gs3CV2kMpLT3mBU3XvB7DXkTXxiEYLtJDYfJoSJ7iwaWfwrVjLbdgGp5
	 QeSMYdXg89aeySC97kao6KBqwyVoVoMW/eI5X183+ZSziIY09bRJzPMSnS3IBRwsNo
	 8sO/0K3hVvMhRlog80kWlGsMQpDVPVBg411vtH1J2nnsjkB0ro19IYr94XD5YMbsfQ
	 tJ3s5wqHjbdMxYtH+Z1gYnA4CmjZu30ksiXO6ebNBAyj4NzMdUDAOIQnjKm9FDYW+1
	 EzAwQ+3Fvug/Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: ath11k: ath11k_mac_op_ipv6_changed(): use list_for_each_entry()
Date: Thu, 11 Apr 2024 19:55:16 +0300
Message-Id: <20240411165516.4070649-3-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411165516.4070649-1-kvalo@kernel.org>
References: <20240411165516.4070649-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Simplify the loop by using list_for_each_entry(). No functional changes.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4fdd56cd30a1..4ff8dd0d157b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9104,7 +9104,6 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct inet6_ifaddr *ifa6;
 	struct ifacaddr6 *ifaca6;
-	struct list_head *p;
 	u32 count, scope;
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "op ipv6 changed\n");
@@ -9120,11 +9119,10 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	memcpy(offload->mac_addr, vif->addr, ETH_ALEN);
 
 	/* get unicast address */
-	list_for_each(p, &idev->addr_list) {
+	list_for_each_entry(ifa6, &idev->addr_list, if_list) {
 		if (count >= ATH11K_IPV6_MAX_COUNT)
 			goto generate;
 
-		ifa6 = list_entry(p, struct inet6_ifaddr, if_list);
 		if (ifa6->flags & IFA_F_DADFAILED)
 			continue;
 		scope = ipv6_addr_src_scope(&ifa6->addr);
-- 
2.39.2


