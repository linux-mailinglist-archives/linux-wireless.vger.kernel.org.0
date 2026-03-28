Return-Path: <linux-wireless+bounces-34105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePoeMt++x2lxbgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 12:43:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5360534E3BC
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 12:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7BE3046BB1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 11:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99093876D0;
	Sat, 28 Mar 2026 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THR14aIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49679388E7B
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774698110; cv=pass; b=RB/bI52q3sd5Fdis3EtJJewCKj3YpuRiMBGS9Rqdt9l29MWpBuZ0omTLaC7KJrOZnvLI6EaJw1umUyy0fRO9b8vxEp/hZ1AknxRp0drh2462/rbeQM2AWJktbDvqf6Y0+zHelqahXktXH13WimY74N2R3DgUxdCSaPcysFu/etA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774698110; c=relaxed/simple;
	bh=h2Xzth2D59LPVTgpDOMCH5plDZi4f+ciY+NSeIeXGCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akpJ5X1RKGSCHb9yVirfdRayYFd2/wl59gYNzpSnkznoDR2n6T1SK3ssYS1/G/7D8IInl/qKJeHH2BVDq56LyrqrpX0Vb4BuaTn1AhAIOVCQTPwZh3nQrJaRO43k0CeQ6SXQ618+CrgyYvkm4IDccsMlDaFYBmgRIIFY/8gTyHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THR14aIt; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67ba5921b84so1762774eaf.3
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 04:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774698108; cv=none;
        d=google.com; s=arc-20240605;
        b=bmhVuy4rfsJvhFW5uVVx/YrJsc5r2irbnlu8Q6VcWm/4PBYpmu+VEqph796+HLIGZu
         CG8+IG92SdP6a2FKJuKSZvvVQESuGyulp19PeZhc+2LxbfNED88NBsXqYFq0/jC6rast
         OgS1O5LxVoevvPPVY9oiyqYKYionaUoQa2Lm5EHcPTcb6YSXDqO8xwmZdRPYStTqVBZZ
         keU5DnCVf6Hg+vTOfLaVw1bpV26jMc35ub5p63KYAm+O+8cMR2RntivbbMPiiZ5yNYVJ
         0unTnJ41HC56ISDzywayad/bHeVnwpt1J5oUIbWeBz5ClktQsFqlsmeX0iAroeOMfaVR
         /Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LWwYScVwA52gWrGbuzFI/dVKL0vznxxTT3o3q3rgtJQ=;
        fh=C9fhOPQcReAEk4nbrlekIoS0jOqZWfVkOqEUlgqD3dw=;
        b=MFI5fiY+pEoPNoj88Yj/AGb/4kIyBWXywotzxIqmSigS7IuC4vo7tn/6wTbMSTuXR7
         7kUUkw98IiaHs7e9O9LeSQwXnwDBLrc5svUtPTnFRMh6b2PfNJ0UQpbqwWf6hV6pk4r+
         P7jxEA7puItLsM7t2h/nlfI8krMRsnn0yjJxdUQxg2IWunC9V5v2kMJInBWNdPJMaQVi
         y41Nq9ajnGZh1dBA3mxVEXKWR2tp8CKI6Ot8LeB10PhtsMZJlrMBlgjJ0NB2yE97CSjG
         L8gs1QjEm4txdsppTLTU8yLUlxeEoJKyoyKVByWFYAzpQVTP1rr6bIgGzY11eroqnoRy
         FO+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774698108; x=1775302908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWwYScVwA52gWrGbuzFI/dVKL0vznxxTT3o3q3rgtJQ=;
        b=THR14aItTqTh8+jDS6/H8ikTOJX/iAQPNW5k+yDwZ83nx2myHl8vrZdHE4RIfSmKw7
         qe2ofu8PnBxG7ecRyJzYPCGyNipM+4TzixjSTojkvq27/+IQx6Jb2TOLJzOne1trCDXw
         9ICL/INi2A2jR1iatJ42YFLsbktFqntA20E0jwpn6n0CKXk9fkGCbAlhZamJAupV0SoK
         wel1eoj5ZlTgF3rplOU+DtANWRtW/0cfRMYA7hRs6CmDl+NZJOtOTvLYPL0HjVV2HFNV
         1HM6qMOYSsNUwVyypQp5MCWhSszOda9dTFGKPvhlgApNAScGwUcMZEPptnvxfBl4ombe
         Wgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774698108; x=1775302908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LWwYScVwA52gWrGbuzFI/dVKL0vznxxTT3o3q3rgtJQ=;
        b=OKaZMIgnmcN7Zo2dpREkMA8Eg3pcGCWy5KakMDmOG+MWW0CluD97crA8H6r0l30rPy
         TZNAr+yN3iyDVGVVru8dKQyDzdZ39SZy4yiFGJV8wPycpdadusbWhCn1Re/TKHwe+A9d
         2r/Acjl6wsJZNumMVuGsHSqv/cmqPnNDGYketbKYow8ojIDWPTb2oLIM1cNiH/sUluWv
         7Ey9c85rjv+Xpj1jThqO6h0Dp79qIuD+Ix2Kdv25Y8oiLAw92gzDESZ01PUevAKCblqK
         agUrJf8Ws/Ux+t+5eDUgFok9c8xdD64My+3WlPBhN2QH+Put+GzbYZy0b2sWYE4L9nAR
         dV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW++ECMsEe22gWyxknB0gJpK10OVSzLATnyyVSkKNxyEWCmdSUEcuWIpHkI8AW2pW79SRTNNzKvGr9TiCR7pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiwp7KoKwzrCzBmVeh3cZ1G6XopQync8JfoR+8P7gsJnKh8aZk
	442bwXGSBonLGZSdZB/glApNBM5u3EwsmetUO/9Zb1R0jUV3Ca/3FPK75g9AGma0wUJ898h3fiG
	MOBevODUmzcYTAQxQm6LoUK7cpuVwxoo=
