Return-Path: <linux-wireless+bounces-38441-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rcEWED/fRGqz2QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38441-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 11:34:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C88AA6EBA21
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 11:34:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38441-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38441-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13A41303C3FC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE55E2BE056;
	Wed,  1 Jul 2026 09:33:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E60C3E5EEA;
	Wed,  1 Jul 2026 09:33:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898419; cv=none; b=Yk124t0b6WCDzIdqlkTEFAUqrgPLBjMRLFOEP6F4KkBhGyr0MJZzfxk/XV37j/CfAKCjD8CR6C09GsMscR0i5F/T4eqyaGJitFa4p0OEf/yvzdE/BI/IqmrCPJQLpm+DBpAISqiZi+7amZrJDTiT5KkaU8jyAi2zTPgTZNpoiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898419; c=relaxed/simple;
	bh=lHbMVPt+HlldYyRohgxVdlApOa9thZh70SgrhcIbbt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3ha8pKV3ZqEjPtPPEVnkJ0lIgAAaPGvRAiczfGNP1T9xBZfjfGu/b1fMNn54YabwdixMZbtZTLuLWi3wqCfxwkmllAxWM5mLPHUQ3WAvIEq6m8z3BK2MjnQHauirfgAi+fy8Xm1Gs7xajVF5jWbBtwu7yHAUCrJHaO8yFlSWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: ec91ca42752f11f1aa26b74ffac11d73-20260701
X-CID-CACHE: Type:Local,Time:202607011730+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:9baf714c-ad49-4eaf-999e-bee07a07cb94,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:60976e77ae99c1a720002554b8eef4c6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ec91ca42752f11f1aa26b74ffac11d73-20260701
X-User: lihaofeng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lihaofeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1111271079; Wed, 01 Jul 2026 17:33:31 +0800
From: Haofeng Li <lihaofeng@kylinos.cn>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] wifi: cfg80211: validate EHT MLE before MLD ID read
Date: Wed,  1 Jul 2026 17:33:27 +0800
Message-Id: <20260701093327.2680709-1-lihaofeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-38441-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:13266079573@163.com,m:lihaofeng@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[lihaofeng@kylinos.cn,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,kylinos.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihaofeng@kylinos.cn,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C88AA6EBA21

cfg80211_gen_new_ie() copies ML probe response elements from
the parent frame when the parent EHT multi-link element has an
MLD ID matching the nontransmitted BSSID index.

The code only checked that the extension element had more than
one byte before calling ieee80211_mle_get_mld_id(). That helper
assumes a BASIC MLE with enough common info and documents that
callers must first use ieee80211_mle_type_ok().

Attack chain:
malicious AP sends a short EHT MLE in an MBSSID beacon.
cfg80211_inform_bss_frame_data() stores the copied IE buffer.
cfg80211_parse_mbssid_data() builds the nontransmitted BSS IE.
cfg80211_gen_new_ie() sees the EHT MLE in the parent frame.
ieee80211_mle_get_mld_id() then reads past the IE boundary.

Validate the MLE type and size before reading the MLD ID. This
matches the contract required by the MLE helper and rejects the
short element before any internal MLE fields are accessed.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 net/wireless/scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 05b7dc6b766c..d93629802b09 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -326,8 +326,11 @@ cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 		/* For ML probe response, match the MLE in the frame body with
 		 * MLD id being 'bssid_index'
 		 */
-		if (parent->id == WLAN_EID_EXTENSION && parent->datalen > 1 &&
+		if (parent->id == WLAN_EID_EXTENSION &&
 		    parent->data[0] == WLAN_EID_EXT_EHT_MULTI_LINK &&
+		    ieee80211_mle_type_ok(parent->data + 1,
+					  IEEE80211_ML_CONTROL_TYPE_BASIC,
+					  parent->datalen - 1) &&
 		    bssid_index == ieee80211_mle_get_mld_id(parent->data + 1)) {
 			if (!cfg80211_copy_elem_with_frags(parent,
 							   ie, ielen,
-- 
2.25.1


