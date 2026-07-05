Return-Path: <linux-wireless+bounces-38634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EqUqF4thSmpgCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 15:52:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6D770A29D
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Jul 2026 15:52:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BUb0eHfJ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38634-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38634-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 713D73028C23
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jul 2026 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F037F010;
	Sun,  5 Jul 2026 13:51:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94872374A04
	for <linux-wireless@vger.kernel.org>; Sun,  5 Jul 2026 13:51:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259493; cv=none; b=RrBsFKIxNtNXTfFxXgWslIVhmbPHtNYLzI1rDGQWEaDdQ2WIm0/3Q1amUUfWF+JD94/VMtcLciBMi1kWXo4f/7DXAKxPfSiCHNeRoterKCoX8OIgWZx7Sqto+F8vfOoNY497/PlV/eQYq0ll5CoCu3tMXMmVyRwAIEc0uYvW7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259493; c=relaxed/simple;
	bh=sRJXxHVrTKnze0J9TQUpyLb/I+/gpyhYLDHWaqhp4IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfIUf15h7drLy5hsXANeq4sINuuaot7Wh0vGnCa6ZxODrb78bkZPQMM+XYG4AZyRuC4eASX+bdwxF3jhWdJPtzL+GiZfrs3hOxVBZGNO2wq1cG8XV1oW48po+JMeaKamH49nE9lJG0SidrvK5GU2Yy4WUjQjiBjzr4PBmiLzB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUb0eHfJ; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381065a7a03so1494366a91.0
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jul 2026 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783259491; x=1783864291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+R3hdh1F0k1XR+/2667ieYYrr29gzoWn8b/WVNacrQ=;
        b=BUb0eHfJSlfQXZIcAdzGvfgTexwOvEObfdJsNBG2bA1yzPjvU4/diakDRO+rFo8Uuq
         uXiVPyV5Ik0+R1WsLBx3aJF3f+ihR0uYY+SrN6t/zeLeQDIavSlBadx6iGUJuaQ1Nvv8
         nXKimxZkQjEYqAMyk+uBLjMWx7hKGiEy2OUABZdLsv0VYY/XTY9uTA7fpcUpS7aQ4YV4
         6NDJGUD2ZQ+jf79+dfvhzSUQ0AS/9OiKxfzTXtx4UCk+UuWpJi3b6UIWxcv9+ZLLW2GU
         T9/eLFIh1/yQFUBPB8mD+60ADiMZhnoBM5mTFhseH7JPH0XIfZMXGJZvo+lW+IyT2RPE
         rhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783259491; x=1783864291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+R3hdh1F0k1XR+/2667ieYYrr29gzoWn8b/WVNacrQ=;
        b=ia2SVWTnLrEcY6CHv39cu+lMceKjsY0CEjzFtl5L8oCLGiO3q3t80Gp/C9K2++qHbv
         gaN9fu9s0fm2QPly7Edgu7GeCEg8SesAOTxGY5VTGU+BWpWho4yHbaXNYZMGewRA75vW
         ME1xwZTgUXcu2hr1fwMzZpnOlxClucNvz12tvaZ+xhEB1VYMUgofG+3kZ4YpdTphunit
         tsWEApU7kJnB/RK6aWWxTWaGXRPjZ1j8ykyRgi+aJQ0Bio94DvhK1O3TjhXTFEgxaDCo
         TUWr3QCuaWCK7/ASMUtV480whbMG4H0faE2O7+jR0kghol+iReiwTrWTXn+cpL7WL9LR
         jCsg==
X-Gm-Message-State: AOJu0YwRbUlNWb7cqxu/ZtA/T+fCif797C64hnYsAD5y2uxUEwafnD93
	kB931ZRoj1gYAS/5Du7Ou2eyAOH6++wGx/wdF+2yDwuYdtrAAwuzeIay
