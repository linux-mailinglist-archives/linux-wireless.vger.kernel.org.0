Return-Path: <linux-wireless+bounces-31962-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN2nG3S7lWntUQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31962-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 14:15:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE91568AC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 14:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C3EB301938C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED0274FE8;
	Wed, 18 Feb 2026 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOEIDHfy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AD28E571
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771420529; cv=none; b=LHDjg0FNnya+Boku7z5cTU1YztZMyQE4J6a5BMfB+t5IHujo43VucxzJ7lypPjYZLm5cCCQvCa7YqyCAC1tczwfjf2HMaLx8rXblq2QNr8fLyZRW0v8U6YRbgdcNr+phD+iZM8uM7F7XP9AchfM1y24N9+Yg6t5Aj9DGKPAMcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771420529; c=relaxed/simple;
	bh=qgqQM3BicoLp//iJlSD25LJvavgVBcGFV4txdNSMKCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhiqCOD6aFw+IlbRqe8S/nSXc2NdAxScCkEIkSnVQ1LhY10iR4C0xAQdjS2mua/mVxAHQCnPfrlUwOoW93YEYxDigQ8Ed8UfwUT9x71blTfe385/2nBDgGvaK+QtsPxdSxcczCWbZIHhONLIEHFHcwEpjZkOfoHP+bFeS9AoPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOEIDHfy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436333dcc42so543935f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771420527; x=1772025327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTS3P2DdO9rrBOyQJCIkcrjqmQuomaNDxfVohLWWfaM=;
        b=BOEIDHfyJAnAb+MmVxlF7oKteh+9yF8AAjiUS1L/zSJBVnmSk1IiyJ0VpslIDNDhIU
         /pVVl1/CGkRulDOYA0NU9ijlWhoHDsYXPGEmA3QKKd5dYdBtn1itD8aa34PERtHWIgxL
         cYIgNl5IWS619S5Yu8GK2xH7p4twJW4Q74i/jhNBZSbGCIryeX9RY+kMSPGW5IqajR/c
         oPesqM00beaWkNfyTF+PsfYm6ggWvlesaQ0nyVnwWeLco8nHvs74nMR05kTAICWluVRK
         EyatqpJDwEziafERzM6Z3KmYzCqQF9pGttqzvz1p8P4fDh0sVYq63Js6+hfNa9YCk3s2
         xImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771420527; x=1772025327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTS3P2DdO9rrBOyQJCIkcrjqmQuomaNDxfVohLWWfaM=;
        b=w21CP3oYtTzJuR2iZauswdBwKiHROrl/hxqcZoHT3soFnsMYSAZM6sOuHmKDXgY+bq
         wKZSKlCYF8FqA0leq2YJ2en1I9+hA3CdBwcCHD7XBYaM5tuEua7rTdYuanmKXxeHXbE3
         25wt9LfjjZUrh6Q558vQyoVbfZIqpXqpzmELlFyJipYTXGLqrNUnQ8J5Ik8ZEL8S0c7b
         OKHQoNv8Av1nAHVXTSnc7/q0YmV0sSohhFtZpofeq8JG7psXDwDuzraiB3ccy/uFo1T3
         g8k5G55tolyk0Ft8y0nu/w2GLCPq2eIsz7WmJCPy5gRuF2IoY1eOW6IzQwtw86CxQtKI
         f0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0mtiv2LI6aBCOO/CbriJcTtaG6ggWkosAoAQihBAOLftnG57C+lwZmaokStdMrovN9tguEjZKSJr07sqHbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyojR7N3CKcPn3LuT7J4b2bnFV1lwz4s0Cx23KNExAPgd+jzuly
	urvcIfdDk/FRHSROIEaWBbgky3YU7AyN9Iq6QgPnEtcFq6FLNbZZ3K8s
X-Gm-Gg: AZuq6aLn8v7KIDRl35J98n3PkB5TFV8NqB52GASRQBPALdKzn8XoWaThe0J0u6OgFi4
	lHNIFPGINh8H/iNU1DoZFxZG5eya5xyyWBcFZp2/Y7G5eA38/Pe8U/LYsgWH5/61aR5ZuRYJnFL
	BQclxdOgQ86Wl4MS2GOI/pjmZ01fMwPxgFPZ1bdhEq5aDjcL7ZXfasjULQnyZelxXB59lkWHOT1
	+DnbxN6u9RoqaY/g/GI1fEOo1ju5xHeFfHTVdwZYiD77dhtFkswDglbclGUYsacs0ahDRSsnaM5
	RW5oohtIByb2hoJEp+V+3pMVUZIK6HNLpNdK5WQAA8CwprUbtEXx4U+9+/FKZzVn/nmrbdXSZKT
	VpeKTtgr8RGKieWrL/EN3ehKQcXxASaKkhSHWO1vosd/zzPj0XOYwUz+O8nGJC3pkrAAE4z1N6h
	2gnN5sFUnUejsgBowrinOlGHcRwGF1kJh9AwvupVtigkAXUXTE0pkhhojbtNIC2EWrTmIfUCHb+
	WOZlidtZfx/bn2EIIlIp86SmiCo9EU=
X-Received: by 2002:a05:600c:6912:b0:477:aed0:f402 with SMTP id 5b1f17b1804b1-48371067b29mr185755875e9.8.1771420526501;
        Wed, 18 Feb 2026 05:15:26 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-82-204.paris.inria.fr. [128.93.82.204])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43796acffcesm38768246f8f.37.2026.02.18.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 05:15:26 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Simon Horman <horms@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] wifi: brcmsmac: Fix dma_free_coherent() size
Date: Wed, 18 Feb 2026 14:07:37 +0100
Message-ID: <20260218130741.46566-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31962-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,broadcom.com,intel.com,kernel.org,tuxdriver.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2EE91568AC
X-Rspamd-Action: no action

dma_alloc_consistent() may change the size to align it. The new size is
saved in alloced.

Change the free size to match the allocation size.

Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index c739bf7463b3..13d0d6b68238 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -483,7 +483,7 @@ static void *dma_ringalloc(struct dma_info *di, u32 boundary, uint size,
 	if (((desc_strtaddr + size - 1) & boundary) != (desc_strtaddr
 							& boundary)) {
 		*alignbits = dma_align_sizetobits(size);
-		dma_free_coherent(di->dmadev, size, va, *descpa);
+		dma_free_coherent(di->dmadev, *alloced, va, *descpa);
 		va = dma_alloc_consistent(di, size, *alignbits,
 			alloced, descpa);
 	}
-- 
2.43.0


