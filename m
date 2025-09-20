Return-Path: <linux-wireless+bounces-27546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BBB8D1C8
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Sep 2025 00:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186C617FB95
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Sep 2025 22:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED2285069;
	Sat, 20 Sep 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b="o2j5TBe1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m101-out-mua-2.websupport.se (m101-out-mua-2.websupport.se [109.235.175.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD91EFF8D
	for <linux-wireless@vger.kernel.org>; Sat, 20 Sep 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.235.175.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758406770; cv=none; b=g4O1mY1tj1sc/no+Q7GO8i0d6H2yspGF4qWnxwg/CLlsxZaChwO9yUo8itUum0tazkorYWOll1ccwVmLMslxgOSw/KDA6A15drB8S+o/Fs3hyCLgo4zJPkABFwyie96TO9frruOHhYsDW8UyC1v73u2+Lnah4V5XdkjXOC+ZfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758406770; c=relaxed/simple;
	bh=FwPN/kfE0oL5jSM/vXSvYUGRrZyCJE6vUwv9LZt2DSY=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=CxDC8X+BcAMtGX8YPogN8ytUwG/CpOh1H2Y8jZMvU+il01XXHGkA0cDci9XKx6xGs9RcjTzgV5E5C14Z0ixL1hRSHHeQQby4o82HSpLygV749SuPLSrsbGRAHUBxF7m5C0I0IfxcHV86EB+x0JOj73kcaMgxgoj71H2f+/s1nZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se; spf=pass smtp.mailfrom=technux.se; dkim=pass (2048-bit key) header.d=technux.se header.i=@technux.se header.b=o2j5TBe1; arc=none smtp.client-ip=109.235.175.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=technux.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technux.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=technux.se; s=mail;
	t=1758406227; bh=21BlgSbO400wZ7rAfoiOr5dJm3AEdcItIEfSnbuS4K4=;
	h=Date:From:To:Subject:From;
	b=o2j5TBe1pTDA/xIGEBcE3Ilp3fOfGp+yfgP2L4cosuvuNfmT9ebCuyXrFG8pynNx2
	 4+dDTYPKgkEeWkRUA2Tt754CXeaUsT5M9wfpCwCwqTmZ41ScAHuV0QE7GzgRglyC3q
	 hN3UCVsfh4AIIOP/anX62lZhimQ9l6suRtNJqnccoRrLCveh0KOgCRz4me1rBoz7hU
	 +AkOaQKOelcA4nMqOtoiGUmQNEqdwJ2bLj7QE9N9Pw025UZAzm3ea15no6B/jnriod
	 C4unpl8g23SoOzEzZtyG14iYsYApIlQTMEaiaTIKffCmXDeLvoq2ct5cefKcb18lyo
	 37t/2qJIZKBnw==
Received: from m101-u5-ing.websupport.se (unknown [10.30.5.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m101-out-mua-2.websupport.se (Postfix) with ESMTPS id 4cTk8M0pH7z1hkt
	for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 00:10:27 +0200 (CEST)
X-Authenticated-Sender: petter@technux.se
Authentication-Results: m101-u5-ing.websupport.se;
	auth=pass smtp.auth=petter@technux.se smtp.mailfrom=petter@technux.se
Received: from roundcube.ws.int (unknown [109.235.175.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: petter@technux.se)
	by m101-u5-ing.websupport.se (Postfix) with ESMTPSA id 4cTk8L5c1gz1XlB
	for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 00:10:26 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Sep 2025 00:10:26 +0200
From: petter@technux.se
To: Linux wireless <linux-wireless@vger.kernel.org>
Subject: [BUG] arm: wlcore: wl18xx: connection timeout after resuming from
 suspend
User-Agent: Roundcube Webmail/1.6.11
Message-ID: <814f1b989aa987fa93e216befec980d5@technux.se>
X-Sender: petter@technux.se
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Spamd-Result: default: False [0.00 / 1000.00];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:41528, ipnet:109.235.175.0/24, country:SE];
	ARC_NA(0.00)[];
	WS_IP_WHITELIST(0.00)[109.235.175.26]
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WS_IP_WHITELIST
X-Out-Rspamd-Queue-Id: 4cTk8L5c1gz1XlB
X-Rspamd-Action: no action
X-Out-Rspamd-Server: m101-rspamd-out-5
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2079
X-purgate-ID: 155908::1758406227-F3A44325-16F7DB7B/0/0

Hi,

When I bumped from Linux 6.6 to 6.9 or later, I have issues with wifi 
after resuming from suspend on my am335x (Beagle Bone Black wireless) 
board.

When the wifi starts up it just repeats with

[ 183.118816] PM: suspend entry (deep)
[ 183.128244] Filesystems sync: 0.005 seconds
[ 183.158165] Freezing user space processes
[ 183.167546] Freezing user space processes completed (elapsed 0.005 
seconds) [ 183.174835] OOM killer disabled.
[ 183.178082] Freezing remaining freezable tasks [ 183.184998] Freezing 
remaining freezable tasks completed (elapsed 0.002 seconds)
[ 183.192636] printk: Suspending console(s) (use no_console_suspend to 
debug) [ 183.206858] wlan0: deauthenticating from d8:07:b6:83:ae:56 by 
local choice (Reason: 3=DEAUTH_LEAVING) [ 183.293875] wlcore: down [ 
183.296231] wlcore: down
[ 183.444907] Disabling non-boot CPUs ...
[ 183.444975] pm33xx pm33xx: PM: Successfully put all powerdomains to 
target state
[ 183.444975] PM: Wakeup source UART
[ 184.159782] wlcore: PHY firmware version: Rev 8.2.0.0.243 [ 
184.262260] wlcore: firmware booted (Rev 8.9.0.0.83) [ 184.408702] OOM 
killer enabled.
[ 184.412231] Restarting tasks ... done.
[ 184.441020] random: crng reseeded on system resumption
[ 184.708905] wlan0: authenticate with d8:07:b6:83:ad:be
[ 184.865164] wlan0: send auth to d8:07:b6:83:ad:be (try 1/3)
...
[ 184.865164] wlan0: send auth to d8:07:b6:83:ad:be (try 2/3)
...
[ 184.865164] wlan0: send auth to d8:07:b6:83:ad:be (try 3/3)
..
timeout...

then repeats.. Only way to make it work again is to restart the board. 
This works perfectly fine in Linux 6.6.. Any ideas what might have 
changed in later kernels that might affect the wifi after rtcwake usage?

Some tries to bisect the issues points to

5797b1c18919 workqueue: Implement system-wide nr_active enforcement for 
unbound workqueues

But that might just be due to some timing issues caused by changed 
behavior in workqueue of the driver?

Any suggestions for how to troubleshoot this further is welcomed.

BR Petter

