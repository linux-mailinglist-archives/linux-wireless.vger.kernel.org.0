Return-Path: <linux-wireless+bounces-24421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1090AE6349
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0C77A7636
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21946283FC2;
	Tue, 24 Jun 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P0TqaJ5G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E52288EE
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 11:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763283; cv=none; b=swXoDpGj1z2PvSBC8ZGMksYwMMZP4mfRhLn8asbUtjIAQJpxI6Qjbrqn0qvOhrZudvlFRNi1zC+2TF7LymT3nO1d5TdPfHSWYGSWEszZ1Uxiz+NfqUdx5FcfKKXIsDaAPWhBvlqKVZMGgV5oxIH02iKL82d3t6apywUtW6P8m+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763283; c=relaxed/simple;
	bh=CMl8z6OKD+6/1QVrOU5K87eptYIfszTT46a487NNys0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuxIrDmJbfPwhx4CDkg2YIDz6V0bgLLD2NwxgG8sHFR7rMvVwFdYzz4kGHNBRvtpryPHFmyRQa/jFxeKN8ZdQmBi8LV7sy7mWdKD/2cH/WfVdbufUQ8IrQCD3MSTc+OuddZAe6WLtvonewILshVEtGd4tXoInhEKdaIucJy4OAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P0TqaJ5G; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Jod9N3Q8dO/dE3Ov3Yh1B8ba131XGIOXudfCi5GVBww=; t=1750763281; x=1751972881; 
	b=P0TqaJ5GichuKRismd/gAlrwM3jXbg1ZcviGhzq5CapsXLTc051PzsGOEiXspxjg7pVoudbM/gD
	8oOCUow/h9jQPXo5TBFYI0q3gdu4TWa+mO7i4hdvqAL3/W3SopOs2LzLqEV3qsu8KI1LbJZsPqeA0
	uAEoO/YkTELKbbICmD9Xa3l2X7w5+n8PvAtsqIUtA6x5zt6N6KVn+Vg1GAo1xzrSd72tG+Y8ITgiR
	Nq9Gbxshrg1asZfUAvQ/luIo+NgcUC4A5XJmtrFMwo2Tqq7rAX1fEdb2XYeinV2gonzvX4BZ78nkD
	UnjRhljqY/8bzzngd363651gVbijbrrBZd9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU1VI-00000008mBI-1k80;
	Tue, 24 Jun 2025 13:07:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: fix RCU initialization
Date: Tue, 24 Jun 2025 13:07:49 +0200
Message-ID: <20250624130749.9a308b713c74.I4a80f5eead112a38730939ea591d2e275c721256@changeid>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since the link/conf pointers can be accessed without any
protection other than RCU, make sure the data is actually
set up before publishing the structures.

Fixes: b2e8434f1829 ("wifi: mac80211: set up/tear down client vif links properly")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/link.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d40c2bd3b50b..4f7b7d0f64f2 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -93,9 +93,6 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (link_id < 0)
 		link_id = 0;
 
-	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
-	rcu_assign_pointer(sdata->link[link_id], link);
-
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
 		struct ieee80211_sub_if_data *ap_bss;
 		struct ieee80211_bss_conf *ap_bss_conf;
@@ -145,6 +142,9 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 
 		ieee80211_link_debugfs_add(link);
 	}
+
+	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
+	rcu_assign_pointer(sdata->link[link_id], link);
 }
 
 void ieee80211_link_stop(struct ieee80211_link_data *link)
-- 
2.49.0


