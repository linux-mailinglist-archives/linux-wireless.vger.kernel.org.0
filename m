Return-Path: <linux-wireless+bounces-12117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10D9620CC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1DA2B23CE6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6C158552;
	Wed, 28 Aug 2024 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C5Vma1X7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E70158848
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829557; cv=none; b=ahx/dNISaOeXVcQzlg6p9TLbktzTbILcKkRyCQ2jmW/S7eJTB8fO82+MWedOBfmKN3rouq1zA5p1pZmxaPnQPNy9wDe8122531UA04ExXMah949Gxl5aVkC4nUlLE3/QGofxJBI4vbyts3LSWJdOt6S/zck2SJUDikNwKWae4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829557; c=relaxed/simple;
	bh=2JAHRlpNhbel6e5TtRGYtCFzWJsfiSSfUJL1bWUXpS0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgZkQdmFZ/e2+CKtOhDbnXv6uzAiTe3WH+79F6/g/HXtTy16aGN7fOmoHH2oMukBFgb4nI91hpjxobyAwRAU9zIZA2OvlMyy+qS6V2in4emg1iP+M1LSCCb5Du5A0UZvpZqE9B8QnxHp9+ez0hrZb/EzNCAKBZuiB2YK6+YbQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C5Vma1X7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mFGHJEbOELDvc/L7FUxcmiha1LNirMx4mGdSAlBb6Rw=;
	t=1724829555; x=1726039155; b=C5Vma1X7bkC77o92z47XZPB9yRZ5jX9NytL4bnDriqkbxBC
	N5ghxfrJvBNwzDPEFdLyaawBY0kJKPKzl/SIOsMqUW5erJRt9+EIO0UchpO6Ml7gwvGX6bhMDBuAV
	T8dfbKJuWHx5+zyL8kmaRPk8/cIisXJKOYakbYrKG9fZvtGPPBMQnaA3nLi7k5JmjQrJn07XvjI5P
	7NmVsyCVhKUjkOhau+nQM8wbrPJ5tyvDq6SZ3fgkkChMIsyFcgsLjoPUcNP/jBy+Y40Y9gQbqrgDw
	bi9qkR5xjqseY8JxfffKzORN0syXttq9pDUqprOTYKN7PRyv8vkFmymZcS4YAbKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sjCxO-00000006fRn-2oMN;
	Wed, 28 Aug 2024 09:19:06 +0200
Message-ID: <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
Subject: Re: WiFi constantly changes association
From: Johannes Berg <johannes@sipsolutions.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Date: Wed, 28 Aug 2024 09:19:05 +0200
In-Reply-To: <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
	 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
	 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
	 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-08-27 at 15:09 -0400, Alan Stern wrote:
>=20
> Well, I'd prefer to avoid unnecessary roaming because of the short=20
> interruptions in service that it causes.

Right, but the interruptions for you are much longer because it _fails_.
Perhaps wpa_supplicant should remember that, and not attempt to use FT
when it keeps failing.

> Below is an extract from the system log for a period of about two=20
> minutes, running with wpa_supplicant's -dd option set for verbose=20
> debugging.  As of the start of the extract, the system had been=20
> associated with an AP for about five minutes.  The log shows a few=20
> spontaneous reassociations and some errors.  I hardly understand any of=
=20
> it, so thanks for your efforts to make sense of what it shows.

I'm not sure I understand it either ... I don't see anything that
_caused_ the roaming.

> [snip]

I'll skip that since I don't know if it's complete, or what came before.
There are some failed transitions there, but eventually it's connected
again:

> Aug 27 14:49:06 strephon kernel: wlan0: associated
> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: Associated with 48:=
b4:c3:81:b1:a0
> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-STAR=
TED EAP authentication started
> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SUBNET-S=
TATUS-UPDATE status=3D0
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5694] d=
evice (wlan0): supplicant interface state: associating -> associated
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.5695] d=
evice (p2p-dev-wlan0): supplicant management interface state: associating -=
> associated
> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-EAP-PROP=
OSED-METHOD vendor=3D0 method=3D13
> ...
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8164] d=
evice (wlan0): supplicant interface state: associated -> 4way_handshake
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8165] d=
evice (p2p-dev-wlan0): supplicant management interface state: associated ->=
 4way_handshake
> Aug 27 14:49:06 strephon kernel: iwlwifi 0000:72:00.0: Unhandled alg: 0x7=
07
> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: WPA: Key negotiatio=
n completed with 48:b4:c3:81:b1:a0 [PTK=3DCCMP GTK=3DCCMP]
> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-CONNECTE=
D - Connection to 48:b4:c3:81:b1:a0 completed [id=3D1 id_str=3D]
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8649] d=
evice (wlan0): supplicant interface state: 4way_handshake -> completed

Now it's fully connected.

> Aug 27 14:49:06 strephon wpa_supplicant[5906]: wlan0: CTRL-EVENT-SIGNAL-C=
HANGE above=3D0 signal=3D-68 noise=3D9999 txrate=3D29200
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] d=
evice (wlan0): ip:dhcp4: restarting
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] d=
hcp4 (wlan0): canceled DHCP transaction
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] d=
hcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8660] d=
hcp4 (wlan0): state changed no lease
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8661] d=
hcp4 (wlan0): activation: beginning transaction (timeout in 45 seconds)
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.8661] d=
evice (p2p-dev-wlan0): supplicant management interface state: 4way_handshak=
e -> completed
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.9397] d=
hcp4 (wlan0): state changed new lease, address=3D10.250.66.194, acd pending
> Aug 27 14:49:06 strephon NetworkManager[978]: <info>  [1724784546.9401] d=
hcp4 (wlan0): state changed new lease, address=3D10.250.66.194

and also with DHCP from NetworkManager now.

> Aug 27 14:49:06 strephon systemd[1]: Starting NetworkManager-dispatcher.s=
ervice - Network Manager Script Dispatcher Service...
> Aug 27 14:49:06 strephon systemd[1]: Started NetworkManager-dispatcher.se=
rvice - Network Manager Script Dispatcher Service.
> Aug 27 14:49:17 strephon systemd[1]: NetworkManager-dispatcher.service: D=
eactivated successfully.
> Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 4=
8:b4:c3:80:58:a1 1
> Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 4=
8:b4:c3:81:c8:e2 1
> Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: SME: Trying to auth=
enticate with 48:b4:c3:81:b8:03 (SSID=3D'Harvard Secure' freq=3D6215 MHz)
> Aug 27 14:49:41 strephon kernel: wlan0: disconnect from AP 48:b4:c3:81:b1=
:a0 for new auth to 48:b4:c3:81:b8:03
> Aug 27 14:49:41 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b8:=
03 (local address=3D3e:de:7e:33:e6:22)
> Aug 27 14:49:41 strephon kernel: wlan0: send auth to 48:b4:c3:81:b8:03 (t=
ry 1/3)

But I don't know what causes this? Maybe a higher debug level would show
something here? But also I don't know too much about wpa_supplicant
behaviour, so perhaps someone on the list can chime in what might've
caused it to decide to roam here.

johannes

