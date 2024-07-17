Return-Path: <linux-wireless+bounces-10314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ED49342CC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 21:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA4281577
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC91836F7;
	Wed, 17 Jul 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CKzi/Jdj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751920B35;
	Wed, 17 Jul 2024 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245514; cv=none; b=KY1hwvVgdvoxT4dPXS5wY8DsGMAKLnb2yG5ixUbjqmFwpkbO7gVEnlFizIMulBX4MaKs8cpap5Bgidc1HpRKwE/igBQW07Hx9H0qKHeVxFUKrtXomRCdHehkSwK+Skq1sEGu8GwLzgoAW7VjA+NkQabYu3jFq7WBgflZBw8Ozcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245514; c=relaxed/simple;
	bh=FzNgTHZLkSU40zqaOilCJIImB4TjMsvLogmTVCxP2cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UnnCnTeOkDT5H8SiyG+JIxCK3Bh0wwm0t6deM2uKDD21U2ncQ86Rr1rgpm3boxqUYUjPB3K3uLXfWUMSAH4k8WQXnJZiVz0ReJ4M65h4WWs+9+wOLXJJPZYWIuxSiRUV+2wbJpuw+nGFz0biocCOnZ/xDpA1e413FR+XXkMn6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CKzi/Jdj reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id d13e08fb08359916; Wed, 17 Jul 2024 21:45:02 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5DA609964C1;
	Wed, 17 Jul 2024 21:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1721245502;
	bh=FzNgTHZLkSU40zqaOilCJIImB4TjMsvLogmTVCxP2cc=;
	h=From:To:Cc:Subject:Date;
	b=CKzi/JdjqBwzXBlTlQyUawKu8vxfdAES64KTXUTzR7ro9Hb4hcEJbjsPSfd1sf+cu
	 xV6Cq6HC6zpkYCYeuvjNfiIiZUUvxjhBqst7R8xPgzPiqavHdLK4u28/kY63pcf6UC
	 qym/lRF3uPWrTeuDZ+m7fQyimbnNhT0p6X+V4G5pSVELX7JOgfGvq2nCcx/e6XGUuG
	 QTGBVXTP81SvupwU5gV7NeI66ASQQDcwg6zPvSCW1nFkyjNdoJBn0QkigwtLbdQ2q0
	 M4CrPB7ievLihUqJnaFk4TA41GuCa8bzNvs4Dn5TtoOLMPEG5wi4C6cSmTj5QqrlGj
	 UHtIJFWQaxLJA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 Eric Biggers <ebiggers@kernel.org>, Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Ben Greear <greearb@candelatech.com>
Subject:
 [PATCH v2] thermal: core: Allow thermal zones to tell the core to ignore them
Date: Wed, 17 Jul 2024 21:45:02 +0200
Message-ID: <4950004.31r3eYUQgx@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrgeejgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegr
 rhhmrdgtohhmpdhrtghpthhtohepmhhirhhirghmrdhrrggthhgvlhdrkhhorhgvnhgslhhithesihhnthgvlhdrtghomhdprhgtphhtthhopehkvhgrlhhosehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The iwlwifi wireless driver registers a thermal zone that is only needed
when the network interface handled by it is up and it wants that thermal
zone to be effectively ignored by the core otherwise.

