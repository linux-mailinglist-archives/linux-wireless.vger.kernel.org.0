Return-Path: <linux-wireless+bounces-24345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA34AE3B41
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99FD7A266C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8AA2192E1;
	Mon, 23 Jun 2025 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JYoydXgp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA61A3168;
	Mon, 23 Jun 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672535; cv=none; b=L5cZAcgD4DGyIv9eEy6N3jksgqpHp9E7Y5AQctoYEWIQ9vAFIyjd6Yqrn7h3jZyer1EKMXIxcRK79de2QkaaPluAZpmpbPZRUqn+0d/hfiPfPr9dQbPaOGNRobdPXwS3dcrHfrXpjSAGU+VGl6/jZxq5OeA3LB8evuUc828mKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672535; c=relaxed/simple;
	bh=OEDsOsbmBWlSCJexaT7tuU8s+GVAmb4vdTnegemyQIY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L53ywB98k5yLEjB1ixygG87CEd1/T/+4pl+3kykzZTU4rygsmXhARHh4wlsluLLLajm5v4Nxc3JrwpJm5OBvcb/s8fIW5BOeGquLShLrOp2n8+XmrulW5vYxvp0rJtuqByF1KJf4tQUTqr9RHXZoXblyamSWlRcwZ8siFG9mJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JYoydXgp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5JC8N6waXzbkMsJ2s1DGUOkVB2uBD2HJQeuuu3PQE4w=;
	t=1750672533; x=1751882133; b=JYoydXgpIAbbe3Urr4micMGUJODHvF12x3woeOVX50wbiWd
	QCy5s8MG4+3lhjhsro8gG6KC/N2WNSDlCEGOIJV3tc/i8gi0AeEqjyC2E8XoBLaDn/Yyql3ele1SW
	uKLJV46XXZLtChNAX1u45iAeSmjQ1v2RJPVJrQtX+9tC2C+zvJPK52TRXtFizkzypc3FB7QxY48TJ
	F9KT4v88xICoH2SSrc0jEbMyWWoEdjQ6i6Jv1/vZkVQQkUS7BUpLetaqDCSRr1yHotfb7Ff/yknDz
	3yNZn3s5pnfHQCxryynqYGgPUagyii7q2935IWheusQp2+Z/Cqg95tbvjEyfhghA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uTdtX-00000007blh-3eQd;
	Mon, 23 Jun 2025 11:55:20 +0200
Message-ID: <3a9f8d73ecd8fc1f6994b58d69014aa064d6cd60.camel@sipsolutions.net>
Subject: Re: 6.16-rc2+ lockdep circular locking between iwlwifi and
 thermal_zone code
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Hans de Goede <hansg@kernel.org>, Miri Korenblit	
 <miriam.rachel.korenblit@intel.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,  Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, Linux PM
	 <linux-pm@vger.kernel.org>
Date: Mon, 23 Jun 2025 11:55:17 +0200
In-Reply-To: <e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org>
References: <e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Hans,


On Fri, 2025-06-20 at 17:56 +0200, Hans de Goede wrote:
> While testing 6.16-rc2+ on a Dell XPS 9640 I got the following lockdep re=
port:
>=20
> (Note this was a build without debuginfo, so I did not run decode_stacktr=
ace.sh)
>=20
> [=C2=A0=C2=A0 19.690210] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0=C2=A0 19.690212] WARNING: possible circular locking dependency de=
tected
> [=C2=A0=C2=A0 19.690214] 6.16.0-rc2+ #3 Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> [=C2=A0=C2=A0 19.690217] ------------------------------------------------=
------
> [=C2=A0=C2=A0 19.690218] modprobe/906 is trying to acquire lock:
> [=C2=A0=C2=A0 19.690220] ffff89da8e948768 (&rdev->wiphy.mtx){+.+.}-{4:4},=
 at: iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
> [=C2=A0=C2=A0 19.690269]=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 but task is already holding lock:
> [=C2=A0=C2=A0 19.690270] ffff89da41ac2708 (&tz->lock){+.+.}-{4:4}, at: th=
ermal_zone_device_set_mode+0x20/0xa0
> [=C2=A0=C2=A0 19.690284]=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 which lock already depends on the new lock.
> [SNIP]

I am thinking that this is a false-positive and the

    lock(cpuhp_state-up);
    lock(&tz->lock);

chain is happening on a different type of thermal device. A solution
might be to create a separate lock class for every thermal_zone_device.
Something like the below, I suspect.

Benjamin

diff --git a/drivers/thermal/thermal_core.c
b/drivers/thermal/thermal_core.c
index 17ca5c082643..fcb060898733 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1556,6 +1556,7 @@ thermal_zone_device_register_with_trips(const
char *type,
 	INIT_LIST_HEAD(&tz->trips_invalid);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
+	lockdep_set_class(&tz->lock, &tz->lock_class);
 	init_completion(&tz->removal);
 	init_completion(&tz->resume);
 	id =3D ida_alloc(&thermal_tz_ida, GFP_KERNEL);
diff --git a/drivers/thermal/thermal_core.h
b/drivers/thermal/thermal_core.h
index bdadd141aa24..9ad5c37620f3 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -141,6 +141,7 @@ struct thermal_zone_device {
 	void *governor_data;
 	struct ida ida;
 	struct mutex lock;
+	struct lock_class_key lock_class;
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;


