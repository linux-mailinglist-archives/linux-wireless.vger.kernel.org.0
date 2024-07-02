Return-Path: <linux-wireless+bounces-9859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A792411F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507191F21A9F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74331BA868;
	Tue,  2 Jul 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ex0/AGAA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980D1B582F;
	Tue,  2 Jul 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931495; cv=none; b=TfKSeT6DeHf5zA8ScLDs6yQmMNfkCD7foPZ0U2X6nbTIW/xZ/iWrHJS5EITKSDbeaKccA1HFvmXKcdXX9JiA9ZMYZLLqxgdGOMOeLyTh0RQbN/IiZhmHR5WQyLjReykzZj692DKOl5vrKECMw/a5aX6NUwpqQMM2Tkk7tWKsmWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931495; c=relaxed/simple;
	bh=igm8Hsce+3exsKL3ldkATepEb7/+cdyJt0g/twzxO/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f13qYN6d75fqvqAyQy855wMzxAZhMvQG01qJigLTXH7jBiRQ8bni3MtxMjZS7gsUq+xsQ1knOD1/hXcNCWd1fCpFcRfoxFvUO+nn6FH3L2NPh61Ag1B0sileIo6iByFyrVPXJMy0q8sB+0CvRTy/QzDxI8RznmbMn2Ly0MeiC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ex0/AGAA reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ea584e3ebb090532; Tue, 2 Jul 2024 16:44:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2D65FA562AE;
	Tue,  2 Jul 2024 16:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719931484;
	bh=igm8Hsce+3exsKL3ldkATepEb7/+cdyJt0g/twzxO/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ex0/AGAAQX/vvvEHT/32DS9NyiXCAdcoJ4xJ3fYsipzmIBNMGAwvzxJU62C8PJmFb
	 eqw1Fu6y8BVtx5EFUCiwCydzn7EVVLssufBnmE/udNswkET/uWOkXFE/BprlWNApOG
	 SzAnR7G5ZmelE/bAEhco502CjRZQADGuEnVplekIwieK7gbDFK5BChNqZYc1acFtYi
	 nuswFuWWCd6UBBdmg7U95xsrRahkTBLKtrFWBvdKXs84Bljkamyfbux2j3Ekn/Mj1o
	 D8oYez5KmhNswvR4xJwdMSnuIEqDTW6TGtMGgqRmdPABnF1ufxOZweg27WTkhd/mcO
	 M/nzcZI1LnTDQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-wireless@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject:
 [RESEND][PATCH v1 4/5] thermal: imx: Drop critical trip check from
 imx_set_trip_temp()
Date: Tue, 02 Jul 2024 16:43:36 +0200
Message-ID: <2272035.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <1890956.tdWV9SEqCh@rjwysocki.net>
References: <1890956.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigt
 rghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the IMX thermal driver does not flag its critical trip as
writable, imx_set_trip_temp() will never be invoked for it and so the
critical trip check can be dropped from there.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/imx_thermal.c |    9 ---------
 1 file changed, 9 deletions(-)

Index: linux-pm/drivers/thermal/imx_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/imx_thermal.c
+++ linux-pm/drivers/thermal/imx_thermal.c
@@ -335,21 +335,12 @@ static int imx_set_trip_temp(struct ther
 			     int temp)
 {
 	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
-	struct thermal_trip trip;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(data->dev);
 	if (ret < 0)
 		return ret;
 
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret)
-		return ret;
-
-	/* do not allow changing critical threshold */
-	if (trip.type == THERMAL_TRIP_CRITICAL)
-		return -EPERM;
-
 	/* do not allow passive to be set higher than critical */
 	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
 		return -EINVAL;




