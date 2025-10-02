Return-Path: <linux-wireless+bounces-27779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB4BB3800
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC49F170CBC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FE3009C3;
	Thu,  2 Oct 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sdj4DGeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673012CD8B
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759398034; cv=none; b=U6wYWv/6VNBi5efMOKIv1H6VuqAql4PwZkfpPlGdXYpElB+SUIdAvOaVAzIOcl6J2fBLf7y+VeAUnALLgKjbLnUyUt29f+/z3yYkn9wgoukb3d6yz5H0bkLu/CYnImV2iuJ2ojGaPZVPI982Rpq3cKvgblPVV5XOz2S/hEcfTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759398034; c=relaxed/simple;
	bh=VqTy0Aa3Ai3F6RMq3mCa/Yk8Bx4rJbv/vquXPwgc7YY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/N8ZtK2BaLNDkFOqz/1LGCNubQqgqCCVgZOLgEsSzoIGWTLxMElsrwaakgOmcYpQ8jGUI5PpKgzyc2DbZnGonAp47jAcJ8wY4uo8RuIFaU6rEpxCTtY5j8SV/xazfRA3e2ldcDK/WVx/BHLO0g40ryn+ziPIvdGzver/RmRCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sdj4DGeh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VqTy0Aa3Ai3F6RMq3mCa/Yk8Bx4rJbv/vquXPwgc7YY=;
	t=1759398032; x=1760607632; b=sdj4DGehtnJ4Yfaf/jqyEdNeIALAykiS5lFnBxk+wfGR1i4
	2KzSHGLytGC6C0xeXWwfIKmL7i4PRwfwIUXb9y2/iLiedO/GJ2WEcUY/Rqs6lJAuVeM0mQmiKVMIq
	hbQ/nGous5KtvM9+ljVJOWqO04FAAEI9fPbuC+w/lc9Twr0GpLwuat9CRYljREeH3GxnypS43LyAM
	lpArfdfQ4ed+WaGFpN9YxQkPs9L5GUcYMgs/7JrA0SedCd6xHp5DrR23Myu2xtY+dAyleLWSXOJnY
	x5xfjvLOh/SN6c3/AdY1K759dI2dskmV8pSWzFJG1nfKsLSLv3fQKf5yyky6XyiA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v4Fna-00000007QnA-13CG;
	Thu, 02 Oct 2025 11:40:30 +0200
Message-ID: <be05e3f830c26c414742418c5dfb45d13e06e672.camel@sipsolutions.net>
Subject: Re: [Bug Report] Intel AX1775 / AX1790 / BE20 / BE401 / BE1750 2x2
 (Wi-Fi 7) fails to resume after suspend (s2idle)
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Bergesio <francescobergesio1@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 02 Oct 2025 11:40:29 +0200
In-Reply-To: <CAFXXzTYQt=LaUW_EdSPWEv7uQ+CTSXB8jY6GoEMcoVWUF55kTg@mail.gmail.com> (sfid-20251002_112259_429078_FA07ED34)
References: 
	<CAFXXzTbHabF2hZKWM=RquQXB_tFq-24SPifnyL9ZA5-HL30X1A@mail.gmail.com>
	 <76fa4cd8d3598c771f5e1c8bb305c241907edc77.camel@sipsolutions.net>
	 <CAFXXzTZD3Wfywo2Mug8=3TrV2b0hsFSMERyd8YpzUgnBzP4uDA@mail.gmail.com>
	 <64ac5b780b412f9a663e86d2745e580a7db6b8e3.camel@sipsolutions.net>
	 <CAFXXzTYQxq9cAob__q2G+AT0PNYp72=cPTR+gRAF2ouAZguzrQ@mail.gmail.com>
	 <07c9465b6c80253975a7a4a70454fa5e6a536ad1.camel@sipsolutions.net>
	 <CAFXXzTYQt=LaUW_EdSPWEv7uQ+CTSXB8jY6GoEMcoVWUF55kTg@mail.gmail.com>
	 (sfid-20251002_112259_429078_FA07ED34)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-10-02 at 11:22 +0200, Francesco Bergesio wrote:
> I hope this is what you need
> I got this with journalctl -u wpa_supplicant.service, the service
> running is "/sbin/wpa_supplicant -u -O /run/wpa_supplicant -ddd -t",
> first line is before the suspend.

Maybe? I don't really see anything, but it is what I said I wanted ;-)

(Though I actually thought also about the initial start of wpa_s, but I
don't see now it would've told me anything...)

> ott 02 11:13:46 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396426.964468: RTM_NEWLINK: ifi_index=3D5 ifname=3Ddocker0 operstate=
=3D2
> linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1003 ([UP])

This is probably well before suspend, yeah.

> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.723771: RTM_NEWLINK: ifi_index=3D2 ifname=3Denp45s0 operstate=
=3D2
> linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1002 ()

This is during suspend - in fact most of the stuff here seems to be for
suspend.

> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.724961: dbus: org.freedesktop.DBus.Properties.Set
> (/fi/w1/wpa_supplicant1) [ssv]
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.724971: properties_get_or_set: Set(WFDIEs)
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.724975: WFD: Wi-Fi Display disabled
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.724976: WFD: Update WFD IE
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.724977: WFD: Wi-Fi Display disabled - do not include WFD IE
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.751518: dbus: fi.w1.wpa_supplicant1.Interface.Disconnect
> (/fi/w1/wpa_supplicant1/Interfaces/0) []
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.751530: wlp44s0f0: Cancelling scan request
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.751536: wlp44s0f0: No ongoing scan/p2p-scan found to abort
> ott 02 11:16:28 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396588.751541: wlp44s0f0: Request to deauthenticate -
> bssid=3D84:d8:1b:70:59:82 pending_bssid=3D00:00:00:00:00:00 reason=3D3
> (DEAUTH_LEAVING) state=3DCOMPLETED

This is tearing down all the state etc.

> ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396589.856970: RTM_DELLINK: ifi_index=3D3 ifname=3Dwlp44s0f0
> operstate=3D2 linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1002 ()
> ott 02 11:16:29 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396589.856984: RTM_DELLINK: Interface 'wlp44s0f0' removed

and here it completed removing all the stuff from wpa_s

> ott 02 11:16:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396596.792185: RTM_NEWLINK: ifi_index=3D6 ifname=3Dwlan0 operstate=3D=
2
> linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1002 ()

This seems to be after resume (there's a 7 second gap) I guess? So
'wlan0' appears.

> ott 02 11:16:36 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396596.793314: RTM_NEWLINK: ifi_index=3D6 ifname=3Dwlp44s0f0
> operstate=3D2 linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1002 ()

guess it got renamed

> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.427735: RTM_NEWLINK: ifi_index=3D2 ifname=3Denp45s0 operstate=
=3D2
> linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1003 ([UP])
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.847401: RTM_NEWLINK: ifi_index=3D6 ifname=3Dwlp44s0f0
> operstate=3D0 linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1043 ([UP][RUNNIN=
G])

now it's up? does NM does that?

> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.847567: RTM_NEWLINK: ifi_index=3D6 ifname=3Dwlp44s0f0
> operstate=3D2 linkmode=3D0 ifi_family=3D0 ifi_flags=3D0x1003 ([UP])
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849949: dbus: fi.w1.wpa_supplicant1.CreateInterface
> (/fi/w1/wpa_supplicant1) [a{sv}]
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849956: wpa_dbus_dict_open_read: start reading a dict entry
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849959: wpa_dbus_dict_get_entry: dict entry key: Driver
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849960: wpa_dbus_dict_get_entry: dict entry variant content
> type: s
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849961: _wpa_dbus_dict_fill_value_from_variant: string
> value: [omitted]
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849964: wpa_dbus_dict_get_entry: dict entry key: Ifname
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849965: wpa_dbus_dict_get_entry: dict entry variant content
> type: s
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849966: _wpa_dbus_dict_fill_value_from_variant: string
> value: [omitted]
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849973: Override interface parameter: ctrl_interface
> ('(null)' -> '/run/wpa_supplicant')
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.849975: Initializing interface 'wlp44s0f0' conf 'N/A'
> driver 'nl80211,wext' ctrl_interface '/run/wpa_supplicant' bridge
> 'N/A'

here it's being added via dbus

> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.850020: nl80211: deinit ifname=3Dwlp44s0f0
> disabled_11b_rates=3D0
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.850021: nl80211: Remove monitor interface: refcount=3D0
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.850022: netlink: Operstate: ifindex=3D6 linkmode=3D0
> (kernel-control), operstate=3D6 (IF_OPER_UP)
> ott 02 11:16:37 linux-Stealth-16-AI-Studio-A1VGG wpa_supplicant[1414]:
> 1759396597.850034: wlp44s0f0: Failed to initialize driver interface -
> try next driver wrapper

but it failed for no discernible reason? and, well, tries 'wext' next
which as we know is going to fail...

Looking at the code, your version might predate the "nl80211: Initialize
interface %s (driver: %s)" message, but we also don't see "nl80211:
interface %s in phy %s" so that narrows down the failure a bit ... Also
not "nl80211: TDLS supported" which should be printed from what we see
in the other log, so ... that doesn't leave a lot of room for what
fails?

Unfortunately I don't really know. Maybe you could strace wpa_s over the
suspend/resume to see what it's actually doing during the init? But
that'd likely be hard to interpret ...

johannes

