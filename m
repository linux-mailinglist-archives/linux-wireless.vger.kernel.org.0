Return-Path: <linux-wireless+bounces-34290-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJpTMxizzWnJfwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34290-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 02:06:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F5B381E40
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Apr 2026 02:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF090303A495
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2026 00:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64191D6BB;
	Thu,  2 Apr 2026 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDSbJ3mP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C493D76
	for <linux-wireless@vger.kernel.org>; Thu,  2 Apr 2026 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775088398; cv=pass; b=hEpKPHR9iEEAwF9LwU0ZFOcGq3eGEw0oI7IE0qFe2c4KsrgdmPCsVpeNBMz/dzFQjdHRlZlFxgfoylZUJkyrspFRHI2nUzJW4dJ9Z3EcdSzPmtHImUP/YfCaLnWckeSgWc5ENnP/cW5VjmS6zmmbllVYWrRs/3jBvgEa8Z8zDJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775088398; c=relaxed/simple;
	bh=O0OYsMIwEd8H7f9E5fN1GgEtlRnuCfuGvC2vlTz8Wg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3aNM3/wq26S8jifQkSKz/HoEqAh/alf9dtx1C/qoCNzxEiscKhDA/B3IbesKfgPhKfgp93si0gD4gIJRPLbPL44ejLmSh+ccbjLXv7SkIl0EwCAEPVYrbirfp3K5hnTJDteMrXiyHeLUTEi53ztK52veaqiZmxKD+x4BDPk8yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDSbJ3mP; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so237096fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Apr 2026 17:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775088396; cv=none;
        d=google.com; s=arc-20240605;
        b=OMUY9cntI7sY4TUf7aP18bp5dqpL1+jKl4efeU/sfgMJxa7tq6FuXgLHWut3HfWnt6
         pQpLQ9/wTal9hFWNkQQ2ifFcBSStIuQ4aOrMdwGpKmh1LBuwpzFF+uNyCF/g+OQ+Ar2S
         Q2LlYB8xQO4pUSGVuMa2Rd51UNYv7mJpGwo+DdlZ1IOun5068pzHq3ObnKBZRB9gOq9z
         OU6nVzUHUvmYt50UQCRklpqez425uM4/dTkdx5eKMm99Df1O2cICWkfM81Tlhd8oWE9D
         /aYxRVKEqlXvNIUPGU0z6sl8OPyUIZMVMkVSIyJF5ORXjo+GKjr8DScVgLYcxJHV1gFc
         rUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mpWXn4SZnXtspgXhXf3JzH5t6Yypg/td1HPrBJuBoAw=;
        fh=w88IcdmLse3yOkclIpgVqrQmVXT+q/SIKIjCbTrH4PI=;
        b=L0DhVGHSnIOPcoXaYGVkx09O104/BZ+3wzBqYULaazbNA8Ntuuq5hORTdK1VLhXJTA
         oD6zUBaY3ScOC2SSGwtZ6Xb8upE7cfddsp4RdLMpR0V8at/cUZEPNJYOp3yhzMmuaqwm
         SWsb4F3ZUh1a4dkmlZUkwma+ZTPH5mkNF8dN6baAhwGqRJc4V8+ijKRkLmkK/8cTmPMQ
         cmeZzCOyN147q/5tYLDwDhqbTvg2+zd9zcPPY+u/tiLhSY1LMLc9axGjbaTmDodV/NSC
         9qgSiTizNGnvZpsbcCh7P5+Yc6BvqSWubcbORzFC4akjKpIY/E6RUxBW+lnNdudBDGVp
         mbyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775088396; x=1775693196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpWXn4SZnXtspgXhXf3JzH5t6Yypg/td1HPrBJuBoAw=;
        b=FDSbJ3mPN8FOGrPqeghm83vzhqxz7YI/FCCRg7TQvN2AVc0hYNt5gM1JCmHpJJ6UTd
         ipmmj9bi3hT3ivIYSMcKxVMjWAByx7eiCRRUeukOq5asD6UsirEsC6q16rNKqNNqnBLE
         KgE7QjrO7KMp9eveDZe6hZZzDd2WC4tVgjWn2r4H/8vS4Oj+uLywLCGx97XPayFWqBnH
         3Rb+ghHR4C31wN0PYoX4tA4sqkfgP+RkDkBWLRq5ptCYma6U/hHu3JPTGd3DG0x9ilaj
         IHwC2aj5eiKG/H6jT8FzbAjpEFhHsqLNlEEKqps6pJa8rfroJBCI/FvcYIl7RF3K43UE
         1wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775088396; x=1775693196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpWXn4SZnXtspgXhXf3JzH5t6Yypg/td1HPrBJuBoAw=;
        b=DAP5pJXHl83el/I5J6/5uk7TP/9nYXKU13vFEB1pDj12xe/kX9CbQ0AY4n3zoEFaLO
         8YDv+lEDzYhjXdY6iGP+HH3zDLBhGwGRJzuKaOXdHAl+G5fm48YRYZ/oneJCImRaiMzk
         yxLdcMK4/KPM1yf0ekdBn0jiwRhEZ6s74DRjfm6AWgXcRHjOanGPL1LTjuYCTTI6o19h
         iW2FHRhhQE3HE7MwHv3r9/gB5P7GbLBRHsCsPtPZwWXj8f2Ts8WXeppspaN8IGyY68ga
         ciPEKQnRqSBXSh105CNdhN76kMhNvjP7psowxJz/xa7u3eLGKYetTr3si/GD+ORwuLhS
         xnZg==
