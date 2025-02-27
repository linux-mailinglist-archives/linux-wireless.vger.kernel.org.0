Return-Path: <linux-wireless+bounces-19535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F767A47D5D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 13:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6181745E0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A0270048;
	Thu, 27 Feb 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHhHT6SM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6642AA5
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658478; cv=none; b=alebKtaT6CgFJ6wqoFl5M5WTB36OC1fg37NcN+ApEfgg1mbYU4xGoldE1jWqZuJmDJTa5P9tkXn1FkNq7Oh9RniWooVTJChBIQh6iBDiVppwAt/QrJzMfFE9qJ2dcZm6wk54VMydqwFKLrcv+amunpYgN73VokTyoFXmeHYvfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658478; c=relaxed/simple;
	bh=534/gYe6iq47ZwP+Br1SPG+hyWeoQO/Rhs3lb6Dkvgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=staXRh9J52uWB4XHqketTabMLVSaVKNFY3evD6SqDoGav+tt9Wc0cTkDFC24Cfg6DxrMxhokQltg52GHs3ogTYjdZdXU1h3uERJnJkWV58Krq6bURe1ZH0DWOkvqSA0n74sFtuFHvToqLyZ+PVF+aO0akFdsXJqI+cBGSvYGYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHhHT6SM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso1427783a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 04:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740658471; x=1741263271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=534/gYe6iq47ZwP+Br1SPG+hyWeoQO/Rhs3lb6Dkvgo=;
        b=fHhHT6SMe+OqzNtt7XR/BGzTHQXkgocitZMD/YpwVLQWo+VFaAxjqLV/e6JXyOtHPI
         ca3WE327+l1vKclM1xelX+i0R/mFkWY6+bo0310Sz8smDcwQvpN5cY8sHvJ86nDDD/E4
         rNJ5DM4BooQVo4bYrloiUjX2jSbeYJ2suY3WHG3JyCWDWT50GGKeIWpGhWeNirblq1lW
         DB2u56rL3VJZtVjySLg3DGZ+OpuA90VqSnmV93llqO3TVMZKyTSxRI9NLFF/A6FBb59c
         RdwiCYvMTaJIbqCZbVpF3QJzzAcAA9uagIbgEG9qeBxFId8Mbi7gtLw0k1rdB7dmuh0u
         w3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658471; x=1741263271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=534/gYe6iq47ZwP+Br1SPG+hyWeoQO/Rhs3lb6Dkvgo=;
        b=eMYRNvtPEBk41ktEoffwoM/wF6+/WdK0RWVQcsRKBDTIqYUbamO/4mCBOUsFuoRTEg
         IYXBMWSe4bWeBvGvMmBN8bWWuI+tt2sxIX9zMAGeLElqiNJeSu3iMGMH9/VypNjekNX/
         qcD++M8X7wJ9bYI07Iw2RxZuRS0EqcK+K9DkYiBf9g8LljqE/Lg9EmKViziplG6TUFQq
         UDs3mk8XSRe9xx9QrOhzkDRdA8Alo7L+k9jL5NAYngqAG+Ag99Un/qZS9wOTvWUyLunX
         nUKpW7LRRwmb9BvjsfQRFRoF0pPnOiCBFs9YvYur2hoF8wr2R4kb+G5SsFRVUYT7AkC6
         jDqA==
X-Gm-Message-State: AOJu0YzyaGZ8vxR2P7apYnjtO5xGGEUNRLZBxVXs/IPNa2703iNr3nTF
	SLePDMS+fnXOVOllDC3Po5Yr610rurkQdzFN69trRUe3vZSzIbQVCGSxqQep/T4kRO7xwp3Sqra
	wp5XP0daU+eDU6PasdHjlPG/n/p731rDu
X-Gm-Gg: ASbGncvhi5c+MRrr9lnhIPmPLbLHYoBFaarI8Jmhgaj16x6seJ6sQHqo7llQWVz45+w
	hF5IB38lBIvA1PDetxmiJy4KgEaSTibfdaOFojSOiV9Js2WqXIvwmeR2vuuuQp7rIYMY4MvqpuP
	g3jhXtyrM=
X-Google-Smtp-Source: AGHT+IGcwAkse25B0aiJaf91xCOFfB3riWt5JKLfWzl9FQNzJ/w5lzaZkBCpRBBulccjEfHR7WjpOQeBFLj5Z/jH9lo=
X-Received: by 2002:a05:6402:274e:b0:5e0:685f:30b8 with SMTP id
 4fb4d7f45d1cf-5e0b724490fmr27079026a12.25.1740658470800; Thu, 27 Feb 2025
 04:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Betonmischer <vkosikhin@gmail.com>
