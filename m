Return-Path: <linux-wireless+bounces-35121-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNnmDos652no5QEAu9opvQ
	(envelope-from <linux-wireless+bounces-35121-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 10:51:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E3438643
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 10:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3845302000C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8D39FCA6;
	Tue, 21 Apr 2026 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV+Bb8sL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9F2AF1D
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761464; cv=pass; b=Eg8Qg+i4DrtLM6xqJtOQqaq1a3P+fKz18KW39pxxKxXF5nY48hlN/Kc/CaoMn6+jPgTvgoFEHi1fSDtb0Zi8+qz8MGs5zeakqIf4AFuMh1XPcXK+RQofRKF6vVFXuRo2t+7MCcpS54UHXNdclkuxhr3gc0Y5l8Mf6FxDcmEEhXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761464; c=relaxed/simple;
	bh=y77IYP6Hfi6BU2wcOSiDcNLVbYrOD1kTkZMOUnLAzJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqjulcoWKUO0pPXe1PLgh/80MLnGUD1JtlPLQzfE7tE3gNx1f23HRr3pO/TaxS0l5VaTXAnd54sxMGCh33ddKGEr7yZw+LSz7R/oym9SStcpy8kLZGj4hdFccW99kkeDjbyi4Vk8KEEaIsBqb6dkIZepuIO9xFeag4UhMz60jaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV+Bb8sL; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ef2b7979so235051b6e.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 01:51:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776761461; cv=none;
        d=google.com; s=arc-20240605;
        b=GTBJi4F76neFA1sVjP8Wm1XpOUkSy8DfLmoFMFeu4f7q+DR/kMG12McEWSVVq0cyeu
         fDmVoCyWBkYfpRoky0O+draOA4oEstH8v8lHNY/WqgUV+cCYWIdgMN76sY4I3D0qlcCd
         6nvrm6nDdn2Np1FyPhjs87nbIqkd0XuwRcbc4M/rSlgm9kT/yxnVt2Ma91EY9IZ+iAp1
         XNE5O7Lmq8n6kS+Sgta1by/7mX6vAGWG/gvz7OgXXfEsimIaJQYzsZLaBo/A+sRAhnhR
         hhN4Kac9SR+hF+uFhK5Yk7hrHyyUfrcUTsVgnSjJWIgLkkAdxmCOKIMM0eVbZn7UJdLW
         W6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrXwOSjEWlXRCH3bSQkhhPPRUpo780ifbYsUKTYhEY4=;
        fh=tAkEC9qnlzGb3t1Mm4YpGMJKPNIA0kX6BrwQAn4jJhQ=;
        b=Ogld8i0n9MQ8hk5/UpCumy/a9H0zzP4x4ANz/DoiJns0wPm023yAI4p02GChy3JIpC
         liTqNo5UadttLRW68BX3i+96+OyGQ/U6peUt3AuV3Ku6WeKUvnSLEUkqeAj/MiWI+dTa
         IlFT0/AUb74vdmWTRvw1M5vrNz2LixsESZTQN+CmsEJ8S2eLQVHDr/WJZHB+TTVBkEQ9
         3oucKxUsloNW3zxnVXpVWmjrB+UnVZ7L9mmhWjm+KlF7/gQdzKD9ST2m0XnM3cFZJaUJ
         C2Rb1U1bp/hlTHOpE9sUnEBvvlfZZVnaVPKihfmqxXNbXyUtHDz5HU3rB49KdrqNOLM3
         b+Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761461; x=1777366261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrXwOSjEWlXRCH3bSQkhhPPRUpo780ifbYsUKTYhEY4=;
        b=XV+Bb8sLMG9kXgilN4sunJ3OPkamlh6R5tZjK1j9Lv3F7nyxzh8Zn+FFDnJJPSXXMu
         GewAhEB3TPSoYIe9Z6fAUOjnQuXNX51P9Y0hX/6K1xPdVAUqLzpPV96xZSrqKpEO57JB
         f16sFkiSAcS/wqsecqNt99hjmkg+EBA8AlDMJv/6Xnkbfd5nC35thQLWq7ePs2PROQ8h
         jhaYu+FnNUSwKIrAk3XbrRiDZ4LPAHfeWCF/1gAcmQadDJPn0uChp2euxH/JJsU0OHLT
         PJpLUCwUXXwevxXs52AkOeQQtlNBWZRZC1p3MMtkBbZSOE5R1PscX6MEMmTio8+wSFRX
         GoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761461; x=1777366261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrXwOSjEWlXRCH3bSQkhhPPRUpo780ifbYsUKTYhEY4=;
        b=cn9ibRNjue+I+jN8bN88vvgRru7WmFEyXIU7ddPDYLqqruAHeZSMgeS3ggmODbHLIs
         Y10QcSBBPSO+oUH4UQ9zhkGAKrpLF7EiWk0csP9TIKvKP/8oPcVCyq40o1h8mu4mIAnK
         ybDOW6aYf3fFO8Vv88mREePdHLJPcTo/MKO49yIaLB7bqe+A7HvpJm1nwJTdWBx1+YQ8
         /sn1N5k4Q0P1xPK6RFIzkEvr/djRoQNMOsUzoLhjEQr4IgGTsB1Uu66HQ5XN46b+ZIvZ
         gmLTusq/rLPR2HUopKNktlkwyv1sV1r3THpTaZrOlYg4qyO2Wo9vCQvc4L1rfXoqSeuk
         e7xA==
X-Forwarded-Encrypted: i=1; AFNElJ/zPb5L008BVFWb0iEVoM2vuqG+4uK8B56bwdbmgIXHBaDliOlpXtB85++WDdkH7g+/AEleuXZfZOr7j4cM2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYmqRx3qeoJ5f60rNRxSZuXeXtzk5ARS7WcrX6a+kng968a0J
	y0gOa/PNq9hVfJc922fJGqDz+DEGqlZgLAOn4OPARcYw7QLVdfVBaNBWzQRNRt5wY8dl/pelN18
	2CS9R8qtd80ZIUH+OzjT8lDPpIDszcjs=
X-Gm-Gg: AeBDietQOUHs+l97yBULDPfGQni7mj/K0kMgdBxEpDV57Phq66DHDLh6Q4+O1U3P/mN
	7tAflqHydF2kJOMAGmwdv2o+q3g9qtWipML3hq3cPS8SvBXMa0K7YZ+0iVX2Snc8KWqnccXQgLr
	POcQVVGKD6z/m0bizC+UmVQ87IC5l37YwlaIJPvD9y3lLlxxKSs8IEuCgeVSJR7flflQDMTIGMT
	dfToZQtgZtXJKv1arDkeMte3APdJqAKmKNVR8cZPvvz6UhnS9oDSsEeVAmrGJv7eZ9k1eGjR0+z
	XOGkcl2oY9v246KdSmA=
X-Received: by 2002:a05:6820:c8d:b0:694:85a9:d8a9 with SMTP id
 006d021491bc7-69485a9e0a3mr3899810eaf.46.1776761461337; Tue, 21 Apr 2026
 01:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrW0Z6NdFsUwycvRhLbe3xnbXSwmb24EW4FKFtn=0TVzBw@mail.gmail.com>
 <20260326013719.1662-1-fjhhz1997@gmail.com> <CA+bbHrX3CdXqW6b0GbY_C7rmte3_9Q=89TJN=A2EBCQM1xSzag@mail.gmail.com>
 <CA+bbHrUkGP5bX6SFVXLS-bTyHWUiRyHaSojvMW6RGPz+T55yHg@mail.gmail.com> <CA+bbHrVJz3O-2yUs-KJC5anADzqt-vA-5LNpu=nZsdxjRJ2U=A@mail.gmail.com>
In-Reply-To: <CA+bbHrVJz3O-2yUs-KJC5anADzqt-vA-5LNpu=nZsdxjRJ2U=A@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Tue, 21 Apr 2026 10:50:51 +0200
X-Gm-Features: AQROBzDLzt2nEeuvJml9b13__9hjzcZ8b-c7s6sxPrR06FTk8Dye17dQw-zo5Og
Message-ID: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix the issue of NULL pointer access
 when deleting the virtual interface
To: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>, brite.airgeddon@gmail.com
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35121-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 903E3438643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, I would like to copy Brite from the airgeddon team, who has
come up with a solution. I will include him in the email, and he will
send you a patch for you to review.

This patch has been refined after a lot of work and no longer has any
=E2=80=9Cside effects=E2=80=9D. At least, we have not detected anything unu=
sual, and
it has been tested extensively with many different chipsets. In any
case, it=E2=80=99s best if he replies to the email himself to explain it an=
d
propose the patch.

Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El jue, 2 abr 2026 a las 2:06, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Hello everyone, a member of the airgeddon team made a kernel
> modification that seems to work. I=E2=80=99ve tested it on VMware and als=
o on
> bare metal with a 7.0.0-rc5 kernel, using both a Fenvi AX1800
> (MT7921U) and an Alfa AWUS036AXML (MT7921AUN), and it appears to work
> well. Deauthentication during VIF operation (evil twin attack) is now
> working for MediaTek.
>
> Everything is documented at this comment in the GitHub thread
> (https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-4167080451)=
,
> including the patch used. A patch that is modifying these three files
> (tx.c, chan.c and ieee80211_i.h). Take a look at it  on the Github
> thread please.
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
> El dom, 29 mar 2026 a las 23:55, =C3=93scar Alfonso D=C3=ADaz
> (<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
> >
> > Please review my latest messages in the GitHub thread.
> > https://github.com/morrownr/USB-WiFi/issues/682
> >
> > There you=E2=80=99ll even find a link to a video I recorded so you can =
see
> > that even on bare metal with Kali Linux installed natively, it still
> > doesn=E2=80=99t work. It behaves exactly the same as it does in the VM.
> >
> > Here is the link
> > https://www.dropbox.com/scl/fi/i6h8xbls5xkvae0pitrbg/video_2026-03-29_2=
3-44-36.mp4?rlkey=3Djm48ly9tjwbhsi4aauml2auh9&dl=3D1
> >
> > Regards.
> > --
> > Oscar
> >
> > OpenPGP Key: DA9C60E9 ||
> > https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> > 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> > --
> >
> > El jue, 26 mar 2026 a las 13:16, =C3=93scar Alfonso D=C3=ADaz
> > (<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
> > >
> > > Hi, in response to the three points:
> > >
> > > 1. VMware
> > >
> > > 2. This is the output of the lsusb command: "Bus 004 Device 002: ID
> > > 0e8d:7961 MediaTek Inc. Wireless_Device". The adapter is very cheap,
> > > it=E2=80=99s a Fenvi AX1800 (MT7921U), this one:
> > > https://s.click.aliexpress.com/e/_okxhxNl . But as I said, the bug
> > > also happens when using the Alfa AWUS036AXML (MT7921AUN).
> > >
> > > 3. I=E2=80=99m not sure about this right now. I=E2=80=99d say everyth=
ing dies. I=E2=80=99ll
> > > test that to see if SSH is still available (I don=E2=80=99t think so,=
 but I=E2=80=99m
> > > not 100% sure at the moment).
> > >
> > > Give me a few days. I=E2=80=99ll test this again over the weekend. I=
=E2=80=99ll also
> > > run a test on bare metal (not in a VM). That said, like me, many
> > > people use VMs for pentesting. So even if it works on bare metal,
> > > which I=E2=80=99ll test this weekend, I think it would still be worth
> > > investigating whether it can be fixed for VMs, since many people,
> > > myself included, use them for work. If it works with other WiFi
> > > adapters, it would be a big drawback if it didn=E2=80=99t work with M=
ediaTek
> > > adapters.
> > >
> > > I=E2=80=99ll also reply with a similar message in the thread.
> > >
> > > Thanks and regards.
> > > --
> > > Oscar
> > >
> > > OpenPGP Key: DA9C60E9 ||
> > > https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
> > > 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> > > --
> > >
> > > El jue, 26 mar 2026 a las 2:37, =E5=82=85=E7=BB=A7=E6=99=97 (<fjhhz19=
97@gmail.com>) escribi=C3=B3:
> > > >
> > > > Hi =C3=93scar,
> > > >
> > > > Lucid-Duck spent some time trying to reproduce your crash and wasn'=
t able
> > > > to trigger it. Here's a summary of what was tested:
> > > >
> > > > - Kali 2025.4 (kernel 6.18.12+kali-amd64) VM on QEMU/KVM, with my v=
2
> > > >   patch applied
> > > > - MT7921AU USB adapter, passthrough to VM
> > > > - Full airgeddon evil twin flow: monitor VIF + hostapd AP + continu=
ous
> > > >   deauth via aireplay-ng
> > > > - Also tested on bare metal Fedora 6.19.8 with the same adapter
> > > >
> > > > All tests were stable -- no crash, no dmesg errors, load stayed low=
. The
> > > > deauth frames were confirmed sending for 30+ seconds under the v2 p=
atch
> > > > without issues.
> > > >
> > > > The one variable that couldn't be matched was the VM hypervisor.
> > > > Lucid-Duck used QEMU/KVM, which handles USB passthrough at the kern=
el
> > > > level (xHCI). If you're using VirtualBox or VMware, the USB passthr=
ough
> > > > path is quite different (userspace proxy), and that could potential=
ly
> > > > explain a total VM freeze that isn't a kernel panic.
> > > >
> > > > Could you please reply to Lucid-Duck directly on GitHub with the
> > > > following information? Here's the link:
> > > > https://github.com/morrownr/USB-WiFi/issues/682#issuecomment-412919=
8757
> > > >
> > > > 1. Which hypervisor are you using? (VirtualBox, VMware, QEMU/KVM, e=
tc.)
> > > > 2. Your exact USB adapter model and ID? (0e8d:7961 covers several
> > > >    MT7921 variants)
> > > > 3. If possible, try SSHing into the VM from the host while the disp=
lay
> > > >    is frozen -- if SSH still works, the issue is at the hypervisor/=
display
> > > >    level, not the kernel.
> > > >
> > > > Thanks,
> > > > =E5=82=85=E7=BB=A7=E6=99=97

