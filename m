Return-Path: <linux-wireless+bounces-7590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC68C40A5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 14:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3091C21E98
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E514F119;
	Mon, 13 May 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D8Hm/MyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50414EC5E
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603065; cv=none; b=uVq3WRPtArcfU4AdSLe0+qn5s8AgK8mIHamDvGdFgEszYCWJUcr/Ndb+AWngw+w9Zow3TuDd2l6bldOaJ1ecOAz6LQQ8MX6VDEfxCUPKi41SkTodWAROFd1MtBPu8xtSELVjZ1pV4td3JjaB1rMWF6eSNcdgSSVbZlKZYyzPMLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603065; c=relaxed/simple;
	bh=nmEbUsWqZoLoKkGCEi5+yD7HIB+4LIhHoKsOYVUVX9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNzRMx3grdEPQhaU1R4UaeW0DzIKWLRLb9I8e17LC2xWGPjLHSRU24B/QldRaO0epPd+Sjoj/jI8AyhFJhMexZPrhuC4ddatTxEXXwWmnqlm5urhWdS0CX7u2MxvlU938BbErXGGPgUV6dSIKb192y3MBvPS7B4XgJnfn1UyUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D8Hm/MyC; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fXvZV
	y+O0FXOwaoVLJHn7SMWSPa7OrLUhbpPfhZ4/e8=; b=D8Hm/MyCPnHJihPxUCHiI
	P1HSTNEkpHjBo1Kl3c6zL2djILhqLO8vGi+XVR5Pf7U3CqY7Noey5cRHv1FSt5HU
	7Dz6htONyX1b9UlIJ8BfbDgR0HGTV8EIwkl+Q16i38MalqWQeZSvCbCEZj8m6lVn
	vrj49TR2K73YVUDXYkYoRY=
Received: from flipped.. (unknown [159.226.94.118])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3f6dEBkJm50hfEQ--.9117S2;
	Mon, 13 May 2024 20:23:33 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: nbd@nbd.name,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sicong Huang <congei42@163.com>
Subject: [PATCH v1] wifi: mt76: mt7615: fix null pointer dereference bug
Date: Mon, 13 May 2024 20:23:29 +0800
Message-Id: <20240513122329.170380-1-congei42@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f6dEBkJm50hfEQ--.9117S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryDKr1rKr17WrykJry3CFg_yoWfCwb_WF
	WkuF1ftw18Gr1kKr42vr4xArW0k395Za48W3sIqrWSq39rJFZrGryavr9rGrZrCrn2vrW3
	Gr1DJFyrX39IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjvtCDUUUUU==
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/xtbBFQfd8mXAlaaUfQAAsC

Function mt7615_coredump_work will call vzalloc to allocate a large amount
of memory space, the size of which is 1300KB. There should be a null
pointer check after vzalloc. Otherwise, when the memory allocation fails
and returns NULL, the function will cause a Kernel crash.

Signed-off-by: Sicong Huang <congei42@163.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 7ba789834e8d..04eb52904520 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2341,6 +2341,9 @@ void mt7615_coredump_work(struct work_struct *work)
 	}
 
 	dump = vzalloc(MT76_CONNAC_COREDUMP_SZ);
+	if(!dump)
+		return;
+
 	data = dump;
 
 	while (true) {
-- 
2.34.1


