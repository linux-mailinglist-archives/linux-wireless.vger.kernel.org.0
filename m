Return-Path: <linux-wireless+bounces-7253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0E8BD5EB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F288A1C20FAC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1915B0FA;
	Mon,  6 May 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="iw2VUnan"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4559315ADBE
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025351; cv=none; b=SfTaHI0wm+5xjfkYcBRM4OE4lAo1RA82u4Rgs4o4St2gEtCd8iKje8pyfhf1RjSmavr/TMmHG1/ipmzOIDm0eIkbRN1xhi57uxyDJpqL5VmewEYA0XF9mjIBI5mnfc4iBGHbcS5VQIAAyWKgmmAGS3FXcfOxNFZI8OtKvzIjBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025351; c=relaxed/simple;
	bh=3iy1XR5gM55LGJyrhH5KlUigCaGn5LDbbJOZNcqjDb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay4WurpaCKTcEGTWhwcBrf3G2ZizmP4wmcWhhU4+vfF44vulbMcve489+KYmnh7J98HCcDKW4Zqv+PMvLdkftq7pATL6rCAsQbr6z9m6uqxUYOSrgcyPq0iWUstXITffsyL7NWsCUKv0czEtiSdTDwEZB8jt4F2ZGhgtDD8mUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=iw2VUnan; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y5N+cyX8Z6N2+1MbxUXLDvzhDzNy3RLlW1HHif10zpI=;
	t=1715025349; x=1716234949; b=iw2VUnan20Dn5yApp9fe/m1gAlhRTIfwdHFgias7cTFpcSI
	+Ow79KsPRdGSP84GhziAjqhDJ24zdDP+1JmTAQxLMmdAP3AGPprwYPhlf220le3nAiri4DLOmIK2k
	vQFVr5KbicguFrC9iIhulPfdcoKm3P0IocQhC7lujjXzluZACt/G+cc1vDdSS1z8zmpgoCbVj/tjb
	wrjqb+rZxXH1E+uQfyx2u/XZqX6qNlLzGT4clN/zzNguzjfzLmhtSLZaJzJXVKVBc24jjrCI0pJlX
	3SUZe+z4etlQrDknGV/dGeGBXku3tVZO7vSnO1xtrhVRhQsnapF0FXzwwKAdveuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44R8-00000008Cj6-1MrI;
	Mon, 06 May 2024 21:55:46 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/4] wifi: mac80211: handle wider bandwidth OFDMA during CSA
Date: Mon,  6 May 2024 21:54:50 +0200
Message-ID: <20240506215543.b2c5a72dac1b.I69f65cb2e75d4a49a174b1aede68bf8ff0a3cab3@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506195543.104411-6-johannes@sipsolutions.net>
References: <20240506195543.104411-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During channel switch, track the AP configuration in the
chanreq, so that wider bandwidth OFDMA is taken into
account correctly, since multiple channel contexts may
be needed due to sharing not being possible due to
wider bandwidth OFDMA.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c      | 8 ++++++--
 net/mac80211/spectmgmt.c | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 702a8399969a..f81e4f82ed7b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2517,8 +2517,13 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		goto drop_connection;
 	}
 
+	link->csa.chanreq = csa_ie.chanreq;
+	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT ||
+	    sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
+		link->csa.chanreq.ap.chan = NULL;
+
 	if (chanctx) {
-		res = ieee80211_link_reserve_chanctx(link, &csa_ie.chanreq,
+		res = ieee80211_link_reserve_chanctx(link, &link->csa.chanreq,
 						     chanctx->mode, false);
 		if (res) {
 			link_info(link,
@@ -2529,7 +2534,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	link->conf->csa_active = true;
-	link->csa.chanreq = csa_ie.chanreq;
 	link->u.mgd.csa.ignored_same_chan = false;
 	link->u.mgd.beacon_crc_valid = false;
 	link->u.mgd.csa.blocked_tx = csa_ie.mode;
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index b2de4c6fb808..df96d3db1c0e 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2008, Intel Corporation
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018, 2020, 2022-2023 Intel Corporation
+ * Copyright (C) 2018, 2020, 2022-2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -366,6 +366,9 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		validate_chandef_by_ht_vht_oper(sdata, conn, vht_cap_info,
 						&new_chandef);
 
+	/* capture the AP chandef before (potential) downgrading */
+	csa_ie->chanreq.ap = new_chandef;
+
 	/* if data is there validate the bandwidth & use it */
 	if (new_chandef.chan) {
 		if (conn->bw_limit < IEEE80211_CONN_BW_LIMIT_320 &&
-- 
2.44.0