X-Forwarded-Encrypted: i=1; AJvYcCU/MV2u11jT5+Ul/SZ7+zy2/s5InzYZtf+f6W9JsKqNdmSdPF9Z+x4UJElo5VJZTNT+MwJjuU9QoDxrRlkNLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0++hTPk6e3wcrH2I8+q0K57aF5mR+X4aJqskFd1PIupNX7r4
	Ix65Jrpl/le+gyyZ3fXzYGLMHj4qMvHPZYkUUjn/zVv8FxWoVY4xZZhOjNJxuy26U6IAbWtYlAC
	jQ7GjfhdvEWhLXZMsdaJ7rwBMXDpKar0=
X-Gm-Gg: ATEYQzxSYaSS/zgWoUvkFCvwFBUB3TWQVFH3YSzDkjMhFI0iQozNmD25wy54M4RfsPr
	IqZzJauG3YcCzub0u+cubWxM1IdHu2Oqeml3w5C54t8Jr2gXUffOkgkf9lEPaM8gz6y8PKw3rek
	KfzdCAUkb7oMXjXa54hxlVUVNP2cGchTRrXKSkzYSKhgrvBx01pmktWk1ZLNDAdxyanP+uFt6RE
	LIAyU/R1ds2X/Yyx5PpX0Z3++zLOA7Awr1t24teDgbwXdzB2EcKXic/NXYQB4Iyy2MJ5kO6HDam
	JJ329g==
X-Received: by 2002:a05:6871:3299:b0:41c:c7a7:b09c with SMTP id
 586e51a60fabf-422cfc2c2femr3404574fac.2.1775088396258; Wed, 01 Apr 2026
 17:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
 <20260326013719.1662-1-fjhhz1997@gmail.com> <CA+bbHrX3CdXqW6b0GbY_C7rmte3_9Q=89TJN=A2EBCQM1xSzag@mail.gmail.com>
 <CA+bbHrUkGP5bX6SFVXLS-bTyHWUiRyHaSojvMW6RGPz+T55yHg@mail.gmail.com>
In-Reply-To: <CA+bbHrUkGP5bX6SFVXLS-bTyHWUiRyHaSojvMW6RGPz+T55yHg@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Thu, 2 Apr 2026 02:06:25 +0200
X-Gm-Features: AQROBzAT0Y0bv8oxX_yBWRaxuN6l6zTfMNhCtZmCl9dIrOeGp4ouS7n9jw3qSQA
Message-ID: <CA+bbHrVJz3O-2yUs-KJC5anADzqt-vA-5LNpu=nZsdxjRJ2U=A@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access
 when deleting the virtual interface
To: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34290-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,aliexpress.com:url]
X-Rspamd-Queue-Id: 52F5B381E40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello everyone, a member of the airgeddon team made a kernel
modification that seems to work. I=E2=80=99ve tested it on VMware and also =
on
bare metal with a 7.0.0-rc5 kernel, using both a Fenvi AX1800
(MT7921U) and an Alfa AWUS036AXML (MT7921AUN), and it appears to work
well. Deauthentication during VIF operation (evil twin attack) is now
working for MediaTek.

