Return-Path: <linux-wireless+bounces-35197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OInyCi4R6Gm2EgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 02:07:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88180440CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 02:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B775302C5F9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D973FF1;
	Wed, 22 Apr 2026 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFWvnhUP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB61FD4
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776816425; cv=none; b=EH3a4ayjOAFR0UQTj8PhGNRzp0ldHQVOmpVoMhYMZHMi6AihDy85V4fFMR3QSckDski0D+iwtK6XUcJd69YFCUCK0FVJ26UXYwsYIVxNcrWQPHu5Q9AK1C1v5wFCGzLyKv33zh57Tjy3oDqCIhVW0f3En0OsbbiafQCz6a9T2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776816425; c=relaxed/simple;
	bh=wVF1iBXhpMscFx2tY5O3cc38r3BrEeXQDR9XcKj4S5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eo4S1x+0YFAKSI1JaFjzhAgmYzw4tmaplMujTuX6Z4HRJnwdX8ndJuIzMbHIexF6o9I7n963X92AejyjVU8Qp7N+fNVOXGaTy0dk/e9OkendRwg8U6QgzgmwUBYGr9XZwwHum5/V5ZTwRsqEdHiafG0J/JUYRn/99kUoymS+r8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFWvnhUP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8dfb9139008so328909485a.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776816423; x=1777421223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmKKE5FYITyhTGVg5YFLJddC5/jrSBVncuDRBnt19M8=;
        b=JFWvnhUPv5PUZsM4AINv3lpn/PV/yYDsw1O33Nl5jCcOP45saPnHwD02awFwkdHtUK
         P+ySZzl12XL7bSONNgpRQzte5YuxA1HiwU76082A0QKjcENJZXI5husb1WL/6DNS2avG
         bUAZg4GUv/TiWneJuEd594fvQJkQS8GAce2dpf0ePUyWdPEnYRbl69PwR0N/bFPX9zHD
         YqwQigMRBUGZ0Fgj0fO5oBTFUEQTuS2Lz6V2CLlVZk+j9pQDvEvzol3/e3m217HX9S/U
         sU3304ncqE8U2LgBzuTa//EbugoJt4v/5NG0BQcYYk3DyOp5I0I9kN4Q1Pz4dqfV38ew
         KpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776816423; x=1777421223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmKKE5FYITyhTGVg5YFLJddC5/jrSBVncuDRBnt19M8=;
        b=Dcrb2KT5mDMu1kPTITYVsnanYEVv1yzxDTO4A3ANUDsrRY5aplHZm1hRKG5OhcaU5Q
         yRgLmEtDIZbdG+Q00e2IhXS+NfiyR48GeBjbkrBX7F6ICH0MikUvMRYI08al97hwXHjZ
         mIF43XBR16vBMyaQweODqvE9Mx976zPVcIKIYUE17CWbvrd2QkiV3pFmWLF4gPl/rVKS
         f7PZ16kEAi91BVhTEvt9uKz/XFAa+h6g6ddjJsbNJxN0Dgbt519ER/HHvLDAaJI0vWez
         6CmRB03O0jmXIRDDAcb3VDfYJxpUDEPI02Z9qnlmsFyvkqucl3l7eanlvzpbrUzGu9Wx
         b/ng==
X-Gm-Message-State: AOJu0YyIetpX9YfTF77DrTsF4KmArgwJyz+BN+E0rC7nb6nlend5CTWl
	sk17ClwcA1X77xTEAf4H1jiCT8F1yQyuX3u+mUjOih4ysYghmYTKimybgT/6iTZZ
X-Gm-Gg: AeBDieuLaTHtgATJjSJ9Cz4lF/4w+cgzx/PXow5FCNcPrVbJ7FpjV2lxLukYi6mB0mh
	PWI0slwMZrkgt0s3TSQ9Amx93EqF83hF1Oe8wvVtl6kIZKcAqYgfo0RrdZnofWAYcDAAoVOHZdC
	QMJRmNh0EVr3X4KLhkAokURxb96sX6o5SRMZccLlYajbNu6xtr9L5b9OAuIhVMs22oNxQFj0vFR
	jFth0znnzekL82ZgmSrLUeFFgxQV6SHQTZCvEcfiwSeaX8Vd5k743hvSG2L3WzT+2ToGop3tAWb
	/mcov/EEFZQ3CtEgXT68J9awmEdOf448I1pLJnMx5Y80RPf3sSok8U4jnp3APlooUIYUmwPdfod
	CDF3P/4TJb4iSIAaI+NX8iMwCd9hE9VaSytIYSEfcsVHlqVx7R1t7aR6v1/KIDpVAh9tfLFls7n
	2wL+qw5GPx7kVpwxXEK3QK9Rn4ZDy8y4yYbm5PtvKIlsewcVQcD7OerWdQfnt4hcad13hPb9ebf
	q8vSqis4WzD+Vkzl+DbSZ3LSNuRi9E=
