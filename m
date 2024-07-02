Return-Path: <linux-wireless+bounces-9862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B2D924129
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A74E284435
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD61BB6AC;
	Tue,  2 Jul 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="VqlLDQLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D661BA081;
	Tue,  2 Jul 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931497; cv=none; b=Hza1x9xRxUUHohreAUKagXcvkz7D8YfjlS+J+1S08VRpygbgargv9UJduNAYsMJTkvJfl2wnxKZf5qFo9kvjttLEBQNLXZiwAQaGE6z0ct4cYzTqCf3NhZJFysshskC12FawVGgk1OPumVgdu3grs07RnStvoFXTmtIhZQjRALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931497; c=relaxed/simple;
	bh=N4431/dEqcLneJ0L4FqIhI85vfz3NLUuiDXk1AU3+nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw9oWruLdxgGlaMw7PA7h6VpDSWK7X973hBn+dsu5HC55vuXH0oFKAXbqeVYwduWMG2c7OpknnqmGnIOymYSONyos4MHOzukaCwUUPtKUvmcPlo5a/B1xUVFvXSGhNrn80B6EtVFP8Vl1Vxcpr95jy5/6hE13WdI7wbH/8kmn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=VqlLDQLZ reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 745cb868f8af16c1; Tue, 2 Jul 2024 16:44:47 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D92E0A562AE;
	Tue,  2 Jul 2024 16:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719931487;
	bh=N4431/dEqcLneJ0L4FqIhI85vfz3NLUuiDXk1AU3+nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VqlLDQLZnR7YAwfrbpap3zxI1WWOea7EZv8XRNZtrMSrkJy8T3vB1nj0cpCAIWFnr
	 Ssz5PV8/wcR6HZLJJXMznIFV+mp/6+uBwZJVRLyk6PaXkBCq9JoCILOPl6w+bFmr20
	 CkMnCLdldnrvy938LH/OhgRaqe483zPltAmCG/mJqfx3XinE7qzd68O/mjckeClHcs
	 6DtSaoShJUPSrW+99njwhJNxnHhuXPa3NFr3VAKhMKgw2LBX6/Bn5vfFBFDsBo9Vzu
	 U+lS2HMIIFFkGG2o3AgJKyrDNObh41fnpb+UqH8xPmG7FIJxqP0Hbeofcc2CKiba2H
	 ZYNmZ5sELNZZg==
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
 [RESEND][PATCH v1 1/5] thermal: helpers: Introduce
 thermal_trip_is_bound_to_cdev()
Date: Tue, 02 Jul 2024 16:39:55 +0200
Message-ID: <13545762.uLZWGnKmhe@rjwysocki.net>
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

Introduce a new helper function thermal_trip_is_bound_to_cdev() for
checking whether or not a given trip point has been bound to a given
cooling device.

The primary user of it will be the Tegra thermal driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c |   47 ++++++++++++++++++++++++++++----------
 include/linux/thermal.h           |    3 ++
 2 files changed, 38 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -39,30 +39,53 @@ int get_tz_trend(struct thermal_zone_dev
 	return trend;
 }
 
+static struct thermal_instance *get_instance(struct thermal_zone_device *tz,
+					     struct thermal_cooling_device *cdev,
+					     const struct thermal_trip *trip)
+{
+	struct thermal_instance *ti;
+
+	list_for_each_entry(ti, &tz->thermal_instances, tz_node) {
+		if (ti->trip == trip && ti->cdev == cdev)
+			return ti;
+	}
+
+	return NULL;
+}
+
+bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
+				   const struct thermal_trip *trip,
+				   struct thermal_cooling_device *cdev)
+{
+	bool ret;
+
+	mutex_lock(&tz->lock);
+	mutex_lock(&cdev->lock);
+
+	ret = !!get_instance(tz, cdev, trip);
+
+	mutex_unlock(&cdev->lock);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
+
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
 		     struct thermal_cooling_device *cdev, int trip_index)
 {
-	struct thermal_instance *pos = NULL;
-	struct thermal_instance *target_instance = NULL;
-	const struct thermal_trip *trip;
+	struct thermal_instance *ti;
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	trip = &tz->trips[trip_index].trip;
-
-	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
-			target_instance = pos;
-			break;
-		}
-	}
+	ti = get_instance(tz, cdev, &tz->trips[trip_index].trip);
 
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
 
-	return target_instance;
+	return ti;
 }
 EXPORT_SYMBOL(get_thermal_instance);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -269,6 +269,9 @@ struct thermal_zone_device *thermal_zone
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+bool thermal_trip_is_bound_to_cdev(struct thermal_zone_device *tz,
+				   const struct thermal_trip *trip,
+				   struct thermal_cooling_device *cdev);
 
 int thermal_zone_device_enable(struct thermal_zone_device *tz);
 int thermal_zone_device_disable(struct thermal_zone_device *tz);




