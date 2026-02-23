Return-Path: <linux-wireless+bounces-32085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNncNhzEm2n06AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:06:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D101717E9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 04:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D6C13012208
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A9343208;
	Mon, 23 Feb 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsxjJ4/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472C342CB4
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771815959; cv=none; b=T6iBrpDiBAmf13y0q4AerAuH+cIzaVWOXu5jthTGEivPIe8mSHuwgCaur7d17nt4EdQSUC7OZRA8eSf7c3wpnjvcf5KggNQ1bhXUzDNBJTsxPYYpfa4GvrYrAQfxxYXUiWRATxxjbZ+9A7txpfbXVxJGIgN+giUiOCJEgOsg2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771815959; c=relaxed/simple;
	bh=i5vgvg3sg+UXIaRcyERPIMtjQmPcakNHGsM4C/i0qXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hnq48Go1rxuAQeXzLb/Jg3Nx0yQpyQOUfUvjIn1sxWi7eyL9/DW0YrerCN43Ch8JP/iL6dh4TIK5zpzdNUoSqHSEGNjDQox5EvEemQoXtCfHQCOY0YuBGr8VwVaG4s4+beL8HhgMs7WDuKEF5ujJg1PELng1L2/+Si8ii1UAcR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsxjJ4/y; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aad1dc8856so26855405ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 22 Feb 2026 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771815957; x=1772420757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GSnvmMEphQ4/6s6fXwVUjqcFnb8wnWTRkYiCVtaRqA8=;
        b=BsxjJ4/y6BkTl93062VsWGvbU0Qwsn1dDBkji8/SLcp3cbhB60u5NKtHncE+7lYJvH
         ragnprEQ+LqPWErcGTFtINhQGWNbYA9OzBel3WlklxA6svNOJ5PQmYYm8SRB33/wQBgY
         A8h35BZgo2CczdkcgLZF3ceeevWWrBrDk8rY2ecn9bmXV7VBx0BSX+Y0jg66p7m2NEUK
         AvZo14T09ipNA9A1n4Xar8STKtWGxN+r3WQ5HBdxi2AWdLlx8k+uoOjFSf1ubDnUbyFK
         yT1Dpyu4/Z6d7uqdsiGr0oW1ECQqv+dztgWDUXvN1niLC9c/afy5H2bNDSoNwllY4MzU
         KK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771815957; x=1772420757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSnvmMEphQ4/6s6fXwVUjqcFnb8wnWTRkYiCVtaRqA8=;
        b=lbRzfgv2sr4uq5khPMegsyf7mplE0LT5duQ0NsoLePJBjbe27eEQuIWLUCpRekTw3f
         NP6ZqjrdKYFmuTt/g43pJSe52fUpjwOHXFFXTveMdxgxoV9YzsMIW7wqie5tovuArUZ6
         cilIpuGbD6mrStD4LjgIU6MZuctC7HJDVFHXv1ELHHbNs9tgkTkvqtkruP/tkfPHGcES
         IcudfojDRNX3vfeaITb/ojBF7gVAHui5HkBh3EOhuJ6/qIPdmdOyWCfDOa6AQNgBQu+T
         V+z93MCOkaOXFvsPf6s+izvSaoJfeqUB0En05/Zi0knTXJZdXbEPQgt5P/vQCjKWsG4h
         SXjg==
X-Gm-Message-State: AOJu0YyPLoVhN/aSPt0OmHpEBF9Mry8L3aH46FlsEd4ah2W2C05y9HWR
	KWRd2w9mNG59nKcUbbnwt516UPXTf0IeLCmftUcNOiIJGsDbE5EULM6VBPBQHodZ
