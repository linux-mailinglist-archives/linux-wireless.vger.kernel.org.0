Return-Path: <linux-wireless+bounces-16621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D841D9F7E26
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB771888F1E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3407A86349;
	Thu, 19 Dec 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksQDFmkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593E2AD16;
	Thu, 19 Dec 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622484; cv=none; b=i6eyBYwO6nasrJhGw1wxD9bAUjDoEcTK26GNZZVIY3V7DOTcVBkYDRSOYk/Kzj65K1NQEd4qrIfh8YxqbYRS/QSRhjW/RqbrC5VGya80KTJyRht6BOwhasU8E3aBM3qUWnwSwjDzV3LoP/zFjwHxqbs7JjTdEsQDM1XHwqNW20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622484; c=relaxed/simple;
	bh=+hjvlfNMo8ElUxqno3RoRTtf8WV+Lg4IEKShLNMSN4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPChXi9tRE54kxU+iU1e9gzOLdakHyp5oX+seB8UjTn+9Ge37iJ5AOSMJlCL8XBM4Hpn5V0Z2rbXMSXHlHIw7WHFCEr630Wu0sdhcO3L6tWyyGUbVk66ZMwvjGg4H7O9fBhT92nzhw0bafTvUEvKmk1KcklqjOKgWqijGufOwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksQDFmkg; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so825302e87.2;
        Thu, 19 Dec 2024 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734622480; x=1735227280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5LU8R5S35xawuTVAp/KUqPbURN6t2idsQB3W8B0Mgrc=;
        b=ksQDFmkgRKIHULFkj1XRBaDhYmSKIv1A8fSktuwdz25pZ4gA3xvAe4UJpPydFiHqO+
         PYeSr2srTn8JaPpjDXtc9eUSr9C38ts5WH847GmV3zfFQy7/qSwl8QvIAt0f9Zx3sSh/
         z/31B/rnp8ToxSUW0IWIa/juFbG5b+b0JIo6Cwa+YEpRqwDcrUqrk2KbMU5FXZB8eC4I
         iNZzRjgF5z/SeLCaW9sMV4hOzBTOcEZVIxKjTjWjQ+0BCBJHq8cEluUi2eeCAT1uMfYK
         B5nMrzspQp+G9OD3WfarTxV3ITy5Diz0nSxCWpV1WyhZtbKexNm4jxyED97NA8O+9rvr
         ExKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622480; x=1735227280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LU8R5S35xawuTVAp/KUqPbURN6t2idsQB3W8B0Mgrc=;
        b=JlZ6FD5egZmPcnMg7u68gi3XYNCg0Rkz0OTWoYTfzw9cjX7H2s2cwCJ/W/ijvt0ACZ
         P+njKbmIaGIEra9qyFWiC2jE7XU4kwJv5vuJP2O+xTxvbAKM06uAuXHky/lwfaErQ79l
         P2nd976kNg5P0m15hqPHV7jicrunNxiy9COorgubXsLqZFllkqpsQ7jQS1Zum7iMjM3O
         OrGO3rR1h2+vBpG/fV+CuYe2MZthMRKa32BzQRHVU7/Ir+JR3MGojSM6nACke/wrTaSL
         pChr0X0wAOzdTMZyefrVkigIcl5R8dieTwxMZEpkaj1damQWwgE1kyIp4ue8yfzQVluo
         Vkzw==
X-Forwarded-Encrypted: i=1; AJvYcCVH4F9XElJ6gpPBSMYggqcXpucLJKRE4Hxg51YMpVEg2UJ1n905PHiGIrAcs3RJ2ZLWyZG/qT1s5iC/E+t/Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynMnL/1eN0Ysvpsu32tBmuj7DRMQSfJG/tZqvx/sYisCtt/sTi
	pOKy3OH1FRRSsCnqmW4hslQMmYnNryYqymNPcV3U+8segjSMnlM8Y9vW1SET1ttDKluZng/AMTG
	GMg+AnlTU2TvWO+mriHzs7UF8fOQ=
X-Gm-Gg: ASbGncsbWRs6Tj9KsyF/3xdZ8NxoGwGiKITE3E1gpb7JfusH6ctkWgBWyzWpEBBSEF3
	7VVXMwKycwqScHscJposzTEqLNWnxJU9V6Ofzi0V70gs9lqSgdgmT8aEdPLKHlt7VbqMH
X-Google-Smtp-Source: AGHT+IGIymQukekdW3JetVOhgWVGLK/wt2yuf38Zk7sSXg/H8vtxfdy057uIWjEz6Go6uT1AHHjOHS+xhZkd/DHSiCk=
X-Received: by 2002:a05:6512:280c:b0:540:2111:db71 with SMTP id
 2adb3069b0e04-541ed8fff33mr2588682e87.42.1734622480012; Thu, 19 Dec 2024
 07:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z19G5zFhmWOfINvt@torres.zugschlus.de> <Z2Q3dTbuRNh0ELo3@torres.zugschlus.de>
