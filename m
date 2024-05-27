Return-Path: <linux-wireless+bounces-8099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73968D0346
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3CE1F27B2C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D50160783;
	Mon, 27 May 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeKKZVfM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDF15EFDE;
	Mon, 27 May 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819259; cv=none; b=KdNRffwZn/7Z2Rt6NosAwOeZsqqwZ/icVGJ4Puq7eM4t/KG8dPxWFk22+EkH8YP/QjLHKXqqD2hs6lb1E1NwiBl7rKUYOMnAYw2KIQWl84yqKXdGAzXhuWys+1WZHt/7jqBPxedvoT+gj6Vvs3Qc1IMiBEIRAdNM87bfcXr//Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819259; c=relaxed/simple;
	bh=vcodY77d0fjdgiOcurVpNnSE7/ZF163gHw2AiqjgWxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5C6T0I4ELxtTS55TmotGfih4VMpdpcazm1TnzwelrvVL8ayrL1P0vClN3YDyppyzPxVhuRwO3HKCIHSefiwZJMnWqX9xPhulkGBoeDZrM0ABmoDY5LmH9OWolk+UgZU1rw6iaYxUCaV/D72Zc/q/loqmoWIqV2wMan5OaJvHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeKKZVfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26D5C2BBFC;
	Mon, 27 May 2024 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819259;
	bh=vcodY77d0fjdgiOcurVpNnSE7/ZF163gHw2AiqjgWxo=;
	h=From:To:Cc:Subject:Date:From;
	b=PeKKZVfMpw1Z9ACDnUUgNKU4ArPn4gpsQrLMDIiQiVyQwuUwQaHj73afr2Xgr/xhn
	 UNonDSouZ4GzEyfGliud+4Fl6GOPiWHSqbdsYFuIXnpSGcZDhz/CncugQiV+dV+Qk3
	 VxNlwYp0OOFdVhDsQOL3pbEHxhWbyifFLMYji7/iQQ5bUs011VsWjP0z1oPNUcoTLh
	 V+VJCwPB47iaI47v/I+e2jKIoRnCW8oDHutQjfMB5Ix7A6X/7JhaMHqpAdkcWcZRDi
	 ZjDGpTI2bzGKGhl26jg5JtzH+jnohqhzaNp95fDoslAFC+y9HbChtme0r1n2IKwjFe
	 GboLVx1RzFqag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/30] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Mon, 27 May 2024 10:13:10 -0400
Message-ID: <20240527141406.3852821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Rand Deeb <rand.sec96@gmail.com>

[ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]

The ssb_device_uevent() function first attempts to convert the 'dev' pointer
to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
performing the NULL check, potentially leading to a NULL pointer
dereference if 'dev' is NULL.

To fix this issue, move the NULL check before dereferencing the 'dev' pointer,
ensuring that the pointer is valid before attempting to use it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ssb/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index b9934b9c2d708..070a99a4180cc 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -341,11 +341,13 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 
 static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	const struct ssb_device *ssb_dev;
 
 	if (!dev)
 		return -ENODEV;
 
+	ssb_dev = dev_to_ssb_dev(dev);
+
 	return add_uevent_var(env,
 			     "MODALIAS=ssb:v%04Xid%04Xrev%02X",
 			     ssb_dev->id.vendor, ssb_dev->id.coreid,
-- 
2.43.0