X-Gm-Gg: ATEYQzzYRVJ+/elY6lguBpZPktXng1TB05hibk9ejTQRnIUyaDzb8/hGWuQ85y9SOqd
	OhRrHEQP9Jf26TRSxzgHpJGolLptvMshA2W2/DhvYuRxSpVOBPVDjph5oJ3R+uLYEsw+UIb/KPL
	OulmAxJZnmGWXlLu1ffDCZuXGhngTJmui5wglA50vRFXGeUkNJGZ/1r42aIEHaf7FwulejK9o1Y
	QXR6NjGjEhV1fCzvTAv9KAWUPt05hzJpwve3Gf75owkKx1789vUXW8AA3BmPX+kG1qbH0m2d3fb
	LorjmGbL
X-Received: by 2002:a4a:e90b:0:b0:67e:2aa4:ce16 with SMTP id
 006d021491bc7-67e2aa4d0f6mr56923eaf.39.1774698108069; Sat, 28 Mar 2026
 04:41:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqSMUPnPfW-_q1RgYr0_SjoXUejAaJJr-o+jpwCk1S7ndQ@mail.gmail.com>
 <e5f00d0a42994812b42df867718fa087@realtek.com> <CALdGYqRbkV7_w7WDiqD-vYMa8MUFV7nSYz-=q2FzotgLHRy=HA@mail.gmail.com>
 <cb32c1eefb614a8bb96ef6fe2c4f4989@realtek.com> <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com> <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
In-Reply-To: <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 28 Mar 2026 13:41:11 +0200
X-Gm-Features: AQROBzCjiTLJHhY2YHXoS76QOjjZxc0y--FONllkzSS1YBkEdacQHUJo0k7Uii4
Message-ID: <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-34105-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5360534E3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bitterblue,

Apologies for the delayed response. I applied your diagnostic patch
right away but held off on replying because the NULL pointer crash
has not reproduced since =E2=80=94 it has been over 36 hours now with no
oops, which is unusual (previously it occurred in 4 out of 7 boots,
typically within 2 minutes to 24 hours).

I wanted to wait and collect the hex dumps from the crash-time burst
(the 50+ "unused phy status page" events that always preceded the
oops), as those would be the most valuable. Unfortunately, the crash
hasn't happened yet during this session. If/when it does, I will
follow up immediately with those dumps.

In the meantime, here is what I have so far. The patch is working
and producing output. I collected 76 "unused phy status page" events
during this boot, with the following time distribution:

  14:01       1 event  (isolated)
  16:33       1 event
  16:57-17:00 73 events (burst over ~3 minutes, no crash followed)
  00:03       1 event  (isolated)

Page number distribution (no page 0 or 1, all are "garbage" pages):

  page 10: 10    page  7:  8    page  8:  7    page 13:  7
  page 11:  7    page  9:  6    page 15:  6    page 12:  6
  page  4:  5    page  2:  5    page 14:  4    page  5:  2
  page  3:  2    page  6:  1

Here are representative hex dumps. I'm showing the byte-level dump
(second print_hex_dump) since it is easier to read:

Isolated event (page 9):

  rtw_8821ce 0000:13:00.0: unused phy status page (9)
  00000000: c7 5e 9c 9d 91 69 4d dc b0 67 c2 09 84 33 00 00  .^...iM..g...3=