In-Reply-To: <Z2Q3dTbuRNh0ELo3@torres.zugschlus.de>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 19 Dec 2024 16:34:03 +0100
Message-ID: <CA+icZUW6nfJKFTUm820a4Mkc+H6_G=qDksn4SNoxCKV1gFSoXg@mail.gmail.com>
Subject: Re: Intel Comet Lake Wifi (8086:02f0) only working after cold start,
 failed with error -110
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:11=E2=80=AFPM Marc Haber <mh+linux-kernel@zugschl=
us.de> wrote:
>
> No takers after half a week?
>
> Greetings
> Marc
>

[ CC Miriam + JoHill ]

Hi Marc,

I enhanced the CC list.

Hmm... Is the T: tag still valid?

T: git git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi.git

Checked for newer firmware?

Thanks.

Best regards,
-Sedat-

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/MAINTAINERS#n11911
[2] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.=
git/

> On Sun, Dec 15, 2024 at 10:15:19PM +0100, Marc Haber wrote:
> > I recently bought a used ThinkPad X13 1st Generation. That one is
> > equipped with an:
> > 00:14.3 Network controller [0280]: Intel Corporation Comet Lake PCH-LP =
CNVi WiFi[8086:02f0]
> >
> > (lspci output avaible online as https://www.zugschlus.de/stuff/lspci-v
> > and https://www.zugschlus.de/stuff/lspci-nn)
> >
> > I can reproduce the following behavior with all Linux kernels beginning
> > with the one that is in Debian Stable (didn't try anything older than
> > that), Debian unstable, current Linux Mint, Fedora Workstation 41, up t=
o
> > a self-compiled Linux 6.12.5).
> >
> > While there was a Windows installed on the box when I got it, I do not
> > intend to dual boot the machine, and Windows has been erased by
> > installing the first Linux over it. Hence, I dont consider the hints
> > found on the Internet regarding Windows fast startup applicable in my
> > case. In any case, I disabled Windows fast startup before overwriting
> > Windows.
> >
> > When the notebook is freshly cold booted (machine OFF, no led blinking,
> > pulsing or anything, power supply disconnected), Wifi works. When I jus=
t
> > reboot the machine without turning it actually off, or turn it off whil=
e
> > leaving the power supply connected, Wifi does not work. The Wifi chip
> > still shows up in lspci but not in ip addr / ip link. dmesg looks like
> > it does not even try uploading firmware.
> >
> > In the non-working case, I see a bunch of lines like
> > [    3.998476] iwlwifi 0000:00:14.3: CSR_RESET =3D 0x10
> > [    3.998494] iwlwifi 0000:00:14.3: Host monitor block 0x0 vector 0x0
> > [    3.998524] iwlwifi 0000:00:14.3:     value [iter 0]: 0x00000000
> > [    3.998545] iwlwifi 0000:00:14.3:     value [iter 1]: 0x00000000
> > [    3.998566] iwlwifi 0000:00:14.3:     value [iter 2]: 0x00000000
> > [    3.998587] iwlwifi 0000:00:14.3:     value [iter 3]: 0x00000000
> > [    3.998608] iwlwifi 0000:00:14.3:     value [iter 4]: 0x00000000
> > ending with
> > [    4.007732] iwlwifi 0000:00:14.3: probe with driver iwlwifi failed w=
ith error -110
> >
> > (full output on https://www.zugschlus.de/stuff/dmesg-notwork)
> >
> > For reference, see dmesg output for a working case on
> > https://www.zugschlus.de/stuff/dmesg-work.
> >
> > As per the instructions given on
> > https://wireless.docs.kernel.org/en/latest/en/users/drivers/iwlwifi/deb=
ugging.html,
> > I have not yet upped the debug level. I am prepared to try with a kerne=
l
> > that has CONFIG_IWLWIFI_DEVICE_TRACING and/or CONFIG_IWLWIFI_DEBUG set.
> > If you ask me to do this, please give me instructions about how to
> > enable the desired debugging if module parameters, kernel command line
> > parameters etc are necessary.
> >
> > I would apprecaite any help. I can keep the machine in the current stat=
e
> > for a few days, I only need it after chrismas.
> >
> > Please keep me on Cc, I am not subscribed to the mailing lists.
> >
> > Greetings
> > Marc
> >
> >
> > --
> > -----------------------------------------------------------------------=
------
> > Marc Haber         | "I don't trust Computers. They | Mailadresse im He=
ader
> > Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 160=
0402
> > Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 160=
0421
>
> --
> -------------------------------------------------------------------------=
----
> Marc Haber         | "I don't trust Computers. They | Mailadresse im Head=
er
> Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 16004=
02
> Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 16004=
21
>

