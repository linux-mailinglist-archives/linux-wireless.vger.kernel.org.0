Return-Path: <linux-wireless+bounces-35321-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF0xCDgj7mnYqwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35321-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 16:37:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B5846A5A4
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D2413003420
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572C6364E96;
	Sun, 26 Apr 2026 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIVLIxu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3F7261A
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214259; cv=none; b=XXVTPipCIqatK5VZqL3fh74bVjKKtJl0SaXjjvKm23c+YPgzbqynHNFbyWb74X7rRvqiLqPWyMgFKp3z7vB3vHiywTvpGQ5aIhJc6DaxvHW+dx3mXuylIYjvno7nZ+dKI5Scs9HWn00VSs1ac6h64Krb/kdxBEOHk/Cz8MAbQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214259; c=relaxed/simple;
	bh=gGpxLTxMrG6yvK1ojoAShxQL3Kf8sRp4c0UBA/ejRF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVCDeY/YAMekghSmIMmn3+hZg99NXFNDi3Dg7nUV4d5bAMpUILdM5Zo6hkrFrmtPvmvqnVXyj0swFkcdKJ7TEPka1ofanVb1umqm11gb4pIG2cO+gAUSxDBRw7APytcANPpCwE2dljwPE1QxczaA1dPXq1+uFDhsTW12mQOspbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIVLIxu1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so4195309b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214257; x=1777819057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp95h01o2/Wl98SnFb+AukwrIEiz+o1jaPsbSAEFOD4=;
        b=iIVLIxu1nA9aVXC6HOpxIVY07VpdUKLtbTrB4QdIFuBgdYu3laObCyZ2ydpSOMZbvs
         zkIraWbMBptowIO3Vi3V4ZTy8BaXV5f70CH0KjfFGkMN5p6JxjE04sTT7RPeVXD5Kg+F
         yzVNFcRrBJsnYle7E0+9XLEe/CGkaBiK5zZRz7MuTenlxCen7ze/3ZIds814HV1+Z+sl
         8DsoP26ZxaFb2eHsXkj5YZfZesRnr+jZ8/d3e2h9pIFkuZV7up3FcCbmQ6mBsPeenVr6
         pW1D+iPmosg67TubKuSMiATJToJKVw8vyLwzRe9GUg8iF4CpDb+30BfFcQcfNgB4xVaq
         fFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214257; x=1777819057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp95h01o2/Wl98SnFb+AukwrIEiz+o1jaPsbSAEFOD4=;
        b=ekDDR3com+6k/5RgPj4sVJ8dz7HryZmTRAbgaqCrj27VgV3XnkLAUY6mhYUysGWUss
         ee/MzLjaf2mSdhhSpQDaVpZptJJs/AMGUSPPYDgrk2eUVS9VrzGqnMPfloWX6hXjiSR+
         vWIAT41jz5z0V4jXmMijZLphT4ZEtoNEINaU3PEFuA0lPy7GBScLvTobUchMbUH9A7/o
         vw3qOnccF3tG7jCGEJnITsg+HLZ8Ii+rSfP9ZQju7nAQdyr5WjGPTQnVyIqNm+HfUOA0
         SLxVwQuW61kA50REzi3FAzcj0rxDvW6UlI9xqsXEeF1ZjxCD7l7WdlPWjnTKA8oJw0aI
         awPA==
X-Gm-Message-State: AOJu0Yx6Rpg1MlSKOxjQ/NHK/bFK7ivTM4kl1g2g8vzHcUaLfP+tBNbU
	U2DP7NqYYTdThjNItJEJf2Efx2patBuVD8arNAJwBupSz95ERjBImYU=
X-Gm-Gg: AeBDiev83E+myPZfCKyfGKHh+lHVQWePagefw8cc/r8QXQ0BqpPOuKpRJxByVbw41Ui
	lGuDdoCUR14mZTogaeJqrVNBZ3VcOweeiiGsT3NKQpoCg1e+059vLDWTErZOyil5Il35p2CyT/U
	jJFzgItTGOhloQE7ohf1sNGRW0eyAPb+4B1n+6qoSzMkUXxbpMph7C4tJyRuIGA9KCAYdqQEyL3
	4/N8m0CkIiiQszER32v73qWx1rt0CMb2P5BCf+M6BuEJU4lg8aujSIDfnsXNMNLXNxX5JomGJN+
	rcm90H3K+rch6D6ZzneJC5I6auYlCe0ycX3MMTWpiIUHMPhNTOKFTjGPnQ307/E8Z6O9UhoWkDM
	CICHPG5eN0sFo7ByN9jMmY2Kxuft6JSNkrvU5CSfQ/lXFMrZxrrH6JEMKM1ffLGwfDIwW0pUXeQ
	OmhVyWf+1DM1bx+UhctD7ixVKnDbyDoQLLyaQCG2errL5xgpw8yJh8bivmfEfKl8u2rwT5LLFzL
	Xzym2Da6HrTGBIdZ5sCHxSv0lxF8vzUF26V5as4MmTewQE=
X-Received: by 2002:a05:6a00:7484:b0:82f:4a4d:3792 with SMTP id d2e1a72fcca58-82f99814b42mr31000118b3a.4.1777214257392;
        Sun, 26 Apr 2026 07:37:37 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d35acsm30061828b3a.15.2026.04.26.07.37.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 07:37:36 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ijae Kim <ae878000@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] wifi: mt76: mt7925: clean up DMA on probe failure
Date: Sun, 26 Apr 2026 23:33:36 +0900
Message-ID: <20260426143728.41534-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89B5846A5A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35321-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Myeonghun Pak <mhun512@gmail.com>

mt7925_pci_probe() initializes DMA before registering the device. If
mt7925_register_device() fails, probe returns through err_free_irq without
tearing down DMA state.

That leaves the TX NAPI instance enabled and skips the DMA queue cleanup
that the normal remove path performs through mt7925e_unregister_device().
Add a dedicated unwind label for failures after mt7925_dma_init() succeeds.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c0..4883772302 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -415,10 +415,12 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	ret = mt7925_register_device(dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_free_dma;
 
 	return 0;
 
+err_free_dma:
+	mt792x_dma_cleanup(dev);
 err_free_irq:
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
 err_free_dev:
-- 
2.39.5