Date: Thu, 27 Feb 2025 15:14:19 +0300
X-Gm-Features: AQ5f1JoXqg01CUP9ptZZYxPAoiPfFFlu1uJO8fhte3HEOqTBNlCgYwefNBCFS88
Message-ID: <CAMcVZfuSTvzS0BeX4AOT1i_bVhS9=kE3B=njWTPCm+1j3ehbYg@mail.gmail.com>
Subject: wireless-regdb: Update regulatory rules for Russia (RU) and provide
 new sources
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wireless-regdb: Update regulatory rules for Russia (RU) and provide new sou=
rces

Transmit power in the 5 and 6 GHz ranges for Russia is currently
limited to 100 mW, which is only partially correct. On certain
channels, depending on the revision of the IEEE 802.11 standard, 200
mW is permitted by Russian law.

Frequencies and transmit power available for use by the general public
in Russia are governed by three bodies of legal documents: on
registration of radio-electronic equipment, on allocation of radio
frequency bands, and the rules for the use of radio access equipment.
All of those must be taken into account to prevent the user from
accidentally failing to comply with regulations.

Since March 1st, 2025, 200 mW transmitters on the 5 or 6 GHz band are
permitted without the need to apply for registration by the Decree of
the Government of the Russian Federation dated July 1, 2024, No. 897
=E2=80=9COn Amendments to the Decree of the Government of the Russian
Federation dated October 20, 2021, No. 1800=E2=80=9D
(http://publication.pravo.gov.ru/document/0001202407010020).
Translated citation from page 4:

> 25. Short-range devices:
>
> [...]
>
> b) In the annex to the specified list:
>
> [...]
>
> Clause 14 shall be amended as follows:
>
> =E2=80=9C14. User (terminal) transmitting equipment, including a receivin=
g
> device, operating within the IEEE 802.11 (Wi-Fi) family of short-range
> standards, functioning in the radio frequency band 2400 - 2483.5 MHz,
> with a maximum allowable transmitter power of no more than 100 mW,
> including built-in or integrated components of other devices.
>
> User (terminal) transmitting equipment, including a receiving device,
> operating within the IEEE 802.11 (Wi-Fi) family of short-range standards,
> functioning in the radio frequency bands 5150 - 5350 MHz and
> 5650 - 6425 MHz, with a maximum allowable transmitter power of no more
> than 200 mW, including built-in or integrated components of other devices=
.=E2=80=9D

