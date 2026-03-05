Return-Path: <linux-wireless+bounces-32545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAmeKWqkqWl5BQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:42:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F8214B96
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC25A31B71DE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAA3CB2C3;
	Thu,  5 Mar 2026 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqO1cP2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3D3CA491;
	Thu,  5 Mar 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725031; cv=none; b=FJIX39XXuDBuX+WIbWn6w6wjT274im7RE67tamaomSW/mV5EnkOSa0isyLY3TP8Fk4LzAiAWeIxwJtKgngvtXn6DGl/qchh4i8eaHFpBxSFAUPOxcRS9MvKOP9GUtOsWstnrsrzCEUmap2o7t3h3GA/BzvmSWHogABZDeWCMUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725031; c=relaxed/simple;
	bh=irmxYN0RdXbC8z9wmgJ+nIquOhFEeCWig0CoW1oDPck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLAcED2zYpx6b9TpLdPK9Wcv5OrWIq9F4+bf/R1Ir0ylAQrcYLpdkmFQH1ZGrsnCuG0xhzxiioYMgJ4JKH9RVXq5WP/vVF7HVrwLY9t4UbNqUJSahHNCX5T2ugQf5+VIvuk851kaRZtHdu7JcMssAenN8VuZoV1JPqo++HSuXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqO1cP2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38FDC116C6;
	Thu,  5 Mar 2026 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725031;
	bh=irmxYN0RdXbC8z9wmgJ+nIquOhFEeCWig0CoW1oDPck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqO1cP2ZOJTHkU27taBRi8toj/uylMGVqwGQ9+1XymHDLedOD0nw3Tgn3yoaQYhCn
	 N67P0iHFm6y3AkbcK4GoDGazBPB36fm4kBV77bhukyi0fjpt8FAyqJlKinfm/64/S6
	 bL7oP4fjKGBjTKQ3r9nrGNd+HfK6QKHquHaJbtIuajuRRYnirIFKxaiTYtpHFtc773
	 qmAlTRjJUU9QB9FxVSvkx+jBiLotKAZv5I3wRywvi7anB8QbyEuS/jL+wPqlA8rbcH
	 PhQ7PY4nXq3rPgmCnoRKO3GQDUcKs3v/2vPZDxJQZKCy4BsxUGFKBXC3AeGk407IVH
	 lzYKAXBRS3lvw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ramanathan Choodamani <quic_rchoodam@quicinc.com>,
	Aishwarya R <aishwarya.r@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.1] wifi: mac80211: set default WMM parameters on all links
Date: Thu,  5 Mar 2026 10:36:47 -0500
Message-ID: <20260305153704.106918-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305153704.106918-1-sashal@kernel.org>
References: <20260305153704.106918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 053F8214B96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32545-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,msgid.link:url,quicinc.com:email,qualcomm.com:email]
X-Rspamd-Action: no action

From: Ramanathan Choodamani <quic_rchoodam@quicinc.com>

[ Upstream commit 2259d14499d16b115ef8d5d2ddc867e2be7cb5b5 ]

Currently, mac80211 only initializes default WMM parameters
on the deflink during do_open(). For MLO cases, this
leaves the additional links without proper WMM defaults
if hostapd does not supply per-link WMM parameters, leading
to inconsistent QoS behavior across links.

Set default WMM parameters for each link during
ieee80211_vif_update_links(), because this ensures all
individual links in an MLD have valid WMM settings during
bring-up and behave consistently across different BSS.

Signed-off-by: Ramanathan Choodamani <quic_rchoodam@quicinc.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Link: https://patch.msgid.link/20260205094216.3093542-1-aishwarya.r@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### What the commit fixes

In WiFi 7 Multi-Link Operation (MLO), mac80211 creates multiple links
per interface. During `do_open()` (iface.c:1519), default WMM (QoS)
parameters are only set on `sdata->deflink`. When additional links are
created via `ieee80211_vif_update_links()`, they never receive WMM
defaults. If hostapd doesn't explicitly configure per-link WMM
parameters, these secondary links operate with uninitialized/zeroed QoS
settings, causing inconsistent behavior across links.

### The fix

Two lines added to `ieee80211_vif_update_links()` in
`net/mac80211/link.c`:
1. A `bool non_sta` variable (mirrors the pattern at iface.c:1520)
2. A call to `ieee80211_set_wmm_default(&link->data, true, non_sta)` in
   the loop that initializes new links (line 340)

This is an exact mirror of what `do_open()` does for the deflink,
ensuring all newly allocated links get the same WMM defaults.

### Stable kernel criteria assessment

- **Fixes a real bug**: Yes — secondary MLO links have uninitialized WMM
  params leading to broken QoS behavior
- **Obviously correct**: Yes — mirrors existing call pattern from
  `do_open()`, same function, same parameter semantics
- **Small and contained**: Yes — 2 lines in a single file
- **No new features**: Correct — just initializing existing structures
  that were missed
- **Risk**: Very low — `ieee80211_set_wmm_default()` is called from many
  places already (iface.c, ibss.c, mlme.c) and is well-tested

### Scope and impact

MLO is increasingly used in WiFi 7 deployments. Without this fix, AP
operators using MLO who rely on mac80211 defaults (instead of explicit
hostapd WMM config per link) get broken QoS on secondary links. This
affects throughput prioritization for video, voice, and background
traffic on those links.

### Dependencies

The fix requires MLO infrastructure which was introduced around v6.1
(2022). The `ieee80211_vif_update_links()` function exists in
net/mac80211/link.c which was created in September 2022. Any stable tree
with MLO support needs this fix. The patch is self-contained with no
other dependencies.

### Verification

- Confirmed via grep that `ieee80211_set_wmm_default()` is called from
  10+ locations across mac80211 (iface.c, ibss.c, mlme.c) — the function
  is mature and well-tested
- Confirmed iface.c:1519 only calls `ieee80211_set_wmm_default` on
  `&sdata->deflink`, verifying the bug claim
- Read `ieee80211_vif_update_links()` in link.c and confirmed the new
  call is placed in the correct loop (`for_each_set_bit(link_id, &add,
  ...)`) right after `ieee80211_link_init()` and
  `ieee80211_link_setup()` — same initialization phase
- Confirmed the `non_sta` variable uses the identical expression
  `sdata->vif.type != NL80211_IFTYPE_STATION` from iface.c:1520
- The commit is authored by Qualcomm engineers and merged by Johannes
  Berg (mac80211 maintainer), indicating proper review
- Could NOT verify exact stable tree versions containing MLO
  infrastructure (unverified, but MLO was introduced ~v6.1)

### Conclusion

This is a clear, surgical bug fix for missing initialization of WMM
parameters on MLO secondary links. It's 2 lines, mirrors existing well-
tested patterns, was reviewed by the mac80211 maintainer, and fixes real
QoS issues for MLO deployments. Low risk, clear benefit.

**YES**

 net/mac80211/link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 1e05845872afc..b659497680b51 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -281,6 +281,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
 	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
 	bool use_deflink = old_links == 0; /* set for error case */
+	bool non_sta = sdata->vif.type != NL80211_IFTYPE_STATION;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -337,6 +338,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		link = links[link_id];
 		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
 		ieee80211_link_setup(&link->data);
+		ieee80211_set_wmm_default(&link->data, true, non_sta);
 	}
 
 	if (new_links == 0)
-- 
2.51.0


