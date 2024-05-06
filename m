Return-Path: <linux-wireless+bounces-7236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A68BD534
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358722831F3
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6491591EB;
	Mon,  6 May 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qp7iOicP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F72158DD7
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022643; cv=none; b=YZfbIuDWSB12g0wuBio+S6r6Jv+M/yLwB3zvCcnhVhmhpvWOZ2n9kjv//VuLTswHyV/OrTlXeLUMImgMLmZtj21sVNSrK/lC+kELNhRZOEW+pP6rn6P1fXuwg+KaP+5F5EM0u1YwIT5U8Yd3syONKA/y6bE5OPVz1fzhd068MBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022643; c=relaxed/simple;
	bh=b+Dj2cqUDvPB/fZ/kV2hEOcl4chUDeaAhAvguYwWH5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6UuxQ9fHHr04i1U/1WHlETKQiHGlU4/YFD9i5SJPmChWuvu85N3kEKnzcbbFs2t22Bt4gAe9G3mPlPdERbWRfd9HxdH9gzYoDUqWQCQz6E6XZ/TqoO5hq9+pzmrI+zmabEXxBLlilOnMIH3Akpee/r/6n6uW53BOOY3QFD1DyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qp7iOicP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h6QVOh7HAtToWoQFnR5alrlPTrq9JbbxnxZ6/Y0lQgU=;
	t=1715022641; x=1716232241; b=qp7iOicPN/+1S6/SON08Wph0UD2o4TxCleQ4SYZ4MJmZHbo
	g0nP6PqIO9b7YSk46hIx3XC0aU2AFso8A/Vdx3Zmb34mRPBAj4e7W4CN1YAips0+uLFSuLTNEKEhT
	0v4xiHtiK5ACvcb/Elwplvd04Y/FltXFu5e1tu3PzRW4H0tiYikRmdsYKmzvrK9jIYe1kg3pw0dYA
	xbiHTTi/Xeazpq5ElRR9zYcoSLhDKG4u0ojECNiF0S+uMOy83a/Vd5WcttGK2uR/lSyqxwiTKbhwt
	oVun6boxVT3Ix1rOx5fLBy53jfR7sr0kL0a/HTtjJoOGgpnYijwFT2bhJrrvLv/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s43jS-000000089kh-2j6t;
	Mon, 06 May 2024 21:10:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 3/3] wifi: mac80211: don't stop TTLM works again
Date: Mon,  6 May 2024 21:10:35 +0200
Message-ID: <20240506211034.f8434be19f56.I021afadc538508da3bc8f95c89f424ca62b94bef@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506211034.ac754794279f.Ib9fbb1dab50c6b67f6de9be09a6c452ce89bbd50@changeid>
References: <20240506211034.ac754794279f.Ib9fbb1dab50c6b67f6de9be09a6c452ce89bbd50@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to stop works that have already been
stopped during disconnect, so don't.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9b0598b42d48..a481728d78c7 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8714,9 +8714,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 			  &ifmgd->csa_connection_drop_work);
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->tdls_peer_del_work);
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
-				  &ifmgd->neg_ttlm_timeout_work);
 
 	if (ifmgd->assoc_data)
 		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
-- 
2.44.0


