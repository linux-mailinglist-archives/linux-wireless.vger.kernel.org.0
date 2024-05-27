Return-Path: <linux-wireless+bounces-8104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D56328D03DD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1501B2305C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3BD15F32D;
	Mon, 27 May 2024 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beKFfO/6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD015F3E1;
	Mon, 27 May 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819365; cv=none; b=gAShw8iKEyAfxjHCyKGj7m2jDf/RTddMCfyc/ZXVjGhPlo6bRCiZJshabd3DValbxvfGXxaJoS7TFVs3Cc8XZ9xatS4yu59AuagmDoXfnhkuKLxamPm+5bOM02jm2l3NnhMOte0XK7VDe7pjvMJmuB7Wt4xQVn7TAAk36Us2j2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819365; c=relaxed/simple;
	bh=61vk/0SqBBEPtHUsvDLwLb8vmKwp05zyKTQUGQlJN34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuUYUn3qPw9zhe1eiVDOTok8fHYNEHjGiqO8Jx3ppthptJ5uuvwA144y5gnKlrmxxA9x8LZvd3Feq/kA3SvdEweP+3lGCU4cwBFhPwypw4oJAvyXeuKkZEyW3QDNSnVaZGOVX1r80ojgQ/pt2rj/hLuDboBYtcw5/vPId/qczZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beKFfO/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F305AC2BBFC;
	Mon, 27 May 2024 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819364;
	bh=61vk/0SqBBEPtHUsvDLwLb8vmKwp05zyKTQUGQlJN34=;
	h=From:To:Cc:Subject:Date:From;
	b=beKFfO/6DNnFxfEEpaOVR2owHqxMKE9bGe/x0FnE+FQWKzkJZP+ldBo92xzli0pQu
	 gSrM8UWSL0aKNu3nF+8wtA4TOPVnVc9lBGcS1ibCC88syKX2V+KlJlmo1nuEtMFPDe
	 jaG/YsOqWXNvS1456mQesv4sb/cXnUnynh1T3lYunhx9WnEJoBsx+NDI/SpP2fGTU8
	 CVi++RKmJOQQl9c0WWAIGysNv1lrakIUHNfyduA7sAelxhf75JNpI/rUghjTHS6PAC
	 8wQXOC41IOWPMynyg8pGOw7SSu9BRyRIIKrhnn+Kfl6/ZiEGo4Sumih9uKSVqeHi69
	 dzDnZhPUnTrFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 01/21] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Mon, 27 May 2024 10:15:12 -0400
Message-ID: <20240527141551.3853516-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index ab080cf26c9ff..0c736d51566dc 100644
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


