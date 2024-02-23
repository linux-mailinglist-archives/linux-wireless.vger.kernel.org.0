Return-Path: <linux-wireless+bounces-3957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E40860FB8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550B51C22E44
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5957E593;
	Fri, 23 Feb 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zkude+fj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65641823C1
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684831; cv=none; b=MSn9s4lgQw8CZHqvC8+WPcrnSAnKeuGG5uD7NnFCoqL4XxvbJI5bPi9mq5i1/vf4/LIdZSxpmOecGooQwG2UAjZpJ4/Sjn/OCGbbZhznwSuhdFFDWGWK35WSyfRYiJL0G2Cq+RrDXk60OCN1ycjL5DcQ6iqV5tlJJAy/Apt2aPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684831; c=relaxed/simple;
	bh=hV/yKZZi42u/3GX5RrWl/h2TSUXotFB4WE2JNkiUvfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOa6VdGzadwHTe/PVS2lSpkBSO1p7QYczhRuQbYyqykCvBQydeYWR0J7OCLGwiUB3O/4OYTwPX88PpvDzeE+BwiKSQ9rJraQD5olOc4ffCt5Jr6S5JRS9451ltkQxhGbJ1TPhrHU5R9mZdAWstyaESvEDN5A71IAI26dLGHv9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zkude+fj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=szU5A2/fb9fuRVNP/Fl2eh853klpAqTds4ZyeiHJd+8=;
	t=1708684830; x=1709894430; b=Zkude+fjij/6sEieZVxDRectXbRLCP1sz2xxGR7hmrRipYq
	HDVnXLqSX3AVK3Oxi4Bkre5BZg3lDUMJ7eMO4g5ECnpJCCZl1jOcL4rstyvV8iAuviogYp/eRXutH
	18W5gO4g06PET0/IH4A1lWyNJTJpukDAarVjqs9udyGnkYA3giIYBloqI9tHn1XeksD3k07IM4Ly3
	KpqNFLsMTBQ/uf1pruOfx5WlpL+k8Pjit22Fw4klK4M1sD4IX92OrIF7kot5EZHg1ayIx+9Dlg9KL
	BpjSiF5uZJDidYzCv1XUXPs/tJIb0KP9om1AVkdtW9EzgNhI1IWy+5Joatl/LOYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rdSyh-000000051om-2NVb;
	Fri, 23 Feb 2024 11:40:27 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] wifi: zd1211rw: silence sparse warnings
Date: Fri, 23 Feb 2024 11:40:27 +0100
Message-ID: <20240223114023.976fcd59e97a.I0bba4ef7dc2847ce8ab5ec229149e1a09413b8b9@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
References: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This code wants to compare the obtained value, but as it also
has a special type for register addresses to find places doing
such compares and calculations wrong, we need explicit casts
here to silence sparse.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 8505d84eeed6..f3b567a13ded 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -380,7 +380,7 @@ static inline void handle_regs_int(struct urb *urb)
 	spin_lock_irqsave(&intr->lock, flags);
 
 	int_num = le16_to_cpu(*(__le16 *)(urb->transfer_buffer+2));
-	if (int_num == CR_INTERRUPT) {
+	if (int_num == (u16)CR_INTERRUPT) {
 		struct zd_mac *mac = zd_hw_mac(zd_usb_to_hw(urb->context));
 		spin_lock(&mac->lock);
 		memcpy(&mac->intr_buffer, urb->transfer_buffer,
@@ -416,7 +416,8 @@ static inline void handle_regs_int(struct urb *urb)
 	spin_unlock_irqrestore(&intr->lock, flags);
 
 	/* CR_INTERRUPT might override read_reg too. */
-	if (int_num == CR_INTERRUPT && atomic_read(&intr->read_regs_enabled))
+	if (int_num == (u16)CR_INTERRUPT &&
+	    atomic_read(&intr->read_regs_enabled))
 		handle_regs_int_override(urb);
 }
 
-- 
2.43.2


