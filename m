Return-Path: <linux-wireless+bounces-9860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B15924123
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABAF1F2287E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75621BA89B;
	Tue,  2 Jul 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="l0HqeHhC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA41BA07C;
	Tue,  2 Jul 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931496; cv=none; b=cVB8v/rkEybh//5VzXgXOh83KYvOGPVj2dZvDmVwZ40ewDD52+DCLuY4xo7QLxwZD0UXAhDKfHhReYmAcJF3HKP34zygLC6yQ9pEi2RWzNdZAxSrydPRzPsRvMH7Lm7+EYUugK+4O/gdFev/3eN7as+Nr0adYfQ7YQkCGDjf1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931496; c=relaxed/simple;
	bh=ULktF8naJ9Rw66szNBQ/Dn3wRGt6CrZufx250lGQItc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tU5I/boqjl0THZYAiDMkEzvtvI+YO9fUvzH7n1TX9awSKy8SUrebLwbiXl/0xH9u5SFxqjdy4kGpmUfLv3doQ7nrRaKMSSpVubG1YHlrZD+400vHg7SHqXs1BRcHB1rBbQfGBLR2zwW2/fDQllej0pnAwEVxWR/Tyj+11CjDZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=l0HqeHhC reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id bc1a8336c5d924f2; Tue, 2 Jul 2024 16:44:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EFAE0A562AE;
	Tue,  2 Jul 2024 16:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719931486;
	bh=ULktF8naJ9Rw66szNBQ/Dn3wRGt6CrZufx250lGQItc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l0HqeHhC21unW2znGp2teRACF1C2/e0FERuief67K4CY9cIUA6n1jl8fj++UPTmlT
	 GemRDMr/c53doxI2F5H/bOWPrZjm1OiHk+9boUYueWVkDhE6tWVxU1955ut4nv7DFM
	 MSrodz6IVa/p3/k0CkYe+13jtyUaEY1Cq/3JZRWPPB/CRbawWdhuNBWKREBwK+6AlJ
	 IrSzpv0u7FUadI6ORBLPs0iZ1AbT/gX4CVhGehbNOqqy8q6/gaVFICQKjS07gYmW6X
	 FPcwS6ihSUPZ7AQukrYFiTm2tHCuYTwnm6XEhIW8Dky8mQ9FjsW4mQblILHE6KwWNb
	 wrMJGUkyrM5mQ==
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
 [RESEND][PATCH v1 2/5] thermal: trip: Add conversion macros for thermal trip
 priv field
Date: Tue, 02 Jul 2024 16:41:03 +0200
Message-ID: <3297884.aeNJFYEL58@rjwysocki.net>
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

Some drivers will need to store integers in the priv field of struct
thermal_trip, so add conversion macros for doing this in a consistent
way and switch over the int340x_thermal driver that already does it and
uses custom conversion functions to using the new macros.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   14 +----------
 include/linux/thermal.h                                      |    3 ++
 2 files changed, 5 insertions(+), 12 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -79,6 +79,9 @@ struct thermal_trip {
 #define THERMAL_TRIP_FLAG_RW	(THERMAL_TRIP_FLAG_RW_TEMP | \
 				 THERMAL_TRIP_FLAG_RW_HYST)
 
+#define THERMAL_TRIP_PRIV_TO_INT(_val_)	(uintptr_t)(_val_)
+#define THERMAL_INT_TO_TRIP_PRIV(_val_)	(void *)(uintptr_t)(_val_)
+
 struct thermal_zone_device;
 
 struct thermal_zone_device_ops {
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -62,16 +62,6 @@ static void int340x_thermal_critical(str
 		thermal_zone_device_type(zone));
 }
 
-static inline void *int_to_trip_priv(int i)
-{
-	return (void *)(long)i;
-}
-
-static inline int trip_priv_to_int(const struct thermal_trip *trip)
-{
-	return (long)trip->priv;
-}
-
 static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
 				      struct thermal_trip *zone_trips,
 				      int trip_cnt)
@@ -106,7 +96,7 @@ static int int340x_thermal_read_trips(st
 			break;
 
 		zone_trips[trip_cnt].type = THERMAL_TRIP_ACTIVE;
-		zone_trips[trip_cnt].priv = int_to_trip_priv(i);
+		zone_trips[trip_cnt].priv = THERMAL_INT_TO_TRIP_PRIV(i);
 		trip_cnt++;
 	}
 
@@ -224,7 +214,7 @@ static int int340x_update_one_trip(struc
 		break;
 	case THERMAL_TRIP_ACTIVE:
 		err = thermal_acpi_active_trip_temp(zone_adev,
-						    trip_priv_to_int(trip),
+						    THERMAL_TRIP_PRIV_TO_INT(trip->priv),
 						    &temp);
 		break;
 	default:




