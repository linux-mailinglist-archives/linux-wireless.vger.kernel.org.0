Return-Path: <linux-wireless+bounces-14562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5C9B10F9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F2B227C9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887951CEE98;
	Fri, 25 Oct 2024 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="l34c1oVs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AA18C021;
	Fri, 25 Oct 2024 20:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889220; cv=none; b=keBlbek1FmRcM1m1FzIGH71upnKJX4a39X41UPHs7Mbe6vUUPAk7Tkz95PsqbCaJAJJ7oAKOo+Ni2hcz4maLYuuzLPPxGYrEqHjYVk71nIwQD0IHZjKoGwhTEbFPs4ZfJWmV1rT7Nm08NGQXJbnpiFiRnlEmxv7c8Zy/gWPuasM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889220; c=relaxed/simple;
	bh=sbx7GKDOCDQxcPyycAmGy9ZEjXCDuDtk+cGxjR6R0HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z87eFmqelASQAmC/6MVOHOqq2yb2iHLvsgBHwpk/OC3brkdlo3tYlpMl3tALIl42kfCSdo6shKMH/yE99fB2E4UptUyJhYGte1LyAiJESxHeqU5QsPdLEWW2+BLYKWpXIc6X5lKKEAphxQmVVjKpZg26ZZp7ueOL4YEe0jOLVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=l34c1oVs; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=eT6kiO3JGaQV7wsi4OCzn24QrjXvaYPh6+rZs8ak/nw=; b=l34c1oVsumRi8+/I
	/NTvvwOvfP5xRoeu4ERWyk9/Oh3MMOasmkCnlGiP8FYDFAs+orZInV/jGwuSt0yQFRqQvHXy88fbb
	TLwY4JA9vpmZVdWe7NzjFK+fVKhjjOgNj1gGgvqek/yN9YkVeCzViRR2XBj5HO+ysGlvVxIWSqB1V
	7f9c5TzUvoL5CC8jSXPgrjws0/WRXB+d+aoENH4id/BX7ey5fEad04X/LijKv3pMfJiUgIt9i39tD
	tIA0nUCNshcAxIib9zZTDPJwyAD77PH0YOWISRyGhaYRJCqEXzdfmQpevkyBikiRTFFlYkfvfwSjw
	PuyVl+m2WKpx+UDWLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t4RCu-00Dc75-0j;
	Fri, 25 Oct 2024 20:46:52 +0000
From: linux@treblig.org
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org,
	kees@kernel.org,
	erick.archer@outlook.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] wifi: brcm80211: Remove unused dma_txflush
Date: Fri, 25 Oct 2024 21:46:51 +0100
Message-ID: <20241025204651.244627-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dma_fxflush() has been unused since 2013's
commit 7b2385b95363 ("brcmsmac: rework of mac80211 .flush() callback
operation")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c | 9 ---------
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index bd480239368a..80c35027787a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -1426,15 +1426,6 @@ int dma_txfast(struct brcms_c_info *wlc, struct dma_pub *pub,
 	return -ENOSPC;
 }
 
-void dma_txflush(struct dma_pub *pub)
-{
-	struct dma_info *di = container_of(pub, struct dma_info, dma);
-	struct brcms_ampdu_session *session = &di->ampdu_session;
-
-	if (!skb_queue_empty(&session->skb_list))
-		ampdu_finalize(di);
-}
-
 int dma_txpending(struct dma_pub *pub)
 {
 	struct dma_info *di = container_of(pub, struct dma_info, dma);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.h
index ff5b80b09046..7905fd081721 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.h
@@ -88,7 +88,6 @@ bool dma_txreset(struct dma_pub *pub);
 void dma_txinit(struct dma_pub *pub);
 int dma_txfast(struct brcms_c_info *wlc, struct dma_pub *pub,
 	       struct sk_buff *p0);
-void dma_txflush(struct dma_pub *pub);
 int dma_txpending(struct dma_pub *pub);
 void dma_kick_tx(struct dma_pub *pub);
 void dma_txsuspend(struct dma_pub *pub);
-- 
2.47.0


