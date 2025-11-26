Return-Path: <linux-wireless+bounces-29350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE4C87C18
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 02:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB8352AE6
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 01:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C52E0B71;
	Wed, 26 Nov 2025 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="DtnaErhT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8AA2DF137
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122291; cv=none; b=rmARfose60w4teIC8VsjS7xebF5DL8uYOE0R5fsYzjVG7+a5qaTGNMA0kDrRItnffU1nAZJCEltbevwYfLWPwvp22Dcb/2iFJog7+YACvTWnbKPpzF0mL63rem26ckZfyP997lPEIcpw4Tx7ojIVat95bgAyma0XTLJac/zoAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122291; c=relaxed/simple;
	bh=e/LqqBOOJCsjijj3gynbSXXcuE9nkZ08q114NY+jotc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJR+euVqe5wr/XfeMBWfCym4eMJvFs8GAuno7Zv65CHvQmQRFjPjfSh96yk199uxvrarsjc63ysc1FFjsp+XesrIR6/j0oPt8IVdELZ0vxM7+r8gElSr0ywRdIBfM/f3ZQEh6a4ITRZRis56HnQ7HhCh1OMVZdWl8fbvhl6cUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=DtnaErhT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297dd95ffe4so55153485ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1764122289; x=1764727089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61Wv3ylulObHI2HQAhB4mk85Bti2PD7sYoOxLjkPkBY=;
        b=DtnaErhTPh8lNUzZxDYGc5fB92+4YxR+oYxnxqmGD+wmxQhUEfa3cLpISMlCSP8UWV
         3Jd/IZFxDyAxKxOgpi8GObLs3HrsBssOlDIR2HerBBw6GbD72tMM1ekR7bdbpFYh3KbJ
         WVWZlHf4OafYiVWEHTgxYuNxRoVPP0ilSRJ6OWjdyt3a6/Ds5NnaOlaYnbnSs/5qiSe8
         DsCkYbO74+wBhWlLwpf/1z491yao/U72Pi6dyKVzawU8oUmwD/wNU+ADkYqpJIb0zlPR
         vgiCTZKqWIxLSDFnX39c9CL8IxMCN1HQgkw36rW9sjDjHVaAMopP+mAvNDjrEkxXo7BE
         jbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764122289; x=1764727089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61Wv3ylulObHI2HQAhB4mk85Bti2PD7sYoOxLjkPkBY=;
        b=F20cNxciTUe3XmicmWFBmsORJ0rPJ31vZVyMdewU/ZQ3XIbpG8Seh+9c9aXHYqEjma
         tIDRieCKqy6dkdj3uxhRyn3JNFRQZzSJS+pmErvNdHDVR8utS3QW08PjF7NIm8pXuVqa
         3lvPH1P32gQzevSAEYE4qebzoSLWf6dZPVu9YifggyeFbrFlutOZXcLXdi/HSPKXPf0O
         bIak3UML2cWQVmrHrCaGLzs1v7aEVtt+b4w6ezk7TU7dVEpGEW0TA0h2exR1rMNdj1uU
         2eWCfJo+m5Pw8VEk8ZoTuXvmaYlBZX3i5zzLM+lVtk3BREIdsmFNGCuHbJeJXa6JQyi3
         K8mg==
X-Gm-Message-State: AOJu0YzQWI95FhKxxuMP6Oi+H5wsjwCd+sxwfrh9T1z15r2vNxRt+2QZ
	Aac4mNpkm+WbXtlURzR5OGBXU0gqTdZ5dLgWt2H+kTBkbcbYEus/ZSN0bqM3fxPY6xWf+VYNGbk
	G8XzKWP8=
X-Gm-Gg: ASbGncuA+9DAOW0d9tCdTFJHuSgbhVbCOnD2ILluZfrzUQcNgKVzo6hgsPb1ut1iQV/
	7xJ1yooA+LJH6e1ePo7do263EsPzVYDehf+nQy1XBziiOvwzoeTWTxLDPhGHzeY7N1RJdMODmYi
	veeBuXUtYYhkBOGup4eItln62txD77Y2pKFc3GB5Ew1yt5VGbFBxFaj3akIsom4OlXe5rxRReja
	1b905ZZ+s/fdQmh2jdxxTgrBmdPxcvCvIIqVgYFzAFTzAWXwFmOhCezel8IL8gshobyBWklntYm
	YS9XeBTaeE+81YQrZZtK6mMRkqt2S9tj/jtFDf9jmhcnaQldEf/Y5lhvq+F9JlwE84Ct2+8Cmmx
	j0Nswrj5OzqHHcIrte6VQXYZhV0AotCY65z1L+UYy+5DXpGC6w2Rt4+wr9UOjtPkBPfhrxpLCXX
	K9ET4oQJBePCo2k+TyFp20h/DW1J3Zv53vhW0gJH2s1XTMDHkRK4PXRnwIREWrK/qb+L09NlrAu
	N/g1Q8xO8e0YUHAQpE=
X-Google-Smtp-Source: AGHT+IHVNbL1z90+Tw91P2H2zzwb2RwQQeVQdI/Sq79f7V1yDeplqrxGHD0Ej6uD/IlsPU5qSRNRFQ==
X-Received: by 2002:a17:903:2ca:b0:297:e231:f410 with SMTP id d9443c01a7336-29baae65be1mr50228385ad.13.1764122289026;
        Tue, 25 Nov 2025 17:58:09 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bfdsm175838245ad.22.2025.11.25.17.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 17:58:08 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next v2] wifi: mac80211: allow sharing identical chanctx for S1G interfaces
Date: Wed, 26 Nov 2025 12:57:58 +1100
Message-ID: <20251126015758.149034-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for sharing identical channel contexts for S1G
interfaces. Additionally, do not downgrade channel requests for
S1G interfaces.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

v1 -> v2:

- simplify code logic and fix clang build bug
- use cfg80211_chandef_is_s1g() instead of enums

---
 net/mac80211/chan.c | 13 ++++++++++++-
 net/mac80211/mlme.c |  5 +++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57065714cf8c..585c99978a63 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -530,8 +530,19 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	};
 	u32 changed = 0;
 
-	/* expected to handle only 20/40/80/160/320 channel widths */
+	/* 5/10 MHz not handled here */
 	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_1:
+	case NL80211_CHAN_WIDTH_2:
+	case NL80211_CHAN_WIDTH_4:
+	case NL80211_CHAN_WIDTH_8:
+	case NL80211_CHAN_WIDTH_16:
+		/*
+		 * mac80211 currently only supports sharing identical
+		 * chanctx's for S1G interfaces.
+		 */
+		WARN_ON(!ieee80211_chanreq_identical(&ctx_req, chanreq));
+		return;
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
 	case NL80211_CHAN_WIDTH_40:
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 025210d50405..ab18d134f835 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6122,9 +6122,10 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	ret = ieee80211_link_use_channel(link, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 
-	/* don't downgrade for 5 and 10 MHz channels, though. */
+	/* don't downgrade for 5/10/S1G MHz channels, though. */
 	if (chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    chanreq.oper.width == NL80211_CHAN_WIDTH_10 ||
+	    cfg80211_chandef_is_s1g(&chanreq.oper))
 		return ret;
 
 	while (ret && chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT) {
-- 
2.43.0


