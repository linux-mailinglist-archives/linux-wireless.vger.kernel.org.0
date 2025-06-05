Return-Path: <linux-wireless+bounces-23725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E7ACE7FE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 03:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672881894B23
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE712B93;
	Thu,  5 Jun 2025 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK1y/bQ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997428EB;
	Thu,  5 Jun 2025 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749088137; cv=none; b=SEfMfRom0ku+4mDO1omFFncDAE6gQa6Z5MdfnPA6/lAcF00DYswMjDmr8IXv+bF6nz/IfABC3nWsItOmlUWSX87mHF8ztyJDilFRm8vyG7soATOGxqw4Vwk22tJaCKw0mT4ZwoHfmD9faJP5l3G8LPR+mOyyiRiYFcJkw1c3hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749088137; c=relaxed/simple;
	bh=P1aMTBsnJVSY/v90gEBryK00v+FDJaZ8jiV/JtTDAGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLuau5YobCtN4Q/UzTq/ibF5tdNTCVno7Ky4CNs0+XCbGHAFPd7bl6PGk+ZQPuX3DW8i3mTv+qiLNoG2PXWUvVl/u1s0GhmF2h/BaPUMOmODt6zDXK0Fj2zLDMZPeKiQhg7Gr6R8ZzpqdZYTzIieaX5WzlyXscfQ03YImkH8gmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK1y/bQ2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so521736b3a.1;
        Wed, 04 Jun 2025 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749088135; x=1749692935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=by+7BIPkkw8WZPU+Sg0JjlCtfySnrdWiSJR+X3EkEx0=;
        b=iK1y/bQ2YpDP4bsrzkfM6XVpSUh6ZpCjbVNcaw08RpMbMscUYBSdBfvpc3WQ+XcGr+
         dUcbgbVg70ZenQBCuL2j5tatoymPhrtDEUVmhOxV+SnI8qh4JPUunOG4xPgUkwGBVBAK
         VmIMiAyo1Qdw1WGMNQIUy4kJJpLZF5Y+DDShHv44oYaq0UeyKqzettweNI271wLNRRU5
         5N2RNq8IaYQJz+E3Cv34oQK4j3k6tSV8a+XzLkoax5z7t3Xzjs6OIRFEV/+9FZnQUr0f
         1oqpnzKUGf69g/DEPnu6Y9snPucrp/gnIxKpW928Z4w6SwWLPxkX8PpXxjBoO8SVc2vy
         qCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749088135; x=1749692935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by+7BIPkkw8WZPU+Sg0JjlCtfySnrdWiSJR+X3EkEx0=;
        b=odGsR1tFaX7jUvkfdTj4Z/zHiYMxU1uVf69Jai3PKHXgWWJcKW6nIGsscIzquDV0I+
         0lLa6URwrHnPIdmH8wd4u12rPRuUOpRGFeH50VOwVjFxwtICakJj3QHYeTy9tz2D5ZDN
         50yqT/YyYd4CvEOfAQKbGikyKMku6usIGnywcdbfdqTu/dc72AFpvcRVpjE+/NOfnHQF
         weJ2sUXyVk4LMKl/tbP2qGfR572LFlkJhac0WnUCl1juttGEgPCswfn7Aq5fAcAbq0QC
         o+C/IMrJtG/LDTtfZXbo9MGxb3WJxUs81Rjnhg2kVCKiHCcadm/aXr+pdVPBXoz/KN67
         muew==
X-Forwarded-Encrypted: i=1; AJvYcCV+NuUOoa1vAwKUnvp1emndHLOMGbqtw7HojHvVRnDj7bOyIQZ/Wmyk2GhFBQ0JiABVjz6Kp+GT/KC3Mu8vx7k=@vger.kernel.org, AJvYcCVs7//1ydCDiMPCb2AoFIkbpJw15Iao5Bc4/r7DmqLlJNYojzwrgWfEXmf6fwrHWN5J7Zd8IwVxUplOneQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaY0TO4QsYZI23mrZb8to+fhDkNqr03OhP2QL/aYAOradR0Vcj
	etxejSfLtZB+C6gUNMNWlQhpF+Y4V1J6L1AwljUyi9sJFLDdlGfpE7tlHsf1Yg==