..
  00000010: 00 1e fe 3f cf f2 f0 08 01 29 00 00 00 11 2a 01  ...?.....)....=
*.
  00000020: 0e 00 00 00 00 00 00 20                           .......

Burst event (page 14):

  rtw_8821ce 0000:13:00.0: unused phy status page (14)
  00000000: bd 2c e0 3d 00 00 00 11 87 0a 40 80 88 33 00 00  .,.=3D......@.=
.3..
  00000010: 00 1e fe 3f 3e b6 9b 44 01 2e 00 00 00 11 2a 01  ...?>..D......=
*.
  00000020: 20 00 00 00 00 00 00 20                            ......

Burst event (page 12) =E2=80=94 byte 0x10 is 0x7e instead of usual 0x00:

  rtw_8821ce 0000:13:00.0: unused phy status page (12)
  00000000: 1c b3 7f 15 d1 94 95 7e 70 5e f4 e3 b4 a1 bf 10  .......~p^....=
..
  00000010: 7e 1e fe 3f 2e f1 62 44 01 2c 00 00 00 11 2a 01  ~..?..bD.,....=
*.
  00000020: 14 00 00 00 00 00 00 20                           .......

Burst event (page 2) =E2=80=94 contains MAC addresses:

  rtw_8821ce 0000:13:00.0: unused phy status page (2)
  00000000: 88 55 51 95 d1 66 ad 50 2f 25 3f 89 ae 35 ef 77  .UQ..f.P/%?..5=
.w
  00000010: 00 1e fe 3f 89 68 62 4d 88 42 40 00 8c c8 4b 68  ...?.hbM.B@...=
Kh
  00000020: d1 63 6c 68 a4 1c 97 5b                           .clh...[

  Note: bytes 0x1a-0x1f are 8c:c8:4b:68:d1:63 =E2=80=94 my adapter's MAC.
        bytes 0x20-0x25 are 6c:68:a4:1c:97:5b =E2=80=94 the AP's BSSID (par=
tially,
        the dump is only 40 bytes so it cuts off after 0x25).

Burst event (page 15) =E2=80=94 completely random, no recognizable structur=
e:

  rtw_8821ce 0000:13:00.0: unused phy status page (15)
  00000000: c6 a1 92 1c a7 68 6b 97 12 bd ad 89 30 98 ab 94  .....hk.....0.=
..
  00000010: 00 1e fe 3f ec 3f 3e 44 1f c2 91 41 0e 9b 54 5f  ...?.?>D...A..=
T_
  00000020: 30 eb 40 18 6f d3 25 62                           0.@.o.%b

Burst event (page 10) =E2=80=94 offset 0x10 is completely different pattern=
:

  rtw_8821ce 0000:13:00.0: unused phy status page (10)
  00000000: cb 1c 2a df f1 69 d0 05 58 c0 e8 0e d0 59 87 6e  ..*..i..X....Y=
.n
  00000010: 63 7e 56 f0 95 fa b8 d3 d5 4b 3e fa b0 0c 0e be  c~V......K>...=
..
  00000020: 42 28 14 89 15 c1 fd ad                           B(......

Last isolated event (page 4):

  rtw_8821ce 0000:13:00.0: unused phy status page (4)
  00000000: 97 ee fa 4e 04 90 00 21 c0 0f 89 80 b3 33 00 00  ...N...!.....3=
..
  00000010: 00 1e fe 3f 97 7e 64 90 5d 3e 74 fa 70 e0 39 65  ...?.~d.]>t.p.=
9e
  00000020: 48 a4 40 d3 de a9 85 15                           H.@.....

Observations:

  - Bytes at offset 0x0e-0x0f are usually 00 00 or have low values
    in most dumps, but some are completely random.
  - Bytes 0x11-0x13 are almost always 1e fe 3f (with byte 0x10
    being 00 or 7e), suggesting this is a consistent part of the
    RX descriptor that is not corrupted.
  - The "page 2" dump at 17:00:23 clearly contains the adapter
    and AP MAC addresses, confirming this is real RX frame data.
  - Some dumps (page 10, page 5, page 15) have completely random
    data with no recognizable RX descriptor structure at all.
  - The 73-event burst at 16:57-17:00 happened over ~3 minutes but
    did NOT result in a crash this time. Previously, similar bursts
    of 50+ events within ~1 second always led to the NULL pointer
    dereference in rtw_fw_c2h_cmd_handle+0x127.

I will keep monitoring and will send the crash-time dumps as soon as
the oops reproduces.

Thanks for looking into this.

Best regards,
Oleksandr Havrylov

