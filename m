Return-Path: <linux-wireless+bounces-26004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE9B111F0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 22:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BEB025DB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 19:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89C22E406;
	Thu, 24 Jul 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="D5tvOlHs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D261FC3
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387206; cv=none; b=Fhwe/Bi/9oTgtDVIcPNrWcAmbfkpki+gYi/SPrQGmS8em5cJH2kk3T+ciz+a/mhuiE4ebPBNr/KRqjC9XxeesQ0/b4BMTNxgfTFXxvUgJ2QVP74nW1Jxeqie5TrWUAnII7S4cqkdCLT+vBchnTAQmr55UlckG1MW7u7MrO6lLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387206; c=relaxed/simple;
	bh=HCy0CWYCmah+8VU5c4Bxy/zzQXjnLVkPn6rOUnWHOPw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jVi8YVTne5Ar2Xv/hH9LuvScAoqQ2yvoBXoKNvqVideV9I00I9VT6tFpItj/81R1zO43QJL2I5bMazwoeao4w9L7IM/AlgzywB+OKKGGG23YkfEAkuFfRLiak6Zoa5FB56mHBvsEeJ9FxWmBMwrMaRmbQopdPaWDQOhrq1CWDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=D5tvOlHs; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id AEBDF11D50;
	Thu, 24 Jul 2025 19:53:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ngITJXo1Bn1; Thu, 24 Jul 2025 19:52:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1753386773; bh=HCy0CWYCmah+8VU5c4Bxy/zzQXjnLVkPn6rOUnWHOPw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=D5tvOlHsH6FIQwW4wvqOtXV7rbrPyxldg3MpvD4mmJN6Ah3XZu3TgMCMpvMtCDfhH
	 BjJra0rhdRHwz856+Ian4bMO2wgw84yOxVxy6oNzb5bZCipakBkDQ0aXV7jM3udJAB
	 NoR5u7UFXbcTru5BD5GFi37kWbLC+DhClzp3ZaCobhqA+Zm7l3FQ9uUvKTmwEuFpBP
	 rzwavCjJ8YR+sOvMAzMKQIcNe3dRWe4hgcEzVsdqflvyxXtTzUYmtXnYVuExS1xsYo
	 JurbfaKOn/+pNHecrZ5qLqFKj/yN4aAAE0BEJ0u4guTZj28oTHnTC3FHZOYV/Bv4hu
	 E3ApcPtycH0Kg==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band capabilities
 element advertisement in lower bands
From: Jouni Malinen <j@w1.fi>
In-Reply-To: <4a1c89a13b299588bf9c94dd545eda3e30fb5491.camel@sipsolutions.net>
Date: Thu, 24 Jul 2025 22:52:41 +0300
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org,
 Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5ADD0C31-F63B-4597-941D-2CABA0F96D2A@w1.fi>
References: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
 <4ab522796b91ed3421991799d3a7831a3c0ffb53.camel@sipsolutions.net>
 <92a6a3b6-397d-4cf3-95d6-01b50f827183@oss.qualcomm.com>
 <6290a248adbc1208df293dc22b85fe5a33963239.camel@sipsolutions.net>
 <ec688c7e-65b1-4ef4-a977-e6c89d2176ef@oss.qualcomm.com>
 <f80c107d6cf596091865961f8d1371b98486a14a.camel@sipsolutions.net>
 <48b3af20-dd6c-49cf-88b0-1d535bd917f7@oss.qualcomm.com>
 <4a1c89a13b299588bf9c94dd545eda3e30fb5491.camel@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>

> On 20. Jun 2025, at 11.39, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Thu, 2025-06-19 at 19:35 +0530, Rameshkumar Sundaram wrote:
>>>=20
>>> Now that I look at it again though, it says for both beacon and =
probe -
>>> _request_ to include it when dot11HEOptionImplemented and
>>> dot11HE6GOptionImplemented are (both) true... We always though, with
>>> some discussions with Cisco IIRC, that we should then always include =
it
>>> even on the other bands for probe requests etc.

> Not sure? I guess what I'm starting to think is that if the language =
is
> all the same across all the frames and says to include it "when
> dot11HEOptionImplemented and dot11HE6GOptionImplemented are true", but
> the beacon clearly doesn't make sense - is that a bug in the spec for
> the beacon, or does it mean your patch is actually correct also for =
the
> client?
>=20
> Jouni, maybe you have some spec interpretation opinion? :)

Unfortunately, this is yet another example of why dot11*Implemented =
variables are a bad idea.. No one knows whether these are really about =
something being capable of being enabled somehow and under what =
constraints vs. something being activated currently. It should be noted =
that before EHT (Wi-Fi 7) and the MLD concept, the STA was really only =
operating on a single channel and these capabilities of operating on a =
specific band are normally really applicable only when the single =
channel at that very point in time (e.g., when transmitting a frame on =
that channel) being within that band,

For an AP, this is kind of clear, i.e., if the AP is operating on a 2.4 =
or 5 GHz channel, dot11HE6GOptionImplemented is actually false even if =
the device containing that standard-defined-entity-AP happens to =
incorporate other possible standard-defined-entity-APs that would be =
capable of operating (and might even operate currently) on the 6 GHz =
channel. As such, I would interpret the AP cases in a manner that the HE =
6 GHz Band Capabilities element would be included only in frames =
transmitted on the 6 GHz band. There are similar cases like the TVHT =
Operation element and dot11TVHTOptionImplemented.

The non-AP STA case is somewhat more confusing with the language talking =
about being capable of operating on the 6 GHz band and what could happen =
during a scan, so I=E2=80=99m not sure what to say about Probe Request =
frames, but my current implementation would be the same even for that =
case, i.e., no HE 6 GHz Band Capabilities element in Probe Request =
frames transmitted on the 2.4 or 5 GHz bands. (Re)Association Request =
frames would be somewhat clearer by being on the operating channel and =
that would seem more logically bound to a specific single band.

All that said, it should also be noted that many people working on IEEE =
802.11 amendments do not really fully appreciate the details in this =
area and whether the original intent was really what the text now says =
is a separate question.. In this particular case, though, the definition =
of the HE 6 GHz Band Capabilities element in Clause 9 is quite clearly =
limiting it to cases where =E2=80=9Coperating in the 6 GHz band=E2=80=9D =
which would seem to back my interpretation: this element is included =
only in frames transmitted on the 6 GHz band. (Some openness for more =
flexible interpretation might be needed to cover cases where Management =
frames are tunneled through a different link in some multi-band cases =
where the frame targeting a STA operating on the 6 GHz band might =
actually be transmitted over-the-air on the 2.4 or 5 GHz band.)

- Jouni
=20=

