Return-Path: <linux-wireless+bounces-25854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C794B0D912
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171EF1886AFC
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55FC2E8DFD;
	Tue, 22 Jul 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="brA4XKm2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C32D9ED2
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186316; cv=none; b=cvHS2ekuevf7g5+G/FcaQDsWwu5jb6y0VRgc4zGv50g+TkDW+4t78wwYeWNfW1oTNtfnirPMYpFq617K/tBROWhqIZVKlcIuwd4BoiLcJBoOi3X5GbDAav6eUpRkZ35Hx0Z/z424CU6svXL4fxHVMo8/K1q7WtgMxoGHmJpAmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186316; c=relaxed/simple;
	bh=sPJhyiMDCYHzU42Rzms7Jbmj9fp9gBeIyc+k/JELhT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNwDhoqGlqJAQijG2KAuCFkG4/FR5VWaZpifPj+7+QbMCzIr2LVgDaG83SgfXkRDw0uLCoQUkWz2V2rhcZYCN/kgp5B2Q5oc/Zb8a0YWpCmcUBCcgHldKG9cActDCE9oZVO5Irg1ZeNXRDJA8YbG76y+OtrMZPuy6eWXgo7GN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=brA4XKm2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PNb7sFScsOX0+p8s6m3ME6DeKN8pEswiBDSVmkFlhMo=;
	t=1753186315; x=1754395915; b=brA4XKm2Sze93k83KnWhisv0aymy6S/155ZRaQJmzg3SBag
	ijKwlu/DRLI/LYt+14QcldWe7RZbBdOoYyv3IapkBIItCTsB4/55WzmDG8PLU0xDYevqcH5lj3mdt
	L596JqL7LTnWs80NEoB6CIPpCHC5EPuWO2/0dJy40ajfSopitHlJviyYEQhNtZ4Wvh5oBy6omB3fL
	vcekBuh+ZJsNHngB7hO0TdYwwmF3Wi+hOYN39ZQiWMRR0rR7Kwf2asMPxicXTj9vzZyctNfedMOOJ
	C0oiuYHDG4qZH0QkQmJKa+9IwygzPXeeg+UolyYvyNMgP+Nx27dgLAGVFjWlaCqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueBqY-000000025cR-3FhO;
	Tue, 22 Jul 2025 14:11:51 +0200
Message-ID: <f06f3b3e40e104cb9fcdb086d8f9fff146225330.camel@sipsolutions.net>
Subject: Re: WARNING check-sdata-in-driver in
 ieee80211_link_info_change_notify
From: Johannes Berg <johannes@sipsolutions.net>
To: Martin Kaistra <martin.kaistra@linutronix.de>, 
	linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Tue, 22 Jul 2025 14:11:50 +0200
In-Reply-To: <a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de> (sfid-20250710_094728_882114_D77AE70A)
References: <a9de62a0-28f1-4981-84df-253489da74ed@linutronix.de>
	 (sfid-20250710_094728_882114_D77AE70A)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-07-10 at 09:47 +0200, Martin Kaistra wrote:
> Hi,
>=20
> when trying to use monitor mode with either rtl8xxxu or rtlwifi driver I =
get a=20
> "Failed check-sdata-in-driver check" warning in=20
> ieee80211_link_info_change_notify(). Aside from the warning, monitor mode=
 seems=20
> to work fine. This might also affect other drivers, I just don't have the=
=20
> hardware to test.
>=20
> I bisected and found that the warning started with c4382d5ca1af ("wifi:=
=20
> mac80211: update the right link for tx power").
>=20
> I can make the warning go away when I add WANT_MONITOR_VIF to the driver,=
 but=20
> the real fix should probably go in mac80211.

Strange, I'm not sure I see the relation with the commit you mention.

Either way though, given NO_VIRTUAL_MONITOR and WANT_MONITOR_VIF we
probably have to catch it in the code, perhaps like the below? But I'm
not sure it handles NO_VIRTUAL_MONITOR correctly? Hm.

johannes


diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 351564360c26..bf338024b5d5 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -408,9 +408,20 @@ void ieee80211_link_info_change_notify(struct ieee8021=
1_sub_if_data *sdata,
=20
 	WARN_ON_ONCE(changed & BSS_CHANGED_VIF_CFG_FLAGS);
=20
-	if (!changed || sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN)
+	if (!changed)
 		return;
=20
+	switch (sdata->vif.type)
+	case NL80211_IFTYPE_AP_VLAN:
+		return;
+	case NL80211_IFTYPE_MONITOR:
+		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+			return;
+		break;
+	default:
+		break;
+	}
+
 	if (!check_sdata_in_driver(sdata))
 		return;
=20