X-Received: by 2002:a05:620a:17a3:b0:8d0:27b8:fb7 with SMTP id af79cd13be357-8e79246cd79mr2879505585a.46.1776816423026;
        Tue, 21 Apr 2026 17:07:03 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1177984585a.11.2026.04.21.17.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:07:02 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH] wifi: mac80211: check ieee80211_rx_data_set_link return in pubsta MLO path
Date: Tue, 21 Apr 2026 20:06:51 -0400
Message-ID: <20260422000651.4184602-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35197-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88180440CA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__ieee80211_rx_handle_packet() resolves the link via
ieee80211_rx_data_set_link() on the pubsta->mlo path but ignores the
helper's return value.  Inside the helper,
  rx->link = rcu_dereference(rx->sdata->link[link_id]);
can leave rx->link NULL if link_id references a slot already cleared
by ieee80211_vif_set_links() during station-initiated ML
reconfiguration (see mlme.c's ieee80211_ml_reconfiguration(), which
invalidates sdata->link[] before the matching
ieee80211_sta_remove_link() loop walks the link-sta hash).  RX dispatch
still resolves a link_sta from the hash and then drops into
ieee80211_prepare_and_rx_handle(), which dereferences link->conf->addr.

Every other user site of ieee80211_rx_data_set_link() checks the return
and bails on failure; only this branch did not.  Mirror the safe
pattern.

Fixes: e66b7920aa5a ("wifi: mac80211: fix initialization of rx->link and rx->link_sta")
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---

Notes for reviewers (not part of the commit):

Found by static audit of unchecked return values on
ieee80211_rx_data_set_link() call sites.  The non-pubsta
arm was already fixed upstream by commit 32d340ae6758 ("wifi:
mac80211: fix receiving MLO frames in the non-fast-path"); the
pubsta arm was missed, and this patch mirrors the same shape.

Runtime evidence:

 - Synthetic kernel-side A/B: on parent commit e66b7920aa5a..
   (pre-fix) forcing sdata->link[1] == NULL while sta->link[1]
   stays live causes ieee80211_rx_data_set_link() to return 0
   and ieee80211_prepare_and_rx_handle() to NULL-deref
   link->conf->addr; with the patch applied the guard drops
   the frame instead.

 - Source-level race window confirmed observationally: an
   instrumented pre-fix UML run with real hostapd + wpa_supplicant
   MLO and station-initiated SETUP_LINK_RECONFIG hits
   "sdata->link[1] == NULL while sta_valid_links still carries
   bit 1" on every reconfiguration attempt, inside
   ieee80211_setup_link_reconfig() between ieee80211_vif_set_links()
   and the per-link ieee80211_sta_remove_link() loop.

 - That same instrumented run does not itself crash, for two
   reasons independent of this bug: mac80211_hwsim feeds RX via
   ieee80211_rx_napi(hw, NULL, skb), so the pubsta arm at
   rx.c:5335 is unreachable from hwsim (frames take the
   already-fixed non-pubsta for_each_sta_info arm), and UML is
   single-CPU so RX softirq cannot interleave with the mlme
   reconfig sequence.  Real MLO-capable drivers (iwlwifi, mt76)
   do populate pubsta on their fast RX paths, and SMP hardware
   gives the race the micro-window it needs.

Benjamin Berg's 2026-02 RFC v2 "wifi: mac80211: refactor RX
link_id and station handling"
(20260223133818.9f5550ab445f.I...@changeid) touches the same
code and may supersede or subsume this patch; happy to fold /
rebase / drop.

 net/mac80211/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..e0ab4852c0c6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5332,7 +5332,9 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 				if (!link_sta)
 					goto out;
 
-				ieee80211_rx_data_set_link(&rx, link_sta->link_id);
+				if (!ieee80211_rx_data_set_link(&rx,
+								link_sta->link_id))
+					goto out;
 			}
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
-- 
2.53.0


