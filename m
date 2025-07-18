Return-Path: <linux-wireless+bounces-25674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA9B0AA15
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4399C7B472F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A251E98FB;
	Fri, 18 Jul 2025 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fpCcpQjG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884117A2F5
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862996; cv=none; b=A92f1pJyeizoE6ACGEbzb6MzXS9gFIMFj7sOugGIpcvbWwElh4VY6QDEdbMXcjMcINU8ENb6w8cdUrIx0XCmVInUf/ZMB4RkVo2i9hNz9VijPpHU7U5xDn0S1KmY/dNt5ePlpwZX1FMCVnA7h+AVpwSPLPYA/CupYa5IcYZgFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862996; c=relaxed/simple;
	bh=6tiieU13nl5zLLWJjjT1+3/aMTCBzmJzQWt6XVm+ksU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Npl+PELR0XUkHQahgPjdxFB4tWUNPQ1bqkVu91gfRuUBoVrRVZfD6gcwTmaoepqmG/DsZ7+VrZ6s6tX1KxmQNVU1gv8qRnBxikBhX9uekGXf/c22Y5IlULibKNQotonzikMwjxPRFn5B1o7IVX7nH6OEm8gC59UnYSW0mjBLlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fpCcpQjG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=kU2rpD4nsbMPvBreXn8OAWk1IYWVVpXf91Nlf5dRXNw=; t=1752862995; x=1754072595; 
	b=fpCcpQjGTJysVQwV4YQU4xmdj9vMllVqMsIyEewG3XEr2j2a4/hbnbDyfODd4AZeg+FAhgTSsT3
	IpCETU7xwv2LTzz7TksOl8r7c1lCifiVqhFBHs4DtQz2YnRNy8qj7AqbYaAxwQj/k/606+1g3WB9Q
	WGy4vyDKY4ecQ99oITgmm6mzuQ0NV5XRGNctZ2gY1zHAVyd+c2Z17XRIdPVAXcWm+izFX2B5uUFgI
	jDbzWAmoXb9cKX5AKKhldiSK7rHJ0E8ZU/krd85jQb3y2a+/WnPa1O6VIwWGpIvlhoSagETgcjQDI
	bWENZY7mue0X/ZczUSC2P2e4tGQWjuCsj5hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucpjj-0000000D3bR-2hBy;
	Fri, 18 Jul 2025 20:23:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: reject HTC bit for management frames
Date: Fri, 18 Jul 2025 20:23:06 +0200
Message-ID: <20250718202307.97a0455f0f35.I1805355c7e331352df16611839bc8198c855a33f@changeid>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Management frames sent by userspace should never have the
order/HTC bit set, reject that. It could also cause some
confusion with the length of the buffer and the header so
the validation might end up wrong.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 05d44a443518..fd88a32d43d6 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -850,7 +850,8 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 
 	mgmt = (const struct ieee80211_mgmt *)params->buf;
 
-	if (!ieee80211_is_mgmt(mgmt->frame_control))
+	if (!ieee80211_is_mgmt(mgmt->frame_control) ||
+	    ieee80211_has_order(mgmt->frame_control))
 		return -EINVAL;
 
 	stype = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_STYPE;
-- 
2.50.1


