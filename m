Return-Path: <linux-wireless+bounces-9861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDBC924127
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7459283BB9
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367B1BB698;
	Tue,  2 Jul 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="NbyX3Mbr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4E1B583A;
	Tue,  2 Jul 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931497; cv=none; b=RZuPI2X31VDOAD4B5t78ss3dqHxklzeZD4KGZwZS1UtxUTo7Bmv7er05s+6ZWWLj+GlA+boD+mh9rMDSzVSVinwStL14RgktnpV66KtlW/Yjfi8Yvq7G5tghUTmpHd29hm3Q8MWA27StQLzASCDT1pWM94JcRWWiJoqpIg60mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931497; c=relaxed/simple;
	bh=23iAF38dh0738CLKJAID/ku3IAjYnmcdw8xf+7Wmg1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmHQVlqjxgg1Gfaq+MRx7uZ7QXtyMWW9SueuSRBN1m1tW8wtWWiMom0pZ8LFXwnMRRaf2ZmuC34FzmFP1MAhI13mp7yhPqlYdX1LKcy5ou/7bFZ09HOhz2sU0zwrl4yXu2DzrpgfZYhknEfuUIKgQVdMLmqzlm0YU+51UeWVPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=NbyX3Mbr reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 28f3861e7503a477; Tue, 2 Jul 2024 16:44:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 08C87A562AE;
	Tue,  2 Jul 2024 16:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1719931485;
	bh=23iAF38dh0738CLKJAID/ku3IAjYnmcdw8xf+7Wmg1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NbyX3MbrjYjZqzm34DrgiKAxyjkIgWpyUoF66hSBSRf9aY9jQVhiC7VZf1ch/COzj
	 KOKLe9ayUt/Sg0ElOajJQ+6kkyPggZKlVUwN3z1mJywtZ287jp9PmWLALBXZjw6cRZ
	 Nrof6wVkrH+1QGpHlMBGYQHIhrR1hQ9PSHu6kUuDi+PWxyY/ItzH+zYDm6NXsVSjvV
	 eg1cXEc3IJaYb0YCvegKxROLFaJjTKnAm85H5s5CsmW9N6t26/j1LCwXa4Vk5Ry4Tw
	 +gPjkQgpd3iWuTDJug5gCZ/rc7eFL6T5we+8kW7qBfqDfDJxVp7DvLHsDXhSSTB03+
	 oTtM7lrD0Z7WQ==
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
 [RESEND][PATCH v1 3/5] thermal: trip: Pass trip pointer to .set_trip_temp()
 thermal zone callback
Date: Tue, 02 Jul 2024 16:42:33 +0200
Message-ID: <8392906.T7Z3S40VBb@rjwysocki.net>
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

Out of several drivers implementing the .set_trip_temp() thermal zone
operation, two don't actually use the trip ID argument passed to it,
two call __thermal_zone_get_trip() to get a struct thermal_trip
corresponding to the given trip ID, and the other use the trip ID as an
index into their own data structures with the assumption that it will
always match the ordering of entries in the trips table passed to the
core during thermal zone registration, which is fragile and not really
guaranteed.

Even though the trip IDs used by the core are in fact their indices in the
trips table passed to it by the thermal zone creator, that is purely a
matter of convenience and should not be relied on for correctness.

For this reason, modify trip_point_temp_store() to pass a (const) trip
pointer to .set_trip_temp() and adjust the drivers implementing it
accordingly.

This helps to simplify the drivers invoking __thermal_zone_get_trip()
from their .set_trip_temp() callback functions because they will not
need to do it now and the other drivers can store their internal
trip indices in the priv field in struct thermal_trip and their
.set_trip_temp() callback functions can get those indices from there.

