Return-Path: <linux-wireless+bounces-37168-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMAxJ0pWGmrv3QgAu9opvQ
	(envelope-from <linux-wireless+bounces-37168-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 05:15:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1D60B145
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D003301ADB2
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29D3446AD;
	Sat, 30 May 2026 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="j9c5D3qJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF363375CB
	for <linux-wireless@vger.kernel.org>; Sat, 30 May 2026 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110832; cv=none; b=GycsWWFf0d8tupvDW9Qv4Der1lBJrQfHWvUV893yp1RCZI/IbtCtAX0YzPRCOQW1W9BgqWAxDdUVUezvG0dtrxqAsI+1CLwmlJvckLHImMC+/XKaIq69/0qZrQT7+8aa64f5d2Y+m/gVaAWp0ENnXTPQaZFFAZAbMkEL16GOer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110832; c=relaxed/simple;
	bh=bYjW3s2GUWfT3qevp5IWdpb3pACIujBNhOruYwM6WLI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TaeBby86jJrhyUar3TkrYam86oj3taN+k13woXWOhyHPXH+1jz6vJKcu0Y2PnDCr5qJiUQzTtNqaIfcP1n4HnvQEf30Kfs2jhyM78bCQ3wR00HQwRioX9HuN3ymepr7KewYwjtOX5cAt7CbzhLT4WWJpMKhj9kFodNZUjxwn7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=j9c5D3qJ; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1780110822; x=1780370022;
	bh=F89fWfbZjVKFWKywIkJDah91A+9YpViV6ygaQd7omHY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=j9c5D3qJl679+aIBV/HbVVCd3DdCI2LqIE1crCTpU7GwqZiozf8obwa4wdmbNzplB
	 SMdZozWTMNKF5+0tfCx7zZFOjTEt9dsnKc+VbTo5TszwSDpKy9gPGLyq/GY49YOXjJ
	 e98l2n5Eqdss+txm+6mVAK7ARA5KuSX/+jTyUp+BdoxG+WBH/GnKW9Wh6r8wFYWqHX
	 a3gAVVbQxyQAB9U8wA3jRtCuQirrmVrYa6tk4v6kZpJqXzNZcVjycaj1qQ94dSRAXd
	 JjP+ZtJV1GVw7BzsMko9aZUSqiVLYfEJdEukRrPxrUG4r4/EeyDKABID11s2HP7J/b
	 E2KgDMZyqWv9g==
Date: Sat, 30 May 2026 03:13:38 +0000
To: linux-wireless@vger.kernel.org
From: Ryan Leung <untilscour@protonmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Ryan Leung <untilscour@protonmail.com>
Subject: [PATCH v2] wifi: mt76: mt7915: add thermal zone device registration
Message-ID: <20260530031239.3820-1-untilscour@protonmail.com>
Feedback-ID: 184418679:user:proton
X-Pm-Message-ID: 6f3f7792181067a36a8ff6ac6895ba21ea5fd026
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37168-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,protonmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[protonmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[untilscour@protonmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,protonmail.com:email,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 94A1D60B145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register the mt7915 phy as a thermal zone sensor using
devm_thermal_of_zone_register() so that device tree thermal-zones
nodes can reference the WiFi chip as a temperature source. This
allows the kernel thermal governor to control external cooling
devices such as PWM fans based on WiFi chip temperature.

Registration is non-fatal: -ENODEV is returned when no
thermal-sensors DT property references this device, which is the
expected case on platforms without a thermal zone configured.

Signed-off-by: Ryan Leung <untilscour@protonmail.com>
---

v2:
- Use phy->mt76->band_idx instead of hardcoded 0 as sensor ID

---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 30 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net=
/wireless/mediatek/mt76/mt7915/init.c
index 250c2d2479b0..6568d7b6bc0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -177,6 +177,25 @@ static const struct thermal_cooling_device_ops mt7915_=
thermal_ops =3D {
 =09.set_cur_state =3D mt7915_thermal_set_cur_throttle_state,
 };
=20
+static int mt7915_thermal_get_temp(struct thermal_zone_device *tz, int *te=
mp)
+{
+=09struct mt7915_phy *phy =3D thermal_zone_device_priv(tz);
+=09int val;
+
+=09mutex_lock(&phy->dev->mt76.mutex);
+=09val =3D mt7915_mcu_get_temperature(phy);
+=09mutex_unlock(&phy->dev->mt76.mutex);
+=09if (val < 0)
+=09=09return val;
+
+=09*temp =3D val * 1000;
+=09return 0;
+}
+
+static const struct thermal_zone_device_ops mt7915_tz_ops =3D {
+=09.get_temp =3D mt7915_thermal_get_temp,
+};
+
 static void mt7915_unregister_thermal(struct mt7915_phy *phy)
 {
 =09struct wiphy *wiphy =3D phy->mt76->hw->wiphy;
@@ -213,6 +232,17 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 =09phy->throttle_temp[MT7915_CRIT_TEMP_IDX] =3D MT7915_CRIT_TEMP;
 =09phy->throttle_temp[MT7915_MAX_TEMP_IDX] =3D MT7915_MAX_TEMP;
=20
+=09phy->tzone =3D devm_thermal_of_zone_register(phy->dev->mt76.dev,
+=09=09=09=09=09=09   phy->mt76->band_idx, phy,
+=09=09=09=09=09=09   &mt7915_tz_ops);
+=09if (IS_ERR(phy->tzone)) {
+=09=09if (PTR_ERR(phy->tzone) !=3D -ENODEV)
+=09=09=09dev_warn(phy->dev->mt76.dev,
+=09=09=09=09 "failed to register thermal zone: %ld\n",
+=09=09=09=09 PTR_ERR(phy->tzone));
+=09=09phy->tzone =3D NULL;
+=09}
+
 =09if (!IS_REACHABLE(CONFIG_HWMON))
 =09=09return 0;
=20
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mt7915.h
index bf1d915a3ca2..92e0f9f0169c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -205,6 +205,7 @@ struct mt7915_phy {
=20
 =09struct ieee80211_vif *monitor_vif;
=20
+=09struct thermal_zone_device *tzone;
 =09struct thermal_cooling_device *cdev;
 =09u8 cdev_state;
 =09u8 throttle_state;
--=20
2.43.0



