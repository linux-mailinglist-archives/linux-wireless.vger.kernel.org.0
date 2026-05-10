Return-Path: <linux-wireless+bounces-36181-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJHLLpkbAWpIQwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36181-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 01:58:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CE0506D89
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 01:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1993300B9AE
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D98374178;
	Sun, 10 May 2026 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrRBWppR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D636B043
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778457488; cv=none; b=A21s/wn80z1z/03oE9Fq17SMzlt79ahUfupsLsQN4djon6/A1/6/syQnE9slKAOMlprzd+q0JMeBDVN3foUqLJhM7AHxlisQCp4cUi8y97BKZhfxxOS7lj9+EcgaR6/GB/1S1qN4JXqZ7XzeqvnhE1esXCkQHN7G0AhWD8ait+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778457488; c=relaxed/simple;
	bh=QLe7+vSEK8byt6zTLXlGdrzr6At8RZJeTVlOt0dmPwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jUG1ZJE3uGR9c8Prm+J8CBzxxbkTgZvWGXAOuRgK87xI77cJJe0QUz3vmznHwGO3gjTzHp8DPwfbhb2+tPtP18CzzWVWnsgd0qNIm1/MDNBhss43DVttLMmpB7FC83qUmkitMIuMVZkGvlPeoZgX9R+iB5+l4XWq2revKdLAAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrRBWppR; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6422489eec.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778457487; x=1779062287; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRcM+PIbmOIW+awIJfxKUZgELRQMFWts00AyYnPQRRg=;
        b=nrRBWppRj6axzj1oAHPfy4oeXYkbQUM1CEHsc2AlberdWPTWomQcRYZa3gRT1O6XzF
         GhxOR2gOcCq6VYP6r0L0E45fNF/efTdvkSVO+keQrsdxQD/5kd5OTq3R0j9jIb2lJnsE
         DbLP4EGkk4DhsDeHlju1sYOipdbeTKdM/AtCvGWgNCOT2qG0H4MZoQqVAevEmSRBlOed
         S43ldl9y/R/HcqXbUxDmCqbqS9Tva1TH1JbFEQceIz+M3JJpuq2NJMO3dvJhsUKkmWsa
         +DGZnWtXOYGPg8KF8ZT1CyRqkuRMe2/Cz7+SK04+v7jiL7eRol0Kkt8rLiW2m88jZdfm
         8fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778457487; x=1779062287;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRcM+PIbmOIW+awIJfxKUZgELRQMFWts00AyYnPQRRg=;
        b=Yx4Lslp0fH1si49yZYtMrK6hXMmbCW7NJt3cduOLNoiYGploQwRhH0I9GzB4mGvryO
         if4MgKveHAQeZsrM0sM3IWACd+lXfT/WQiuwWJJNYqqKIp2gkCOdDhYGhEq83yPQMDQV
         rR/i5FxeHVLckvaw+0jpvHpUmostzb+ncfmjcDG/cr0348JUenYsbHAVNxfEbE0XLj1/
         pbJDs33NhJxmVBoctpmE94OqxbOxL7yOKYqCvtzNV9mPKFCqRBAQ2e9fuqzcobqRzFj+
         enmAfUJ/Zxf6eCo11vdvLdiiuq/hpOMSB/l8OWTRFY9jyulK07rQdqUVmlosbLDkB/dK
         JriA==
X-Gm-Message-State: AOJu0YytH1Jk2brPIxUhCnDCumfpGc1f73jRUztYtB+qeNIP2WgPCGle
	a7DU4gKDZISrJLCrHKrLvZ/hSNl59BDUhiV2m94H3YFRTNRlKZJJNNh4OecBBkLJiB6xkQ==
X-Gm-Gg: Acq92OGH5hlGOXVDkGJTimUFU4m3K51wKSLInJkp+0o2VxzamdYXdRXk8aWwynuAygI
	0mh8SaDBFQTJGe0FhcfQScdXDzx1lgTVZJvEa3wAaKhnbAqFnJCdGQYJw7DU1JTp+0qbtqQckiG
	wBSgWNEKVXBtjS01xoTmd8kfpD7dvlRnUrZoXjnvz/5GWK3U/8QZzwsNhcqtcWnlI0iewoJ9V2l
	DMYbIL04CioKnrHJlNq/+XicNeYEZDoqkXC++a04iQjDlfX0jMsV9faMCzuBiaD/7dSGOxEIGPt
	hBsk09VcctF7x46cSUjvxbeLrJ2sDVsEOYt0DrPgz0TrUKFG0e6zMdF9ywjCjnT1bjY6eRmO6Vn
	Pv1nbWwgN8Z/5CZ9Mg2BkE4lguSGppFSHEnW0y17A0UIjxPPXoinrcy7ymiaRp9ovn5C3l+QdFE
	T+rB1FeIilCR+6a+puuPtYScoeteucsTO4
X-Received: by 2002:a05:7300:5727:b0:2d8:8c38:8cec with SMTP id 5a478bee46e88-2f54d698ec8mr9342030eec.2.1778457486570;
        Sun, 10 May 2026 16:58:06 -0700 (PDT)
Received: from wico-dev.wnam.ru ([23.95.253.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b87dsm13694390eec.21.2026.05.10.16.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 16:58:06 -0700 (PDT)
Date: Mon, 11 May 2026 02:58:02 +0300
From: Ruslan Isaev <legale.legale@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: disable rx napi before queue cleanup
Message-ID: <agEbiurBZzZv_Yt0@wico-dev.wnam.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 36CE0506D89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36181-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legalelegale@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mt76_dma_cleanup() already disables tx napi before deleting it, but
it still removes rx napi instances while they can remain enabled on the
normal device remove path. On mt7915 this triggers a warning.

Disable each rx napi instance before netif_napi_del() and page pool
destruction. This fixes repeated warnings on rmmod mt7915e on
mt7915e/mt7981b.

Signed-off-by: Ruslan Isaev <legale.legale@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f8c2fe5f2..12183142f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1189,6 +1189,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
+		napi_disable(&dev->napi[i]);
 		netif_napi_del(&dev->napi[i]);
 		mt76_dma_rx_cleanup(dev, q);
 
-- 
2.39.5


