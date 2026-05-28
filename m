Return-Path: <linux-wireless+bounces-37059-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJD0D4giGGocdggAu9opvQ
	(envelope-from <linux-wireless+bounces-37059-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 13:10:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 474985F111C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E3163026A66
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C73B0AF8;
	Thu, 28 May 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="twKGV4K0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAEA23909F
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966456; cv=none; b=RNlQZnf+qL2CkGTas8Hg8SE4Kk/94yrYPBWggxTRiVVJcnyz+cWRAEfUBb2ynEQNcrADOca6B+YJoKtTKqCLMI6o5XZp3JushdT/YcLwEjTqbk52tYxCh1g/fkL2awQDB2eKdDK3qznV++eR8oVMsQOPIAeVGPslrn5UoSaio5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966456; c=relaxed/simple;
	bh=3PYigtpme7FogDOEy4i/MjudQ1bZreeZC0EvEVYHXkg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I3dXHLSe6H17Sszi9ao3+g2z59PMqLp0Dcv4fCRaBrJg0sLnERhnY9ISI5pVYj56ymOSe5W2mrK159zz5vPRkNP4Yg2Mo0/hfzDzfZu/jh7E8WWPhZvORYEqlAI88pRi9Eyt3qyVXfvJZaoLSrUUdIrCop/+3iNoCYnLt6XkYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=twKGV4K0; arc=none smtp.client-ip=109.224.244.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1779966446; x=1780225646;
	bh=U0iwg2QlaKOm56qrJPRNqzU55rEEuc+8+OmxMHTxVtY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=twKGV4K0FpQbs4lyq4DEgL9yTo8sVfzqcFIeU/UhKjLTxph5JBtVQY4Tvfck4h0co
	 QO7+XKwieF3m1vgNyGaODEk8CPt/vjRoOUMAsKRl2o+tgK48GCaaIw5pVXrwAQvP8h
	 TDK9Oor7wTNKs8kFDVP6tA/Lz0ltBAK70GBOHtwNOpc4RUjc6Lvl66NfstWx3i+FHd
	 aviTwPzseD1o/CrdIFWN/1sKFEk9s8Iq52ZQ8XAALHZcSIyvNWXhDeVoeT3F8oaRiB
	 n7KAo2QjG5MS7KTGH2//HHrXTmUvWi9/gDOyh8AIlcLwjro5IPxVZ2jnQ5Eca5Ki3V
	 sLW9smwrpBp6g==
Date: Thu, 28 May 2026 11:07:20 +0000
To: linux-wireless@vger.kernel.org
From: Ryan Leung <untilscour@protonmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Ryan Leung <untilscour@protonmail.com>
Subject: [PATCH] wifi: mt76: mt7915: add thermal zone device registration
Message-ID: <20260528110655.4688-1-untilscour@protonmail.com>
Feedback-ID: 184418679:user:proton
X-Pm-Message-ID: 6fe615c4eec4c9240a87f08f15cc8452ab613b68
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37059-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,protonmail.com:email,protonmail.com:mid,protonmail.com:dkim]
X-Rspamd-Queue-Id: 474985F111C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Register the mt7915 phy as a thermal zone sensor using
devm_thermal_of_zone_register() so that device tree thermal-zones
nodes can reference the Wi-Fi chip as a temperature source. This
allows the kernel thermal governor to control external cooling
devices such as PWM fans based on Wi-Fi chip temperature.

Registration is non-fatal: -ENODEV is returned when no
thermal-sensors DT property references this device, which is the
expected case on platforms without a thermal zone configured.

Signed-off-by: Ryan Leung <untilscour@protonmail.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 29 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net=
/wireless/mediatek/mt76/mt7915/init.c
index 250c2d2479b0..817a9045e326 100644
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
@@ -213,6 +232,16 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 =09phy->throttle_temp[MT7915_CRIT_TEMP_IDX] =3D MT7915_CRIT_TEMP;
 =09phy->throttle_temp[MT7915_MAX_TEMP_IDX] =3D MT7915_MAX_TEMP;
=20
+=09phy->tzone =3D devm_thermal_of_zone_register(phy->dev->mt76.dev, 0, phy=
,
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



