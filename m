Return-Path: <linux-wireless+bounces-9858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6B92411C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD402833BA
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A81BA08A;
	Tue,  2 Jul 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YHEOPZXf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6FBE7F;
	Tue,  2 Jul 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931495; cv=none; b=aH4qMpORMYev9NhFGEUX4CeQ7TYgQ/dO3KAM66aUAXc95LD4Sm/zenhay/DcWWB/ROimEVhgg4HEDtI0trKLgYFNjqfinnxXxviWZM/CpLtRvLIFKz9189zvjQW41EJI+4r6Cz8Exs9K40F4WIVAarVtdawWkVwzjvVWr9uP3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931495; c=relaxed/simple;
	bh=hylGUm911e4WMhiZzXuDXft7cF0yyM6IgOOX8pQZKto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQNrkLTyqoTar9DlZKbHHjnhXgyyhNI+X4pE6INZTzIPywR4N5+cHCFAbuWs/VZTCN0qYmDSJfJEU7M/u8QWh+sHMvBbbtFEyLROgTluCrBjAbYFS36YsZAi/7mBqMF/nM3e3KBNTBAiwFn4RBbpnImwFz2RspRt81buVLiJfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YHEOPZXf reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id aed396a62b52ac75; Tue, 2 Jul 2024 16:44:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 43444A562AE;
	Tue,  2 Jul 2024 16:44:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719931483;
	bh=hylGUm911e4WMhiZzXuDXft7cF0yyM6IgOOX8pQZKto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHEOPZXf+76dohpZb1tqnMCHzzVnxT+Eithjngiq2luwFTK7aUUkjmymASzTAodqH
	 gHQaFoRKyp3ixiPuj96QCVVz44w9ZM84M7pGewktFATsgAU0jnkVb8zGmjvj/4coJn
	 keswOV8bywQr5KtTO4PgYZyMZn86loZGqBe598EG/rN6Qk0jQII2ew1xbH0lwvGzrm
	 K2vNtHcaXRCuz3x2Ah0/LHaxKjG+/z33MZcFxcPQWK2iBuINh4TiXk1Lxj/kz6iWgo
	 MOG3NppUhThUPI5qppVr1ZgiPAk9SOBRltXONZI4iyP8w5plnAJujoAvKRozOBuGwF
	 jE/Xtd5Gm7kDg==
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
 [RESEND][PATCH v1 5/5] thermal: trip: Fold __thermal_zone_get_trip() into its
 caller
Date: Tue, 02 Jul 2024 16:44:27 +0200
Message-ID: <22339769.EfDdHjke4D@rjwysocki.net>
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

Because __thermal_zone_get_trip() is only called by thermal_zone_get_trip()
now, fold the former into the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_trip.c |   18 ++++--------------
 include/linux/thermal.h        |    2 --
 2 files changed, 4 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -114,27 +114,17 @@ void thermal_zone_set_trips(struct therm
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
 
-int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			    struct thermal_trip *trip)
-{
-	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
-		return -EINVAL;
-
-	*trip = tz->trips[trip_id].trip;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
-
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip)
 {
-	int ret;
+	if (!tz || !trip || trip_id < 0 || trip_id >= tz->num_trips)
+		return -EINVAL;
 
 	mutex_lock(&tz->lock);
-	ret = __thermal_zone_get_trip(tz, trip_id, trip);
+	*trip = tz->trips[trip_id].trip;
 	mutex_unlock(&tz->lock);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -202,8 +202,6 @@ static inline void devm_thermal_of_zone_
 }
 #endif
 
-int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 int for_each_thermal_trip(struct thermal_zone_device *tz,




