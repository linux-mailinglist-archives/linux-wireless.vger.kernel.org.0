Return-Path: <linux-wireless+bounces-28758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26483C4673B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD715189A614
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B434F30FC01;
	Mon, 10 Nov 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgQ1WQwO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ACB30E0DC
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776125; cv=none; b=BegpU7ay6JCEWjvrm793r3o6KNCBe4S1kzln/mWaBpizmEJ/+Ni/BANQ2DHGv56klhk8mlZJ2g/aXIfTDx8XJ36Epnlik6JTk51iBHWtCOAcHOhxOwiCDdpKNF203KIwNxEx5Ykl0VSki8c7jaPle3XmHR3QWXFNZ3wrqAurjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776125; c=relaxed/simple;
	bh=uCi9fR6gGgL1VRZIMOCZRsPtB1fs8o9cNn6lwh1/aIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EAlYY7rxJTCyU68Exe8mp5Q4k1jlkPJOK3tYnYV/lNJxg+3uW2ZIPKFkmmBu7I2XzEO84eN3ff9ih+AFMhUQ9wRWRWNGmkTlDVCJ9VAxICj9tRXjkuajLVUcGvygiBp6GzvpP1rulJ+XI3xSGty+t24/gwZlzrDOzXGX3Vl8ytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgQ1WQwO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776124; x=1794312124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uCi9fR6gGgL1VRZIMOCZRsPtB1fs8o9cNn6lwh1/aIc=;
  b=VgQ1WQwOTviaeLZodcFcMoREglERA2zm2tByB9zdRFfbF1ix3mPAOqGm
   E9ohhYrF8tJLbTa5piaUdiUbJ/Yj23RbY3v/iu9RTfKju04wctZTh0KGu
   9UpNgEUq6RYWz3Ok65sgpDRae5Li5lupPGJpc/oOR1pGPgSWbRNhUTyp2
   GgevfonQNGSAQxm4fISCl2ZzUyl7rchVE4RdSW9pfKvCKxF2L/NF+RoCX
   SgjelDUe9nzIz9Gci5XCtGcltqe9LLDoPUxGE47j0XdBAQzCgyvUyB1uU
   rcKVPmvikWU/tZnuZhtZucI5+sArYsdk+wwXHdWKp6ZEeByA54OL/tW6q
   g==;
X-CSE-ConnectionGUID: erxLRFVDTA+R5htTU/u9nA==
X-CSE-MsgGUID: +fNMWy5ZRDSUjJaMBUTXVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="63829844"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="63829844"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:02:03 -0800
X-CSE-ConnectionGUID: 4SSxnq7tQUmMwrgZOxKLpA==
X-CSE-MsgGUID: SpgUA0GCQB+SKa1P4Bl3hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="189097447"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:02:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211_hwsim: Fix possible NULL dereference
Date: Mon, 10 Nov 2025 14:01:54 +0200
Message-Id: <20251110140128.ec00ae795a32.I9c65659b52434189d8b2ba06710d482669a3887a@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The 'vif' pointer in the Tx information might be NULL, e.g., in
case of injected frames etc. and is not checked in all paths. Fix it.
While at it, also directly use the local 'vif' pointer.

Fixes: a37a6f54439b ("wifi: mac80211_hwsim: Add simulation support for NAN device")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/aNJUlyIiSTW9zZdr@stanley.mountain
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index d28bf18d57ec..5903d82e1ab1 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2003,8 +2003,14 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		struct ieee80211_sta *sta = control->sta;
 		struct ieee80211_bss_conf *bss_conf;
 
+		/* This can happen in case of monitor injection */
+		if (!vif) {
+			ieee80211_free_txskb(hw, skb);
+			return;
+		}
+
 		if (link != IEEE80211_LINK_UNSPECIFIED) {
-			bss_conf = rcu_dereference(txi->control.vif->link_conf[link]);
+			bss_conf = rcu_dereference(vif->link_conf[link]);
 			if (sta)
 				link_sta = rcu_dereference(sta->link[link]);
 		} else {
@@ -2065,13 +2071,13 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
-	if (txi->control.vif)
-		hwsim_check_magic(txi->control.vif);
+	if (vif)
+		hwsim_check_magic(vif);
 	if (control->sta)
 		hwsim_check_sta_magic(control->sta);
 
 	if (ieee80211_hw_check(hw, SUPPORTS_RC_TABLE))
-		ieee80211_get_tx_rates(txi->control.vif, control->sta, skb,
+		ieee80211_get_tx_rates(vif, control->sta, skb,
 				       txi->control.rates,
 				       ARRAY_SIZE(txi->control.rates));
 
-- 
2.34.1


