Return-Path: <linux-wireless+bounces-33350-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAPgAA87uWmKwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33350-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:29:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D792A8B8B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 12:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B49930AA5C6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102583AC0E4;
	Tue, 17 Mar 2026 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXanRmQE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9253AB275
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746877; cv=pass; b=cIQpLbuymoPMsTHq+rE+1O/ZmKlFi47lXL+n1IIAKlVv1jaMWMFQZcwEQEZGQwK47OsRZm8iizV4fjZX27AlkAhmci+KbZRIJY/kwjzXxx8QOdWhCjXf29S+OP3LYLJfwQ3LrEtKsEYijJwjdeA3lvqlCskoBuHMQRT5D0wwPcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746877; c=relaxed/simple;
	bh=jaDdGsLeklJgpvhkj2rDxfNhnaxEoJoDxoGqyuDdKk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtLqfxn9xYviWBhjeQMEHVjqMcHxkMzMUAetoCoo7254vsQl6LA/hjCabVqf+BfuGI7GuU1950bfCnFsjuAuVRtBNy/h3W7FYUaJF7WjqPD0RDQRVMjknGBupM0+XGkFDvCpzvihTO4YHwBWv1SpleeLiPwL3wo2pPGYJSO8/W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXanRmQE; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso50117395e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 04:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773746875; cv=none;
        d=google.com; s=arc-20240605;
        b=IIb8WtvNDjs4Jbklcjtp59B64RkiXcfooQvgjTKxbK09yz9FSbNYCxNfIkj5cMeHUM
         5qigG9wsOdyKw+gCVj2rJs1P1TR2sen0tx4oqUYxIRg+MGYG5k6bwvuk/hVOy7lQ3DjN
         HI3lCjTi/tu6vM5bpX17TsFyX2I9q10rNK6PivRe0Aj2yEU3jXJVUUuHFUQpIf9vWrUU
         p+qe96Bqfsdtg58Zn9ACr8tAT63hM4C5rJ28ZQApASwwXWzfE5CtAyFT0ND06Rqexwm3
         Zpuqg1lUwQkya8o4AoBUSlNaL62nGPQRZQnn2L2L/MfnFaiuP+cKQrJVsJoxOWASRtQ6
         UgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jaDdGsLeklJgpvhkj2rDxfNhnaxEoJoDxoGqyuDdKk0=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=jCCi0dOlUrXxt4si9iEmnxZwxjhGxhQfo8VUyHnY+hVe8K/W7gLqs/0p4rG2j0oJVi
         ydx3wyyPePJb811d0rEWcxujtBn26vnsAuSmhHVVTiCy6pWDl8eyEKeMJubkeJyt1KAL
         bCh+YBI+4wWUwgukH9JesxJILwTaJ5sk3G7mbx/s+haVKqmb3M++Jpaekfz/1X8Gr0wh
         8Gl5oH6bJrrU+1Vu5+n3wlfoUFgP5+p0VzHypiL7Rm6AL4Veq1In1IAWdSRCY8alqcpW
         C0sv+Gm7I3sj4/TOBAKv7CSc57/gzA6dZf5vz7+7UX5jtHJnopDi90WViud+iAHry98G
         Ec+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746875; x=1774351675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaDdGsLeklJgpvhkj2rDxfNhnaxEoJoDxoGqyuDdKk0=;
        b=XXanRmQEf/OmqfoWrUwnFYt15RJ/6VHkkIczmCFdcJ/6+XSkd5/KvGuiYZtlICK9th
         r1kQv9TfiZCIanVb4ERV9UPNHEpor8KpicKePzvwF2g98Gem0oAYgIECMWFcgFDkUqSx
         /Jo8ogo739kZsAN6tWVQINDzyKr6KnQ9B84N1lAxjosLTuESAbykd6Y6O2G3cSjNpCc8
         xFj+71REHfc+GTKYxTHbEExD3OmT1SGUxSv5oumMwHajUgt178lU+Tbzjew+6OJPe4KW
         u+qmUZs64DkGdsR4EIRv1Y5aAw72I7i9+6j5jOw/YMPQ6oZUkWte9YYv51ZzG7aIsBr9
         n9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746875; x=1774351675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jaDdGsLeklJgpvhkj2rDxfNhnaxEoJoDxoGqyuDdKk0=;
        b=pZe8+caFWiZgZrBtqSOm34aI08YQX0gpEqKiG/DNSVX2Nu7IKsbAb8sSGrA0ebt5UZ
         P1cb2h8TVE0VV3O3JF1ZCf0q3fVGHDCwVNMXTcmx7Ft2g0Y4atehhF65zRkiyL/ypBOO
         yt6xHd9WbDh0mKlQmyOIg9FA7+rvBI2G3GNFxrRIe2hTYPWk7FdLZB7FsW5Qdq0mHkMd
         JML05+U+usclH/UyN5yfRJHrvBMu7pg1Lqv7KSeYuY9gIlG486j3vpi1YEDkMZtf3a70
         AQdNvCAR/d59mqfksSuSa5YHoMlqp3UjNLPtyB78GlpxmM1WMzlWp/Wqf5qoZXeB4ax+
         ohpg==
X-Gm-Message-State: AOJu0YwAu7JafjVHH94sVw0/mjiacxwM2spn8aYVQRFOVEaQpMh1BMcW
	fSGCSd2EBlP4rCajeOyyx5cP7ev0PLBPD3qDOI/CV9nUGy193b9bH1WG8b6Yb8gLxiWNt5M93eZ
	QfgYmMseOB/MjIKpiHU2lQ7/3tQaEKiY1Fh9AHmQ=
