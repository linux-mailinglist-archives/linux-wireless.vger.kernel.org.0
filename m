Return-Path: <linux-wireless+bounces-2664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B084B8404BC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CAB2837D6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 12:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C36024C;
	Mon, 29 Jan 2024 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cz6hdaJv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623860241
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530470; cv=none; b=mtJ3TY+zvdhZS3Pfw90E1japLlhLx8xTzWeH3Z8pRbk9SRjpCtZ+buw0k7Ca07QhRwIhRNUDqlyXl7uNKRAjCwEBPASJPyMG5FVbMlf65k8sVqSoxaXHTN/hsAUdT4fZGC6E2Q/j1IBraGTSUENI+Dq51BP4ekHphL6m3BAHaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530470; c=relaxed/simple;
	bh=o990qUxfTiRCokUXP29ryWUG0sxVFt5iLLWx7Kx/g4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1WhGw/0dpNWeBgEbezj5F7KSzDiRhV/5GOdt49cEx3kLaHAMmnN9VZ8zsjzqLTgEORyGSu7zusdtDLLunKv+XoX96hReF/jjIAPpArQblc7/adjut6YddHCac14m1RnqvQ/R2E2uCAaLLqkg3YGxl5B9EvEwg3cz9BJbQYyQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cz6hdaJv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=UZVOyeiOQpa9atwmk+wqK79IMjLJnBkLc6u9fJVYwlw=; t=1706530466; x=1707740066; 
	b=Cz6hdaJvraaEBIMnIv4qiRQpalgVP2YTsBTusg6zmXnVPudJ99TDH5KZr/vOewaTj10gEVDS1Dq
	JVuOYej+YJMsxSxWNMcQBBGJGECcq9QWnl+Jqpufyyt8LkkLMTF6l40+GQLqWXRkUq6imvGkoN9DP
	CPS1YG8p5ueIhuQxoEfTzoufY/u4m+dU4qR1r8L4oxID0rP8XqryulwJUwg4XRHW4MonJglb3q33i
	QuBU3c0uZBp+qZnd05kwdvK+FC2n1Up4RTbZI6wuTCpBkH591GPCN+YaCKf72lVG0KZH7nyHdI2Qa
	F5IfwIJsK+9vMkk0PWiEGXT1rZ/eVgCTrEuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUQWl-00000004p5l-3ZhV;
	Mon, 29 Jan 2024 13:14:16 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	coldolt <andypalmadi@gmail.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: cfg80211: detect stuck ECSA element in probe resp
Date: Mon, 29 Jan 2024 13:14:13 +0100
Message-ID: <20240129131413.246972c8775e.Ibf834d7f52f9951a353b6872383da710a7358338@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We recently added some validation that we don't try to
connect to an AP that is currently in a channel switch
process, since that might want the channel to be quiet
or we might not be able to connect in time to hear the
switching in a beacon. This was in commit c09c4f31998b
("wifi: mac80211: don't connect to an AP while it's in
a CSA process").

However, we promptly got a report that this caused new
connection failures, and it turns out that the AP that
we now cannot connect to is permanently advertising an
extended channel switch announcement, even with quiet.
The AP in question was an Asus RT-AC53, with firmware
3.0.0.4.380_10760-g21a5898.

As a first step, attempt to detect that we're dealing
with such a situation, so mac80211 can use this later.

Reported-by: coldolt <andypalmadi@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com/
Fixes: c09c4f31998b ("wifi: mac80211: don't connect to an AP while it's in a CSA process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  4 +++
 net/wireless/scan.c    | 59 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cf79656ce09c..2b54fdd8ca15 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2910,6 +2910,8 @@ struct cfg80211_bss_ies {
  *	own the beacon_ies, but they're just pointers to the ones from the
  *	@hidden_beacon_bss struct)
  * @proberesp_ies: the information elements from the last Probe Response frame
+ * @proberesp_ecsa_stuck: ECSA element is stuck in the Probe Response frame,
+ *	cannot rely on it having valid data
  * @hidden_beacon_bss: in case this BSS struct represents a probe response from
  *	a BSS that hides the SSID in its beacon, this points to the BSS struct
  *	that holds the beacon data. @beacon_ies is still valid, of course, and
@@ -2950,6 +2952,8 @@ struct cfg80211_bss {
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 
+	u8 proberesp_ecsa_stuck:1;
+
 	u8 bssid_index;
 	u8 max_bssid_indicator;
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 2249b1a89d1c..389a52c29bfc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1731,6 +1731,61 @@ static void cfg80211_update_hidden_bsses(struct cfg80211_internal_bss *known,
 	}
 }
 
+static void cfg80211_check_stuck_ecsa(struct cfg80211_registered_device *rdev,
+				      struct cfg80211_internal_bss *known,
+				      const struct cfg80211_bss_ies *old)
+{
+	const struct ieee80211_ext_chansw_ie *ecsa;
+	const struct element *elem_new, *elem_old;
+	const struct cfg80211_bss_ies *new, *bcn;
+
+	if (known->pub.proberesp_ecsa_stuck)
+		return;
+
+	new = rcu_dereference_protected(known->pub.proberesp_ies,
+					lockdep_is_held(&rdev->bss_lock));
+	if (WARN_ON(!new))
+		return;
+
+	if (new->tsf - old->tsf < USEC_PER_SEC)
+		return;
+
+	elem_old = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				      old->data, old->len);
+	if (!elem_old)
+		return;
+
+	elem_new = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				      new->data, new->len);
+	if (!elem_new)
+		return;
+
+	bcn = rcu_dereference_protected(known->pub.beacon_ies,
+					lockdep_is_held(&rdev->bss_lock));
+	if (bcn &&
+	    cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+			       bcn->data, bcn->len))
+		return;
+
+	if (elem_new->datalen != elem_old->datalen)
+		return;
+	if (elem_new->datalen < sizeof(struct ieee80211_ext_chansw_ie))
+		return;
+	if (memcmp(elem_new->data, elem_old->data, elem_new->datalen))
+		return;
+
+	ecsa = (void *)elem_new->data;
+
+	if (!ecsa->mode)
+		return;
+
+	if (ecsa->new_ch_num !=
+	    ieee80211_frequency_to_channel(known->pub.channel->center_freq))
+		return;
+
+	known->pub.proberesp_ecsa_stuck = 1;
+}
+
 static bool
 cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *known,
@@ -1750,8 +1805,10 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 		/* Override possible earlier Beacon frame IEs */
 		rcu_assign_pointer(known->pub.ies,
 				   new->pub.proberesp_ies);
-		if (old)
+		if (old) {
+			cfg80211_check_stuck_ecsa(rdev, known, old);
 			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
+		}
 	}
 
 	if (rcu_access_pointer(new->pub.beacon_ies)) {
-- 
2.43.0


