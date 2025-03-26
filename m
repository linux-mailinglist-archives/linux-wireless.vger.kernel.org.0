Return-Path: <linux-wireless+bounces-20860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3FA71DFB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B7616E0B4
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15824EF75;
	Wed, 26 Mar 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jwollrath@web.de header.b="Eos81tew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912EC24EF7D;
	Wed, 26 Mar 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012397; cv=none; b=lGywtpWVnGIDn3LT7bsRDUeMPBVRr8FWEfGvsNptk3EzFHjE0Qjzq/DH1P9i8/QfGr7zIKwwoYKHWSJ7yQsXBCnSkLCZeQlRyLoWHJ0fPFc4XDgJ72tT+IrBgpefwVNtXWi84EQNggREK9Wm2v/S0qAyVEiurc3exgzNcqEBtRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012397; c=relaxed/simple;
	bh=gbjKAFgB71V9E3Bslr8DsOC6gEuRlewbUsD3uvKJu6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn14RdtlIr0UyCvyJHh+Sq1TkkKRBVgls4AY5En7TwXS0RJydMrcmHivlIPMOsxCdb0H9HpUGkH27zeBnCZVa0E4gj0JBMbWUqY/5VCpA0ux7YLCZU8KvCkjqVo7xAvk8krdLoK9+uFBfPYxyJhC7ocuQ7XYzITvwfgFlyYt97w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jwollrath@web.de header.b=Eos81tew; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743012375; x=1743617175; i=jwollrath@web.de;
	bh=bpRhe6RCKqjpwMwkouG+nGcRPzNhh2JSM9SYfRCWoAw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Eos81tewP6FLrCWlbSdLx+8Hb7BFMxEswteE84RUz5HRCG90kWVE8ySt5pmg6zod
	 epP9lXjgNcBCOfPcDDHXwm2fEhFf/NhJv+xiF0WHvO29OzYmdpgYrM5rnEvoKzI0t
	 vrMxAaepJLhet3mF3RaUG+U49ke7PY6SddOELerXhW0irh4cV+ntUey+DUzbBFxBW
	 n+eZc6B3R+zc6GjoelrLUOg0jPWcP43c7fpLPdpiXv8tq+adlyerk0kMoQyYewLjK
	 qG1iXxCQZ1mr9vrrZO+7pA96wfKnYI4lS2u7+jzAEiB/cPSuz6bkD4fhK51plqM8s
	 IU5WlKJ1Jpk9IdROSw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mayene ([178.195.12.4]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Pda-1tzA6K3iMY-008mYC; Wed, 26
 Mar 2025 19:06:14 +0100
Date: Wed, 26 Mar 2025 18:48:27 +0100
From: Julian Wollrath <jwollrath@web.de>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Muhammad
 Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH ath-next v2 0/6] wifi: ath11k: bring hibernation support
 back
Message-ID: <20250326184754.0ca1e54d@mayene>
In-Reply-To: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
References: <20250326-ath11k-bring-hibernation-back-v2-0-87fdc2d6428f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XKlqPR7CaYFNVTeUed8hujZfTgJ3sgDDS1VsGg5S/aYXvpRCQSU
 hDKheiL0r7qwRqEAHRBZV9VgtB/PrVZqvQBBq0K903ZqLk7KZ0LrcUoANfuTOyab015H9j7
 NehcQSyK9Of1IwPuYvdv1qi+6vUN3ub81KVgG+Sev25r5vsg67aR0ooVwF+fmFd3grx8PHT
 5AEbLCzAcnq0jCSk47cLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wg4lQbYzcsk=;QSlL76JITTF3FjDt65v9xEBXzYI
 zrl1LC9yaIXU0mgcEXVJUXuxklNOTSv3/wCgUfhNd47YVa6+T4ZPk9P4i7Upoj49VlBcUodf9
 Ksj9+/lLie6ZXRR7QdouGcsoLQwaoXhBYahUDs0uFXnyxkt9xabEBYbqvtviOudMGZyi/s41w
 VSpoMNbPZXSVLThlqjlc5vu2P8Fl6a1Dv5pbNd+9BiPeoZyPnxtekBP9yOqgiqqWAhNAefQnw
 unTyF9AEfMMEPLLSuhJY4X9fq8G9BYkg4L9o3MUKLrDhRuMJAJm4YJCfh32kW6I/1/xwin0En
 EF3NHovUNCam8/Ee53V29RZwBkWGbi/x9o80XLWwy1ZO3udbP90MRT6LsGx+WY7O7tBBXvR0O
 HWQ9N4kPjvZNhKG4Ig0IBTC8i1F6LZdoVyylgaSZnp6eDpTtZgjeY17f+09+oypWu1C6erFX0
 3mRe5Y5g7njMcKuSKrbfHgjJ+xqTsj4jXGiBILRVbaSetNhA3d33QfpcyMlGZgmOXrfpvkgr9
 CV0Lk45fNUCxw2l6CjaXWGHOXLavPqlaAbdsk/7MDfwTzD4L2BSAYf61H3j++r/xwNM/xVnEK
 g6P9a9iGIHNRXUaXZhzj2peFFDHrIk4L97igFl5BTwrKUOEKe4UAVHtIZM3v1EBHA1KT3sn5m
 pFGCdj5bTJFGO3UllQLpsZD9Z+vJ3vz7XKVcK/K88tG4B33l4lCp7L5qNYBEl7zNw9tOub7eX
 N2V8KIPVo2pvPG/QNJONcr8q3q/MsDPQzolvdn4wLP5x5k8/ZAChhgoh07kGgOd58lDnkuen3
 qXaSaNN7q0nJhhyUQCaEFqbL6i33qDJ/XyD7yMF8m5Y90oVNA6f1lsBulHeVkxnDNUllBPTdU
 SNj8p5y8ufDunWt0RNonN2kyLG1CDQbCUVxk9+0s6z+Y4/ziDNe7alray7GzNmVSaiNSegCMr
 H+bFBHPdnQoqBsbed0FfRkMsbqCYCL+50THDdNKbVqpnQTUG1HFR5CRAcaqhS3x9eYyR/JTZv
 Vhe4MmMGXeo6Aq2cNeMggXEGZ+G3cjQVLktLOjp1pwA3kiCIYzr4H5wykflB4Nh0qPakKaOmh
 FtcuagQv+AURc6++62Wb6JEBzOehPK6x4GCB7lEUU52OP84vcPxZaJ6JvPSlY4NBxvPdv+ROd
 hGzKbPPtihRSbulmcZjxreqOU5sG/wiSdmJxzeJEEVR50zbpnoPneaXBsR7BTuhqDRrxFqxGl
 IEkUWKT3/e3cvio7x4TAEkL8skEaln7tFkKbTsA0XeEBEhaDmQnezSv+fVYq51njdrIZd5byM
 czneFwgc65yBnsgX29JWnQH0iXoSYWTYGQ9M1TTePgpDVP85uVLNtrLMUoDbcuJgk9FfGmwl3
 3YyBuGlVluaXtwJfb7Du3XbuGkvy9wHhAgxCaJdU0/jkWMZD0JblcH65ZlWkv7oSwYBXidNiX
 2+KebJQ==

