Return-Path: <linux-wireless+bounces-5163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD5887BD6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Mar 2024 07:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCFE1C20A83
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Mar 2024 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538F2CA4;
	Sun, 24 Mar 2024 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="gFO5IbBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED58BEC
	for <linux-wireless@vger.kernel.org>; Sun, 24 Mar 2024 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711260363; cv=none; b=tUaSefHc9VFlN/Dks6lyEP5Jjqsocrm4sgm03wVM4tlwzL89ShDp1jKmr4xZOSIseMA0MmR1VSR78igVbs0S4UShvXN2YQFSD8WLEJ9I+f4JHfR8TRU5IUCvWJxaX3crl0+M0Ru6gBcQQvunMKDpfmky/ZNOr/8YdvGsUYCmZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711260363; c=relaxed/simple;
	bh=3Qt1U1stu2skA20B4LZg3PtWR2Q7BXkgiKzuoM3GlE0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RP+ES47b0AwulIfssINOPFtmt1KZvN7rET+StA0WBOnrSuI8G9RSSXJtSmtSySzlloaselcpdhVtm7dt0dkiwKgCZwupVKlVlQsAObM49FIRMn0ret3235B2e9admKufTPuDYVwB0H56+TULVIzxK+Zktmrvpk9xhlZ6ygSh/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=gFO5IbBm; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711260353; x=1711519553;
	bh=Gj7oiZi2zy0q6f6O7DoUoqKsP+HrmPrKpNI3N8y09ls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gFO5IbBms+FfDzhGRBcPr7Kxj0XusuVImR4V96+929UagEhi9TShk0P0v1itLc0rU
	 mrMDhKmlE+ZbG+wVdR3gqhtMDbdboxEfZSDSteLPOVPLhZrhLqYTigYt8rc73cRzzF
	 A0wQaBwdmobyohrTd2IbcxRfRTyxwPOG5rWspJE3kCvJx4G3uxRw+/2CO8WO+2TMsR
	 GvsNiog2luTzOcWh7+h/McJnb09Kv6k0h5gWK0VzVRbtROufuZ6N1UW3wRaDA3g1tj
	 vUfxLlrJFDjPVuTpt/MzDXZzBcfE0pWU8u0Ampjwf00OKFc3GqzM2kz1X6jeFm4PAV
	 oZfP8iQVXq7Hg==
Date: Sun, 24 Mar 2024 06:05:34 +0000
To: Arend van Spriel <arend.vanspriel@broadcom.com>
From: Hranislav Milenkovic <hmilenkovic@protonmail.com>
Cc: Sebastian Gottschall <s.gottschall@newmedia-net.de>, brcm80211@lists.linux.dev, linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: bump
Message-ID: <5u7iu5Tx-lrkzwy-W394f9Xfoe8qo1rQr8LfxbwIk5IlHvovg9plHMapMXoJYQpKc5Ma9OKMR9tRN5uCPM5Fw_CrQe_k272jr6RRNx_bqnE=@protonmail.com>
In-Reply-To: <a83ce650-2b21-4efa-8b01-86bdbfddee94@broadcom.com>
References: <H1YMm0UlsCAAuLjY3yG9iqSb0G4tRSHoe0_-bLXMowq8eNCd7eW5Vs_D_PdO4KnriiKO5e5fehpmXmQPtAR9htqHRT5MgFZumadSikTcNWw=@protonmail.com> <3618d1dc-cdff-4336-b35a-26307fa7b51c@broadcom.com> <8c28Epkp0EJf_9cUpCt3bnVZDa6uAkGxy-Uuwkw-D9x3XLIelFLEzsdREBm6c4Acsrl8MH1pj7ADIEUD-A7a8DCi7h1LLQCAUQ_YKsut5Qk=@protonmail.com> <a83ce650-2b21-4efa-8b01-86bdbfddee94@broadcom.com>
Feedback-ID: 4710327:user:proton
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ah, ok... here is the output:

OPENWRT:

[hranislav@toshiba-laptop ~]$ sudo ssh 192.168.1.1
[sudo] password for hranislav:=20
root@192.168.1.1's password:=20


BusyBox v1.36.1 (2024-03-22 10:37:01 UTC) built-in shell (ash)

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------
 OpenWrt SNAPSHOT, r25604-494c5691c6
 -----------------------------------------------------
root@R8000:~# cd /lib/firmware/brcm
root@R8000:/lib/firmware/brcm# for f in brcmfmac43602-pcie.*; do strings $f=
 | tail -1; done
43602a1-roml/pcie-ag-splitrx-fdap-mbss-mfp-wl11k-wl11u-txbf-pktctx-amsdutx-=
ampduretry-chkd2hdma-proptxstatus-11nprop Version: 7.35.177.56 CRC: 548eccd=
4 Date: Fri 2015-09-18 03:31:06 PDT Ucode Ver: 986.122 FWID: 01-6cb8e269
root@R8000:/lib/firmware/brcm#=20


DDWRT:

[hranislav@toshiba-laptop ~]$ mactelnet r8000
Searching for 'r8000'...found
Login: root
Password:=20
Connecting to 2c:30:33:59:aa:79...done
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
=20
     ___  ___     _      _____  ______       ____  ___=20
    / _ \/ _ \___| | /| / / _ \/_  __/ _  __|_  / / _ \
   / // / // /___/ |/ |/ / , _/ / /   | |/ //_ <_/ // /
  /____/____/    |__/|__/_/|_| /_/    |___/____(_)___/=20
                                                    =20
                       DD-WRT v3.0
                   https://www.dd-wrt.com


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


BusyBox v1.36.1 (2024-03-21 07:18:48 +06) built-in shell (ash)

~ # cd /lib/firmware/brcm
/lib/firmware/brcm # for f in brcmfmac43602-pcie.*; do strings $f | tail -1=
; done
43602a1-roml/pcie-ag-splitrx-fdap-mbss-mfp-wnm-osen-wl11k-wl11u-txbf-pktctx=
-amsdutx-ampduretry-chkd2hdma-proptxstatus-txpwr-authrmf-11nprop-obss-dbwsw=
-ringer-dmaindex16-bgdfs-stamon-hostpmac-hostmemucode-splitassoc-cca Versio=
n: 7.49.6.0 CRC: 17a26fb1 Date: Sun 2022-06-12 22:22:41 +07 FWID 01-f458629=
d
/lib/firmware/brcm #=20



Hranislav Milenkovic
+381 (0)65 2026199

Sent with Proton Mail secure email.

On Saturday, March 23rd, 2024 at 8:40 PM, Arend van Spriel <arend.vanspriel=
@broadcom.com> wrote:

> On 3/20/2024 10:20 PM, Hranislav Milenkovic wrote:
>=20
> > I attached as many info as I could get like hostapd.conf, dmesg, build
> > versions/branch but commad you asked for f in brcmfmac43602-pcie.*; do
> > strings $f | tail -1; output nothing both on openwrt and ddwrt...
>=20
>=20
> The command should be executed in the directory where the firmware file
> reside, eg. /lib/firmware/brcm. Might be they are in a different
> location though.
>=20
> Regards,
> Arend

