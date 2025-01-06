Return-Path: <linux-wireless+bounces-17093-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F493A01CDF
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC61624F5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 00:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D352524F;
	Mon,  6 Jan 2025 00:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP3pJT68"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20624A3C
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736124130; cv=none; b=py6LDT/X2u/VV5MmSrkDQ3PCMooaBIcbcy04czvfLLwikc/4892ZybdKN5YYig4JvQLcvGbVcGEst88v5iaBvGYHI6o2etA1geOFGjTiO52W8e5J2MmVwbzy+t+mOVOqo/Sj7adIo/LSvHZEDmFuOC6iYDx6whKgi56UE/V1cA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736124130; c=relaxed/simple;
	bh=2Fb8b13/P3dzLIvFp/0RAdDOarYATNqeoRWItPEPfGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXiiQ4SBfW923aG3cI/Azl1O+apN2hLF2o04p3d633VSJ5RXblaCF44IUaUgP6uBsPSHneNSOs6jt1018jZx3mrWUZ5g4s9trji3msnMJEMosgp9yLNz7Qa/iVxAQ8Dg8BVqLYPEB+1mlMiV8mOCjTMSvcmRrmxu2Vm2edbAyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP3pJT68; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso15529913a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 05 Jan 2025 16:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736124128; x=1736728928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkEov7BiZSlNescGbA5nE5JrkpqpgpPdU1WQaMZf4Yk=;
        b=WP3pJT68aFqOawkK+lZmn09BwKDBT+wW3DzYowzYEIXIG7bm8OCJVgvGDp1jTXainh
         OyqZbephh34hEG4EmIPeA1Pd9JXLmX5nnTyNOI1Roenj/6Op+LYGkhBTog298421nuKr
         q5PoLam2jIK7lo670iLhi0t/yXMOEPxf/hSXhHtb2xPS6fY0lyoWhPhjwp+iB+pXQSVi
         ov9SzOejrXRm+CEB5/F8l35dqVuMgI3W4UQI81VdU9Ss0ozxMZnvHUiEZK9uCAMULBle
         ljk/v3OGDjUMSHe8CrXvfsgYFf1g5V05KLgAH4ydiSkGHwdXWLWteoDXGhNU7RqVb1XN
         3rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736124128; x=1736728928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkEov7BiZSlNescGbA5nE5JrkpqpgpPdU1WQaMZf4Yk=;
        b=sHZApgKQRcdYrrFUrZGQ7+5ib1sAGxBZiRHUjeqTxZLrIr83bKXcGcePOrMZ9f7OML
         PbbGZBmpvN9jSNKQsGOYXNFM/8dPylhCIuS2CaMmDZT/IGHE8ZSKahYi7zrq6Hz0bU/v
         JTXn60pW4kh9K279w4ZEP4+nnJ1+XbzzAbjW9kziECsgdDHHWDptZ8XDW+rYxHRIw23r
         9/nDaJ8ReXq4fL/7DFCoR34X6h2k5moUHGteF4d/4VxpBuyjFjkpuc4LpymUdYe/GS+j
         aUcpezDDdhwz2kCwImAS2z2zRi7FMCtD6FBOxxLb/2he99sqPWZ9ZbjVYnLaUrDWWTIR
         /HmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdg3Oa56xt97GTYPu+3MA9lKZAAJ4Tb+7mt9xlPgweZUJHtvbIRN8Ddd7CKHXu57PuGCijTYmIAugp1+/ecA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRALrCmITiXC/dUURvK02yb+UYydDU4w5BZzRDXrFH6+28zUrR
	RK7k8o7xDF7KzsvvLFWh37D2Yt1J9lHc7BjgOt1IrlOyD4i88mXENq0qFYa76laVDUXGvgmxp7M
	Ts9i16x9kD5T7JuemeFxy/9pR+F/0+w/F
X-Gm-Gg: ASbGncvrnXIPaDcI3uwH1REzbekoBCup2j164hHY7xAD2qx1Gnq4BG3ep5DGQ+IW7La
	31/oSCp0T8V9G99BXInku5FiIn6o2DzfSon1sDw==
X-Google-Smtp-Source: AGHT+IGG+cPiTgc4eTSe5j1oO53XTcETt2p/o6AdGR/5X4Fgo2HOs6cTzqSVmmUeyMw+J6jYcmpBXG6HiOaYmJyQefw=
X-Received: by 2002:a17:90a:d00b:b0:2ee:9a82:5a93 with SMTP id
 98e67ed59e1d1-2f452e1d13amr84989746a91.14.1736124128100; Sun, 05 Jan 2025
 16:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com> <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com> <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
 <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com> <CAG17S_OAPEWsr61cBA1qfNhFst-mYK5a2_VrCZVZhdd-KVM9cw@mail.gmail.com>
 <c6e8ab71-d1e3-41a1-925c-9013f5a87f12@broadcom.com> <CAG17S_MoZDbu1vSt+=80xs+Cje_PPFhFwPxmWDUeNPJ9qRZ6bw@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com> <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com> <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com> <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