The intel_quark_dts thermal driver can instead use the trip type to
determine the requisite trip index.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c                          |    2 
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |    8 +--
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    3 -
 drivers/thermal/intel/intel_quark_dts_thermal.c                      |   26 +++++++---
 drivers/thermal/intel/intel_soc_dts_iosf.c                           |   15 +++--
 drivers/thermal/intel/x86_pkg_temp_thermal.c                         |    9 ++-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c                          |   10 +--
 drivers/thermal/tegra/soctherm.c                                     |   14 +----
 drivers/thermal/thermal_sysfs.c                                      |    2 
 include/linux/thermal.h                                              |    3 -
 10 files changed, 54 insertions(+), 38 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -113,7 +113,7 @@ trip_point_temp_store(struct device *dev
 
 	if (temp != trip->temperature) {
 		if (tz->ops.set_trip_temp) {
-			ret = tz->ops.set_trip_temp(tz, trip_id, temp);
+			ret = tz->ops.set_trip_temp(tz, trip, temp);
 			if (ret)
 				goto unlock;
 		}
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -93,7 +93,8 @@ struct thermal_zone_device_ops {
 	int (*set_trips) (struct thermal_zone_device *, int, int);
 	int (*change_mode) (struct thermal_zone_device *,
 		enum thermal_device_mode);
-	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
+	int (*set_trip_temp) (struct thermal_zone_device *,
+			      const struct thermal_trip *, int);
 	int (*get_crit_temp) (struct thermal_zone_device *, int *);
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *,
Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -638,7 +638,7 @@ out:
 }
 
 static int iwl_mvm_tzone_set_trip_temp(struct thermal_zone_device *device,
-				       int trip, int temp)
+				       const struct thermal_trip *trip, int temp)
 {
 	struct iwl_mvm *mvm = thermal_zone_device_priv(device);
 	int ret;
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -39,13 +39,14 @@ static int int340x_thermal_get_zone_temp
 }
 
 static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
-					 int trip, int temp)
+					 const struct thermal_trip *trip, int temp)
 {
 	struct int34x_thermal_zone *d = thermal_zone_device_priv(zone);
-	char name[] = {'P', 'A', 'T', '0' + trip, '\0'};
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
+	char name[] = {'P', 'A', 'T', '0' + trip_index, '\0'};
 	acpi_status status;
 
-	if (trip > 9)
+	if (trip_index > 9)
 		return -EINVAL;
 
 	status = acpi_execute_simple_method(d->adev->handle, name,
@@ -144,6 +145,7 @@ struct int34x_thermal_zone *int340x_ther
 		zone_trips[i].type = THERMAL_TRIP_PASSIVE;
 		zone_trips[i].temperature = THERMAL_TEMP_INVALID;
 		zone_trips[i].flags |= THERMAL_TRIP_FLAG_RW_TEMP;
+		zone_trips[i].priv = THERMAL_INT_TO_TRIP_PRIV(i);
 	}
 
 	trip_cnt = int340x_thermal_read_trips(adev, zone_trips, trip_cnt);
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -225,7 +225,8 @@ static int sys_get_curr_temp(struct ther
 	return 0;
 }
 
-static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
+static int sys_set_trip_temp(struct thermal_zone_device *tzd,
+			     const struct thermal_trip *trip, int temp)
 {
 	struct proc_thermal_pci *pci_info = thermal_zone_device_priv(tzd);
 	int tjmax, _temp;
Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -195,7 +195,7 @@ static int get_trip_temp(int trip)
 }
 
 static int update_trip_temp(struct soc_sensor_entry *aux_entry,
-				int trip, int temp)
+				int trip_index, int temp)
 {
 	u32 out;
 	u32 temp_out;
@@ -230,9 +230,9 @@ static int update_trip_temp(struct soc_s
 	 */
 	temp_out = temp + QRK_DTS_TEMP_BASE;
 	out = (store_ptps & ~(QRK_DTS_MASK_TP_THRES <<
-		(trip * QRK_DTS_SHIFT_TP)));
+		(trip_index * QRK_DTS_SHIFT_TP)));
 	out |= (temp_out & QRK_DTS_MASK_TP_THRES) <<