X-Gm-Gg: ASbGncv0hUOO5Yb0gEaOBip2wFuk9BPv3JTwbPybqzTUK8ndbepU2lDjBpkMiWWijoh
	EPntd9mqg+mxeAftbrIPE56WDJjPQXcJpi9E7TYpnIbyTJDoZeNMpUjLirU4I+DJwChyg0Kg0Ve
	UTJ6IPvGUo06wk/Z3ey4Mzyw3Yi8/AAFE8DowGoXfnlP57w6qhOCIqF5RyH6RKJIVuZU1vxBbLt
	mPkp8FKXp9vZT2N7EKlDrqL5v8bcCgjs2bNYmV4O3WQdpMHD7VuYX6OQHjK4b/MrFfHhXOf+XpS
	M4nmO5raZsa+3TAJfJPhB1Yj066MqW0Gv6CmFiknPfGe2g/v8qUxEjfLbwELKahyB8rgumFWeqW
	+JBr9E04=
X-Google-Smtp-Source: AGHT+IHV8YHr0uXpF/OHEsa+kL8AF1LWep7wKAP7SEElccAGzTR4C5CaMZdh2g0nGrxO21JkO9tM4w==
X-Received: by 2002:a05:6a00:813:b0:73c:c11:b42e with SMTP id d2e1a72fcca58-7480b4216b7mr6876405b3a.20.1749088134902;
        Wed, 04 Jun 2025 18:48:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafd60sm12220612b3a.97.2025.06.04.18.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 18:48:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B13AD4209E8C; Thu, 05 Jun 2025 08:48:50 +0700 (WIB)
Date: Thu, 5 Jun 2025 08:48:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Alex Davis <alex47794@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: Re: Latest kernel firmware update breaks intel wifi card.
Message-ID: <aED3gmw0xqm_lMRQ@archie.me>
References: <CADiockAtCnLdN1rWTRuMeyuQisAWRyosG_K64AQSdVr-k7CLug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KVPUsnhqMaipHaNp"
Content-Disposition: inline
In-Reply-To: <CADiockAtCnLdN1rWTRuMeyuQisAWRyosG_K64AQSdVr-k7CLug@mail.gmail.com>


--KVPUsnhqMaipHaNp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: iwlwifi folks]

