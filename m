Return-Path: <linux-wireless+bounces-18116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725DFA2183B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3507164A90
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A2198A19;
	Wed, 29 Jan 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AuA/L93N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA619580F
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136152; cv=none; b=Np9wpaL2y7MPUoPdWDFy5oIZmAZsrkJ491cNVTI59AamKHwG5KklKFuDaWzipO+PL+coSNbW3xQEmGFbglBEgC+qfIxEJcE3XzWxb4WcP9DiMO9USTMTuhyTwn1ic8hCsc8ruv5PXP+IAyvlPvy5fU/QczhLm2ljszSuRx3KvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136152; c=relaxed/simple;
	bh=Ltf4GBwdfYVmHMpW1qQW52gsWf8m9TxvwQ44BJdIxFo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=af75KjOwcdMAwPfgwOw+rH5NE7ztZBjp6TNuP1lpwxKPJfTRjhMUYQ8np95+j5WX3k49A6aTARVPdnfT/jZechlTgM+gZlyBSCVHVBLhPo6T0uzBkW1nIZEG+qojuXbWeT7mhuzj4G2fJxpOOITgYH7dOfeAd0yZXHkbE+wTaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AuA/L93N; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oh8jkP5efpTa0k+MG4pTPShpTuzUF489bcllsKk6Yic=;
	t=1738136150; x=1739345750; b=AuA/L93NTzuZdEkY+27CDmDCn5IzE7rYh77krACoiW1mvBD
	d0fXIpQJWRYcL5PUK2n9pNXZGhVxkYwtaLy3n4oEuDvYZWLbgdftsRgS+SxCZnGCfYdUI36zjIaCb
	/0FLn5bpDCIK/Yd7THzw3Kz4/rgAQZekrgubmuUucO8LI08CeMiwtWYrfpyp9i1lDsAZiBECHW17v
	QC0Hte9Ev4yvJkdqOf9iWjszEpcrz1e8ph4JWNRBboRDSlh0dbpiwus4fFbL2fCQsLWbEc9h06Tmf
	Yj5YvCH91/aiElEm1n8M5fTEzkM0Nj0umK36npOxcjF2lSYpVkvHHseHndEVcTpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td2bw-0000000Dq2T-32NT;
	Wed, 29 Jan 2025 08:35:45 +0100
Message-ID: <a49e58998553c45953a30243ad1957c06ce6db8c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 01/13] wifi: mac80211: Fix virtual monitor interface
 creation
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 29 Jan 2025 08:35:43 +0100
In-Reply-To: <20250127162625.20747-2-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <20250127162625.20747-2-Alexander@wetzel-home.de>
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

On Mon, 2025-01-27 at 17:26 +0100, Alexander Wetzel wrote:
> Virtual monitor interfaces should only be created when all of the
> following conditions are fulfilled:
>  - All remaining enabled interfaces are monitor interface(s),
>  - %IEEE80211_HW_NO_VIRTUAL_MONITOR isn't set by the driver and
>  - %MONITOR_FLAG_ACTIVE and %MONITOR_FLAG_COOK_FRAMES isn't set on any
>    of the enabled (monitor) interfaces.
>=20
> ieee80211_add_virtual_monitor() will then setup the virtual monitor
> interface for local->monitor_sdata and - when
> %IEEE80211_HW_WANT_MONITOR_VIF is set - inform the driver about the
> virtual monitor interface.
>=20
> But assuming %IEEE80211_HW_NO_VIRTUAL_MONITOR is not set, the current
> code still creates a virtual monitor interface when:
>=20
>  1) We have one non-monitor and one monitor interface with
>     %MONITOR_FLAG_ACTIVE enabled and then delete the non-monitor
>     interface.

That sounds like a bug, indeed. We shouldn't count monitors with ACTIVE
in local->monitors at all, I think.

>  2) We only have monitor interfaces enabled on resume while at least one
>     has %MONITOR_FLAG_ACTIVE set.

Which would also address this, I'd guess?

> Fix the logic to follow the above stated rules and fixed/updated related
> checks not following the logic.
>=20
> Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
> ---
> I have problems understanding the current logic of how monitor
> interfaces are handled. For me it looks like we use local->monitors
> sometimes to count all monitor interfaces - except the ones using
> %MONITOR_FLAG_COOK_FRAMES - and at other times to count interfaces
> linked to the virtual monitor interface.
>=20
> This patch tries to fix the logic according to my understanding.
>=20
> Noteworthy here is the wording in 0d9c2beed116 ("wifi: mac80211:
> fix monitor channel with chanctx emulation"):
>      ...
>      Fix this by always allocating the virtual monitor sdata, and
>      simply not telling the driver about it unless it wanted to.
>      This way, we have an interface/sdata to bind the chanctx to,
>      and the emulation can work correctly.
>=20
> But the commit with this statement is not changing the condition to call
> ieee80211_add_virtual_monitor(), contradicting these sentences.
>=20
> From ieee80211_do_open():
>         case NL80211_IFTYPE_MONITOR:
>                 if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
>                         local->cooked_mntrs++;
>                         break;
>                 }
>=20
>                 if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
>                         res =3D drv_add_interface(local, sdata);
>                         if (res)
>                                 goto err_stop;
>                 } else if (local->monitors =3D=3D 0 && local->open_count =
=3D=3D 0) {
>                         res =3D ieee80211_add_virtual_monitor(local);


The "always" there perhaps should've said "whenever we have monitor
active", obviously we don't want a virtual monitor when there's no
monitor at all.

The "cooked" is completely different, and not really a monitor, it's
indeed used for ancient versions of hostapd that don't know nl80211 yet
and need to receive all frames not otherwise handled by the kernel via
monitor.

We can probably justify removing that, it was only used by hostapd
versions between April 2009 and December 2011, from
0915d02c3c08 ("wpa_supplicant AP: Add management frame RX for nl80211")
to
a11241fa1149 ("nl80211: Use nl80211 for mgmt TX/RX in AP mode")


The "active" monitor is something we still want, and indeed it doesn't
work for iwlwifi (which simply doesn't support it), but that should
indeed always be added to the driver - drivers that support it need the
vif so they have the MAC address to send ACKs for (to program it into
the device.)

> +++ b/net/mac80211/cfg.c
> @@ -4366,10 +4366,11 @@ static int ieee80211_cfg_get_channel(struct wiphy=
 *wiphy,
>  	if (chanctx_conf) {
>  		*chandef =3D link->conf->chanreq.oper;
>  		ret =3D 0;
> -	} else if (!ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
> -		   local->open_count > 0 &&
> -		   local->open_count =3D=3D local->monitors &&
> -		   sdata->vif.type =3D=3D NL80211_IFTYPE_MONITOR) {
> +	} else if (local->virt_monitors &&
> +		   local->open_count =3D=3D local->virt_monitors &&
> +		   sdata->vif.type =3D=3D NL80211_IFTYPE_MONITOR &&
> +		   !(sdata->u.mntr.flags & (MONITOR_FLAG_ACTIVE |
> +					    MONITOR_FLAG_COOK_FRAMES))) {
>  		*chandef =3D local->monitor_chanreq.oper;
>  		ret =3D 0;

Not sure this is really all that relevant - if you have (only) active
monitors then it should still be correct, and having only cooked
monitors is pointless, not even sure it's supported at all. So I'm not
sure I see a need to change this?

Overall this seems needlessly complex.

I'd go for two changes:
 * remove cooked monitor support entirely, unused since Dec 2011.
 * not count active monitors in local->monitors, which should address
   the other issues?

johannes

