Return-Path: <linux-wireless+bounces-12128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C69621EA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F0A1F2618F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57415853A;
	Wed, 28 Aug 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="IGLoHxpQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FD515B122
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831890; cv=none; b=Mdu4k3AVqaB1Pds/7FdyvV0r3JhgVjlvscSB2Aa+iOagkNUyh1AJxGuShk6AACaAzLMkj99pwHnprV8WMzlFnjb5q1jsXY3SkliCb6Gp6yTk6hqLpOu7xw3h7arY9nPF2X/OZRJBE5okWAVE6fzBtdtSETE1LWKQBt9LgriWQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831890; c=relaxed/simple;
	bh=LIQRNli3CllbOGaGJ54BgGgTcZ+YlPlQWmX0Z5C/3uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ep8eMWBhFSa8/L88ZFnXxbYfKHJr9vw9kHUd51lpirKoBIkPfJiFusMlvoUGscIkqGoAaxwvySBEU6Gbxdq6EiqhHezHVKMBO3WnqTa8ITBemGypbHU2Xc2rRsE3eE3KLG1WO2bFjgBgRIPWUeRWN8lEJ+n3Je+IwavdBxES3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=IGLoHxpQ; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 391AF11B51;
	Wed, 28 Aug 2024 07:49:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRAMAlCFpuJl; Wed, 28 Aug 2024 07:49:17 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 28 Aug 2024 10:49:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1724831357; bh=LIQRNli3CllbOGaGJ54BgGgTcZ+YlPlQWmX0Z5C/3uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGLoHxpQAXvbOBW5pKulr/J/RuNGgiWC+FjTMoEf0zXNYIo58RoyoYMmQzhqZG61x
	 kqUfOMbi0ZrKIGjbnN3Wa8IY0NKb8Wxd7TSk7BcYAB4rpcSfXC6qowfVsBtpHkjuom
	 Urhe/DJMawyxVa2GRhjB8RFCCdy2bG+ZvmPNdH5UCjhClOokn4xadka3O5phC79A3l
	 dozJTC+k4XgkvQmBBCOLv+AYtn+nGd3PewSPr4VBn7enBLHuBVg6vvUtaAxyUMySxy
	 kPlB3ZF5V0xRBopDteHimRQnuDmFz+ZTq6hwXzJf0Ayl1ts/1VeYCXiOLyWUkXiUPd
	 YvEKbNufwum1Q==
Date: Wed, 28 Aug 2024 10:49:14 +0300
From: Jouni Malinen <j@w1.fi>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-wireless@vger.kernel.org,
	hostap@lists.infradead.org
Subject: Re: WiFi constantly changes association
Message-ID: <Zs7WegloyrfZdRu9@w1.fi>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
 <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>

On Wed, Aug 28, 2024 at 09:19:05AM +0200, Johannes Berg wrote:
> On Tue, 2024-08-27 at 15:09 -0400, Alan Stern wrote:
> > Well, I'd prefer to avoid unnecessary roaming because of the short 
> > interruptions in service that it causes.
> 
> Right, but the interruptions for you are much longer because it _fails_.
> Perhaps wpa_supplicant should remember that, and not attempt to use FT
> when it keeps failing.

That depends on what exactly is failing.. I did not bother going through
all the details of the debug log since it seemed to be missing
something. I did notice one of the APs using comeback mechanism which is
a sign of the STA having an older entry on it and PMF being used. That
is actually not a failure but part of the expected behavior for
protecting against disconnection attacks. One would need to have a full
log from the first initial connection to the point of a failed
reassociation. Ideally, I'd like to see that from wpa_supplicant stdout
with -ddt on the command line instead of syslog.

> > Below is an extract from the system log for a period of about two 
> > minutes, running with wpa_supplicant's -dd option set for verbose 
> > debugging.  As of the start of the extract, the system had been 
> > associated with an AP for about five minutes.  The log shows a few 
> > spontaneous reassociations and some errors.  I hardly understand any of 
> > it, so thanks for your efforts to make sense of what it shows.
> 
> I'm not sure I understand it either ... I don't see anything that
> _caused_ the roaming.

Indeed. That log is not sufficient to debug this.

> > Aug 27 14:49:06 strephon systemd[1]: Starting NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service...
> > Aug 27 14:49:06 strephon systemd[1]: Started NetworkManager-dispatcher.service - Network Manager Script Dispatcher Service.
> > Aug 27 14:49:17 strephon systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.
> > Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:80:58:a1 1
> > Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: PMKSA-CACHE-ADDED 48:b4:c3:81:c8:e2 1
> > Aug 27 14:49:41 strephon wpa_supplicant[5906]: wlan0: SME: Trying to authenticate with 48:b4:c3:81:b8:03 (SSID='Harvard Secure' freq=6215 MHz)
> > Aug 27 14:49:41 strephon kernel: wlan0: disconnect from AP 48:b4:c3:81:b1:a0 for new auth to 48:b4:c3:81:b8:03
> > Aug 27 14:49:41 strephon kernel: wlan0: authenticate with 48:b4:c3:81:b8:03 (local address=3e:de:7e:33:e6:22)
> > Aug 27 14:49:41 strephon kernel: wlan0: send auth to 48:b4:c3:81:b8:03 (try 1/3)
> 
> But I don't know what causes this? Maybe a higher debug level would show
> something here? But also I don't know too much about wpa_supplicant
> behaviour, so perhaps someone on the list can chime in what might've
> caused it to decide to roam here.

This is clearly missing entries. Maybe something in syslog is filtering
things out? Like I noted above, debug log directly from wpa_supplicant
stdout would be better way of getting a complete log in a form that
could be analyzed without having to guess what exactly happened in this
type of a case.

Something external(?) seemed to do some management of the PMKSA cache
here. It is not what that is. If it is NetworkManager through the
wpa_supplicant D-Bus interface, it is possible that wpa_supplicant does
not log all the details in its debug log. If that is indeed the case, I
would recommend testing this with NM disabled or with a closer look at
NM debug log to see what it is trying to do here. Adding PMKSA cache
entries should not result in roaming, but removing them could if
something is removing the currently used PMKSA entry. I'd expect
wpa_supplicant debug log to include more detaild about that, though.

-- 
Jouni Malinen                                            PGP id EFC895FA