X-Gm-Gg: AZuq6aK5yDsK1fH/kAqPQcjKbFYDMcGvxv+IMiuMcEuVcXe2MdJ0YxkSABOrSAGgOX+
	Exx2EMxixTwb1kMZZT1eb+vMCjNT84e9kuXNupUN4eo7ZFyn9YxSQd4qPe1O5/+q7EyjgcgSDG9
	1AaSPvQcCX4oDiN59bXMGgrnKgw2AIktqcFIJY4WeUlfeeCGwoU2Wh72T3lmSCnMtk+f2oi/fsQ
	uxbC/c4p1oS/CeoiPL9GCP+OwKyGIykuyeQKg2p380cDYZkIcLRphNnMHukPfYZkvRF4zRlQ7pa
	I5lpOUY/v5cQ6+rqgDx/tRwboQ589Gtt7pM83+SQUIx57M2d7c/zhJKLhLfYand4fcOYr5PKc/X
	Ct1in6jzhnIx+lxQ2UGhcVHA7OOjRFLJ5SWCBOZAo7O2P7kS8/FWeHnkLl/MVzxM4dI2KJHrHNM
	6YLuR8cvCJGZiG8isTdqAomKmO4C+pHWXkgq68tKqhsF3lX3iRJFYOPgMnCTzSMNCF
X-Received: by 2002:a17:903:9cf:b0:2a0:8ca7:69de with SMTP id d9443c01a7336-2ad74540793mr68899235ad.41.1771815957390;
        Sun, 22 Feb 2026 19:05:57 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750591e2sm56676485ad.91.2026.02.22.19.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:05:56 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	brcm80211@lists.linux.dev (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wireless-next] wifi: brcmsmac: use FAM for debug code
Date: Sun, 22 Feb 2026 19:05:39 -0800
Message-ID: <20260223030539.19307-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-32085-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62D101717E9
X-Rspamd-Action: no action

Debug code requires a separate allocation to duplicate a string. A FAM
allows properly sized allocation with a single kfree.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c     | 15 +++++----------
 .../broadcom/brcm80211/brcmsmac/mac80211_if.h     |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index aadcff1e2b5d..87b636273b3f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -317,9 +317,6 @@ static void brcms_free(struct brcms_info *wl)
 	/* free timers */
 	for (t = wl->timers; t; t = next) {
 		next = t->next;
-#ifdef DEBUG
-		kfree(t->name);
-#endif
 		kfree(t);
 	}
 }
@@ -1499,7 +1496,11 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 {
 	struct brcms_timer *t;

+#ifdef DEBUG
+	t = kzalloc(struct_size(t, name, strlen(name) + 1), GFP_ATOMIC);
+#else
 	t = kzalloc(sizeof(*t), GFP_ATOMIC);
+#endif
 	if (!t)
 		return NULL;

@@ -1511,7 +1512,7 @@ struct brcms_timer *brcms_init_timer(struct brcms_info *wl,
 	wl->timers = t;

 #ifdef DEBUG
-	t->name = kstrdup(name, GFP_ATOMIC);
+	strcpy(t->name, name);
 #endif

 	return t;
@@ -1574,9 +1575,6 @@ void brcms_free_timer(struct brcms_timer *t)

 	if (wl->timers == t) {
 		wl->timers = wl->timers->next;
-#ifdef DEBUG
-		kfree(t->name);
-#endif
 		kfree(t);
 		return;

@@ -1586,9 +1584,6 @@ void brcms_free_timer(struct brcms_timer *t)
 	while (tmp) {
 		if (tmp->next == t) {
 			tmp->next = t->next;
-#ifdef DEBUG
-			kfree(t->name);
-#endif
 			kfree(t);
 			return;
 		}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
index eaf926a96a88..8ef6d657e487 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.h
@@ -43,7 +43,7 @@ struct brcms_timer {
 	bool set;		/* indicates if timer is active */
 	struct brcms_timer *next;	/* for freeing on unload */
 #ifdef DEBUG
-	char *name;		/* Description of the timer */
+	char name[];		/* Description of the timer */
 #endif
 };

--
2.53.0


