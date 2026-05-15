Return-Path: <linux-wireless+bounces-36493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMPbFXo5B2ottwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 17:19:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09355206C
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFBBF3002B58
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76733CD8A3;
	Fri, 15 May 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyXT3n2a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA43CAE74
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858258; cv=none; b=E7PzAJrjyJNEBjpRLhjCQyVSAByxpsqt03NaVlz2BgiwIjr2CPo/6HWSmsYiDDAjGQ2fM9GXTc2y1+eqkzo99EZkXl/12Tlls3/72RAyWxqsEnxpUGWEL3pCPG/6e+XiafohTX3uLqQhoWOrGNbh2/WUa9E/3y4z8mkigarHuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858258; c=relaxed/simple;
	bh=aGtwR86sEeHR7pHMo8gANYh64TgSQdSaZeRrCkV6FaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI4+Hf8OPFRWNaq82VRVqcu8aZuiLZQsMkpxSpVWt7kaHBvpLud29GqEFJ38Gq98U9BKqY8YjE2U72EXgryoBIYS+m1ZDe3tnzFLujVCRL12XD6zaUIb1vMVeF0ouVQhrdsvhpd0oSk98TgP4E3TOXvUZo611cYcbkxpyDBYSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyXT3n2a; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90fa736d46fso204592685a.0
        for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778858253; x=1779463053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PGD6v0QN8Iw3KQBRbl1nKm6w7zibwHykGZddKUBe34=;
        b=dyXT3n2a8VWG5UPufHcXu1dwTSESZeY/W8P8ZjJZLZprgsybrc3aSECwcaWn1C5OIq
         RdaVHhgQjpj2+fCV/UXA3oAvTZjVqDpVydJ61sINuLF04qV7kQZbhbiqsr4AmEVzipCr
         kjURS7B0k+e7l/uPi8LPg0IlHTLF4vgMZv862GMdSAztmotLtJffJ2GWMojYlodGkZmE
         cpfGJmnf70/o/8kxtzZQ7P0edsGtDabW2OMM1tvu1dk+9+rTFJOl+RwKwAUebXcEWlvd
         XZp9qyyLd7JjKyqyfkixmA/yFTwsKKMsOM9MHYJtL5GkgeOCrsk5qd4gefN4SP3NpI7a
         ndcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858253; x=1779463053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PGD6v0QN8Iw3KQBRbl1nKm6w7zibwHykGZddKUBe34=;
        b=Xe9Es4VWK/U+XZe3B85QDMO2kPKoofpKV/Nlyqt+TdfeUGva7SgBtl9KE55l6KB2KA
         kOichhHC2lv/05/f05HiobbDC3mptp6GEe/UYowWloxXhudV/BoNaJGjEI7bQifja3s/
         /P5VyLCsmHde/U1bmos5lEm4ZIrQ+lM0NKFnpMeEokdYH/KD6bAgRIys71ftDLHEa9/S
         FBi+ygu37l0dyFIya26gNwJ+lt/xww1F6Es9ieQj1qo8kfrRpQbFrJfZdiMLXqf35A+h
         SV9AGdDu3aZcJEgxmy7uDBLG7F8nIKgQQO6QEdonzfXKoVYij1Qpnx9HlmuVM7xo08M2
         dXSQ==
X-Forwarded-Encrypted: i=1; AFNElJ87/eGdO/HDkKqCU+5+Jpb9+a6owjFT+6giNevHXMfjcSQeApPY8IvJf93dnB1IaqtSGpWHznx3UJv3AOxklA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW91N8JudnkE750cn5OeIVNRgASHqltmVMe1LxJsQhL+Q2Dkps
	U/NP0LmaO+SSdY6sjhAZJma3x547WiiNmAIv4v1XWM5eQVmSUwMcgVdD
X-Gm-Gg: Acq92OEGZnfIOh3A7IZDIouHwSA3Qq7Pi0KGbgBqEBaHd91KqOiMuOCHOKwG/TUdg61
	/V8pnBTgPuERH8gqecnOTgoYyEEisShSdSOoosnSXxJaBDzfQ6zFavERKpCHWkXfdnH7ROyujEk
	1OiOU0VxU8Q8EE6HDgKG+ngy8NFXfo8HI1OTpkRKJfnmGuq5Nx9EK6WO80mLM0+ZuBYn0JzPVc+
	G2fkvZNBlgtfncX0e+H7z4Wfqbg9oTZN0gBC4eDRq+ptiqSaAC9hi907Mna1DMAjU6udO3fH8Cr
	lCb0BdhqJdP0RlZOQRvIipwHmfcvYLopCQK+SqD7fjyU9zl9S4V9Am81Kfx0HiWhCG0elrqOjjc
	Tk574+ng6moSxYp01kMXz4YIDnaVOKKRcG1B2HrINk9sjDMVz/WZJ5SmfiK3HHk+Fx+r2T8Qpag
	xWFzAdLs9yL5KMsi+hUymEb9fxl7FuCNOBCUi9r0VhAoMaSqJQkq+t2FcPqP2oSLc/lObySIKMV
	nKYrbHgH1FScPbXKkcY6PSjV81w++YI2oYJWMe8n6WoBwtJ17BzOQ==
X-Received: by 2002:a05:620a:1984:b0:90f:429c:e63e with SMTP id af79cd13be357-911cdc4936emr753468285a.12.1778858252911;
        Fri, 15 May 2026 08:17:32 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm569877385a.9.2026.05.15.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:17:32 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ayala Beker <ayala.beker@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless 0/2] wifi: mac80211: negotiated TTLM sparse-map cursor
Date: Fri, 15 May 2026 11:17:17 -0400
Message-ID: <20260515151719.1317659-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7C09355206C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36493-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ieee80211_parse_neg_ttlm() advances its cursor by map_size for every
TID, even TIDs whose bit is clear in link_map_presence and therefore
contribute no map bytes to the element.  A sparse map then makes a
later present TID read past the validated element.

Patch 1/2 moves the cursor advance inside the if-present branch so
the parser walks the same layout that ieee80211_tid_to_link_map_size_ok()
already validates.

Patch 2/2 adds two KUnit cases under the new mac80211-ttlm suite to
lock the layout: sparse_presence_no_oob_read crafts a buffer sized
exactly to the validated element so a pre-fix run is a KASAN
slab-out-of-bounds report; dense_presence_baseline confirms the fix
does not regress the path that was already correct.

Reach is adjacent (AV:A) from an associated peer MLD; the sender does
not need privileges on the victim kernel.  The OOB bytes are gated by
valid_links before being applied to driver state, so a peer cannot
turn the read into a policy change.  KUnit + KASAN observes a slab-
out-of-bounds read when the element is exactly sized.  Whether the
same read trips KASAN through the production RX frame path depends on
allocator state; this series does not include an over-the-air hwsim
replay.

Michael Bommarito (2):
  wifi: mac80211: consume only present negotiated TTLM maps
  wifi: mac80211: add KUnit coverage for negotiated TTLM parser

 net/mac80211/ieee80211_i.h      |   4 +
 net/mac80211/mlme.c             |   5 +-
 net/mac80211/tests/.kunitconfig |   4 +
 net/mac80211/tests/Makefile     |   2 +-
 net/mac80211/tests/ttlm.c       | 175 ++++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 net/mac80211/tests/.kunitconfig
 create mode 100644 net/mac80211/tests/ttlm.c

-- 
2.53.0


