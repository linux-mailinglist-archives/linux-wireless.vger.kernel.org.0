Return-Path: <linux-wireless+bounces-12955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20D97BBD4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662F61F2105B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720A2AEE0;
	Wed, 18 Sep 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b="XJK/vGXY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19961862B9
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726660674; cv=none; b=ktZfHAk27e8nGP0GekalViYRyqVUNDmWwvQFbnYgG1CQ5IyChh1lc7iYAH8IEAbo8vgXshrVpRhPXQaRKGiya94S2uAL2SHxibLIJK1U0Il1U/jcWkvGNMvOw7IQ/bsPiyaDskKBiG/PzmrhTjXF0cbzeuLNyvHTbwY2TQIIdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726660674; c=relaxed/simple;
	bh=rPIM2CHJEYDBY6xzZyIEJywLsirOLas2Aw/CRHzIbsM=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=RvDkEQwtI+lKpp3E952+WsfViKwTo2skHVtmvE1EAidHlGON8lpYgQ/uUOS1AgXlz3cU9ijZX/aIPLVKUuTGCBoD7tp7PbXgvJUSM6tvfb/5Ge+LQl7BVmk4zhXC4QJGK6agIyJlVMHkA5b9L9rUrENgJq2Uuw61F8A1coEXEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org; spf=pass smtp.mailfrom=linuxmail.org; dkim=pass (2048-bit key) header.d=linuxmail.org header.i=cemunal@linuxmail.org header.b=XJK/vGXY; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxmail.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxmail.org;
	s=s1089575; t=1726660669; x=1727265469; i=cemunal@linuxmail.org;
	bh=tnGt2mitA4HbyTPbp3AXC/o6jO2LvnfdyqnYSdQ9scA=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XJK/vGXYaDKhuYY6JXKh7VDJ6aXeIzXAYZ7y5lYc6IMt9HqzjxNmWxN1yxD9XeVR
	 rcAKnijZgspvD85elrK+LJ6L5JwpGNRqxc7W9MwMx0Va2xm5dYi3y7rwqC0BEEwFF
	 cOChihvrh3VOc9kz2596ZL0mpTbyqZxYG0B3nTCJQH3YJGSBCwamErmEgFZy0exZB
	 z4fS+situYz1xn/qcjyNXCtWRVE1VienbP90E9u+5JwnWMsv68VoIcLkV0C/cyN4t
	 ai84pyLaCSyTYY49tq2FdfGuMULvz7DElrIHCm4cgQSY0slRj0+ANT5HTxBMscjeK
	 MP9YUOw/5bTQRTQCcA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [188.3.12.169] ([188.3.12.169]) by web-mail.mail.com
 (3c-app-mailcom-lxa11.server.lan [10.76.45.12]) (via HTTP); Wed, 18 Sep
 2024 13:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-dd463594-7071-49e4-8e07-e6c885c189e3-1726660668932@3c-app-mailcom-lxa11>
From: =?UTF-8?Q?Cem_=C3=9CNAL?= <cemunal@linuxmail.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: RE: RE: PCIe Bus Error from rtw_8821ce
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Sep 2024 13:57:48 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <71107862cf8e451ca19c1dac72a51b4a@realtek.com>
References: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
 <6d0fc72b21794f73a6017b467a102500@realtek.com>
 <trinity-154f2ef3-0df7-4802-88fc-d2ddcfb70a52-1726643761105@3c-app-mailcom-lxa04>
 <71107862cf8e451ca19c1dac72a51b4a@realtek.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:QXFtii9YLUX0bPtV/bZqfklSP5GvEEVHGW+Z5qC9dnCCVq5aSIxJ3PtFy3hZHS50l6H4R
 xRW6lnpuGWwXhLAUR2ZpBZ/03ZIH+9rYc/DA6QwENcXSxtTzIudnPYNWn8L8bx/bnNTyQvwk3GIa
 r1Sg8h7J+WGKbxPm4sN8yoaWW33PrtSKf9RtipyZntbTpuHVIXd7tcUT93BMdVOucK8it6dCVyLE
 9GaJ2Hl1hPwaLPRpHcMMhEeWdwmq4NZcH3VVJhVVjldUD7gv0PKkk6u/x5HkNisBsOb15hL/ccB8
 58=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WUdZ6LKghCc=;OI9ZoZxL/VhfdbePXkC8Gac60Ws
 5M+IiuvaGFzAfjCWPdwTc5g5yqy+BjIdseoXXF/WzPWw5vMvumYH/tFmu7fJnIYP2u6SVwa7Y
 j/jd6kG8y8WnhDjuXfVMZNWeXtPosAI8lpPQnTDWcSUlspPlDy6m+5w+ALaEpgqzGj8OHkpVM
 mDEBdVRk2vEWw+wnoo7btwGL26KR+XLs9wld6PGzT4jIAIFC5gfXmoRAtujKeyP5fGtpVgWhu
 gUHbDLJG+5nzJ7HuSi4ANlt0SN89zHaNFeYbvTyngBQbg5nSviBMgHJw84+hWxrEYwOl8aqrT
 jL+lOrCMvz5+n5XEA1gxEVZua5exn/qyxPCHKIZS6ueeSJwrTCi6IbKZavailNlP9Q0dcWtug
 1x2jyExmlMVCpVgjMcXOrkwgJPeYyb99aInEQTYHlN0denEAA+gBz6Hg3FUiJbvswv3uKmLOh
 OfS67YnxLVFipCUsfcEE9gARFCICKi7S3Izd71Ki78jLa3oV5vM+S7PhcoHCTyB6dws5AUdgF
 vomVPq4deeuKs8hGB4RlIif5o++kW/+qvRVSjM6k60K8d5tc9UCWbSRpbpYs2uzPUIqDJvxX7
 bZXq+Qa+gTCNsSZypfbdZZRjCeAPmpJ1WwlGJW091j8/9pClqwxYlwtd3cVGGCIMdB3iYdW2z
 oEnjkEzmiw+p8cOBHm5dF69taridxyBgMnMqnVmZYQ==

Yes, checked and their values are set as "Y" and there is no options about =
PCI power save in the BIOS=2E

Thanks=2E

> Sent: Wednesday, September 18, 2024 at 10:34 AM
> From: "Ping-Ke Shih" <pkshih@realtek=2Ecom>
> To: "Cem =C3=9CNAL" <cemunal@linuxmail=2Eorg>
> Cc: "linux-wireless@vger=2Ekernel=2Eorg" <linux-wireless@vger=2Ekernel=
=2Eorg>
> Subject: RE: RE: PCIe Bus Error from rtw_8821ce
>
> Cem =C3=9CNAL <cemunal@linuxmail=2Eorg> wrote:
> >=20
> > Thank you but this did not solve the problem=2E
> >=20
>=20
> After rebooting, have you checked the values of below?=20
> 	/sys/module/rtw88_pci/parameters/disable_aspm
> 	/sys/module/rtw88_core/parameters/disable_lps_deep
>=20
> If there is option related to PCI power save in BIOS, please try to turn=
 them off=2E
>=20
>=20
>

