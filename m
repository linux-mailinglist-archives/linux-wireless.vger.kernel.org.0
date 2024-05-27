Return-Path: <linux-wireless+bounces-8093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A768D02D4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D8729A976
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D715D5B0;
	Mon, 27 May 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9NLFaWp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481D91640B;
	Mon, 27 May 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819137; cv=none; b=dGmFpxxcFhP08JhGeOpMDt087zrp0azNs9PBNP5gbE0CNWBrbmoHz6JaY1C2FJ3Xusi6/9mBDB0m9T/S1x9jGst0wd21deESN0yeAC7Y+PuOnQW6otczky+4z5h/vthv2XL+OkFJt5iXGrhFCY9vTdTzYskmlURSI3AmbnkzUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819137; c=relaxed/simple;
	bh=6SYKgBlXJN9TOW8fSy6AeVIJaXX94pXSGwfM/4Tmus4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SACeCP6WSeo0Dum8NFdI30gcvquNCHE2eTtFcscoB8Elp2esMfXP/u/pdTKwJ4piLNnQVuJpqIJmCVqSreYUfJVhYL6rIDl5kP5MtwG+BGjz76HOoPdJVpRNZRX5ek+Uc/tUMNI+ltsH0pWnTXyhZuJ9jbYDgAJdmoHqCMZq4r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9NLFaWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D8FC2BBFC;
	Mon, 27 May 2024 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819136;
	bh=6SYKgBlXJN9TOW8fSy6AeVIJaXX94pXSGwfM/4Tmus4=;
	h=From:To:Cc:Subject:Date:From;
	b=B9NLFaWpRBFXUabGFdTwJzSy6wxkeE8Dq15PHjo9+Pym3PKSVCUNHzw2V5N6cZBGg
	 8xYoOf46rWc2AzhmhBEC8itJGl/Rj8t/dDMyIBsD05ySS3gglp+U9Gg/37wKMjrWIy
	 Agon5V1v4LfhPYKtgxSsDbehpo0jOFoGK6MbZfK2BZwqUhTOeccL0q8Q/e3qdLwAiz
	 gVhmgNQrVMSzHZZJiPtnzxOrpd+P7IHzmaJLN335G570xo1QqXWIQZsxj2OTBl8a/T
	 TBbhewxOxe1xSJBWruBS2gPcGd7irr5Gd1DWVFaKiRHQIj3QpiHxC/Ua8AVR38Lq7P
	 ETBJ97sMLkQ8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rand Deeb <rand.sec96@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 01/35] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Mon, 27 May 2024 10:11:06 -0400
Message-ID: <20240527141214.3844331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
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
index 9f30e0edadfe2..bdb6595ffd2d5 100644
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


