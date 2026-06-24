Return-Path: <linux-wireless+bounces-38058-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vu0BBR5DPGpslwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38058-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 22:50:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4B6C1482
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 22:50:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L6ZvWZoI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38058-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38058-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 399C130377BB
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0723D37DAB1;
	Wed, 24 Jun 2026 20:50:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E105383326
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 20:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334218; cv=none; b=UnKcwj6ctT7mxYXKtQl0Gp9JdJnX9P0MTweSxXBvqGN11fSjIa5Uj/or8/7vYz8ktBvmqWqGNg1lSz9zXuVppddQ0UUgQBwbe5nkqmQIS/MX5vObioUSTBpNHSDaTAgZf4slyuqE4J85MGnIcSthz0g56Nl5GRhy7CL4yJeI5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334218; c=relaxed/simple;
	bh=jFTf4PrLX22uvgBVIFxRSx3JKDE5mssT8ULm4dUrvlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6KCbbdY3cKhxTuA6dDd9Yxkb4ORbOemx5GNpb5/AsSPexFE6zOo7zGDUdKiCGs4dgN3yqbTNdLLMB9o1Kf0V4mRiAMG2SLCiIhwqIq22RVyWvINwK6dsfc6/YcMYPsVFHJn3Duyr6cRAKA0EsS9kK0qK5iTRkiC9J9IeqoS6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6ZvWZoI; arc=none smtp.client-ip=209.85.221.65
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-46cbe01d4b6so689784f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 13:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782334211; x=1782939011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJGqi/K1v+ssUJNVChcD2KX05iBVf8qFmmPThWCAueY=;
        b=L6ZvWZoIFNQr+ftL2+qP57eVhR3GYafKc8faNHEBt5dhqTe3eoPZrPNkhGoX4MnHEh
         4qy8tO4yC9afmGheD5+rL97tL2TvyRQKWODUC7KqdziVzgG0nkL0gvW5CFLT2EBpiMPf
         yT1VGjLTiiTnRSGgGaJSRrWjOLUn9sKCYc7q8ZnGBF2OipaZzHBUN6pMa1vQ2Xmz4jUa
         zLocjgHGlfWQY+9dzLKkfx476gsaV5jY9o5isFAHZA/M2c9EFOohcnndzNjQVXPbeacr
         piYM8l9bNXzqZiuADsTmjPr+3Uz5p0wFFrVgPdaFNGIPA3BmiC9ZtvobRCoI2kXe13dx
         tWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782334211; x=1782939011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJGqi/K1v+ssUJNVChcD2KX05iBVf8qFmmPThWCAueY=;
        b=IFjnxvCUz0EV2H7H+eyqUIUytVkyNiijYdCgtKqjPVxe/T1hyxaG5giv1QZKrQzwx6
         hzksha46Q2wkjrcQef2BZhHKmTC/7bsQroXZX3QS400GpZ01+27PtMrtUY5TAQzRS6PK
         jmICV/M3Y8+T48fbCWLKdBg4+BC/aI97ohCJYDW6O0p44VqPWICEplu4DJOUUpC3CImP
         gmb8oZRGy+AEMAyAwlVbguIGJ+w+0BzJtGd2YZHRK44XYZ+qUcQG4DqGssB/2j4q4BPd
         flUmL7EgG5HNkZGuqZJ7uS6rdlIcGeh37tJENGowKKigJSLAhb1UKw0EHURabxwm8MJr
         eJMw==
X-Gm-Message-State: AOJu0YzhvAJ4hhPFSoeouUZVMhp65tK8EVkF4Nrc9DrhwpRTZBnFqekC
	G5MZCKv/Al9q0COg9QiBo5pExdROLJl4NTEvtg0RJEs9s1klWG4p80NnOiazP6IBWSsRWQ==
X-Gm-Gg: AfdE7claYgRTL8Yd0fDTkYkzGzgPuyWhXkMMizylA/81QLlGuJzh7+SOvUq8xivCj8V
	r2vp7VcmTkkHY3Z4jJWQFKY4+ZFGK+nnUqMWbd7xmE6dZUYkTIbu4grkACVOwn0sqEU1+7YPbK1
	W2FS0228AUEr93HCDkU5QKAKs4papMu9dfeDeUA/hgn2iVfdmtnWHwwB1ulCDlU9CJRECoOa6nF
	+irkouP3s6qNlbklE5H3Q0ESzqCs5IKriMlsqRP5wR3lg/xwVoVTtC14t48hsscsMIAw5f/8VrA
	V42mxBbtVsVSIqQvbNjKgnrpqDFbT+xpBrheOQOqO+dAOlb9Nx72ZIC3+ut9fCdKusQgehhPHwe
	L+PJszPRLNgrxcx2osM85LbOmOwoO0yRlFusVYtvgiWSGkRr9B3Zar5/m2YIu1ncRj2oz/JYCwe
	rlOrmbSvRXt/0=
