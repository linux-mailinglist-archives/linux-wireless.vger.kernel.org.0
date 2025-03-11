Return-Path: <linux-wireless+bounces-20170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B82A5BEB6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 12:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581EE3A476C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519A227B94;
	Tue, 11 Mar 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wCrpTpat"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01F2222D0
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691838; cv=none; b=kbIx9dzdDgBI51pKPvfH00Luc6tZlKFs8qDa6R0yJclNWs/63rUK0IHiRQGEBdQ3S9nZpwxOVPTLFntUDD3p/Qe+Gvd3tzO8hKZBP9cewrHrV/mjZMLA/uW+q617cISTDZFEN96Eq7LMqaNq/Sdg17OhVxIIDp4NBJcKpEXow3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691838; c=relaxed/simple;
	bh=0wwvXRvQ1+BNdGUDZofBjtH+cczZuQhigEH0HqZwNYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERrVmThofek5nIovWcWk/ouOR25uBWSFDKjv4k+NX+glT2NH1s7Uz3xqLdEMgq9uRqvc4zBOXOMrli6Gtx2gNqfLb2sms2GF045FpF0izFa3B436KKvKDaPB+sCR0nb97CZKFQDXqjT8O9tQPpXBGzy+vc2bdi+0x/dbtYb2sBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wCrpTpat; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3RQTr4zUGublhKpkuy/6qvFXHqIZaQPez9EVjpOT7eU=; t=1741691837; x=1742901437; 
	b=wCrpTpatdRSFLzjl5nonlevyxmLX77qYVxMSA9M9dHF1EtpRx61aXSe9PeMaSLg1peXwFNOfPPD
	iwTUuafl4FIZg/2yX2oMI7RGwJrGhY9Dv5tte2Wvzuld321LO88jhkkXiKg7H4LZRl/XrOd0y8w/E
	VmsY4YUt1ZJ/iOq3izm/QHS1684PZQX8A+g8ZPDU5YXPr+d6xqQOzuTAOXwEbKac+HcBzHSOMTHaU
	8BrksxyT+fPgnEXgCt54KOjcXGh87w3PvRBwdazZSArepcbaihqBidclBx4f57WCIxfWrsgDKeuII
	O7Hj4OjkZPpPj0Dy2qarit4wKaqRUoxDTniw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trxbm-00000007ozf-2gIb;
	Tue, 11 Mar 2025 12:17:14 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless] wifi: mac80211: fix MPDU length parsing for EHT 5/6 GHz
Date: Tue, 11 Mar 2025 12:17:04 +0100
Message-ID: <20250311121704.0634d31f0883.I28063e4d3ef7d296b7e8a1c303460346a30bf09c@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The MPDU length is only configured using the EHT capabilities element on
2.4 GHz. On 5/6 GHz it is configured using the VHT or HE capabilities
respectively.

Fixes: cf0079279727 ("wifi: mac80211: parse A-MSDU len from EHT capabilities")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/eht.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 7a3116c36df9..fd41046e3b68 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -2,7 +2,7 @@
 /*
  * EHT handling
  *
- * Copyright(c) 2021-2024 Intel Corporation
+ * Copyright(c) 2021-2025 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -76,6 +76,13 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 	link_sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(link_sta);
 	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
 
+	/*
+	 * The MPDU length bits are reserved on all but 2.4 GHz and get set via
+	 * VHT (5 GHz) or HE (6 GHz) capabilities.
+	 */
+	if (sband->band != NL80211_BAND_2GHZ)
+		return;
+
 	switch (u8_get_bits(eht_cap->eht_cap_elem.mac_cap_info[0],
 			    IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK)) {
 	case IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454:
-- 
2.48.1


