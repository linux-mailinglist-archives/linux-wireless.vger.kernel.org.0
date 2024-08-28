Return-Path: <linux-wireless+bounces-12148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7939622CF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE41C243FF
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8015CD4A;
	Wed, 28 Aug 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="W0+CVSkc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D515B12A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 08:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835072; cv=none; b=FHD8WjVVGrGyr0hQRbClaREcwrvD52o8U2bn3T3IoPi6J276gz1EteQ2jkMLtuuv4Oxh+lXxVyMPHqCA+f9A32PxVvC4TRiHuUoyJk7mWa7Zxt7C3NNXmK0duyT43Jb2ECNx6YXlO/Cx8XdqRy5II9vsXwyg5EIgOuCcCW3hMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835072; c=relaxed/simple;
	bh=Q1XZ0wlkhbLl65+rtGUZ4JkoYZ3+W2MKU5sYnZveBIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeYN+A75q1D7wFw19T7bmxvpVxjhfVbaAJyWRwEYOJ1oOiEhZE055KvveyUzqy65tyAqufDwhwnSdif6izYsNpEszB40Bam2zKbgmoxhzeaG/N++kZaycYF1YFEaiYVM47LpSf0/TQn/4b2IeDNbrgVo4tDt5XXpdAVZyee1myQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=W0+CVSkc; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 5BDA911B7B;
	Wed, 28 Aug 2024 08:51:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNE6e9g8VPJl; Wed, 28 Aug 2024 08:50:15 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 28 Aug 2024 11:50:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1724835015; bh=Q1XZ0wlkhbLl65+rtGUZ4JkoYZ3+W2MKU5sYnZveBIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0+CVSkcGjpiQ3EZ5ZAPUrNsofTDNM/vmUCm9dTnYAo8Udy++aJsvtmyhTcO/AEZh
	 7djEDgWK/U7K1422kJRVEv8NALdgxOkA7XEHlyuYpP/K6dpHnDlXjLDIC9MOFLhm8Q
	 Eb+/X8z5OvV7pN/f1kpaHe1T1f0T+lLzHUi3SC7Cyj/hlpWTk33nEpnV1ZXZ4+OjtY
	 Sjf54VVcgFDaPWfM8aUGDOZLaifcc/rLLe/NYn6fLPaFNHy5vyoF8N1l/L410W6Jdn
	 vq1jVpDZhhU3AAttvcIZDFNHLuetKjlRJgoX5N5ukNBf4srB6lTRW0bbKJv0Xf6/QZ
	 9egrCl/F2nroQ==
Date: Wed, 28 Aug 2024 11:50:13 +0300
From: Jouni Malinen <j@w1.fi>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-wireless@vger.kernel.org,
	hostap@lists.infradead.org
Subject: Re: WiFi constantly changes association
Message-ID: <Zs7kxVAHmCaeOxSH@w1.fi>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
 <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
 <Zs7WegloyrfZdRu9@w1.fi>
 <f6ea69035f7ff32edc2575765641689e469f764a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ea69035f7ff32edc2575765641689e469f764a.camel@sipsolutions.net>

On Wed, Aug 28, 2024 at 09:55:09AM +0200, Johannes Berg wrote:
> But for example:
> 
> > wpa_supplicant[5906]: wlan0: FT: RSNE mismatch between Beacon/ProbeResp and FT protocol Reassociation Response frame
> 
> is something that perhaps could result in an FT-blocklist or something
> for the BSSID in question, or perhaps even the whole network since it's
> likely to be a single controller/unified installation or so.

Somehow I managed to miss then entry.. This is something that I'd be
quite interested in getting more details for since this seems to show a
clear interoperability issue with the FT reassociation implementation
between the AP and the STA.. I'd like to see the full wpa_supplicant
debug sequence that started from selecting the AP and how it resulted in
this mismatch.

Is there any idea which AP devices are used in the network? It is
clearly misbehaving if the wpa_supplicant debug log entries are accurate
on what RSNE values it uses:

RSNE in Beacon/ProbeResp - hexdump(len=32): 30 1e 01 00 00 0f ac 04 01 00 00 0f ac 04 02 00 00 0f ac 05 00 0f ac 03 e8 00 00 00 00 0f ac 06
RSNE in FT protocol Reassociation Response frame - hexdump(len=44): 30 2a 01 00 00 0f ac 04 01 00 00 0f ac 04 02 00 00 0f ac 01 00 0f ac 03 e8 00 01 00 ff 84 62 84 5a a3 06 82 4f b4 2d 43 36 76 87 4b

It is expected to add the PMKID entry for FT, but the AP changed its
list of AKM suites (!?) and removed the group management cipher suite.
Such changes are not allowed and the STA has to stop since those would
be a clear indication of an active downgrade attack. While
wpa_supplicant could in theory prevent FT attempts with this AP for some
time from the view point of interoperability workarounds, I'm not
exactly happy about such a change since it could make it easier to
perform various attacks.

As far as the AKM suite lists are concerned, the RSNE from scan results
indicated 00-0F-AC:5 (802.1X with SHA-256) and 00-0F-AC:3 (FT with
802.1X) while the RSNE from Reassocation Response frame indicated
00-0F-AC:1 (802.1X with SHA-1) and 00-0F-AC:3 (FT with 802.1X). This
feels really strange. Either the AP has a really broken FT
implementation or something has messed up with scan results.. Since this
attempt is on the 6 GHz band, I'm assuming the AP has other BSSs on the
2.4 and 5 GHz bands and it might be possible that there are differences
in which AKMs are enabled on different bands. That would be a bit
strange configuration of the AP, but still, possible. It would be nice
to get full scan results that show the RSNE values from all bands.

-- 
Jouni Malinen                                            PGP id EFC895FA

