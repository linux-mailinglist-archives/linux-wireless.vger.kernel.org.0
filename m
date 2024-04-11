Return-Path: <linux-wireless+bounces-6193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC38A1D3C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1EE4286EC6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373AB502A4;
	Thu, 11 Apr 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh5m6T6R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13386502A2
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854521; cv=none; b=azzSc8KwAXQQPk7yDeHFhi4XWz1U5Gzi2EeDIzElx8h9fWsgmwNO/MLjdIfh8s91VSy9dgltOQgjo0dC9nQL/AxFnXHxF0wx63O2aa5Ide4G1/W3yF0lq/JtzR2c+l9vvqhPJD/ZZWwOcfr7U+XlgkwjkqzlXweKsanmsNzSZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854521; c=relaxed/simple;
	bh=mD15s8QTfvS01rb0QJAhoIJhD4a3Q4/jwyVKrvxr9mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OucGC01dULh3GXe2SP2DSRXvxLh0MMjX+c9Gv8nTMbPab11RQPeygMP9vtyJ7ZEFVpn/J9ggma2LH+7Pn6J1zwAzwAKjiHlRibQlh66ARWwb/KTK3jDAaVbwAgRwA5nRpP4Xc/MohWXa10Agps43e1tU077OeH00IiS4tS+C3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh5m6T6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7AC113CE;
	Thu, 11 Apr 2024 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712854520;
	bh=mD15s8QTfvS01rb0QJAhoIJhD4a3Q4/jwyVKrvxr9mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kh5m6T6Rkn6NoY+t9k1pvf+zZzl/SR4R3I84prDvKhCzOQvZP78ZSk/rBRD9xWZL5
	 cLcSwYXjc9s5KtDsu8a1SfL2g7tDKCwHaNCK78j+K5m06PcDqL/lyKsaNYDw6oD8Qm
	 MJJZU4Mjj2FygAEY69DyTZHS4G7IRKmhbPPKWNDtY8+jgiy5lnRnnv3mknASUas3hv
	 u2XkM0q9DUyt7rHJ2LqWt79ysqyVunS2qkvkYb3DPi4El8Nzmw0T7CJ21vFazwnO1z
	 epiBQzT98wI3XK066w+JtyG5o6ySlzhNmNr7GE5K7EIBZRTFymxV5OxLrTZq+V6ZM8
	 XdNdqRGiDrrBw==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list
Date: Thu, 11 Apr 2024 19:55:15 +0300
Message-Id: <20240411165516.4070649-2-kvalo@kernel.org>
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

Commit c3718936ec47 ("ipv6: anycast: complete RCU handling of struct
ifacaddr6") converted struct inet6_dev::ac_list to use RCU but missed that
ath11k also accesses this list. Now sparse warns:

drivers/net/wireless/ath/ath11k/mac.c:9145:21: warning: incorrect type in assignment (different address spaces)
drivers/net/wireless/ath/ath11k/mac.c:9145:21:    expected struct ifacaddr6 *ifaca6
drivers/net/wireless/ath/ath11k/mac.c:9145:21:    got struct ifacaddr6 [noderef] __rcu *ac_list
drivers/net/wireless/ath/ath11k/mac.c:9145:53: warning: incorrect type in assignment (different address spaces)
drivers/net/wireless/ath/ath11k/mac.c:9145:53:    expected struct ifacaddr6 *ifaca6
drivers/net/wireless/ath/ath11k/mac.c:9145:53:    got struct ifacaddr6 [noderef] __rcu *aca_next

Fix it by using rtnl_dereference(). Also add a note that read_lock_bh() calls
rcu_read_lock() which I was not aware of.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

Fixes: c3718936ec47 ("ipv6: anycast: complete RCU handling of struct ifacaddr6")
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c32be587000d..4fdd56cd30a1 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9112,6 +9112,7 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	offload = &arvif->arp_ns_offload;
 	count = 0;
 
+	/* Note: read_lock_bh() calls rcu_read_lock() */
 	read_lock_bh(&idev->lock);
 
 	memset(offload->ipv6_addr, 0, sizeof(offload->ipv6_addr));
@@ -9142,7 +9143,8 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	}
 
 	/* get anycast address */
-	for (ifaca6 = idev->ac_list; ifaca6; ifaca6 = ifaca6->aca_next) {
+	for (ifaca6 = rcu_dereference(idev->ac_list); ifaca6;
+	     ifaca6 = rcu_dereference(ifaca6->aca_next)) {
 		if (count >= ATH11K_IPV6_MAX_COUNT)
 			goto generate;
 
-- 
2.39.2