-		(trip * QRK_DTS_SHIFT_TP);
+		(trip_index * QRK_DTS_SHIFT_TP);
 
 	ret = iosf_mbi_write(QRK_MBI_UNIT_RMU, MBI_REG_WRITE,
 			     QRK_DTS_REG_OFFSET_PTPS, out);
@@ -242,10 +242,24 @@ failed:
 	return ret;
 }
 
-static inline int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
-				int temp)
+static inline int sys_set_trip_temp(struct thermal_zone_device *tzd,
+				    const struct thermal_trip *trip,
+				    int temp)
 {
-	return update_trip_temp(thermal_zone_device_priv(tzd), trip, temp);
+	unsigned int trip_index;
+
+	switch (trip->type) {
+	case THERMAL_TRIP_HOT:
+		trip_index = QRK_DTS_ID_TP_HOT;
+		break;
+	case THERMAL_TRIP_CRITICAL:
+		trip_index = QRK_DTS_ID_TP_CRITICAL;
+		break;
+	default
+		return -EINVAL;
+	}
+
+	return update_trip_temp(thermal_zone_device_priv(tzd), trip_index, temp);
 }
 
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -129,18 +129,20 @@ err_restore_ptps:
 	return status;
 }
 
-static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
+static int sys_set_trip_temp(struct thermal_zone_device *tzd,
+			     const struct thermal_trip *trip,
 			     int temp)
 {
 	struct intel_soc_dts_sensor_entry *dts = thermal_zone_device_priv(tzd);
 	struct intel_soc_dts_sensors *sensors = dts->sensors;
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
 	int status;
 
 	if (temp > sensors->tj_max)
 		return -EINVAL;
 
 	mutex_lock(&sensors->dts_update_lock);
-	status = update_trip_temp(sensors, trip, temp);
+	status = update_trip_temp(sensors, trip_index, temp);
 	mutex_unlock(&sensors->dts_update_lock);
 
 	return status;
@@ -293,11 +295,12 @@ static void dts_trips_reset(struct intel
 }
 
 static void set_trip(struct thermal_trip *trip, enum thermal_trip_type type,
-		     u8 flags, int temp)
+		     u8 flags, int temp, unsigned int index)
 {
 	trip->type = type;
 	trip->flags = flags;
 	trip->temperature = temp;
+	trip->priv = THERMAL_INT_TO_TRIP_PRIV(index);
 }
 
 struct intel_soc_dts_sensors *
@@ -332,7 +335,7 @@ intel_soc_dts_iosf_init(enum intel_soc_d
 		sensors->soc_dts[i].sensors = sensors;
 
 		set_trip(&trips[i][0], THERMAL_TRIP_PASSIVE,
-			 THERMAL_TRIP_FLAG_RW_TEMP, 0);
+			 THERMAL_TRIP_FLAG_RW_TEMP, 0, 0);
 
 		ret = update_trip_temp(sensors, 0, 0);
 		if (ret)
@@ -340,10 +343,10 @@ intel_soc_dts_iosf_init(enum intel_soc_d
 
 		if (critical_trip) {
 			temp = sensors->tj_max - crit_offset;
-			set_trip(&trips[i][1], THERMAL_TRIP_CRITICAL, 0, temp);
+			set_trip(&trips[i][1], THERMAL_TRIP_CRITICAL, 0, temp, 1);
 		} else {
 			set_trip(&trips[i][1], THERMAL_TRIP_PASSIVE,
-				 THERMAL_TRIP_FLAG_RW_TEMP, 0);
+				 THERMAL_TRIP_FLAG_RW_TEMP, 0, 1);
 			temp = 0;
 		}
 
Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -119,9 +119,11 @@ static int sys_get_curr_temp(struct ther
 }
 
 static int
-sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
+sys_set_trip_temp(struct thermal_zone_device *tzd,
+		  const struct thermal_trip *trip, int temp)
 {
 	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
+	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
 	u32 l, h, mask, shift, intr;
 	int tj_max, val, ret;
 
@@ -132,7 +134,7 @@ sys_set_trip_temp(struct thermal_zone_de
 
 	val = (tj_max - temp)/1000;
 
-	if (trip >= MAX_NUMBER_OF_TRIPS || val < 0 || val > 0x7f)
+	if (trip_index >= MAX_NUMBER_OF_TRIPS || val < 0 || val > 0x7f)
 		return -EINVAL;
 
 	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
@@ -140,7 +142,7 @@ sys_set_trip_temp(struct thermal_zone_de
 	if (ret < 0)
 		return ret;
 
-	if (trip) {
+	if (trip_index) {
 		mask = THERM_MASK_THRESHOLD1;
 		shift = THERM_SHIFT_THRESHOLD1;
 		intr = THERM_INT_THRESHOLD1_ENABLE;
@@ -296,6 +298,7 @@ static int pkg_temp_thermal_trips_init(i
 
 		trips[i].type = THERMAL_TRIP_PASSIVE;
 		trips[i].flags |= THERMAL_TRIP_FLAG_RW_TEMP;
+		trips[i].priv = THERMAL_INT_TO_TRIP_PRIV(i);
 
 		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
 			 __func__, cpu, i, trips[i].temperature);
Index: linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
===================================================================
--- linux-pm.orig/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ linux-pm/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -261,17 +261,13 @@ skip:
 	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
 }
 
-static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
+static int qpnp_tm_set_trip_temp(struct thermal_zone_device *tz,
+				 const struct thermal_trip *trip, int temp)
 {
 	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
-	struct thermal_trip trip;
 	int ret;
 
-	ret = __thermal_zone_get_trip(chip->tz_dev, trip_id, &trip);
-	if (ret)
-		return ret;
-
-	if (trip.type != THERMAL_TRIP_CRITICAL)
+	if (trip->type != THERMAL_TRIP_CRITICAL)
 		return 0;
 
 	mutex_lock(&chip->lock);
Index: linux-pm/drivers/thermal/tegra/soctherm.c
===================================================================
--- linux-pm.orig/drivers/thermal/tegra/soctherm.c
+++ linux-pm/drivers/thermal/tegra/soctherm.c
@@ -582,11 +582,11 @@ static int tsensor_group_thermtrip_get(s
 	return temp;
 }
 
-static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
+static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz,
+					const struct thermal_trip *trip, int temp)
 {
 	struct tegra_thermctl_zone *zone = thermal_zone_device_priv(tz);
 	struct tegra_soctherm *ts = zone->ts;
-	struct thermal_trip trip;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
 	int ret;
@@ -594,11 +594,7 @@ static int tegra_thermctl_set_trip_temp(
 	if (!tz)
 		return -EINVAL;
 
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret)
-		return ret;
-
-	if (trip.type == THERMAL_TRIP_CRITICAL) {
+	if (trip->type == THERMAL_TRIP_CRITICAL) {
 		/*
 		 * If thermtrips property is set in DT,
 		 * doesn't need to program critical type trip to HW,
@@ -609,7 +605,7 @@ static int tegra_thermctl_set_trip_temp(
 		else
 			return 0;
 
-	} else if (trip.type == THERMAL_TRIP_HOT) {
+	} else if (trip->type == THERMAL_TRIP_HOT) {
 		int i;
 
 		for (i = 0; i < THROTTLE_SIZE; i++) {
@@ -620,7 +616,7 @@ static int tegra_thermctl_set_trip_temp(
 				continue;
 
 			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip_id))
+			if (thermal_trip_is_bound_to_cdev(tz, trip, cdev))
 				stc = find_throttle_cfg_by_name(ts, cdev->type);
 			else
 				continue;




