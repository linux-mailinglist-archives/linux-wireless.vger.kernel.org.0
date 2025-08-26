Return-Path: <linux-wireless+bounces-26613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA4B35675
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F87C1B62821
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B342853E3;
	Tue, 26 Aug 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkYsF8Pn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09C284678
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196000; cv=none; b=dpr+KRO2USU88OggV5QviO/P5UOwTtHd9RxXJowKKO/LgMCCRiO9dboUkPRKUbJonhOoj2xBRGinKs21U8VNE66v+IAzxTsT8s3mXVgchvzC8CpJux3yIdCAh3ZEz9/uQ7Ys4MaG7wksWgsKDgAKy7GMHO57Ct6BvpV4wODLD50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196000; c=relaxed/simple;
	bh=s4iG796SpblwfefRkKQPUe+QpyGgGkIMxALCGJUdOGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AnclZhMKpH17K+1+4WvZyDn9t/RFTCegrg9CUv5V+uQYprJ+4amBWPrdxQbfaA6rz1xf0yOIheyn3jXAlRCzF6rUv89QnzxEBPgH+vCQFCu+OPzqkpmzreJWFEi1DADE9hkgkA3dvADBpBYIOiLQJJuHw/oA9Ln0vWNmeJuI/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkYsF8Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9F7C4CEF1;
	Tue, 26 Aug 2025 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756195999;
	bh=s4iG796SpblwfefRkKQPUe+QpyGgGkIMxALCGJUdOGU=;
	h=From:Date:Subject:To:Cc:From;
	b=GkYsF8PnyxOTjyj4LHcO0EpT8UbDDVBN+FMqY6PDbBmVE5YRDpu/mfwQth36T7Bzz
	 oj8GFG46+G/gM6fB4r2h5k2NFkiWug3K4vZ5t8cG7sfzPc3JFg3K2mcSqc1uuw38AB
	 SGysBf3gUGaZuXmGMciMJgZbISxsECkT+Jt2bIxHRH39KurK3xKcLuSOS7YNg6ER1W
	 oI/TabvEzjKjMlGHX6qHwgeVkQs30t9FRLmMmFt09RkwCd2tN6mLJPwNLtgBGNOt/4
	 Xvh/HFbJvEw2USrQ1nA2IRIT/8/5xlo4LDiawAojWbqFvwJCz+Ri+g6wLr1F9gzXaF
	 Nv207cqGce3aw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 26 Aug 2025 10:13:04 +0200
Subject: [PATCH mt76] wifi: mt76: Remove dead code in mt76_scan_work
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-mt76_scan_work-dead-code-v1-1-ac5234c4d044@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI9srWgC/x3MQQqDMBBA0avIrDsQg46xVykiITPWoTQpidiCe
 HdDl2/x/wFFskqBe3NAll2LpljR3hoIq49PQeVqsMb2xlnC9zbQXIKP8zflF7J4xpBYkL0byS0
 dkemg5p8si/7+68d0nhfkHAqKagAAAA==
X-Change-ID: 20250826-mt76_scan_work-dead-code-da8968f46604
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Duration can't be equal to 0 in mt76_scan_work routine so get rid of
related if condition.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/scan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 9b20ccbeb8cf19d3c231b82121c1dbeec8ab8a33..458f8cdebc1088c2c52360a2b004cf163b0e7e8c 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -112,9 +112,6 @@ void mt76_scan_work(struct work_struct *work)
 	local_bh_enable();
 
 out:
-	if (!duration)
-		return;
-
 	if (dev->scan.chan)
 		duration = max_t(int, duration,
 			         msecs_to_jiffies(req->duration +

---
base-commit: d9104cec3e8fe4b458b74709853231385779001f
change-id: 20250826-mt76_scan_work-dead-code-da8968f46604

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