On Wed, Jun 04, 2025 at 05:20:31PM -0400, Alex Davis wrote:
> I have the following card:
> 2f:00.0 Network controller: Intel Corporation Wi-Fi 7(802.11be)
> AX1775*/AX1790*/BE20*/BE401/BE1750* 2x2 (rev 1a)
>     Subsystem: Intel Corporation BE200 320MHz [Gale Peak]
>     Flags: bus master, fast devsel, latency 0, IRQ 19, IOMMU group 16
>     Memory at aa800000 (64-bit, non-prefetchable) [size=3D16K]
>     Capabilities: [40] Power Management version 3
>     Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>     Capabilities: [70] Express Endpoint, IntMsgNum 0
>     Capabilities: [b0] MSI-X: Enable+ Count=3D32 Masked-
>     Capabilities: [100] Advanced Error Reporting
>     Capabilities: [148] Secondary PCI Express
>     Capabilities: [158] Physical Layer 16.0 GT/s <?>
>     Capabilities: [17c] Lane Margining at the Receiver
>     Capabilities: [188] Latency Tolerance Reporting
>     Capabilities: [190] L1 PM Substates
>     Capabilities: [1a0] Vendor Specific Information: ID=3D0002 Rev=3D4 Le=
n=3D100 <?>
>     Capabilities: [2a0] Data Link Feature <?>
>     Capabilities: [2ac] Precision Time Measurement
>     Capabilities: [2b8] Vendor Specific Information: ID=3D0003 Rev=3D1 Le=
n=3D054 <?>
>     Capabilities: [500] Vendor Specific Information: ID=3D0023 Rev=3D1 Le=
n=3D010 <?>
>     Kernel driver in use: iwlwifi
>=20
> With the current firmware, I get the following error in dmesg:
> iwlwifi 0000:2f:00.0: Detected crf-id 0x2001910, cnv-id 0x2001910 wfpm
> id 0x80000000
> iwlwifi 0000:2f:00.0: PCI dev 272b/00f4, rev=3D0x472, rfid=3D0x112200
> iwlwifi 0000:2f:00.0: Detected Intel(R) Wi-Fi 7 BE200 320MHz
> iwlwifi 0000:2f:00.0: Direct firmware load for
> iwlwifi-gl-c0-fm-c0-93.ucode failed with error -2
> iwlwifi 0000:2f:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.182.4.1
> iwlwifi 0000:2f:00.0: loaded firmware version 92.67ce4588.0
> gl-c0-fm-c0-92.ucode op_mode iwlmvm
> iwlwifi 0000:2f:00.0: Detected RF FM, rfid=3D0x112200
> iwlwifi 0000:2f:00.0: loaded PNVM version 71864399
> iwlwifi 0000:2f:00.0: Microcode SW error detected. Restarting 0x0.
> iwlwifi 0000:2f:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:2f:00.0: Transport status: 0x0000004A, valid: 6
> iwlwifi 0000:2f:00.0: Loaded firmware version: 92.67ce4588.0
> gl-c0-fm-c0-92.ucode
> iwlwifi 0000:2f:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
> iwlwifi 0000:2f:00.0: 0x000002F0 | trm_hw_status0
> iwlwifi 0000:2f:00.0: 0x00000000 | trm_hw_status1
> iwlwifi 0000:2f:00.0: 0x002C43D6 | branchlink2
> iwlwifi 0000:2f:00.0: 0x002B89BE | interruptlink1
> iwlwifi 0000:2f:00.0: 0x002B89BE | interruptlink2
> iwlwifi 0000:2f:00.0: 0x00015ADA | data1
> iwlwifi 0000:2f:00.0: 0x00000010 | data2
> iwlwifi 0000:2f:00.0: 0x00000000 | data3
> iwlwifi 0000:2f:00.0: 0x00000000 | beacon time
> iwlwifi 0000:2f:00.0: 0x0001A67A | tsf low
> iwlwifi 0000:2f:00.0: 0x00000000 | tsf hi
> iwlwifi 0000:2f:00.0: 0x00000000 | time gp1
> iwlwifi 0000:2f:00.0: 0x00046F7B | time gp2
> iwlwifi 0000:2f:00.0: 0x00000001 | uCode revision type
> iwlwifi 0000:2f:00.0: 0x0000005C | uCode version major
> iwlwifi 0000:2f:00.0: 0x67CE4588 | uCode version minor
> iwlwifi 0000:2f:00.0: 0x00000472 | hw version
> iwlwifi 0000:2f:00.0: 0x58C80002 | board version
> iwlwifi 0000:2f:00.0: 0x800CFD1B | hcmd
> iwlwifi 0000:2f:00.0: 0x00020000 | isr0
> iwlwifi 0000:2f:00.0: 0x20000000 | isr1
> iwlwifi 0000:2f:00.0: 0x48F00002 | isr2
> iwlwifi 0000:2f:00.0: 0x00C0001C | isr3
> iwlwifi 0000:2f:00.0: 0x02000000 | isr4
> iwlwifi 0000:2f:00.0: 0x00000000 | last cmd Id
> iwlwifi 0000:2f:00.0: 0x00015ADA | wait_event
> iwlwifi 0000:2f:00.0: 0x10000004 | l2p_control
> iwlwifi 0000:2f:00.0: 0x00000000 | l2p_duration
> iwlwifi 0000:2f:00.0: 0x00000000 | l2p_mhvalid
> iwlwifi 0000:2f:00.0: 0x00000000 | l2p_addr_match
> iwlwifi 0000:2f:00.0: 0x0000000B | lmpm_pmg_sel
> iwlwifi 0000:2f:00.0: 0x00000000 | timestamp
> iwlwifi 0000:2f:00.0: 0x00000024 | flow_handler
>=20
> When I use the file iwlwifi-gl-c0-fm-c0.pnvm from the previous
> version, it works. I'm running kernel 6.12.30 in Slackware current

What firmware versions?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--KVPUsnhqMaipHaNp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaED3fgAKCRD2uYlJVVFO
o7fOAP4gYZ8wbhKTkxmGANJUXc5ckfnpKCTwF31wEnUcPN/ewgEA0o0GPsWmnMdJ
0sI7xax5GaA3vFJrSPh99/4N++27iQI=
=QU/g
-----END PGP SIGNATURE-----

--KVPUsnhqMaipHaNp--

