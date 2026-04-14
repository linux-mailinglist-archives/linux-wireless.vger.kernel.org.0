Return-Path: <linux-wireless+bounces-34743-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APv8EVA33mlxpQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34743-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:47:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E44933FA237
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 14:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A498C30179F7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD6339A8;
	Tue, 14 Apr 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="fAzpenIg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78343E5ECE;
	Tue, 14 Apr 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170544; cv=none; b=bL1JUBbM/qwDxPm8tvua4kRFNMwpAxIOQ0ryhUJ5lKVFBo7X0Z75lHW+2ZynVhqAN//O3NwetGVzIm4+suzP7Ic3UDzOG3Dxdxiu8aMij1BgKfrvUnle/z0eDsEOYCJFGcPw/f2XakDpfr0tBCTiaMp3o7w9TvEqJ3yux+IAhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170544; c=relaxed/simple;
	bh=H9b1q5soDhblyiDBjSBP8bxpTr8ytn0bYGyZZ21Viag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZxc9UHKXALGUuhnXrdB+tTw7yXaHZO4/xV7YlPoNuBm0VZtqjp2Jpf7379FIMM0a/oq6MqbkQVnK7/D8AEl/vBN1b07/yGyo6P1PSwSjAjQNMmkLS9QmwXAG1HiyWSAT6dGXkhtOsILvAJ8Fy0RgwdfTDYpEryYdl40q5Qxrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=fAzpenIg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776170520; x=1776775320; i=deller@gmx.de;
	bh=t+TkXeWEba/XrFX3yATqWZDjmT7vuDDsgvIBT65AAhc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fAzpenIgpi3rVYugWOIkZZn0tIyFERuZsPfi46E8ZHN94Sc5kE/YMsjy3v3oWzr+
	 Qfw6wzuSGlr8dS591fcpDsbv+ftgBEfYXTWA19Pu5Qr8kDzb6JoPyy5SFw0BW3RPU
	 Bf7qFVm3pzevH2My1og5pLNoQKnQtHa91BakdZN1enkoxtKTBtqgakivdwpsPDDAH
	 mipzWdckMOOoOphH0+XzAK0gdPQo9m+Bf7rF7/pA/F9Qf88DJFr/uTkTD1UBnV5aW
	 RSF31i+XPMsy+XIHjnT28Gdk1G4bCiu1VG5V6QBFy2hV8AcN5VhDJvVPRgmTQV5Tl
	 60IPWSvmUUbh0PWVvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1vnwIX2Vas-00YsyQ; Tue, 14
 Apr 2026 14:41:59 +0200
Message-ID: <f0731727-fae7-4582-ad5b-a5d95b0d78ec@gmx.de>
Date: Tue, 14 Apr 2026 14:41:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 31/38] parisc: Select ARCH_HAS_RANDOM_ENTROPY
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <20260410120044.031381086@kernel.org>
 <20260410120319.658485572@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20260410120319.658485572@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZqOPGpEpMYOOKnwdNEQ7I3XH33yrIj2uNRXsp2/NoY4YKTm37d
 cWruVun3i7Sk4GIlBSCYmCwwqcNjragvIKsBHFI3iLQKRhUmXElNimqdOrFj4qhSzGCrQz5
 4Nl2leWKLE/WJTA3v6zYwlGFukOTRBLg+lyk/SmoPVxTH7cptbFjBFi4OyiaN9y5NYZwXCM
 E/BuuquGn8nLMTRaoFkig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:znJiATTqjr0=;C7ANzcgujBb/tqMadvALWw89Q6O
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34743-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@gmx.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:dkim,gmx.de:email,gmx.de:mid]
X-Rspamd-Queue-Id: E44933FA237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/10/26 14:21, Thomas Gleixner wrote:
> The only remaining non-architecture usage of get_cycles() is to provide
> random_get_entropy().
>=20
> Switch parisc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROP=
Y
> and providing random_get_entropy() in asm/random.h.
>=20
> Add 'asm/timex.h' includes to the relevant files, so the global include =
can
> be removed once all architectures are converted over.
>=20
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> ---
>   arch/parisc/Kconfig              |    1 +
>   arch/parisc/include/asm/random.h |   12 ++++++++++++
>   arch/parisc/include/asm/timex.h  |    6 ------
>   arch/parisc/kernel/processor.c   |    1 +
>   arch/parisc/kernel/time.c        |    1 +
>   5 files changed, 15 insertions(+), 6 deletions(-)

I tested this series on parisc.
Works as expected.

Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

