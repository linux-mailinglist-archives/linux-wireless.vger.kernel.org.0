Return-Path: <linux-wireless+bounces-8876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C4490529B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8050B20DDD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2817083F;
	Wed, 12 Jun 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n3/lG1Ya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763316FF3E
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195835; cv=none; b=isx0xdvSAARs0R/wvWYyHVwE4l3G4RVC9+3c5zyoQHQ/5TDXZb85Jfr2Tr2gEHi+JXC2EgYPMBl8NU02uqzX8N3BVmSRix5WvwVv+gJHInCkx/3VelscBkA8nql2m0CU0i9ohVsiq+/HPsF5fr0NPxX3BGgHQ4SJm+la9eD3muY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195835; c=relaxed/simple;
	bh=w2Br6UDueL4M26SFC+kjiJwIdAzUN2QIOP0pU+kfcW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohI/0JPQx0qg9RgPL44bLkkRNvlXbUmyzTtqKoQiMYY+PTXaOJLEovKUuxsxrBRKSNUbZtJSEQT9EUBXIxFUbYsHyZ/K/Nmpeksn6YY89p74P3MrPwbM8bkjZfqhreJD0CZT2JwFxdU1lzVL5mLBRLzPArFuPyXz0AhnbirXcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n3/lG1Ya; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2lUv2X3AmHo2Qws41cN+p9itpz0YFs14JwerG26zAA4=;
	t=1718195834; x=1719405434; b=n3/lG1Ya5PILCN2kLqvcbn3FjWxujfaytOexeSpkf1Mvule
	HwSbB/rk8+TJYpniR7M+OrTQHwO4L+cWcdf2FxoNNnEyG5tRtrw7OI1Q1Q/+SwaLvqNDNP6jL6GV4
	gbGKX07yLrffAYpLpZMMfRASt3ntikmAQksxhWZLzVxDfvv45KXD+mAhYhR16/BcYhJvyFfOy3dd4
	exMiq81ffd4FekM4QU6U2ka0NOA0VDX/usNcuhjU06DIdnRACJycnXyIiPFSqi2jlXoJfEbxYpHgd
	Cm8TCJ95dj1oSO8sJekrnGcaKobZclLNe83yThdckn2vbm8UDebF4NVBzVnvBhRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNDz-0000000AH0b-1sK8;
	Wed, 12 Jun 2024 14:37:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: correcty limit wider BW TDLS STAs
Date: Wed, 12 Jun 2024 14:35:57 +0200
Message-ID: <20240612143707.1ad989acecde.I5c75c94d95c3f4ea84f8ff4253189f4b13bad5c3@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123707.38067-4-johannes@sipsolutions.net>
References: <20240612123707.38067-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When updating a channel context, the code can apply wider
bandwidth TDLS STA channel definitions to each and every
channel context used by the device, an approach that will
surely lead to problems if there is ever more than one.

Restrict the wider BW TDLS STA consideration to only TDLS
STAs that are actually related to links using the channel
context being updated.

Fixes: 0fabfaafec3a ("mac80211: upgrade BW of TDLS peers when possible")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index ec16d7676088..2f7cbb998b96 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -775,13 +775,24 @@ void ieee80211_recalc_chanctx_chantype(struct ieee80211_local *local,
 
 	/* TDLS peers can sometimes affect the chandef width */
 	list_for_each_entry(sta, &local->sta_list, list) {
+		struct ieee80211_sub_if_data *sdata = sta->sdata;
 		struct ieee80211_chan_req tdls_chanreq = {};
+		int tdls_link_id;
+
 		if (!sta->uploaded ||
 		    !test_sta_flag(sta, WLAN_STA_TDLS_WIDER_BW) ||
 		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
 		    !sta->tdls_chandef.chan)
 			continue;
 
+		tdls_link_id = ieee80211_tdls_sta_link_id(sta);
+		link = sdata_dereference(sdata->link[tdls_link_id], sdata);
+		if (!link)
+			continue;
+
+		if (rcu_access_pointer(link->conf->chanctx_conf) != conf)
+			continue;
+
 		tdls_chanreq.oper = sta->tdls_chandef;
 
 		/* note this always fills and returns &tmp if compat */
-- 
2.45.2