X-Received: by 2002:a05:6000:38b:b0:46d:638e:4581 with SMTP id ffacd0b85a97d-46d638e47a4mr787843f8f.14.1782334210625;
        Wed, 24 Jun 2026 13:50:10 -0700 (PDT)
Received: from fedora ([212.253.214.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22b73badsm9880992f8f.33.2026.06.24.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 13:50:10 -0700 (PDT)
From: Serhat Kumral <serhatkumral1@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org,
	Serhat Kumral <serhatkumral1@gmail.com>
Subject: [PATCH] wifi: cfg80211: replace BOOL_TO_STR macro with str_true_false()
Date: Wed, 24 Jun 2026 23:49:38 +0300
Message-ID: <20260624204938.15222-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38058-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:serhatkumral1@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7B4B6C1482

Remove the local BOOL_TO_STR macro and replace all its usages with
the kernel's str_true_false() helper from <linux/string_choices.h>.

No functional change intended.

Signed-off-by: Serhat Kumral <serhatkumral1@gmail.com>
---
 net/wireless/trace.h | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 94944f2a39a4..befab459852a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -14,6 +14,7 @@
 
 #include <linux/rtnetlink.h>
 #include <linux/etherdevice.h>
+#include <linux/string_choices.h>
 #include <net/cfg80211.h>
 #include "core.h"
 
@@ -228,7 +229,6 @@
 		__entry->plink_state = sinfo->plink_state;	       \
 	} while (0)
 
-#define BOOL_TO_STR(bo) (bo) ? "true" : "false"
 
 #define QOS_MAP_ENTRY __field(u8, num_des)			\
 		      __array(u8, dscp_exception,		\
@@ -578,7 +578,7 @@ DECLARE_EVENT_CLASS(key_handle,
 	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %d, "
 		  "key_index: %u, pairwise: %s, mac addr: %pM",
 		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id,
-		  __entry->key_index, BOOL_TO_STR(__entry->pairwise),
+		  __entry->key_index, str_true_false(__entry->pairwise),
 		  __entry->mac_addr)
 );
 
@@ -621,7 +621,7 @@ TRACE_EVENT(rdev_add_key,
 		  "mac addr: %pM",
 		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id,
 		  __entry->key_index, __entry->mode,
-		  BOOL_TO_STR(__entry->pairwise), __entry->mac_addr)
+		  str_true_false(__entry->pairwise), __entry->mac_addr)
 );
 
 TRACE_EVENT(rdev_set_default_key,
@@ -647,8 +647,8 @@ TRACE_EVENT(rdev_set_default_key,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
 		  "key index: %u, unicast: %s, multicast: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
-		  __entry->key_index, BOOL_TO_STR(__entry->unicast),
-		  BOOL_TO_STR(__entry->multicast))
+		  __entry->key_index, str_true_false(__entry->unicast),
+		  str_true_false(__entry->multicast))
 );
 
 TRACE_EVENT(rdev_set_default_mgmt_key,
@@ -733,7 +733,7 @@ TRACE_EVENT(rdev_start_ap,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->ssid, CHAN_DEF_PR_ARG,
 		  __entry->beacon_interval, __entry->dtim_period,
 		  __entry->hidden_ssid, __entry->wpa_ver,
-		  BOOL_TO_STR(__entry->privacy), __entry->auth_type,
+		  str_true_false(__entry->privacy), __entry->auth_type,
 		  __entry->inactivity_timeout, __entry->link_id)
 );
 
@@ -1469,7 +1469,7 @@ TRACE_EVENT(rdev_assoc,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", bssid: %pM"
 		  ", previous bssid: %pM, use mfp: %s, flags: 0x%x",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
-		  __entry->prev_bssid, BOOL_TO_STR(__entry->use_mfp),
+		  __entry->prev_bssid, str_true_false(__entry->use_mfp),
 		  __entry->flags)
 );
 
@@ -1518,7 +1518,7 @@ TRACE_EVENT(rdev_disassoc,
 		  ", reason: %u, local state change: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid,
 		  __entry->reason_code,
-		  BOOL_TO_STR(__entry->local_state_change))
+		  str_true_false(__entry->local_state_change))
 );
 
 TRACE_EVENT(rdev_mgmt_tx_cancel_wait,
@@ -1591,7 +1591,7 @@ TRACE_EVENT(rdev_connect,
 		  ", ssid: %s, auth type: %d, privacy: %s, wpa versions: %u, "
 		  "flags: 0x%x, previous bssid: %pM",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->bssid, __entry->ssid,
-		  __entry->auth_type, BOOL_TO_STR(__entry->privacy),
+		  __entry->auth_type, str_true_false(__entry->privacy),
 		  __entry->wpa_versions, __entry->flags, __entry->prev_bssid)
 );
 
@@ -2033,7 +2033,7 @@ TRACE_EVENT(rdev_tdls_mgmt,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->peer,
 		  __entry->link_id, __entry->action_code, __entry->dialog_token,
 		  __entry->status_code, __entry->peer_capability,
-		  BOOL_TO_STR(__entry->initiator),
+		  str_true_false(__entry->initiator),
 		  ((u8 *)__get_dynamic_array(buf))[0])
 );
 
