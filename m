Return-Path: <linux-wireless+bounces-6509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F6F8A955F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6515F28264F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0338815AD82;
	Thu, 18 Apr 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gavP0t2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DB15A499
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430356; cv=none; b=RjRhi688cAqw8gL9vMREdVybSeIOEm9uGeMDA8P+8UXwM/apCMkirfFww6JvGgtFBbTs5UNzzYazIl2VSveIFFxmooy8bodOpAnNhkcScX+GelxtDXSuA2i116MOAsD0zmKf80Us01ieb3/OST3d7ebHmb1LVC5qEXqEuk/bZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430356; c=relaxed/simple;
	bh=ic1msN5tmISeUCdOjVCKVfBcVNyyzBxWsBminIYjo1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDdeuodQLjN8eMTH2GS6rLxxr1FQOCqElzcQ1SvgclMn2pkYAjwcUb7BIGloF1+sG1TdXPoCRh1oOafOjFOXf52TKJVPBGMx00FPwCMWx2aZifffnVhchpuTY0jC6/PptYelN/lDQcWVWECzOhAQP1AwiJV9+2RQVUfT1dFHGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gavP0t2T; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VyBcvUdkHv130+nutZFFWhe86AxTJkftAD0IEJ1h/Zs=; t=1713430353; x=1714639953; 
	b=gavP0t2TQbZ0aW0npn0XUkRz41LWgNPQHvaP2j4J36ebP6nfspoGfHHztcRXqzn9Ui3a8OygHX/
	4UvqVRU8z7jGyH8Q7tFWkDIv3zfS4+hnTVhNbl6xcyL9jW6asyQm9S3C1IVC4sPdaNhgcHyBe5kim
	mzi+1TxpPGxXnnu6yhOw1Nv9jS0KpjH+PsuZvYSxwOFsqZFut4dW5d8FBMhp85Dh92ZvORvRhQ2bb
	WPowEzU2fivAnkZSm/r6EnMpZqBV6piLixtBeuB6ugys+YK7V+n/5kr7NqxOKU8fG+EvMui/LTjGf
	97qz4ASmyaAMgkQu9FIDL+AL9AB1GIt2SLOw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVI-0000000CIvO-156A;
	Thu, 18 Apr 2024 10:52:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 1/8] wifi: mac80211: fix idle calculation with multi-link
Date: Thu, 18 Apr 2024 10:52:19 +0200
Message-ID: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The vif's idle state doesn't automatically go to true when
any link removes the channel context, it's only idle when
_all_ links no longer have a channel context. Fix that.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 80e4b9784131..ccacaed32817 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -797,6 +797,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *conf;
 	struct ieee80211_chanctx *curr_ctx = NULL;
+	bool new_idle;
 	int ret = 0;
 
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_NAN))
@@ -829,8 +830,6 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 out:
 	rcu_assign_pointer(link->conf->chanctx_conf, conf);
 
-	sdata->vif.cfg.idle = !conf;
-
 	if (curr_ctx && ieee80211_chanctx_num_assigned(local, curr_ctx) > 0) {
 		ieee80211_recalc_chanctx_chantype(local, curr_ctx);
 		ieee80211_recalc_smps_chanctx(local, curr_ctx);
@@ -843,9 +842,27 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 		ieee80211_recalc_chanctx_min_def(local, new_ctx, NULL);
 	}
 
-	if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
-	    sdata->vif.type != NL80211_IFTYPE_MONITOR)
-		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_IDLE);
+	if (conf) {
+		new_idle = false;
+	} else {
+		struct ieee80211_link_data *tmp;
+
+		new_idle = true;
+		for_each_sdata_link(local, tmp) {
+			if (rcu_access_pointer(tmp->conf->chanctx_conf)) {
+				new_idle = false;
+				break;
+			}
+		}
+	}
+
+	if (new_idle != sdata->vif.cfg.idle) {
+		sdata->vif.cfg.idle = new_idle;
+
+		if (sdata->vif.type != NL80211_IFTYPE_P2P_DEVICE &&
+		    sdata->vif.type != NL80211_IFTYPE_MONITOR)
+			ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_IDLE);
+	}
 
 	ieee80211_check_fast_xmit_iface(sdata);
 
-- 
2.44.0