Hi,

Am Mi, 26 M=C3=A4r 2025 09:33:04 +0800
schrieb Baochen Qiang <quic_bqiang@quicinc.com>:

> To handle the Lenovo unexpected wakeup issue [1], previously we revert
> commit 166a490f59ac ("wifi: ath11k: support hibernation"). However we
> need to bring it back, of course with additional changes such that
> Lenovo machines would not break.
>=20
> For suspend (S3), as those machines work well in WoWLAN mode, the
> thought here is that we put WLAN target into WoWLAN mode on those
> machines while into non-WoWLAN mode (which is done in the reverted
> commit) on other machines. This requires us to identify Lenovo
> machines from others. For that purpose, read machine info from DMI
> interface, match it against all known affected machines. If there is
> a match, choose WoWLAN suspend mode, else choose non-WoWLAN mode.
> This is done in patches [1 - 4/6]
>=20
> For hibernation (S4), non-WoWLAN mode is chosen for all machines. The
> unexpected wakeup issue should not happen in this mode, since WLAN
> target power is cut off. To know if the system is going to suspend or
> to hibernate, register a notifier such that kernel can notify us of
> such infomation. This is done in patch [5/6]

with this, I just want to confirm, everything now works as expected
after hibernation.


Best regards,
Julian

>=20
> The last patch bring the reverted "wifi: ath11k: restore country code
> during resume" commit back.
>=20
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
>=20
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> Changes in v2:
> - fix compile warnings
> - support hibernation on Lenovo machines listed in quirk table
> - Link to v1:
> https://lore.kernel.org/linux-wireless/20250320023003.65028-1-quic_bqiang=
@quicinc.com/
>=20
> ---
> Baochen Qiang (6):
>       wifi: ath11k: determine PM policy based on machine model
>       wifi: ath11k: introduce ath11k_core_continue_suspend_resume()
>       wifi: ath11k: refactor ath11k_core_suspend/_resume()
>       wifi: ath11k: support non-WoWLAN mode suspend as well
>       wifi: ath11l: choose default PM policy for hibernation
>       Reapply "wifi: ath11k: restore country code during resume"
>=20
>  drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
>  drivers/net/wireless/ath/ath11k/core.c | 294
> ++++++++++++++++++++++++++++++---
> drivers/net/wireless/ath/ath11k/core.h |  16 ++
> drivers/net/wireless/ath/ath11k/hif.h  |  14 +-
> drivers/net/wireless/ath/ath11k/mhi.c  |  14 +-
> drivers/net/wireless/ath/ath11k/mhi.h  |   5 +-
> drivers/net/wireless/ath/ath11k/pci.c  |  45 ++++-
> drivers/net/wireless/ath/ath11k/qmi.c  |   4 +- 8 files changed, 350
> insertions(+), 46 deletions(-) ---
> base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
> change-id: 20250324-ath11k-bring-hibernation-back-e11ad8e82adf
>=20
> Best regards,



--=20
 ()  ascii ribbon campaign - against html e-mail=20
 /\                        - against proprietary attachments