@@ -2246,9 +2246,9 @@ TRACE_EVENT(rdev_mgmt_tx,
 	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", " CHAN_PR_FMT ", offchan: %s,"
 		  " wait: %u, no cck: %s, dont wait for ack: %s",
 		  WIPHY_PR_ARG, WDEV_PR_ARG, CHAN_PR_ARG,
-		  BOOL_TO_STR(__entry->offchan), __entry->wait,
-		  BOOL_TO_STR(__entry->no_cck),
-		  BOOL_TO_STR(__entry->dont_wait_for_ack))
+		  str_true_false(__entry->offchan), __entry->wait,
+		  str_true_false(__entry->no_cck),
+		  str_true_false(__entry->dont_wait_for_ack))
 );
 
 TRACE_EVENT(rdev_tx_control_port,
@@ -2276,7 +2276,7 @@ TRACE_EVENT(rdev_tx_control_port,
 		  " proto: 0x%x, unencrypted: %s, link: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->dest,
 		  be16_to_cpu(__entry->proto),
-		  BOOL_TO_STR(__entry->unencrypted),
+		  str_true_false(__entry->unencrypted),
 		  __entry->link_id)
 );
 
@@ -2894,7 +2894,7 @@ TRACE_EVENT(rdev_set_multicast_to_unicast,
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", unicast: %s",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  BOOL_TO_STR(__entry->enabled))
+		  str_true_false(__entry->enabled))
 );
 
 DEFINE_EVENT(wiphy_wdev_evt, rdev_get_txq_stats,
@@ -3225,7 +3225,7 @@ TRACE_EVENT(cfg80211_return_bool,
 	TP_fast_assign(
 		__entry->ret = ret;
 	),
-	TP_printk("returned %s", BOOL_TO_STR(__entry->ret))
+	TP_printk("returned %s", str_true_false(__entry->ret))
 );
 
 DECLARE_EVENT_CLASS(cfg80211_netdev_mac_evt,
@@ -3500,7 +3500,7 @@ TRACE_EVENT(cfg80211_mgmt_tx_status,
 		__entry->ack = ack;
 	),
 	TP_printk(WDEV_PR_FMT", cookie: %llu, ack: %s",
-		  WDEV_PR_ARG, __entry->cookie, BOOL_TO_STR(__entry->ack))
+		  WDEV_PR_ARG, __entry->cookie, str_true_false(__entry->ack))
 );
 
 TRACE_EVENT(cfg80211_control_port_tx_status,
@@ -3517,7 +3517,7 @@ TRACE_EVENT(cfg80211_control_port_tx_status,
 		__entry->ack = ack;
 	),
 	TP_printk(WDEV_PR_FMT", cookie: %llu, ack: %s",
-		  WDEV_PR_ARG, __entry->cookie, BOOL_TO_STR(__entry->ack))
+		  WDEV_PR_ARG, __entry->cookie, str_true_false(__entry->ack))
 );
 
 TRACE_EVENT(cfg80211_rx_control_port,
@@ -3542,7 +3542,7 @@ TRACE_EVENT(cfg80211_rx_control_port,
 	),
 	TP_printk(NETDEV_PR_FMT ", len=%d, %pM, proto: 0x%x, unencrypted: %s, link: %d",
 		  NETDEV_PR_ARG, __entry->len, __entry->from,
-		  __entry->proto, BOOL_TO_STR(__entry->unencrypted),
+		  __entry->proto, str_true_false(__entry->unencrypted),
 		  __entry->link_id)
 );
 
@@ -3726,7 +3726,7 @@ TRACE_EVENT(cfg80211_probe_status,
 	),
 	TP_printk(NETDEV_PR_FMT " addr:%pM, cookie: %llu, acked: %s",
 		  NETDEV_PR_ARG, __entry->addr, __entry->cookie,
-		  BOOL_TO_STR(__entry->acked))
+		  str_true_false(__entry->acked))
 );
 
 TRACE_EVENT(cfg80211_cqm_pktloss_notify,
@@ -3769,7 +3769,7 @@ TRACE_EVENT(cfg80211_pmksa_candidate_notify,
 	),
 	TP_printk(NETDEV_PR_FMT ", index:%d, bssid: %pM, pre auth: %s",
 		  NETDEV_PR_ARG, __entry->index, __entry->bssid,
-		  BOOL_TO_STR(__entry->preauth))
+		  str_true_false(__entry->preauth))
 );
 
 TRACE_EVENT(cfg80211_report_obss_beacon,
@@ -3848,7 +3848,7 @@ TRACE_EVENT(cfg80211_scan_done,
 		}
 	),
 	TP_printk("aborted: %s, scan start (TSF): %llu, tsf_bssid: %pM",
-		  BOOL_TO_STR(__entry->aborted),
+		  str_true_false(__entry->aborted),
 		  (unsigned long long)__entry->scan_start_tsf,
 		  __entry->tsf_bssid)
 );
-- 
2.54.0