Before commit a8a261774466 ("thermal: core: Call monitor_thermal_zone()
if zone temperature is invalid") that could be achieved by returning
an error code from the thermal zone's .get_temp() callback because the
core did not really handle errors returned by it almost at all.
However, commit a8a261774466 made the core attempt to recover from the
situation in which the temperature of a thermal zone cannot be
determined due to errors returned by its .get_temp() and is always
invalid from the core's perspective.

That was done because there are thermal zones in which .get_temp()
returns errors to start with due to some difficulties related to the
initialization ordering, but then it will start to produce valid
temperature values at one point.

Unfortunately, the simple approach taken by commit a8a261774466,
which is to poll the thermal zone periodically until its .get_temp()
callback starts to return valid temperature values, is at odds with
the special thermal zone in iwlwifi in which .get_temp() may always
return an error because its network interface may always be down.  If
that happens, every attempt to invoke the thermal zone's .get_temp()
callback resulting in an error causes the thermal core to print a
dev_warn() message to the kernel log which is super-noisy.

To address this problem, make the core handle the case in which
.get_temp() returns 0, but the temperature value returned by it
is not actually valid, in a special way.  Namely, make the core
completely ignore the invalid temperature value coming from
.get_temp() in that case, which requires folding in
update_temperature() into its caller and a few related changes.

On the iwlwifi side, modify iwl_mvm_tzone_get_temp() to return 0
and put THERMAL_TEMP_INVALID into the temperature return memory
location instead of returning an error when the firmware is not
running or it is not of the right type.

Also, to clearly separate the handling of invalid temperature
values from the thermal zone initialization, introduce a special
THERMAL_TEMP_INIT value specifically for the latter purpose.

Fixes: a8a261774466 ("thermal: core: Call monitor_thermal_zone() if zone temperature is invalid")
Closes: https://lore.kernel.org/linux-pm/20240715044527.GA1544@sol.localdomain/
Reported-by: Eric Biggers <ebiggers@kernel.org>
Reported-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201761
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc: 6.10+ <stable@vger.kernel.org> # 6.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * It is safer to retain the old behavior in thermal_zone_get_temp(),
     which is the second place where the .get_temp() zone callback is
     used, so make it return -ENODATA if the temperature value coming
     from that callback is invalid.
   * Add Tested-by: for Stefan.

I have retained the previous Tested-by because the part of the patch that has
been tested remains unchanged.

---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    7 +++
 drivers/thermal/thermal_core.c              |   51 +++++++++++++---------------
 drivers/thermal/thermal_core.h              |    3 +
 drivers/thermal/thermal_helpers.c           |    2 +
 4 files changed, 35 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -300,8 +300,6 @@ static void monitor_thermal_zone(struct
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
-	else if (tz->temperature == THERMAL_TEMP_INVALID)
-		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
 }
 
 static struct thermal_governor *thermal_get_tz_governor(struct thermal_zone_device *tz)
@@ -382,7 +380,7 @@ static void handle_thermal_trip(struct t
 	td->threshold = trip->temperature;
 
 	if (tz->last_temperature >= old_threshold &&
-	    tz->last_temperature != THERMAL_TEMP_INVALID) {
+	    tz->last_temperature != THERMAL_TEMP_INIT) {
 		/*
 		 * Mitigation is under way, so it needs to stop if the zone
 		 * temperature falls below the low temperature of the trip.
@@ -417,27 +415,6 @@ static void handle_thermal_trip(struct t
 	}
 }
 
-static void update_temperature(struct thermal_zone_device *tz)
-{
-	int temp, ret;
-
-	ret = __thermal_zone_get_temp(tz, &temp);
-	if (ret) {
-		if (ret != -EAGAIN)
-			dev_warn(&tz->device,
-				 "failed to read out thermal zone (%d)\n",
-				 ret);
-		return;
-	}
-
-	tz->last_temperature = tz->temperature;
-	tz->temperature = temp;
-
-	trace_thermal_temperature(tz);
-
-	thermal_genl_sampling_temp(tz->id, temp);
-}
-
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
@@ -452,7 +429,7 @@ static void thermal_zone_device_init(str
 
 	INIT_DELAYED_WORK(&tz->poll_queue, thermal_zone_device_check);
 
-	tz->temperature = THERMAL_TEMP_INVALID;
+	tz->temperature = THERMAL_TEMP_INIT;
 	tz->passive = 0;
 	tz->prev_low_trip = -INT_MAX;
 	tz->prev_high_trip = INT_MAX;
@@ -504,6 +481,7 @@ void __thermal_zone_device_update(struct
 	struct thermal_trip_desc *td;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
+	int temp, ret;
 
 	if (tz->suspended)
 		return;
@@ -511,10 +489,29 @@ void __thermal_zone_device_update(struct
 	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
-	update_temperature(tz);
+	ret = __thermal_zone_get_temp(tz, &temp);
+	if (ret) {
+		if (ret != -EAGAIN)
+			dev_info(&tz->device, "Temperature check failed (%d)\n", ret);
 
-	if (tz->temperature == THERMAL_TEMP_INVALID)
+		thermal_zone_device_set_polling(tz, msecs_to_jiffies(THERMAL_RECHECK_DELAY_MS));
+		return;
+	} else if (temp <= THERMAL_TEMP_INVALID) {
+		/*
+		 * Special case: No valid temperature value is available, but
+		 * the zone owner does not want the core to do anything about
+		 * it.  Continue regular zone polling if needed, so that this
+		 * function can be called again, but skip everything else.
+		 */
 		goto monitor;
+	}
+
+	tz->last_temperature = tz->temperature;
+	tz->temperature = temp;
+
+	trace_thermal_temperature(tz);
+
+	thermal_genl_sampling_temp(tz->id, temp);
 
 	tz->notify_event = event;
 
Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -622,7 +622,12 @@ static int iwl_mvm_tzone_get_temp(struct
 
 	if (!iwl_mvm_firmware_running(mvm) ||
 	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
-		ret = -ENODATA;
+		/*
+		 * Tell the core that there is no valid temperature value to
+		 * return, but it need not worry about this.
+		 */
+		*temperature = THERMAL_TEMP_INVALID;
+		ret = 0;
 		goto out;
 	}
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -133,6 +133,9 @@ struct thermal_zone_device {
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
+/* Initial thermal zone temperature. */
+#define THERMAL_TEMP_INIT	INT_MIN
+
 /*
  * Default delay after a failing thermal zone temperature check before
  * attempting to check it again.
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -145,6 +145,8 @@ int thermal_zone_get_temp(struct thermal
 	}
 
 	ret = __thermal_zone_get_temp(tz, temp);
+	if (!ret && *temp <= THERMAL_TEMP_INVALID)
+		ret = -ENODATA;
 
 unlock:
 	mutex_unlock(&tz->lock);