The amended document is the Decree of the Government of the Russian
Federation dated October 20, 2021, No. 1800 =E2=80=9COn the Procedure for t=
he
Registration of Radio-Electronic Equipment and High-Frequency Devices=E2=80=
=9D
(http://publication.pravo.gov.ru/Document/View/0001202110220034). The
annex referenced by the amendments contains exceptions from the list
of devices requiring registration with the Federal Service for
Supervision of Communications, Information Technology, and Mass Media
(Roskomnadzor).

Another set of restrictions comes from the State Commission for Radio
Frequencies under the Ministry of Communications and Information of
the Russian Federation. I'll be citing the most recent amendments to
the Decision of the SCRF dated May 7, 2007, No. 07-20-03-001 =E2=80=9COn th=
e
Allocation of Radio Frequency Bands for Short-Range Devices=E2=80=9D
(https://digital.gov.ru/ru/documents/4039) which apply to the relevant
frequencies.

Decision of the SCRF dated June 16, 2021, No. 21-58-05
(https://digital.gov.ru/ru/documents/7973):

> The SCRF decision dated May 7, 2007, No. 07-20-03-001,
> =E2=80=9COn the Allocation of Radio Frequency Bands for Short-Range Devic=
es,=E2=80=9D
> shall be revised as set forth in the annex to this SCRF decision.

Annex to the SCRF decision dated June 16, 2021 No. 21-58-05
(https://digital.gov.ru/uploaded/files/prilozhenie-k-resheniyu-gkrch-ot-16-=
iyunya-2021-g--21-58-05.pdf),
pages 10=E2=80=9311:

> 5150-5350 MHz =E2=80=93 Maximum EIRP: 200 mW =E2=80=93 Indoor use only.
> With the use of an automatic power control system.
> 5650-5850 MHz =E2=80=93 Maximum EIRP: 200 mW =E2=80=93 Indoor use only.
> With the use of an automatic power control system.

Decision of the SCRF dated December 23, 2022, No. 22-65-05
(https://digital.gov.ru/ru/documents/8628):

> 26. The following amendments shall be made to Annex No. 2 of
> the Decision of the State Commission for Radio Frequencies (SCRF)
> dated 07.05.2007 No. 07-20-03-001:
>
> Section 2, =E2=80=9CDevices with Direct Sequence Spread Spectrum and Othe=
r
> Types of Modulation,=E2=80=9D shall be supplemented with the following en=
tries:
>
> 5925-6425 MHz =E2=80=93 Maximum EIRP: 200 mW =E2=80=93 Indoor use only.
> With the use of an automatic power control system.

Decision of the SCRF dated September 23, 2023, No. 23-68-03
(https://digital.gov.ru/ru/documents/8628):

> 3. On amendments to previously issued SCRF decisions:
>
> 3.1. Based on the application of the Association of Trade Companies
> and Manufacturers of Electrical Household and Computer Equipment
> (OGRN 1027700101505), in Annex No. 2 to the SCRF decision dated
> 07.05.2007 No. 07-20-03-001, the words =E2=80=9CWith the use of an automa=
tic
> power control system=E2=80=9D shall be replaced with =E2=80=9CWith the us=
e of LBT2 mode.=E2=80=9D

None of the decisions cited above impose a limit of 100 mW, and the
previously ambiguous phrase =E2=80=9Cautomatic power control system=E2=80=
=9C has now
been clarified. =E2=80=9CLBT2=E2=80=9C is an obvious clerical error, where =
=E2=80=9C2=E2=80=9C was
originally a footnote marker, as there is no such thing as the LBT2
mode. I have reported the error to the SCRF.

Additionally, there are rules for the use of radio equipment which all
Wi-Fi access points connected to public networks must be compliant
with. Citations are from the original document and the subsequent
amendments.

Order of the Ministry of Communications and Mass Media of the Russian
Federation dated 14.09.2010 No. 124 =E2=80=9COn the Approval of the Rules f=
or
the Use of Radio Access Equipment. Part I. Rules for the Use of Radio
Access Equipment for Wireless Data Transmission in the 30 MHz to 66
GHz Range=E2=80=9C (https://digital.gov.ru/uploaded/files/pr124-10_1.pdf),
page 62:

> Requirements for radio access equipment of the 802.11n standard
>
> [...]
>
> Maximum transmitter power in the frequency band:
> 5150 =E2=80=93 5250 MHz no more than 20 dBm (100 mW)
> 5250 =E2=80=93 5350 MHz no more than 20 dBm (100 mW)
> 5650 =E2=80=93 5725 MHz no more than 30 dBm (1000 mW)
> 5725 =E2=80=93 5825 MHz no more than 30 dBm (1000 mW)
> 5825 =E2=80=93 6425 MHz no more than 30 dBm (1000 mW)

Order of the Ministry of Communications and Mass Media of the Russian
Federation dated April 22, 2015, No. 129 =E2=80=9COn Amendments to the Rule=
s
for the Use of Radio Access Equipment. Part I. Rules for the Use of
Radio Access Equipment for Wireless Data Transmission in the Frequency
Range from 30 MHz to 66 GHz, Approved by Order of the Ministry of
Communications and Mass Media of the Russian Federation dated
14.09.2010 No. 124=E2=80=9D (https://digital.gov.ru/ru/documents/4626), pag=
e
25:

> Requirements for radio access equipment of the 802.11ac standard
>
> [...]
>
> Limit values of average EIRP and average spectral power density EIRP
> when operating at the maximum declared power
>
> Frequency range, MHz Output average EIRP, dBm
> with TPC without TPC
> 5 150 =E2=80=93 5 350 MHz 23 20/23 (1)
> 5 470 =E2=80=93 6 425 MHz 30 27

(1) A value of 20 dBm is applied, except in the case of transmissions
for bands that fully fall within the 5150 =E2=80=93 5350 MHz range, in whic=
h
case a value of 23 dBm is applied.

The footnote is somewhat ambiguous. The distinction seems to lie
between discontiguous channel bonding (e.g., 80+80 MHz) and contiguous
bonding within the lower channel range.

Order of the Ministry of Digital Development, Communications, and Mass
Media of the Russian Federation dated July 6, 2020, No. 321 =E2=80=9COn
Amendments to the Rules for the Use of Radio Access Equipment. Part 1.
Rules for the Use of Radio Access Equipment for Wireless Data
Transmission in the Frequency Range from 30 MHz to 66 GHz, approved by
the Order of the Ministry of Communications and Mass Media of the
Russian Federation dated September 14, 2010, No. 124.=E2=80=9D
(http://publication.pravo.gov.ru/document/0001202008070002), page 9:

> Requirements for radio access equipment of the 802.11ax standard
>
> [...]
>
> Maximum power in frequency bands, MHz
> 5150 =E2=80=93 5350 5650 =E2=80=93 6420
> Max. transmitter power , dbW -10 0

I propose the following changes to wireless-regdb by picking the
lowest transmit power value for each combination of frequency and IEEE
802.11 revision among the three bodies of legal documents. dBm units
are preferred over mW when applicable, as 23 dBm is slightly lower
than 200 mW after conversion.

IEEE 802.11n:

5150 =E2=80=94 5350 MHz 100 mW
5650 =E2=80=93 5850 MHz 200 mW

IEEE 802.11ac:

5150 =E2=80=94 5350 MHz 23 dBm with TPC, 23 dBm without TPC if contiguous
within the range, 20 dBm without TPC if discontiguous and out of the
range
5650 =E2=80=93 5850 MHz 200 mW

IEEE 802.11ax:

5150 =E2=80=94 5350 MHz 100 mW
5650 =E2=80=93 6420 MHz 200 mW

IEEE 802.11be isn't defined in the Rules for the Use of Radio Access
Equipment yet. Therefore, depending on the interpretation, 320 MHz
could be illegal to use in public networks until explicitly included
in further revisions. Russian law tends to be restrictive when it
comes to radio communications, and, to my knowledge, no major brand
has officially shipped a device with Wi-Fi 7 capabilities enabled in
Russia.

The source currently cited in db.txt
(https://docs.cntd.ru/document/1300597464?section=3Dtext) is not on a
government-maintained website. It is also limited in scope and
doesn't cover all of the relevant regulations. I propose to replace it
with different sources, which cover this topic exhaustively,
from official government platforms:

Decision of the SCRF dated June 16, 2021, No. 21-58-05
(https://digital.gov.ru/ru/documents/7973) =E2=80=94 contains the most rece=
nt
frequencies for 2.4, 5, and 57=E2=80=9366 GHz bands

Decision of the SCRF dated December 23, 2022, No. 22-65-05
(https://digital.gov.ru/ru/documents/8628) =E2=80=94 6 GHz band added

Decision of the SCRF dated September 23, 2023, No. 23-68-03
(https://digital.gov.ru/ru/documents/8628) =E2=80=94 reference to LBT added

Order of the Ministry of Communications and Mass Media of the Russian
Federation dated 14.09.2010 No. 124 =E2=80=9COn the Approval of the Rules f=
or
the Use of Radio Access Equipment. Part I. Rules for the Use of Radio
Access Equipment for Wireless Data Transmission in the 30 MHz to 66
GHz Range=E2=80=9C (https://digital.gov.ru/uploaded/files/pr124-10_1.pdf) =
=E2=80=94
rules for up to IEEE 802.11n

Order of the Ministry of Communications and Mass Media of the Russian
Federation dated April 22, 2015, No. 129 =E2=80=9COn Amendments to the Rule=
s
for the Use of Radio Access Equipment. Part I. Rules for the Use of
Radio Access Equipment for Wireless Data Transmission in the Frequency
Range from 30 MHz to 66 GHz, Approved by Order of the Ministry of
Communications and Mass Media of the Russian Federation dated
14.09.2010 No. 124=E2=80=9D (https://digital.gov.ru/ru/documents/4626) =E2=
=80=94 rules
for IEEE 802.11ac and IEEE 802.11ad

Order of the Ministry of Digital Development, Communications, and Mass
Media of the Russian Federation dated July 6, 2020, No. 321 =E2=80=9COn
Amendments to the Rules for the Use of Radio Access Equipment. Part 1.
Rules for the Use of Radio Access Equipment for Wireless Data
Transmission in the Frequency Range from 30 MHz to 66 GHz, approved by
the Order of the Ministry of Communications and Mass Media of the
Russian Federation dated September 14, 2010, No. 124.=E2=80=9D
(http://publication.pravo.gov.ru/document/0001202008070002) =E2=80=94 rules
for IEEE 802.11ax

Decree of the Government of the Russian Federation dated July 1, 2024,
No. 897 =E2=80=9COn Amendments to the Decree of the Government of the Russi=
an
Federation dated October 20, 2021, No. 1800=E2=80=9D
(http://publication.pravo.gov.ru/document/0001202407010020) =E2=80=94 200 m=
W
transmitters in the 5/6 Wi-Fi range are now exempt from registration

For research and verification purposes only, up-to-date
compilations are provided by law firms:

https://www.consultant.ru/cons/cgi/online.cgi?req=3Ddoc&base=3DEXP&n=3D8340=
25
(free access from 8 PM to 0 AM, Moscow Time)

https://base.garant.ru/199539/53f89421bbdaf741eb2d1ecc4ddb4c33

--
Best regards
Valeriy Kosikhin
Head of Testing Lab
3DNews - Daily Digital Digest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Web: www.3dnews.ru
E-Mail: vkosikhin@gmail.com

