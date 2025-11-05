Return-Path: <linux-wireless+bounces-28618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A562C36388
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08084F7941
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7E41C63;
	Wed,  5 Nov 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fKD/TPWr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815F314B8E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355080; cv=none; b=cyNLMCSberVbkL02Ty0+gOS6d3WZRgs9q2zUekLlsaYieMKbQmZ90FN4DHnlbCbdvPSmLxoHWgKy1e9iupDywJJ1Gi9gHmohwtGgXIbsGVYF08uM1G5MfD38hsoarRHh7pOAI08y9Axf0LYzSRvt6pTTSpqjsb/IkobenLsqKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355080; c=relaxed/simple;
	bh=VPlvFTuscMH+rZOmdoushavvB4Gk73x+DnZYHg8Rqew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOCYHgfA9Cn/3UGAw7JuGeRzSbPkCnGcwvAlhqy9AnEdC/KPsMlxooJCKL79IoNtlmS+7XQgP36hTpHN/me8DXe68tDzk9iZn2yL009RSndH3nuy9YFzG4hDiXBG6mptUBV+ZXikkogkgI6v1fnsfTjy8CESxRl0a/jBb1EA8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fKD/TPWr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BPu+u5y1kVFwub+2Ezf54/JEIFopfHyrb/C90N3F3+g=;
	t=1762355078; x=1763564678; b=fKD/TPWrK5kEMiUbo4ZNzYN4HF9EpgyTRDeTIEVOshAkAU5
	ogXb9jKkwsy0weZNVdFaGpC5mxX0A/Nc0O7lCuNUFKu86daS3eOtBMZOhKYw+9JTiiw6XaJKnIvQ7
	qpA/mjpoot3h9Rfok0nqh+4o2bPomWMFnuMRUzfru67/GxLPUsjl70Uo+CqVQuQL13RTuAxS3pHMh
	Vz6I7Ee5lE/BSMfjoAWydlTyhOMZ7+evyYBTbP22H4IMNlFHmjFyrqYnO348OVZz9a9gCoFb7xJNv
	IZlZqP6MSRZ8y+CHpRQQ0+dt3KSGJG43lrWUROmkzeDcLz66SMe9evo9Ek8Z/WPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf3r-0000000FGVb-3gkr;
	Wed, 05 Nov 2025 16:04:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/4] wifi: mac80211: make link iteration safe for 'break'
Date: Wed,  5 Nov 2025 16:03:42 +0100
Message-ID: <20251105160431.c21956654fc0.I8d4739af061c44c57d172f19a15303a44ad1e596@changeid>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105150431.49595-6-johannes@sipsolutions.net>
References: <20251105150431.49595-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The current link iteration macros for_each_sdata_link() and
for_each_sdata_link_rcu() are various nested for loops, but
because they iterate all sdata instances and then all links
inside, using 'break' inside the iteration doesn't actually
break out of the whole iteration.

Make it work by tracking whether or not the inner iteration
(over links) actually completed, if it broke out then given
list_for_each_entry() it still iterates all sdata instances
but won't go into them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 73fd86ec1bce..d8c7abf4bca5 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1239,9 +1239,12 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	for (struct ieee80211_sub_if_data *___sdata = NULL;		\
 	     !___sdata;							\
 	     ___sdata = (void *)~0 /* always stop */)			\
+	for (int ___link_id = ARRAY_SIZE(___sdata->link);		\
+	     ___link_id; ___link_id = 0 /* always stop */)		\
 	list_for_each_entry(___sdata, &(_local)->interfaces, list)	\
-	if (ieee80211_sdata_running(___sdata))				\
-	for (int ___link_id = 0;					\
+	if (___link_id == ARRAY_SIZE(___sdata->link) &&			\
+	    ieee80211_sdata_running(___sdata))				\
+	for (___link_id = 0;						\
 	     ___link_id < ARRAY_SIZE(___sdata->link);			\
 	     ___link_id++)						\
 	if ((_link = wiphy_dereference((_local)->hw.wiphy,		\
@@ -1255,9 +1258,12 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	for (struct ieee80211_sub_if_data *___sdata = NULL;				\
 	     !___sdata;									\
 	     ___sdata = (void *)~0 /* always stop */)					\
-	list_for_each_entry_rcu(___sdata, &(_local)->interfaces, list)			\
-	if (ieee80211_sdata_running(___sdata))						\
-	for (int ___link_id = 0;							\
+	for (int ___link_id = ARRAY_SIZE(___sdata->link);		\
+	     ___link_id; ___link_id = 0 /* always stop */)		\
+	list_for_each_entry(___sdata, &(_local)->interfaces, list)	\
+	if (___link_id == ARRAY_SIZE(___sdata->link) &&			\
+	    ieee80211_sdata_running(___sdata))				\
+	for (___link_id = 0;						\
 	     ___link_id < ARRAY_SIZE((___sdata)->link);					\
 	     ___link_id++)								\
 	if ((_link = rcu_dereference((___sdata)->link[___link_id])))
-- 
2.51.1


