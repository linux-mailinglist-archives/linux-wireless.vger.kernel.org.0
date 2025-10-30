Return-Path: <linux-wireless+bounces-28410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1204C209B3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DECD84EC2B7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4501A9FBF;
	Thu, 30 Oct 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="g78AxvLC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291137A3C2
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834670; cv=pass; b=k6G9Yo6udSOfA8spsUd2VS5QIUXB6d21fDmH8ajE/fzkC5XehpbT2yUm5ne/MU8p7NFGkrAoEz0FQCtVjDJ0Sxahz/VPBhCbQ65POIbszlwIiPjlCxWTZPztRUmQQGkDqzB9vFaxv8q44L/SmKN2vkFX+hpobnwuBVlSY1lEjHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834670; c=relaxed/simple;
	bh=nf9B99XKJo0dc53MQXha0bcD27gg3Uv1Uh/SNZmgEaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7jJZs5np43IL1BSI21FTYdM0N5k8zXDUGEAHhknbH9cTF+VYJInuR3MIfGzenjGuGNs5vTlM104+wKMQRtNhTg+8SSAjLKkvJCtBou5UNKIw/CToYeWqpvcE0LGHl48O7OY2+Gxh1+tDl5wMM52NYTxMlUZWq3ke6Y322mLes4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=g78AxvLC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1761834657; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fNAASr4B1bzC/pEJtTi+lgpiWt+fF15kBUFcIDcSqz/ijWH0e6WPKIoHtO5rFtNQzdhALl0UYpYRPtPZgxFL51pxZJFjaePVEh59mgT/SD+rTP6Rj5B6Rn7+KqSc6q1W1juba9sTRWI4XivJn87iOJYkKngiJugcV/CtNNi4wao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761834657; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fELUXCyEO5u+hm/ZzD8bjXuY1M8yiutIcxsOu2hdzdk=; 
	b=DxQBGBaxvw4QEpBdEKNClzIlWQ1xl5tQUJhjacgJgtfCK89sBf1yt60c1R6+36QTt7ahZH7sUWNpnhyJLGdZJq4gwN4ys1moUw2aMDeO/kOV3xWUIO7ZT6iOb05VdQXX94+FEkHRd3dZ+GgmHQRU9xYJzlthB+Uz16tL6h+xxlM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761834657;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fELUXCyEO5u+hm/ZzD8bjXuY1M8yiutIcxsOu2hdzdk=;
	b=g78AxvLCrojp5U2OY3QRT6zsTK5xu7Di3fAfbwM9ehhaeosDmdlLXb1HlyC7ZHQC
	Noiryin0s2UGdzgsNbpWD5Kc9CWzkTKFN/ciK8RlQNaRsuRaF81d2VQJkArsP+1zYhM
	hPyykQC76u52bIA2wugZyje1n+Ehe/ZGJ66O0y7s=
Received: by mx.zohomail.com with SMTPS id 1761834653816426.06990330153076;
	Thu, 30 Oct 2025 07:30:53 -0700 (PDT)
From: Chien Wong <m@xv97.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: ath: fix comment typo in monitor mode handling
Date: Thu, 30 Oct 2025 22:30:41 +0800
Message-ID: <20251030143041.12027-1-m@xv97.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Correct a typo in the monitor mode comment where "it make" was mistakenly
used instead of "it doesn't make". The comment explains that the brief
period where monitor mode appears enabled before being removed is harmless
in practice.
Also, use more common phrase "in practice" instead of "in practise".

Fixes: 3f6e6c3291ed ("ath11k: disable monitor mode on QCA6390")
Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Chien Wong <m@xv97.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3276fe443502..668307f28038 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -10640,7 +10640,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (!ab->hw_params.supports_monitor)
 		/* There's a race between calling ieee80211_register_hw()
 		 * and here where the monitor mode is enabled for a little
-		 * while. But that time is so short and in practise it make
+		 * while. But that time is so short and in practice it doesn't make
 		 * a difference in real life.
 		 */
 		ar->hw->wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4c8b7a527e74..c72198c6cc96 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14083,7 +14083,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 	if (is_monitor_disable)
 		/* There's a race between calling ieee80211_register_hw()
 		 * and here where the monitor mode is enabled for a little
-		 * while. But that time is so short and in practise it make
+		 * while. But that time is so short and in practice it doesn't make
 		 * a difference in real life.
 		 */
 		wiphy->interface_modes &= ~BIT(NL80211_IFTYPE_MONITOR);
-- 
2.51.0


