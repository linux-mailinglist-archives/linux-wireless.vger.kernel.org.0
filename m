Return-Path: <linux-wireless+bounces-4608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FFC8791CB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 11:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3061F2210A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C189878267;
	Tue, 12 Mar 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="W0zmOuL9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C9AD53
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238855; cv=none; b=r3JkCZ8tqnuzimMyEh97reZ2+05o0CjM7cMX0nViQqnbvvq4wUqFjiUXnigWcPWpjqH74txLIAh839XHiAfK3xOw9pjpTlyaaoQiKusisq/eaeI1JTV4RZPJIrQIUw1PApNblD7IrKZ4Zj6UafE2dkJaPTbnGZ71+0VITYS464I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238855; c=relaxed/simple;
	bh=PscMH+Tst8UXalpzfpGKuisLxCXL1o29ieBW+4cXaeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGcQcYDgb83f3nIUggD8FDzfL7NjpdvKKW9HKgYbEazstb7qbesaMSNmWzGQGfozOqGMmYDYEtnnGxu/gwDeOhBvCiqUh5fi5/G6YCkHmUCJyPEFrvSvJntpelArEwzqVoUdhRO/dUoamOg9R7g/Ir67JA1/W71qVTVbFTXCWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=W0zmOuL9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=tuIFSZllcc3iNkW0au0GlQkfDIu4E56wGnqTE6jhOBw=; t=1710238853; x=1711448453; 
	b=W0zmOuL9DWuCVTIs46i6498a/C7mjkrY5V4hy5cgAJ93HoGoC5VLP12Sff2uxmF+VDjr/+d4Zmw
	1BJWDwZVz8Pm+4G7rtFCeT1iGjH+bxZMeU54ZwNGVz/B8WzUCpqIH0nBrUAZqp6o20sLWfPn5XuvO
	moGI94qkXcoj6dOgocF38Cn5d/MwZW+q/jKmAdiexFkMode0Y7Z/6m8b+GD/eOnoHbfxfjs+kmT66
	SgW8tK7N1Uk5F80Fj+t/AGlLSoScF7x9ysF0A4NqUIhkZ/918+mLg3e3ZhSeh+gbzSA9kveAQUAy6
	7b2inahtmVn1t8+077HxJfeqh3PBMRo5+/Sw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rjzFa-0000000Dnkd-2AOj;
	Tue, 12 Mar 2024 11:20:50 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: spectmgmt: simplify 6 GHz HE/EHT handling
Date: Tue, 12 Mar 2024 11:20:48 +0100
Message-ID: <20240312112048.94c421d767f9.Ia7ca2f315b392c74d39b44fa9eb872a2e62e75c1@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Clean up the code here a bit to have only a single call
to ieee80211_chandef_he_6ghz_oper() by using a local
pointer variable for the difference.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/spectmgmt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 327c74e296e2..f7f06b9d3b47 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -155,6 +155,7 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_eht_operation _oper;
 		struct ieee80211_eht_operation_info _oper_info;
 	} __packed eht;
+	const struct ieee80211_eht_operation *eht_oper;
 
 	if (conn->mode < IEEE80211_CONN_MODE_HE) {
 		chandef->chan = NULL;
@@ -203,19 +204,18 @@ validate_chandef_by_6ghz_he_eht_oper(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (conn->mode < IEEE80211_CONN_MODE_EHT) {
-		if (!ieee80211_chandef_he_6ghz_oper(local, &he._oper,
-						    NULL, chandef))
-			chandef->chan = NULL;
+		eht_oper = NULL;
 	} else {
 		eht._oper.params = IEEE80211_EHT_OPER_INFO_PRESENT;
 		eht._oper_info.control = he._6ghz_oper.control;
 		eht._oper_info.ccfs0 = he._6ghz_oper.ccfs0;
 		eht._oper_info.ccfs1 = he._6ghz_oper.ccfs1;
-
-		if (!ieee80211_chandef_he_6ghz_oper(local, &he._oper,
-						    &eht._oper, chandef))
-			chandef->chan = NULL;
+		eht_oper = &eht._oper;
 	}
+
+	if (!ieee80211_chandef_he_6ghz_oper(local, &he._oper,
+					    eht_oper, chandef))
+		chandef->chan = NULL;
 }
 
 int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
-- 
2.44.0


