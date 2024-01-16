Return-Path: <linux-wireless+bounces-2066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402FF82FC83
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 23:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76151F29FA8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A61F95D;
	Tue, 16 Jan 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OVCCx7UX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871951F939;
	Tue, 16 Jan 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439332; cv=none; b=ZpiEBKUr7m0LxCALS0UdpRVq55KP0D3rgvwa0OdV/JtKrxvLQdTZnuMuJ8QzyylzVGpXSfcXW+rDzqPDcfa/pF8mkODjcJ0GpPMQ3JBjvfNUZx6qM7naT//SYjB8KSjfz8g43RpfgVRx+FaQh6bKGDtGJMC7Py+5Wlosp0UTLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439332; c=relaxed/simple;
	bh=0iK44sT+JH6btkONVaDDfvQMivb0ALaKOLPT0/zAEbs=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar; b=gqScOWQ+9fSbXLTjDGxogpqugWTmW9RFLiKg2WqMJ6YyPcKkR3yg2qn0a8AVxAKsBFCdC0cAamnOJn+tlpstYloZjeaS16EnoBNUydJIDoRvcNLJUVxzn1KUdVsrazsh+m3FOtWfHJt5TO9vuZNieI1E215hFprR9BLVsYTtmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OVCCx7UX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0iK44sT+JH6btkONVaDDfvQMivb0ALaKOLPT0/zAEbs=;
	t=1705439329; x=1706648929; b=OVCCx7UX8+WR6D4MT23f+se5pC23jW4iC6LPsRjd1RYJMNa
	92+NwRKLsu+0UQZjY+Z7c4Oo70qbdsAHznJaJAQPIj9163pXn8RoU1VoaJfrpbUP++qdGPZQr5q9R
	Z8g8bLCU3x+BxkG+W0rBskkebWE8LDUh+XCZTWr4qW6EWnuOlwB/E7TwZxY/eMARsa4Klb+MlhhQ9
	7t5pvq3kL5gOs5Cgb+XF6mwXMWH2YtUlg4l5vkbXdyRd+4KWTPt/2P6NbLTjlZhDc6HeingLR4eU3
	4XNv5JJQvf4k6YoSbYU3FYbjeE+kk4DGtOIujzKKymbSKgTOWxYltglqsaSgKdIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPqfu-00000005III-0oaT;
	Tue, 16 Jan 2024 22:08:46 +0100
Message-ID: <f7b6c875dd41e792795ee3a7cea542b98c949a7d.camel@sipsolutions.net>
Subject: Re: [REGRESSION] 6.7 broke wifi "AP is in CSA process, reject auth"
From: Johannes Berg <johannes@sipsolutions.net>
To: coldolt <andypalmadi@gmail.com>
Cc: ayala.beker@intel.com, linux-wireless@vger.kernel.org, 
	regressions@lists.linux.dev
Date: Tue, 16 Jan 2024 22:08:45 +0100
In-Reply-To: <CAJvGw+BF+LWAzOKa8aJvGcdORWWjRDZObXupkCF5VAgSEm21nA@mail.gmail.com>
References: 
	<CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
	 <dae4bb032ad8b0c9fa6547de5e869e51f9f6e766.camel@sipsolutions.net>
	 <CAJvGw+ATM3B09KbuLM0VsmU9GZRSO-ZP6ffwvvOa75xVHR3-kw@mail.gmail.com>
	 <d14d6b4c02282d6ef48a936b1ac8be71c80a8835.camel@sipsolutions.net>
	 <CAJvGw+BF+LWAzOKa8aJvGcdORWWjRDZObXupkCF5VAgSEm21nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-16 at 22:37 +0200, coldolt wrote:
> On Tue, Jan 16, 2024 at 1:43=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
> > so mode=3D=3D1 indicates quiet, new_operating_class/new_ch_num are actu=
ally
> > the channel it's currently on, and count is 9.
> >=20
> > Can you say if it actually changes the count? Maybe capture on channel
> > 36 using the NIC as a sniffer what it does over time:
> > https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging#air=
_sniffing
>=20
> If I keep checking it the line "Unknown IE (60): 01 16 24 09" seems to
> always stay the same, the 09 doesn't change, it's the same today as it
> was yesterday.

Interesting.

> I captured the channel 36 for 15 mins, here is the 34MB file in
> gdrive: https://drive.google.com/file/d/1yqDb3g3Cfttm4W-Jb5AA51nLQ7OglWhl=
/view?usp=3Dsharing

Thanks! I got it, feel free to delete.

It's interesting, the AP is not including the element in the beacon, but
is unconditionally and always including it in the probe responses.

> > Initially I'd say though that if this situation persists, then your AP
> > is having some problems and we'd not have stayed connected without the
> > patch in question either. If you want, maybe revert and see what the
> > symptom is then?
>=20
> I now compiled and installed commit c09c4f3 and its parent 2bf57b0.
> The 2bf57b0 works great, connects immediately and I used it for 30+
> mins, also tried to connect/disconnect 5+ times smoothly, no symptoms.
> The c09c4f3 has the problem described originally, never connects even
> if trying 10+ times in 5+ minutes, keeps outputting the same dmesg
> message "AP is in CSA process, reject auth".

Yes, I didn't think of it being broken enough to include it in probe
responses but not beacons ... So it makes sense that w/o that we could
connect and not even disconnect, because while connected we ignore
(E)CSA in probe responses...

I'll think about it for a bit and ask some folks, but I guess we'll just
remove the check for probe responses from this ... there's little
guarantee anyway that this works well. Or maybe if we find it in probe
response check if we have a recent beacon? But that's tricky, we may
not, if we got a probe response on the channel but no beacon.

johannes