X-Gm-Gg: ATEYQzy1xmLTM2SwYRYEgzb87v1DyP29yZ3uxg5dxYOYEVAkzkTgiX97nRNWvsEluQY
	DqiXcj+29yUjFGil+N33UVtRYbh7MuR4eO2oxpSGfVtWCS4K838PS4l3hZ3+k8HExuRRnBUYzvu
	D1t4x/fTCgIJNEFMYLIAPu+5QHoBEiZQiY8rZyuK1HknwNI2cKs7OdapcE1sfk8X/gu6nhD2jPV
	qK0x0RHnYROWl7MKe6msbI7AIOURclZ3TxPbMIOVhE+CZnvICZZuq28RvdCfWBGuuIy3ON6nH6H
	L+Du328J8FG7SQzrbxY=
X-Received: by 2002:a05:600c:3588:b0:485:5d25:81a9 with SMTP id
 5b1f17b1804b1-4855d258656mr250546045e9.14.1773746874212; Tue, 17 Mar 2026
 04:27:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFR=mzkTDNVwypi_PvUw2PX0MM_ck0H61+PUAdJoo6h3yZfggw@mail.gmail.com>
 <b8cb73b5c8bf42b38ad275220b1d559e@realtek.com>
In-Reply-To: <b8cb73b5c8bf42b38ad275220b1d559e@realtek.com>
From: Jason Kakandris <ikakandris@gmail.com>
Date: Tue, 17 Mar 2026 13:27:43 +0200
X-Gm-Features: AaiRm5171j2R-T5Y8j77f0TobsmhPbMiM1MbQ3u3aerRRUZiqliZ8SKGyF-iH1U
Message-ID: <CAFR=mzmENf-SqdFYzfdjb3KtA153rGT1VDVXUrXTvK+Dd6teSg@mail.gmail.com>
Subject: Re: RTL8852BE fails to power on: "xtal si not ready" on ASUS TUF
 GAMING B650-PLUS WIFI
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33350-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ikakandris@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,realtek.com:email]
X-Rspamd-Queue-Id: 57D792A8B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello!

- The error appears on first boot, not after resume. It has never
worked on Linux.
- I have set up a udev rule to disable D3Cold for the device and will
test with a cold boot. I will also try the latest firmware
(v0.29.29.15) and report back.
Where can I obtain firmware v0.29.29.15? Is it rtw8852b_fw-2.bin from
linux-firmware.git?

=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CF=81=CE=AF 17 =CE=9C=CE=B1=CF=81 2026 =CF=
=83=CF=84=CE=B9=CF=82 5:03=E2=80=AF=CF=80.=CE=BC., =CE=BF/=CE=B7 Ping-Ke Sh=
ih
<pkshih@realtek.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> Jason Kakandris <ikakandris@gmail.com> wrote:
> > System Info
> >
> > Distro: Linux Mint 22.3 Zena (Ubuntu 24.04 base)
> > Kernels tested: 6.14.0-37-generic, 6.17.0-14-generic (same failure on b=
oth)
> > Motherboard: ASUS TUF GAMING B650-PLUS WIFI (Rev 1.xx)
> > BIOS: v3827 (Feb 2026)
> > CPU: AMD Ryzen 7 7700X
> > Driver: rtw89 v7.0 (git commit d2f175e
> > https://github.com/morrownr/rtw89/commit/d2f175eafa0a4ef9cc65e7073a77e6=
0238c
> > ae614)
> > WiFi works in Windows: Yes
> >
> >
> > Problem
> > The RTL8852BE WiFi card fails to initialize with xtal si not ready erro=
r. No
> > wireless interface is created.
> >
> >
> > dmesg output
> >
> > rtw89_8852be_git 0000:08:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
> > rtw89_8852be_git 0000:08:00.0: enabling device (0000 -> 0003)
>
> It looks like you didn't encounter D3Cold problem, but I think you can
> give it a try [1].
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D221213
>
> > rtw89_8852be_git 0000:08:00.0: xtal si not ready(R): offset=3D41
> > rtw89_8852be_git 0000:08:00.0: xtal si not ready(W): offset=3D90 val=3D=
10 mask=3D10
> > rtw89_8852be_git 0000:08:00.0: failed to power on
> > rtw89_8852be_git 0000:08:00.0: failed to setup chip information
> > rtw89_8852be_git 0000:08:00.0: probe with driver rtw89_8852be_git faile=
d with
> > error -110
>
> These messages appear when first booting or after system resume?
> Recently we update something related to suspend/resume problem.
> Please use the latest driver (kernel 7.0-rc4) with the latest
> firmware (v0.29.29.15).
>
> >
> >
> > lspci
> >
> > 08:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8=
852BE
> > PCIe 802.11ax Wireless Network Controller [10ec:b852]
> > Subsystem: AzureWave RTL8852BE PCIe 802.11ax Wireless Network Controlle=
r
> > [1a3b:5471]
> >
> > What I've tried
> >
> > Kernel parameter pcie_aspm=3Doff
> > Module parameters: disable_clkreq=3DY disable_aspm_l1=3DY disable_aspm_=
l1ss=3DY
> > disable_ps_mode=3Dy
>
> As you try this, please ensure that add a configuration file to /etc/modu=
le.d/,
> and cold reboot.
>
> > Updated BIOS from v3057 to v3827
> > Updated firmware files via make install_fw
> > Tested on kernels 6.14 and 6.17 =E2=80=94 same failure on both
> > In-kernel driver and morrownr out-of-tree driver =E2=80=94 same failure
> > WiFi works fine in Windows on the same hardware
>