Everything is documented at this comment in the GitHub thread
(https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4167080451),
including the patch used. A patch that is modifying these three files
(tx.c, chan.c and ieee80211_i.h). Take a look at it  on the Github
thread please.

Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El dom, 29 mar 2026 a las 23:55, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Please review my latest messages in the GitHub thread.
> https://github.com/morrownr/USB-WiFi/issues/682
>
> There you=E2=80=99ll even find a link to a video I recorded so you can se=
e
> that even on bare metal with Kali Linux installed natively, it still
> doesn=E2=80=99t work. It behaves exactly the same as it does in the VM.
>
> Here is the link
> https://www.dropbox.com/scl/fi/i6h8xbls5xkvae0pitrbg/video_2026-03-29_23-=
44-36.mp4?rlkey=3Djm48ly9tjwbhsi4aauml2auh9&dl=3D1
>
> Regards.
> --
> Oscar
>
> OpenPGP Key: DA9C60E9 ||
> https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> --
>
> El jue, 26 mar 2026 a las 13:16, =C3=93scar Alfonso D=C3=ADaz
> (<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
> >
> > Hi, in response to the three points:
> >
> > 1. VMware
> >
> > 2. This is the output of the lsusb command: "Bus 004 Device 002: ID
> > 0e8d:7961 MediaTek Inc. Wireless_Device". The adapter is very cheap,
> > it=E2=80=99s a Fenvi AX1800 (MT7921U), this one:
> > https://s.click.aliexpress.com/e/_okxhxNl . But as I said, the bug
> > also happens when using the Alfa AWUS036AXML (MT7921AUN).
> >
> > 3. I=E2=80=99m not sure about this right now. I=E2=80=99d say everythin=
g dies. I=E2=80=99ll
> > test that to see if SSH is still available (I don=E2=80=99t think so, b=
ut I=E2=80=99m
> > not 100% sure at the moment).
> >
> > Give me a few days. I=E2=80=99ll test this again over the weekend. I=E2=
=80=99ll also
> > run a test on bare metal (not in a VM). That said, like me, many
> > people use VMs for pentesting. So even if it works on bare metal,
> > which I=E2=80=99ll test this weekend, I think it would still be worth
> > investigating whether it can be fixed for VMs, since many people,
> > myself included, use them for work. If it works with other WiFi
> > adapters, it would be a big drawback if it didn=E2=80=99t work with Med=
iaTek
> > adapters.
> >
> > I=E2=80=99ll also reply with a similar message in the thread.
> >
> > Thanks and regards.
> > --
> > Oscar
> >
> > OpenPGP Key: DA9C60E9 ||
> > https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> > 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> > --
> >
> > El jue, 26 mar 2026 a las 2:37, =E5=82=85=E7=BB=A7=E6=99=97 (<fjhhz1997=
@gmail.com>) escribi=C3=B3:
> > >
> > > Hi =C3=93scar,
> > >
> > > Lucid-Duck spent some time trying to reproduce your crash and wasn't =
able
> > > to trigger it. Here's a summary of what was tested:
> > >
> > > - Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v2
> > >   patch applied
> > > - MT7921AU USB adapter, passthrough to VM
> > > - Full airgeddon evil twin flow: monitor VIF + hostapd AP + continuou=
s
> > >   deauth via aireplay-ng
> > > - Also tested on bare metal Fedora 6.19.8 with the same adapter
> > >
> > > All tests were stable -- no crash, no dmesg errors, load stayed low. =
The
> > > deauth frames were confirmed sending for 30+ seconds under the v2 pat=
ch
> > > without issues.
> > >
> > > The one variable that couldn't be matched was the VM hypervisor.
> > > Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kernel
> > > level (xHCI). If you're using VirtualBox or VMware, the USB passthrou=
gh
> > > path is quite different (userspace proxy), and that could potentially
> > > explain a total VM freeze that isn't a kernel panic.
> > >
> > > Could you please reply to Lucid-Duck directly on GitHub with the
> > > following information? Here's the link:
> > > https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-41291987=
57
> > >
> > > 1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, etc=
.)
> > > 2. Your exact USB adapter model and ID? (0e8d:7961 covers several
> > >    MT7921 variants)
> > > 3. If possible, try SSHing into the VM from the host while the displa=
y
> > >    is frozen -- if SSH still works, the issue is at the hypervisor/di=
splay
> > >    level, not the kernel.
> > >
> > > Thanks,
> > > =E5=82=85=E7=BB=A7=E6=99=97

