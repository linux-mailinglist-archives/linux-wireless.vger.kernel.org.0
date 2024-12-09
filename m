Return-Path: <linux-wireless+bounces-16034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F69E921B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521522823E8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FFA219EB1;
	Mon,  9 Dec 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9jMzoBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B6219EA1;
	Mon,  9 Dec 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743426; cv=none; b=a1GJC1ih4TCXELkwBswzM/fAS5wmEAjplCegt4rzLCPVuy6YyX676NPmC4WM+aQDIM1uIZGz3BgAKf07gAqh5ZfpX1v1r5/GcScmuNg65uWyt5/dM/oVCDbtBOH6KL4dpEMSmb+Krtxyz2oJkTcyHFcHhmBaPbN9SuBB7sPCDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743426; c=relaxed/simple;
	bh=6jpdGdgWWpxlvOI2MzFO+lVqIN1ePLo95nTR5s9bRws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnOESfj7HTVVas1pYzTIIoqiIw+fxdE75kFRY2HQmuWZ7S84mNYemgmGaa+pMQ+ZqeO/zqaR25X+V83p1CDNpeoIBc9KffkkT/rh2lQtYoJ18yS5TlfaSaoEMSCzSAs7O0kPFHqmwgc3xQDBjlXYWF377yu//zY8PwhGtvzQUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9jMzoBL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso2326559a12.3;
        Mon, 09 Dec 2024 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743423; x=1734348223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf+IKqMd4jWP7PDOCpVWhE6CrZFz+9D4Dw7c3vH6cEo=;
        b=i9jMzoBLZonJeFvSxTvsPWpGiJ9n2a/DqpEBiK+Uotn+HtP1e5O4sbjquRqOo0mbsh
         4hKu8EmhWQDNRwvO17fs2hXXsoqCHnuG2f2B3if5aR7Rq3L0WfFqxr0woofdzb2nrZaP
         7xNFhlyWpLGnF2CX6TRzHIa3mKgbJnRQKbTNjb2sYGaEzJnpJWhTy4AMEHnOxT0GZpmv
         fL/bc115to32pz6mPvDtJMqVuDPI4qvVJK+hxYyA4chW8dsv+wLRBo/OD7S2+GmzOz0S
         Il7dAD3y10XaB9lR8xI9pvgm7iFMizUX4bttBhQJi3UeVQbsl5EvNlj2xAeLqHgu/FR0
         MWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743423; x=1734348223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf+IKqMd4jWP7PDOCpVWhE6CrZFz+9D4Dw7c3vH6cEo=;
        b=U1M7pdIxetecTO7+kZ00eVeQG1K/DQ6emipjHfjq1tS7KMHjAJEMOhyCBZJp129pTA
         j+ykkifWLSXYR/lbsmfK7c1opwkxFPban0Dsa83JsakAUsTfUTVyWlbf4nwyle/hhjQy
         byHEqqRY+HPu0h6qIviyzjU4p9VzUbF1VExCH+5OPUevF03KoXc7EdldwBa4BBhKH4ok
         rr2ut+d0N2gWywa+YE9Nh5AHysdnV0hV9MbsOGqd+s8bpdPyix2lP5qgjwipD+eMlJiM
         ssOJrbnZF6mXJkaWcZuNuEmBv5SmeseYCjsHpFYWRPF2S6s9BAlRH5Scyd9Twx0msSgP
         tH7A==
X-Forwarded-Encrypted: i=1; AJvYcCURLMS6PEOx+mZ5GRY1KMLDS8smmubB4bnAjLMwHse+Ts9ET6OOEQtqaTkdWn9xZpY/u8e+hy1NPWJ4nV0=@vger.kernel.org, AJvYcCX3fPj23BPtX98E27S1bp6RJrSwRHqJk1ufp/X7tHRV31m3OtAmFdoEWS3gElgiy3j2kDHHfen2mPyRKwf4j4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfLEZkjoBSuERWecnT22BxIVNOKJJp9kq6Iqv+XmIznGrL2E2
	34r/x0aJVaRAfg+Sv1ZwHUdNr9IIMajT0E696Z/Li6MU/YYz1zkjYIAj4fc64SZO2q14lW/++ME
	UaTVbPBjpIu7ZsnPIiFjfOQ879H0=
X-Gm-Gg: ASbGncvY2nFUpRXRzMm0looPWUXFTAFgUDa7p77RHqFJWiKxbRibHkJ9936elgMpyrd
	H1dxvkmUSIVBpmGmpb9mDo+F/zTJ+yGILbQ==
X-Google-Smtp-Source: AGHT+IH2cTojVaNjg6f1XOAo3y7FAUwBnB3zsEJ0j7YM43+fRPIRPXFJpkVI999WVguOEAF19y8Qup5SYSTPKeqAtOg=
X-Received: by 2002:a05:6402:51cb:b0:5d3:baa3:28a with SMTP id
 4fb4d7f45d1cf-5d3be65a53fmr10464855a12.1.1733743423083; Mon, 09 Dec 2024
 03:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20bf2693-ce53-48e9-8b54-7e3273815033@quicinc.com>
 <20241203094820.106225-1-jtornosm@redhat.com> <99359cc4-2279-4a8a-80a1-d5475fd5208d@quicinc.com>
In-Reply-To: <99359cc4-2279-4a8a-80a1-d5475fd5208d@quicinc.com>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Mon, 9 Dec 2024 12:23:32 +0100
Message-ID: <CAFED-jk--dXAoXJ9ijpnUDeD=WiW4ZeoLb45WXiVpzPvkgX12A@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: allow APs combination when dual stations
 are supported