X-Gm-Gg: AfdE7ckBGs2GZbiSvyehBRHY+IuO4Ejru+r0ayK0CR4K7iCwF3hF+aO52y5H0Iwoeay
	YrDTMIUsEoyRMn9Lpl78pmBBpsSS0K6uOIIajoCh65hJZcebZkUNkzFJvoBIm6D/iOr6IWi37lJ
	oFWijvJSG53zi8q+o2KvnREWuvWxDUBU8kboyhogn8DuGBqfCv9WI+EAlz6QUKh/+p9IoUB1CRZ
	wJx3sy371CbIfu7fY6hvuylidyl3Is/NhbzxpdpUfYGXYmPe3ksyUEolY2tVDkLIo4Wff6EpXU/
	JY6U5x19PKq50gkid1NbJFYW3v272G5251l+jZkXHGMkWISUEUrrPZt0LTVMiST6PAFyIuZnDa2
	e84/wJROoMeKOYQwbHCCdkcA7JHPPLpEdh2sF5bkVUVlttXTYdFeiaR62Q/vyIZfBrfEgfNJ3Ce
	gwYNWT
X-Received: by 2002:a17:90b:2243:b0:380:ced0:ecf9 with SMTP id 98e67ed59e1d1-382802bbe2dmr6940705a91.4.1783259490940;
        Sun, 05 Jul 2026 06:51:30 -0700 (PDT)
Received: from beelink.. ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3d92c44bsm21017170eec.19.2026.07.05.06.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 06:51:30 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] wifi: cfg80211: bound Common-Info-Length in ieee80211_mle_size_ok()
Date: Sun,  5 Jul 2026 10:50:11 -0300
Message-ID: <20260705135011.407300-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38634-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:security@kernel.org,m:gregkh@linuxfoundation.org,m:qwe.aldo@gmail.com,m:qwealdo@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[qwealdo@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qwealdo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF6D770A29D

ieee80211_mle_size_ok() only lower-bounds the Common-Info-Length octet
(mle->variable[0]) of a Multi-Link element. After accumulating the
expected 'common' length from the presence bitmap it checks
len >= fixed + common and then returns "mle->variable[0] >= common", but
it never verifies that variable[0] fits within the element, i.e. that
variable[0] <= len - fixed.

Because ieee80211_mle_common_size() returns "sizeof(*mle) +
mle->variable[0]" truncated to u8, a Common-Info-Length of 254 wraps it
to 0. cfg80211_defrag_mle() then starts walking per-STA-profile
subelements from offset 0, and a body crafted to also parse as a valid
element stream passes the for_each_element_completed() interlock.
cfg80211_parse_ml_elem_sta_data() finally does:

	ml_common_len = ml_elem->variable[0];
	...
	memcpy(new_ie + data.ielen, ml_elem,
	       sizeof(*ml_elem) + ml_common_len);

Only the destination is bounded (against IEEE80211_MAX_DATA_LEN); the
source read of sizeof(*ml_elem) + variable[0] bytes from the received
frame is not. A crafted probe response therefore makes the parser
over-read up to ~230 bytes past the element into adjacent slab memory
(the RX skb head, including skb_shared_info), and the copied bytes are
exposed to unprivileged user space through the per-link BSS information
elements in nl80211 scan results -- a remotely-plantable,
locally-readable kernel heap infoleak.

Confirmed over the air between two physical Intel radios on an
unmodified v7.2-rc1 KASAN build: scan results contained heap pointer
values and a kernel uevent string that were absent from the transmitted
frame.

Add the missing upper bound so the Common-Info-Length can never exceed
the element. This also removes the same latent gap in the other
ieee80211_mle_common_size() consumers.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 include/linux/ieee80211-eht.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 18f9c662cf4c..dd1ec8a0af5a 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -919,7 +919,8 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 		return true;
 
 	/* if present, common length is the first octet there */
-	return mle->variable[0] >= common;
+	return mle->variable[0] >= common &&
+	       mle->variable[0] <= len - fixed;
 }
 
 /**
-- 
2.43.0


