Return-Path: <linux-wireless+bounces-4026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8B868112
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 20:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FED71F23D18
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C544112B165;
	Mon, 26 Feb 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FdTmKm96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39822069
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976054; cv=none; b=hTi8omqdE7e7e+jxySaxFllFrgVCp/V3CtsgBKyHGjzp48WU/uyye1WlqZzs0BCwSpBzHIpuN2vQULBZBhvODq7Oeue3HYF6jYQFILAI5b8Wd0mm/hd5Vi6FFmO8nHPxOM1oMu8K1z7vb9kQ5XcJZHk0NzHhaBhfqu7XeLgxqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976054; c=relaxed/simple;
	bh=bmUGEKUN8DR1U2wai5W4xHW+eqEMOg/QS9DO0hAxi3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyqwXXfusXw8wuF3HJpdBiupcD2h0sVgqReuRLJ2Lu2BD0cGkm0mdjSImlDkzJOxmRJMFO7Uo+togjSiw/+3brFwanPmt1GVD0Ph2wbtYHzQz39Hk0W9IqlANcQHA1clxQ7VBFnAKtKgXp/Sxa/ys0//VHaTmpU+Jm8d43GiHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FdTmKm96; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=D9ZjFtrFebA/Uo9j4/dU6PS3lP2XNqrVwAv3h0zfkLw=; t=1708976051; x=1710185651; 
	b=FdTmKm96uULx9NA6gcmP863zFCztxCURlX9F4fBhTWACHuNGL1A/B5FPCk4QCSBnFqTANaoIK+O
	7Z4DB9IjFcPrp46n8Aepyo7S0rYelKG+fDthGdo9h/zXQPV41Oq0UqGFpLG2eEd4kNGE1Yt0xyuBi
	EHSo64cSFcjE6IRTiWI19YsnJG8ITQR8YHZgBRSOkh1cOfJwV6h01Qzo6aAv5YcGwdqoH2rgq8bxm
	uWczro7U0JEKPVc7e8Az+br0zJOXR3MaZS4gry5A8S8Uin0OM0hGVK9ggk41aKuarRwou6n49T5Wj
	ncVAUm0CYGhu8Alk3be4ih1sodA54OCVbrIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1regjn-00000009T9l-3cun;
	Mon, 26 Feb 2024 20:34:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com
Subject: [PATCH] wifi: cfg80211: check A-MSDU format more carefully
Date: Mon, 26 Feb 2024 20:34:06 +0100
Message-ID: <20240226203405.a731e2c95e38.I82ce7d8c0cc8970ce29d0a39fdc07f1ffc425be4@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If it looks like there's another subframe in the A-MSDU
but the header isn't fully there, we can end up reading
data out of bounds, only to discard later. Make this a
bit more careful and check if the subframe header can
even be present.

Reported-by: syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/util.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index d1ce3bee2797..b9d15f369378 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -791,15 +791,19 @@ ieee80211_amsdu_subframe_length(void *field, u8 mesh_flags, u8 hdr_type)
 
 bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 {
-	int offset = 0, remaining, subframe_len, padding;
+	int offset = 0, subframe_len, padding;
 
 	for (offset = 0; offset < skb->len; offset += subframe_len + padding) {
+		int remaining = skb->len - offset;
 		struct {
 		    __be16 len;
 		    u8 mesh_flags;
 		} hdr;
 		u16 len;
 
+		if (sizeof(hdr) > remaining)
+			return false;
+
 		if (skb_copy_bits(skb, offset + 2 * ETH_ALEN, &hdr, sizeof(hdr)) < 0)
 			return false;
 
@@ -807,7 +811,6 @@ bool ieee80211_is_valid_amsdu(struct sk_buff *skb, u8 mesh_hdr)
 						      mesh_hdr);
 		subframe_len = sizeof(struct ethhdr) + len;
 		padding = (4 - subframe_len) & 0x3;
-		remaining = skb->len - offset;
 
 		if (subframe_len > remaining)
 			return false;
@@ -825,7 +828,7 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 {
 	unsigned int hlen = ALIGN(extra_headroom, 4);
 	struct sk_buff *frame = NULL;
-	int offset = 0, remaining;
+	int offset = 0;
 	struct {
 		struct ethhdr eth;
 		uint8_t flags;
@@ -839,10 +842,14 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		copy_len = sizeof(hdr);
 
 	while (!last) {
+		int remaining = skb->len - offset;
 		unsigned int subframe_len;
 		int len, mesh_len = 0;
 		u8 padding;
 
+		if (copy_len > remaining)
+			goto purge;
+
 		skb_copy_bits(skb, offset, &hdr, copy_len);
 		if (iftype == NL80211_IFTYPE_MESH_POINT)
 			mesh_len = __ieee80211_get_mesh_hdrlen(hdr.flags);
@@ -852,7 +859,6 @@ void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 		padding = (4 - subframe_len) & 0x3;
 
 		/* the last MSDU has no padding */
-		remaining = skb->len - offset;
 		if (subframe_len > remaining)
 			goto purge;
 		/* mitigate A-MSDU aggregation injection attacks */
-- 
2.43.2


