Return-Path: <linux-wireless+bounces-14568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97079B13CE
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 02:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9124D281331
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 00:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C240EC4;
	Sat, 26 Oct 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="BIWdoKCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00020E3
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901872; cv=none; b=FRikKIs6vvwJMhDpwEUeNQOGvpjX/XLtszzGnF4BLurv82dF4Kq2nX/ZdjWyFrW9wguvOBeZhTRKWVDBRZ0Vq4bkfVeFI8hRTOf3bEyKKRR5VSwyEJy+KvTZsVbBKWyUNvfgvjWrGzqTw2fZh/GOsPq34TzgUx9yNFhD7hHYk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901872; c=relaxed/simple;
	bh=GpoFvR/ixgUTW4yOL/YhbRYkHU8AZGcwHA6Fq5KOixk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jViYD5Kee5jhs4ZWxvid2nfkKpDr0T8EU/1wyjw5zp8fbCtwBH8aldPh7KlI58iDFF+ggdUyILWi1MNbTQ9jftnafBy4/3AYwyaT1P3p6xkeEiUyPs2YMb491ztqrbCuvjWvQ0O7vLVYdWU9ZypMvdebMkTTQOG3kbvA/YCWQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=BIWdoKCa; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ED760340011;
	Sat, 26 Oct 2024 00:17:41 +0000 (UTC)
Received: from carkeek.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 979C413C2B0;
	Fri, 25 Oct 2024 17:17:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 979C413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1729901859;
	bh=GpoFvR/ixgUTW4yOL/YhbRYkHU8AZGcwHA6Fq5KOixk=;
	h=From:To:Cc:Subject:Date:From;
	b=BIWdoKCah9t/W4bsfRDofl6jUoUOAv5YSkgsjXqPvQFoVu+yWPzapIrbWo/KMtSgj
	 MlziudwhSx9gURXu/fPBuau6iZpguVa8BVDW1TBCbizAFvvWGp7/R7zWdSlihYgQnv
	 Xd7ABtJxmBDLtBn09VeQ2j73RgMettxIungowLyk=
From: Rory Little <rory@candelatech.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	Rory Little <rory@candelatech.com>
Subject: [PATCH] wifi: mt76: mt7915: Release wiphy mutex if WCID allocation fails.
Date: Fri, 25 Oct 2024 17:15:49 -0700
Message-Id: <20241026001549.163966-1-rory@candelatech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1729901862-ZP09BXzsi5VA
X-MDID-O:
 us5;ut7;1729901862;ZP09BXzsi5VA;<rory@candelatech.com>;340f598122f25443170ac9d27e6a82df
X-PPE-TRUSTED: V=1;DIR=OUT;

This fixes a lockup observed when the alloc failed. The mutex is
released in the normal exit path - we miss it if we early return here.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b79ef44732d8..a2c199219224 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -265,8 +265,10 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, mt7915_wtbl_size(dev));
-	if (idx < 0)
-		return -ENOSPC;
+	if (idx < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
-- 
2.46.0


