Return-Path: <linux-wireless+bounces-8837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD5904D45
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 09:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489E81C22625
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EDA16C6B1;
	Wed, 12 Jun 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BCx1hMRm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9A16B736;
	Wed, 12 Jun 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179100; cv=none; b=kh3Z39NarP3zDnBxbFaW+qUma6wug0cAcNS9m2lCUV18yeiBlmMtNuEiah6f+tPg3UmeCXyChPUCILuWsvXDmVB22OZJU+PDZlaPeAaH0zrCimW81eK+GHCIgBTNfPAY2OvkKV0r/cpHIGeWfpc8g05xZhZTshQEVRfbywtHp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179100; c=relaxed/simple;
	bh=2jKJ20lACwa8Lhy1jPFHX9qJeJNWe+wNDq/R6ZIvLEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m6vVIM0QRMBkz/zsGKjSMI3no4S9mawTMeIudofoobtxzPnaskPqhHSjcH5Yn9IRpdYzwkcsjGPtQciXBCKM/aAhXbx2QxGulSPrdg1dxiv75HjO7LvqT0N29PMweS3epQRIchGMcmkz4yMdA9eXksYBy7BEp4KN9AI0g/9U1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BCx1hMRm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ndOyxQUJxrNxnsAspzStG/x5rg/w1hxjNghGsxB7p88=;
	t=1718179098; x=1719388698; b=BCx1hMRmC4U1XdOuSVJX8a6DM9QWHWmGM0RfTFx97Ig/7WN
	N8n87o7A043LalhVEtQ94bWUV4U0X9NWriFwjD09YlapAutT4UDs15SBl/gMUKh/dznGQZg+ybhJt
	z+AgxFsjeWXotfsVz4m2BV159G9RXBLoEpMYd4hzDzLpOcDN4oCUX0jaKc1s0E7oSo6XFwsYrq/Z0
	g698Tab+zsWii/HHVVN5F0msk3Qk1t9FkPCLk+TwaG9VXU3Eg+L4mP0qIyxFmdVhzxS3RmVnYZC+y
	Uic823OrYt+gFApUaC/gcmuqd5vztWrv+TBvWe9w5EdebProp33X6fTJcIYWi+ag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHIs1-0000000A1tt-1BRh;
	Wed, 12 Jun 2024 09:58:13 +0200
Message-ID: <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Savyasaachi Vanga <savyasaachiv@gmail.com>, 
 Christian Heusel <christian@heusel.eu>
Cc: Kalle Valo <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>
Date: Wed, 12 Jun 2024 09:58:12 +0200
In-Reply-To: <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
References: 
	<chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
	 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
	 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
	 <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-12 at 09:07 +0200, Johannes Berg wrote:
> On Wed, 2024-06-12 at 00:56 +0000, Ping-Ke Shih wrote:
>=20
>=20
> > > Just got pinged (sp?) about this, can you share the driver fix so I c=
an
> > > take a look what the issue is about?
> > >=20
> >=20
> > Please reference patch below. I copy this idea from rtw89 [1], which th=
e main
> > stuff is to add WANT_MONITOR_VIF and case NL80211_IFTYPE_MONITOR in add=
_interface().=20
>=20
> Ah, OK, but that gives me a hint. Yes, I see the issue now.
>=20
> OK it's not trivial and it might leave ath12k still not working (though
> not sure it ever did before? or maybe I'm missing something...), but I
> think I can fix this. Let's see.
>=20

I don't have any of the affected hardware, could someone test this?

https://p.sipsolutions.net/619a4ce4a197b2b4.txt

diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index dce37ba8ebe3..254d745832cb 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -311,6 +311,18 @@ int drv_assign_vif_chanctx(struct ieee80211_local *loc=
al,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
=20
+	/*
+	 * We should perhaps push emulate chanctx down and only
+	 * make it call ->config() when the chanctx is actually
+	 * assigned here (and unassigned below), but that's yet
+	 * another change to all drivers to add assign/unassign
+	 * emulation callbacks. Maybe later.
+	 */
+	if (sdata->vif.type =3D=3D NL80211_IFTYPE_MONITOR &&
+	    local->emulate_chanctx &&
+	    !ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		return 0;
+
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
=20
@@ -338,6 +350,11 @@ void drv_unassign_vif_chanctx(struct ieee80211_local *=
local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
=20
+	if (sdata->vif.type =3D=3D NL80211_IFTYPE_MONITOR &&
+	    local->emulate_chanctx &&
+	    !ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		return;
+
 	if (!check_sdata_in_driver(sdata))
 		return;
=20
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dc42902e2693..4a49e834a9f5 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1121,9 +1121,6 @@ int ieee80211_add_virtual_monitor(struct ieee80211_lo=
cal *local)
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
=20
-	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-		return 0;
-
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
=20
@@ -1145,11 +1142,13 @@ int ieee80211_add_virtual_monitor(struct ieee80211_=
local *local)
=20
 	ieee80211_set_default_queues(sdata);
=20
-	ret =3D drv_add_interface(local, sdata);
-	if (WARN_ON(ret)) {
-		/* ok .. stupid driver, it asked for this! */
-		kfree(sdata);
-		return ret;
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
+		ret =3D drv_add_interface(local, sdata);
+		if (WARN_ON(ret)) {
+			/* ok .. stupid driver, it asked for this! */
+			kfree(sdata);
+			return ret;
+		}
 	}
=20
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
@@ -1187,9 +1186,6 @@ void ieee80211_del_virtual_monitor(struct ieee80211_l=
ocal *local)
 {
 	struct ieee80211_sub_if_data *sdata;
=20
-	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
-		return;
-
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
=20
@@ -1209,7 +1205,8 @@ void ieee80211_del_virtual_monitor(struct ieee80211_l=
ocal *local)
=20
 	ieee80211_link_release_channel(&sdata->deflink);
=20
-	drv_remove_interface(local, sdata);
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+		drv_remove_interface(local, sdata);
=20
 	kfree(sdata);
 }
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 283bfc99417e..963ed75deb76 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1843,7 +1843,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
=20
 	/* add interfaces */
 	sdata =3D wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
-	if (sdata) {
+	if (sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
 		/* in HW restart it exists already */
 		WARN_ON(local->resuming);
 		res =3D drv_add_interface(local, sdata);