In-Reply-To: <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sun, 5 Jan 2025 18:41:56 -0600
Message-ID: <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: James Prestwood <prestwoj@gmail.com>, connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am looking at the iwmon logs for a successful wpa_supplicant
connection versus one from IWD. Both connect and both pass data and
both grab a DHCP address. I do note one difference in the connection,
though.

Request : Connect
through the responses RTNL
wpa_supplicant knows it is dynamic
> RTNL: New Link (0x10) len 80                                        15.66=
3131
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x9003) [up,broadcast,multicast,dynamic]
        IfName (len:6): wlan0
        Wireless: len 48
            30 00 08 8c 00 00 00 00 20 00 00 00 00 00 00 00  0....... .....=
..
            01 08 82 84 8b 96 0c 12 18 24 32 04 30 48 60 6c  .........$2.0H=
`l
            7f 08 04 00 00 00 00 00 00 40 82 84 8b 96 24 30  .........@....=
$0

and wpa_supplicant connects like this:
# ifconfig wlan0
wlan0: flags=3D-28605<UP,BROADCAST,RUNNING,MULTICAST,DYNAMIC>  mtu 1500
        inet 192.168.5.207  netmask 255.255.255.0  broadcast 192.168.5.255
        inet6 fe80::ba27:ebff:fea4:6e0f  prefixlen 64  scopeid 0x20<link>
        ether b8:27:eb:a4:6e:0f  txqueuelen 1000  (Ethernet)
        RX packets 13  bytes 2785 (2.7 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 58  bytes 9015 (8.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


Whereas the iwd log does not:
> RTNL: New Link (0x10) len 128                                       26.80=
9429
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1003) [up,broadcast,multicast]
        IfName (len:6): wlan0
        Wireless: len 96
            60 00 07 8c 00 00 00 00 50 00 00 00 00 00 00 00  `.......P.....=
..
            00 07 64 65 73 6b 53 41 45 01 08 82 84 8b 96 24  ..deskSAE.....=
.$
            30 48 6c 32 04 0c 12 18 60 21 02 03 14 24 02 01  0Hl2....`!...$=
..
            0b 30 14 01 00 00 0f ac 04 01 00 00 0f ac 04 01  .0............=
..
            00 00 0f ac 08 80 00 7f 08 00 00 00 00 00 00 00  ..............=
..
            40 dd 09 00 10 18 02 00 00 10 00 00 00 00 00 00  @.............=
..

and when it does connect, it looks like this:
# ifconfig wlan0
wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.5.207  netmask 255.255.255.0  broadcast 192.168.5.255
        inet6 fe80::ba27:ebff:fea4:6e0f  prefixlen 64  scopeid 0x20<link>
        ether b8:27:eb:a4:6e:0f  txqueuelen 1000  (Ethernet)

On Sat, Jan 4, 2025 at 12:28=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> Started a new thread as the other was already at 30! Hope this is OK
> for the list.
>
> This is on a RPi running the latest connman and iwd, with the brcmfmac
> 43455 chip, a patch to the brcm80211 driver from Arend and the latest
> firmware from Infineon:
> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> (be70ab3 CY) FWID 01-95efe7fa
>
> The latest iwd (3.3 at latest commit: g4b535cee) will connect to an
> SAE/WPA3 AP. It just will not do it every time. I use connman as the
> manager with iwd to manage the wifi.
>
> I have seen 2 different errors. One is 'invalid key' and the other is
> 'connect-failed'
> The invalid key dialog in connman is:
> connmanctl> connect wifi_b827eba46e0f_6465736b534145_managed_psk
> Agent RequestInput wifi_b827eba46e0f_6465736b534145_managed_psk
>   Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory ]
> Passphrase? secret123
> Agent ReportError wifi_b827eba46e0f_6465736b534145_managed_psk
>   invalid-key
> connmanctl> Retry (yes/no)? no
> Error /net/connman/service/wifi_b827eba46e0f_6465736b534145_managed_psk:
> Input/output error
>
> This one did not connect and the iwmon log is attached as is the
> journal (iwd and brcmfmac debug enabled)
>
> The connect failed dialog in connman is:
> connmanctl> connect wifi_b827eba46e0f_6465736b534145_managed_psk
> Agent RequestInput wifi_b827eba46e0f_6465736b534145_managed_psk
>   Passphrase =3D [ Type=3Dpsk, Requirement=3Dmandatory ]
> Passphrase? secret123
> Agent ReportError wifi_b827eba46e0f_6465736b534145_managed_psk
>   connect-failed
> connmanctl> Retry (yes/no)? yes
> Connected wifi_b827eba46e0f_6465736b534145_managed_psk
>
> This 'connected' but it resulted in an AIPIA 169.254.133.42 address as
> is seen in the logs.
>
> I also attach an iwmon and journal of a successful connection with a
> valid DHCP address of 192.168.5.207 that passes traffic in the case
> teh comparison helps diagnose it.
>
> I could be wrong, but I think this is related to iwd because when I
> try wpa_supplicant ver 2.10-12 on the debian apt list, it connects
> every time. If it is useful, I also have an iwmon and journal log of
> successful connect using wpa_supplincant. I do notice that it connects
> very quickly with wpa_supplicant compared to a connection with iwd.
>
> Keith