To: "Yu Zhang (Yuriy)" <quic_yuzha@quicinc.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, ath11k@lists.infradead.org, jjohnson@kernel.org, 
	kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, quic_cjhuang@quicinc.com, vbenes@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 3 gru 2024 o 11:57 Yu Zhang (Yuriy) <quic_yuzha@quicinc.com> napisa=C5=
=82(a):
>
>
>
> On 12/3/2024 5:48 PM, Jose Ignacio Tornos Martinez wrote:
> >> Which chip do you use?
> > Since I am not totally sure about the useful information, let me show y=
ou
> > the kernel logs:
> > $ dmesg | grep ath11k
> > [    3.659388] ath11k_pci 0000:01:00.0: BAR 0 [mem 0x84200000-0x843ffff=
f 64bit]: assigned
> > [    3.659405] ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> > [    3.659649] ath11k_pci 0000:01:00.0: MSI vectors: 32
> > [    3.659653] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
> > [    4.871571] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb boa=
rd_id 0xff soc_id 0x400c0210
> > [    4.871586] ath11k_pci 0000:01:00.0: fw_version 0x11088c35 fw_build_=
timestamp 2024-04-17 08:34 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_=
SILICONZ_LITE-3.6510.41
> > [    5.241485] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
> >
> yes, you also use wcn6855 hw2.1.
> > If I try to setup 2 APs with your interface combination I get this:
> > # iw list | grep -A6 "valid interface combinations:"
> >       valid interface combinations:
> >                * #{ managed } <=3D 2, #{ AP, P2P-client, P2P-GO } <=3D =
16, #{ P2P-device } <=3D 1,
> >                  total <=3D 16, #channels <=3D 1, STA/AP BI must match,=
 radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 80+80 MHz, =
160 MHz }
> >
> >                * #{ managed } <=3D 2, #{ AP, P2P-client, P2P-GO } <=3D =
16, #{ P2P-device } <=3D 1,
> >                  total <=3D 3, #channels <=3D 2, STA/AP BI must match
> >       HT Capability overrides:
> 2 combinations are to support DBS and DFS.
> Combinations is correct. channels=3D2, max interfaces=3D3.
>
Small question from my side. If phyX will support 3 bands (2.4/5/6)
what this channes<=3D2 limitation mean here for APs?
 a) can I setup APs on 2412 and 5180
 b) or even can setup APs on 2412 and 2462?
 c) or setup APs on 5180 and 6055?
How could I know a or b or c is allowed?

BTW, do you plan to share same firmware (with 2 possible APs) for
ath12k and WCN7850?

BR
Janusz

> And you want setup sta + sap + sap, right?
> When up the second sap will meet error? Could you pls share the error log=
s?
>
> I'm not very sure if you add all interface with managed type, and do
> "ifconfig xxx up" before running hostapd.
>
> You can try add second and third interface with
> "iw dev xx interface add xx type __ap".
>
>
> > # iw dev
> > phy#0
> >       Interface wlp1s0_1
> >               ifindex 6
> >               wdev 0x4
> >               addr a2:42:d2:1e:89:a3
> >               type managed
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >       Interface wlp1s0_0
> >               ifindex 5
> >               wdev 0x3
> >               addr 52:e9:be:33:6a:61
> >               ssid test-qe-wpa2-psk
> >               type AP
> >               channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
> >               txpower 14.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >       Interface wlp1s0
> >               ifindex 3
> >               wdev 0x1
> >               addr c8:94:02:b5:fe:fb
> >               type managed
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> > Or even this with no AP up:
> > # iw dev
> > phy#0
> >       Interface wlp1s0_1
> >               ifindex 6
> >               wdev 0x4
> >               addr ca:e5:84:22:10:ec
> >               type managed
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >       Interface wlp1s0_0
> >               ifindex 5
> >               wdev 0x3
> >               addr 9e:4e:c5:ea:4c:e9
> >               type AP
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >       Interface wlp1s0
> >               ifindex 3
> >               wdev 0x1
> >               addr c8:94:02:b5:fe:fb
> >               type managed
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >
> > If I use the parameter to ignore the feature and configure the interfac=
e combination as before:
> > # iw list | grep -A4 "valid interface combinations:"
> >       valid interface combinations:
> >                * #{ managed } <=3D 1, #{ AP, P2P-client, P2P-GO } <=3D =
16, #{ P2P-device } <=3D 1,
> >                  total <=3D 16, #channels <=3D 1, STA/AP BI must match,=
 radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz }
> >
> >       HT Capability overrides:
> > # iw dev
> > phy#1
> >       Interface wlp1s0_1
> >               ifindex 7
> >               wdev 0x100000004
> >               addr 82:90:89:90:c1:37
> >               ssid test-qe-wpa3-psk
> >               type AP
> >               channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >       Interface wlp1s0_0
> >               ifindex 6
> >               wdev 0x100000003
> >               addr 6a:ef:d0:db:10:f0
> >               ssid test-qe-wpa2-psk
> >               type AP
> >               channel 13 (2472 MHz), width: 20 MHz, center1: 2472 MHz
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >       Interface wlp1s0
> >               ifindex 4
> >               wdev 0x100000001
> >               addr c8:94:02:b5:fe:fb
> >               type managed
> >               txpower 16.00 dBm
> >               multicast TXQ:
> >                       qsz-byt qsz-pkt flows   drops   marks   overlmt h=
ashcol tx-bytes        tx-packets
> >                       0       0       0       0       0       0       0=
       0               0
> >
> > Thanks
> >
> > Best regards
> > Jose Ignacio
> >
>
>


--=20
Janusz Dziedzic

