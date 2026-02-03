Return-Path: <linux-wireless+bounces-31496-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAgVNszMgWl1JwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31496-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 11:24:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4AD7887
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 11:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16AAA30B454C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Feb 2026 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797B23126DA;
	Tue,  3 Feb 2026 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EvjJWzEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC3313526
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114117; cv=none; b=RQkDeq1A/dbFIJ+F6TiSVUTB2xGrzruOem00KbzTYHKTN+UnXsBwBSwlzQCF3UDRURBt8WyNMhPfbBVmNV1Vwmtb7DDiYnFFgOlsxYQkmRIxiahoiq+AwporGoWjIOcX6NdFbFJj+t787aWWHUHBsQQfbq9YO24iNGnG4pRF6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114117; c=relaxed/simple;
	bh=mDbAkw6+5b3PYP4j3HekYDmobxPGUwHOAHgr6SSerzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Y3Szzc1lRprJEpr5WPgy/uODzgNp+vm1la7K7k8Uvb2datd2Yi1S4O3as4wuJ3V7bikir6KW4Y6Py0JxcH/bGIeyn7iXztZ7ap99lVtFAcjxnt/VH5PKCFSrx9r/v5TEFyRpTIzAldQsYjWSdZtXpv2YZWtLXdGWif2ifnhulas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EvjJWzEo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260203102151euoutp02e6b86f8d07c0c75c363af49a39484aa3~QtWf0VraR0091500915euoutp02S
	for <linux-wireless@vger.kernel.org>; Tue,  3 Feb 2026 10:21:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260203102151euoutp02e6b86f8d07c0c75c363af49a39484aa3~QtWf0VraR0091500915euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770114111;
	bh=G9a2mtBb++O8s1zmn/uRpbg3SjCQvjrM8KhIPFcNSJQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=EvjJWzEo3V54M3mh4AdPSkP/QPhZqrgi0pA2lGYM42pX1UrZgwBYCjZ/tKNSmtyRg
	 SQjs6Fepn3bKZcL+HzTPb2jMcjfKJ5JW2CM6R3G25Ojbh/KaAMVgtmpO7hzgyDugBv
	 cs6p9j6XcSV/GJYoAVKNxfBe8Fa7fIPZcVSPk6VI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59~QtWdUoppG3022430224eucas1p1p;
	Tue,  3 Feb 2026 10:21:48 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260203102148eusmtip201effc4af688babcac9ef33e67d90e4c~QtWdC86R-0627706277eusmtip2U;
	Tue,  3 Feb 2026 10:21:48 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>
Subject: [PATCH v2] wifi: brcmfmac: Fix potential kernel oops when probe
 fails
Date: Tue,  3 Feb 2026 11:21:33 +0100
Message-Id: <20260203102133.1478331-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59
X-EPHeader: CA
X-CMS-RootMailID: 20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59
References: <CGME20260203102148eucas1p10c43be72827d74e5be41fe40a84fbd59@eucas1p1.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31496-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:dkim,samsung.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FB4AD7887
X-Rspamd-Action: no action

When probe of the sdio brcmfmac device fails for some reasons (i.e.
missing firmware), the sdiodev->bus is set to error instead of NULL, thus
the cleanup later in brcmf_sdio_remove() tries to free resources via
invalid bus pointer. This happens because sdiodev->bus is set 2 times:
first in brcmf_sdio_probe() and second time in brcmf_sdiod_probe(). Fix
this by chaning the brcmf_sdio_probe() function to return the error code
and set sdio->bus only there.

Fixes: 0ff0843310b7 ("wifi: brcmfmac: Add optional lpo clock enable support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changelog:
v2:
- changed return type of brcmf_sdio_probe() function

v1: https://lore.kernel.org/all/20251231143544.4158840-1-m.szyprowski@samsung.com
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 7 +++----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 7 ++++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h   | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 6a3f187320fc..13952dfeb3e3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -951,11 +951,10 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		goto out;
 
 	/* try to attach to the target device */
-	sdiodev->bus = brcmf_sdio_probe(sdiodev);
-	if (IS_ERR(sdiodev->bus)) {
-		ret = PTR_ERR(sdiodev->bus);
+	ret = brcmf_sdio_probe(sdiodev);
+	if (ret)
 		goto out;
-	}
+
 	brcmf_sdiod_host_fixup(sdiodev->func2->card->host);
 out:
 	if (ret)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 8cf9d7e7c3f7..4e6ed02c1591 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4445,7 +4445,7 @@ brcmf_sdio_prepare_fw_request(struct brcmf_sdio *bus)
 	return fwreq;
 }
 
-struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
+int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 {
 	int ret;
 	struct brcmf_sdio *bus;
@@ -4551,11 +4551,12 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 		goto fail;
 	}
 
-	return bus;
+	return 0;
 
 fail:
 	brcmf_sdio_remove(bus);
-	return ERR_PTR(ret);
+	sdiodev->bus = NULL;
+	return ret;
 }
 
 /* Detach and free everything */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 0d18ed15b403..80180d5c6c87 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -358,7 +358,7 @@ void brcmf_sdiod_freezer_uncount(struct brcmf_sdio_dev *sdiodev);
 int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev);
 int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
 
-struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
+int brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
 void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
 
-- 
2.34.1


