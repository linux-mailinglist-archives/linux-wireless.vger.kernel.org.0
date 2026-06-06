Return-Path: <linux-wireless+bounces-37449-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SzwXMcnPI2r0zAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37449-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 09:44:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3464CDD0
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 09:44:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=xxllkh7mjjh2hbqtnfxgf3o65e.protonmail header.b=lo2L9RuM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37449-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37449-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79003301F4B6
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FD25D215;
	Sat,  6 Jun 2026 07:44:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD3194AE6;
	Sat,  6 Jun 2026 07:44:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731844; cv=none; b=YFdH1GiznvOWPu8DRSm2svGQn5efRdezALUekubPzT6/bgOCZz61p82f2rJXeGxKFvV2cHgXwZu38OFV0g+71g5wMh8rECRRdMbEmIhMc58/SeOfWrlN0eT/OBqmzl3ggC80SEX8yVL7hFnGtQBZdBDmo86NcIfPykRwjAEqcd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731844; c=relaxed/simple;
	bh=0CfQ6SgTCuV1f2Qw5GhyMPnMGkzCr4zho38Y4ceJLa4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eSPsrMMEykGIGIH39Zqqn1YvvoJTm0Hxq3QWdsAfIrSOmzKE/WhLZkTeVAYl7LWn0xXld1rOS/7nN2uJEbFV2RnzVq/xNTcuo0I30Su2H/CPhqRGVGo4uhivG1TWkgknDHx22CwyFRMKC22z0sw6fKqdSG9CE1BDjQIWlcot/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lo2L9RuM; arc=none smtp.client-ip=185.70.43.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xxllkh7mjjh2hbqtnfxgf3o65e.protonmail; t=1780731832; x=1780991032;
	bh=La5WWk6czPwHglKdizTEEf2S5e1ekFLe4+W+uq74dB4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lo2L9RuMYxrqxsWzRp1ln7jr9MSl/ZRG8KxpunxPA+IHS/IM+OgnXqXevo/Y14v+V
	 QvO2dj5qh/HLsyNdHDqbKVizxzCpm5L5tsDDFolxQsqFL39iNuzn915f/CGcQ2w3bt
	 PoR98jD+WyA3QIOrqB9H/7yYpjhjgX9zrdp5ErlS3rOTAYWPk4NUvIwDM3OPDC3cko
	 l5L3gs5ZnhB14C/+eld3NBYOzOFMUpwUSQJPPE92gbWvpl2KpYxa9FlSoYnu9NE58P
	 z4k/0gaOgksdmZmiLKZftLCSa67PQYKUhD+QLuZIXdwLwcxwWDrEXpdTA2VVc7rFK4
	 6Uy4iU3v2s0lg==
Date: Sat, 06 Jun 2026 07:43:45 +0000
To: Johannes Berg <johannes@sipsolutions.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mac80211: bound S1G TIM PVB walk to the TIM element
Message-ID: <20260606074341.49135-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: ea74879c923ac78e3fda9d0bd4e396360ec2d66f
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=xxllkh7mjjh2hbqtnfxgf3o65e.protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37449-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,proton.me:mid,proton.me:dkim,proton.me:from_mime,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0C3464CDD0

ieee80211_s1g_check_tim() parses the S1G Partial Virtual Bitmap (PVB) of a
received TIM element. The TIM is handed in as the element payload:
ieee802_11_parse_elems_full() stores elems->tim =3D elem->data and
elems->tim_len =3D elem->datalen (net/mac80211/parse.c), so the valid bytes
are [tim, tim + tim_len).

When walking the encoded blocks the function passes the walker an end
sentinel of (const u8 *)tim + tim_len + 2, i.e. two bytes past the end of
the element. ieee80211_s1g_find_target_block() loops while (ptr + 1 <=3D en=
d)
and dereferences ptr (and the per-mode ieee80211_s1g_len_*() helpers read
*ptr), so it can read up to two bytes beyond the TIM element -- an
out-of-bounds read of adjacent skb/heap data when the TIM is the last
element in the frame. The +2 appears to account for the element id/len
header, but tim already points past that header at the element payload, so
the addend is wrong.

Pass the correct element end, (const u8 *)tim + tim_len.

Fixes: e0c47c6229c2 ("wifi: mac80211: support parsing S1G TIM PVB")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Everything below the --- is dropped by git am.

Class / impact: CWE-125 out-of-bounds read (CWE-193 off-by-two end
sentinel). An S1G (802.11ah) station that has the PS_NULLFUNC_STACK
software path processes the TIM of every beacon from its AP
(ieee80211_rx_mgmt_beacon() -> ieee80211_check_tim(..., s1g=3Dtrue) ->
ieee80211_s1g_check_tim()). A beacon -- which is unauthenticated and can be
spoofed over the air by anything in radio range -- carrying a short S1G TIM
element placed last in the frame makes the PVB walker read up to two bytes
past the element. The bytes only influence the boolean "is my AID buffered"
result, so this is a robustness/hardening fix (no leak to userspace, no
corruption); KASAN flags it as a slab out-of-bounds read.

Affected: introduced this merge window by e0c47c6229c2; the buggy +2 is
present at mainline v7.1-rc6 and at torvalds/master 8e65320d (2026-06-06).
It is not in any released stable tree yet, so no Cc: stable here -- but not=
e
"[PATCH AUTOSEL 6.17-6.12] wifi: mac80211: support parsing S1G TIM PVB" is
proposing to backport the feature (with this bug) to 6.12..6.17; if that
lands this fix should ride along.

A/B verification:

1) Full-system KASAN (x86-64, KASAN_GENERIC+INLINE, kasan.fault=3Dreport).
   A test module calls the real in-kernel ieee80211_s1g_check_tim() on a TI=
M
   kmalloc()'d at exactly tim_len bytes, with a crafted single-mode PVB blo=
ck
   whose block offset never matches the target so the walk runs to the
   element end. Without this patch:

     BUG: KASAN: slab-out-of-bounds in ieee80211_s1g_find_target_block
     Read of size 1 at addr ffff88810340d345 by task insmod
      ieee80211_s1g_find_target_block
      <test caller>
     The buggy address is located 0 bytes to the right of
      allocated 5-byte region [ffff88810340d340, ffff88810340d345)
      cache kmalloc-8

   A well-formed PVB (block offset matches the target AID) produces no
   report. With this patch the crafted case produces no report.

2) ABI-invariant userspace AddressSanitizer extraction of the verbatim
   walker (-m64 and -m32): both report

     heap-buffer-overflow READ of size 1 ... 0 bytes after 5-byte region
       in ieee80211_s1g_find_target_block

   without the patch; clean with the patch and clean on a well-formed PVB.

 include/linux/ieee80211-s1g.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-s1g.h b/include/linux/ieee80211-s1g.h
index 22dde4cbc1b0..3f9626ad3d97 100644
--- a/include/linux/ieee80211-s1g.h
+++ b/include/linux/ieee80211-s1g.h
@@ -556,7 +556,7 @@ static inline bool ieee80211_s1g_check_tim(const struct=
 ieee80211_tim_ie *tim,
 =09 */
 =09err =3D ieee80211_s1g_find_target_block(&enc_blk, &target_aid,
 =09=09=09=09=09      tim->virtual_map,
-=09=09=09=09=09      (const u8 *)tim + tim_len + 2);
+=09=09=09=09=09      (const u8 *)tim + tim_len);
 =09if (err)
 =09=09return false;



