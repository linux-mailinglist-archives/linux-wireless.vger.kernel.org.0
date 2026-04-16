Return-Path: <linux-wireless+bounces-34879-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLLnI2Cv4GkRkwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34879-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:44:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B980040C8BA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6692F301A401
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 09:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26B396567;
	Thu, 16 Apr 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eskapa.be header.i=@eskapa.be header.b="Em2jNf64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EA391507
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332393; cv=none; b=HT7pYnWFbEqcQMi6Z8cTmLHX1r1b07H5OrZoOZ0RczqHCNKx4yDDWUZCuslpK5R40/MYfRNDQ/+OKiiVZ/G9TJSOol94zBobSSclODlRNp7WaXtSnceH/PGt24OHjU0LE5rVFQZXJSuySYtKwJ9+1So/1g72Esfnku47SAxAl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332393; c=relaxed/simple;
	bh=c7SUvv98yBbdmiS00lwnJibEnJTn19T8mAU7Vt0OvDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mWZ3dj1N187BdU8zRljs/lu3jV5ympIzrgiTopKQcElyvG+8mLkQfsCVCy/UinNH8J/QkhLvBNrB1dI0UyXlDO28LDIqQ/kxw55SNWmoO7YTGbXdWvP+vtzMYULO/SD6FVTpP0LbyFTCc2K7wryxLS4rVqv4xWbsIKGFcHd213k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eskapa.be; spf=pass smtp.mailfrom=eskapa.be; dkim=pass (2048-bit key) header.d=eskapa.be header.i=@eskapa.be header.b=Em2jNf64; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eskapa.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eskapa.be
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fxCf30MHFzT8t;
	Thu, 16 Apr 2026 11:39:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eskapa.be;
	s=20230820; t=1776332378;
	bh=sC6DOp6I+UJxsZ/NFuRT61E82T7wW4cje7LW0fyzt+k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Em2jNf64PP8l7OK5Y06dgsn1+/7GS3vsf87QhRgvtn5Jvk91We/BvGaXTBJ4m8vJJ
	 Vb/ZfnfbBGglvCEAC3V6RDFcV9AD3x2bhdoHNExyNeyTNjjB8GWkpSDa7xs1sw6WMp
	 c6eP9VcCvWJ6MOy8lk6NXmglNeJ/qFElsLv8Bopv4YB513X9kXCJHDQ8orqWpNSlnt
	 TPXv9cqfyx6XHZRSKtqTH/wKWTh6F/oO9NMkvsLIZmfOcr1Rlwc/gum8FKiUU2uv6k
	 1YMv4cNqMqEqAeyWiWfYM2lT4i23pFEZtg+P+tRgDXvbNfpBIlPaeHFItHe4iuO/Bn
	 MuoX9tywVDiWA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fxCf248qgzw3l;
	Thu, 16 Apr 2026 11:39:38 +0200 (CEST)
Message-ID: <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be>
Date: Thu, 16 Apr 2026 11:39:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: Benson Bear <benson.bear@gmail.com>, linux-wireless@vger.kernel.org
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
From: Pablo MARTIN-GOMEZ <pablomg@eskapa.be>
Content-Language: en-US
In-Reply-To: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[eskapa.be,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[eskapa.be:s=20230820];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34879-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[eskapa.be:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablomg@eskapa.be,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B980040C8BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,
On 16/04/2026 10:47, Benson Bear wrote:
> Hi folks, I've never posted here before, don't know much about wireless, but
> am having a big problem I have been trying to solve for a week. I've been
> googling and ai chatting non-stop but finally after reading the info
> page about the
> list figured it would probably be acceptable to send this message.
> 
> BRIEFEST SUMMARY: There was a firmware update in Rogers's (Canada) XB7 Gateway,
> and subsequently my Wi-Fi transfer speeds degraded badly on all three
> Linux notebooks I have. Fully up to date notebooks, running Fedora 43 and
> 42 with most recent kernel 6.19.11. Two different NICs: RTL8852BE and Intel
> 7265 (rev 59). Wired machines and phones are unaffected.
> 
> The machines all connect with high transfer rates of around
> 800-1000Mbs on the 5G band,
> with an 80Mhz wide channnel, and MCS level ranging from 7 to 11 (HE and VHT).
> 
> Transfer speeds using WPA2 security have dropped in the one case (RTL)
> from 600Mbps to
> about 30Mbps. (Using internet speed test but iperf3 gives similar). The other
> cases are similar.
When traffic is capped around 30-50Mbps, the usual suspect is
aggregation not being setup.
> 
> BUT the transfer using no network security is still what it used to
> be! It is simply
> the enabling of WPA2 that brings them to their knees.
If I had to guess, this is an issue with PMF. Either the STA or the AP
considers PMF is activated and the other one not; so the action frames
that set up a BA session are dropped.

Check
`/sys/kernel/debug/ieee80211/phy<n>/netdev\:<devname>/stations/<bssid>/flags`
on your notebooks if there is `MFP` in the flags
> 
> So it seems to be a problem related to WPA2, and at a lower level in the
> stack of modules, since it happens on two different NICs?
You can try a few things:
- build a master wpa_supplicant from source and replace the Fedora's
binaries
- use a raw wpa_supplicant connection and set ieee80211w=0 in the config
file
- switch the backend of NetworkManager to iwd
- update the security to WPA3
> 
> I suspected for a long time that it was a firmware bug in the gateway, but
> now I am starting to wonder. I have no solid evidence of that except that
> Windows works fine on the same gateway and the same machine.
> 
> All three machines work well on another network I have occasional access
> to, and have worked fine on this network until about a week ago.
> 
> I have ordered another router that I hope I can use to solve the
> immediate practical problem, but I would really like to figure out
> what is going on and contribute what I can to fixing it, even if only
> by being sent out to gather potentially useful data.
> 
> Thank you.
> 

Pablo MG

