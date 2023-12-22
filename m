Return-Path: <linux-wireless+bounces-1198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262481C3FD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 05:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC1B24CFC
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 04:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1A63CF;
	Fri, 22 Dec 2023 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTtEL5sp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9963C2
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 04:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D3BC433C8
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 04:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703219731;
	bh=To2N8riyib9+sPzLqqS20HZlgIw8Oqv+5SaabQ8T9eU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=RTtEL5spQjNED1ATODWMoLF8TSpBj8ZdsSMjB92Z8OyBJihOvnOboEgUYwRk41zHT
	 cFCFEmpzJDvKa2m5GS9IoSvrwrmvzE6Y21kY/VA0FnxOi7xuFP4w/lbqQansYOyoAx
	 fHpoRnxiolQJpgGhRTYk9bBZNMwTTZz7e/8U82jxGc/SlvTUcfEEz/hvFesCv11PUO
	 wnCYH+mT0hSbap+1xiHSX6X883VJ7QsyVVTJPXkkuXvCoOLoEXruaTfyqh89jAb12h
	 35D5ed0oTZ65OSdmhP66pTt2pEwDM4Z2DbtystH5VhcM2f8YnVg5BtGjAptwZw/mq5
	 kj/8LpU1rc6Zw==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28bd623c631so1297326a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 20:35:31 -0800 (PST)
X-Gm-Message-State: AOJu0Yy6GLC4Y61pcpnFmJDlh4yZWMX0IihrRx+spBDJPfgMmbuOAuol
	CFJR6fS0gbrS15P9nBQvRIrNt2YvWaGsKgKsMgw=
X-Google-Smtp-Source: AGHT+IGZFpyoMxyncs90ct/xhu+G772tKZ351ovFW96vsw9Bv+HqrBBKXGigVUBCnxT2LeDKN8KN3dEweTABwat2dIg=
X-Received: by 2002:a17:90b:1042:b0:28b:6aa5:34a3 with SMTP id
 gq2-20020a17090b104200b0028b6aa534a3mr647163pjb.60.1703219730817; Thu, 21 Dec
 2023 20:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230903102022.11186-1-me@ndoo.sg>
In-Reply-To: <20230903102022.11186-1-me@ndoo.sg>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 22 Dec 2023 12:35:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v65uD9TQuMzrMo8JoWEMp8WbVrKAf92tn17tA98GXdPWZQ@mail.gmail.com>
Message-ID: <CAGb2v65uD9TQuMzrMo8JoWEMp8WbVrKAf92tn17tA98GXdPWZQ@mail.gmail.com>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Singapore (SG) for September 2023
To: Andrew Yong <me@ndoo.sg>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 3, 2023 at 9:25=E2=80=AFPM Andrew Yong <me@ndoo.sg> wrote:
>
>  - Update regulatory rules for September 2023 IMDA TS SRD [1]
>  - Enable 5945 - 6425 MHz (Wi-Fi 6E) band per legislation
>  - Switch units from dBm to mW to match values listed in legislation
>  - Allow AUTO-BW between 5470 - 5850 MHz to permit additional 160 MHz BW =
options
>
> [1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-c=
onsultations/ict-standards/telecommunication-standards/radio-comms/imdatssr=
d.pdf

Thanks for the patch!

> Signed-off-by: Andrew Yong <me@ndoo.sg>
> ---
>  db.txt | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index fdc2c13..cbe1a88 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1584,25 +1584,27 @@ country SE: DFS-ETSI
>         # 60 GHz band channels 1-4 (ETSI EN 302 567)
>         (57000 - 66000 @ 2160), (40)
>
> -# https://www.imda.gov.sg/-/media/Imda/Files/Regulation-Licensing-and-Co=
nsultations/ICT-Standards/Telecommunication-Standards/Radio-Comms/IMDATSSRD=
.pdf
> -# IMDA TS SRD, Issue 1 Revision 1, April 2019, subsequently "IMDA TS SRD=
"
> -# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 (25); ANSI C63.10-2013 and FCC=
 Part 15 Section 15.247 or EN 300 328
> -# 5150 - 5350 MHz: IMDA TS SRD, Table 1 (29); FCC Part 15 Section 15.407=
 (1) 5.15-5.25 GHz (2) 5.25-5.35 GHz; EN 301 893
> -# 5470 - 5725 MHz: IMDA TS SRD, Table 1 (30); FCC Part 15 Section 15.407=
 (2) 5.47-5.725 GHz; EN 301 893
> -# 5725 - 5850 MHz: IMDA TS SRD, Table 1 (27); FCC Part 15 Section 15.247=
; FCC Part 15 Section 15.407 (3) 5.725-5.85 GHz
> -# 57000 - 66000 MHz: IMDA TS SRD, Table 1 (31); ETSI EN 302 567
> -# Note: 27dBm for 5470-5725MHz bands is 3dBm reduction per FCC Part 15 S=
ection 15.407 (2) 5.47-5.725 GHz; EN 301 893 as referenced by IMDA TS SRD
> +# https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-co=
nsultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd=
.pdf
> +# IMDA TS SRD, Issue 1 Revision 3, Sep 2023, subsequently "IMDA TS SRD"
> +# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 Sub-band 32e
> +# 5150 - 5350 MHz: IMDA TS SRD, Table 1 Sub-band 33a
> +# 5470 - 5725 MHz: IMDA TS SRD, Table 1 Sub-band 34
> +# 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
> +# 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
> +# 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
> +# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 (2) =
5.47-5.725 GHz as referenced by IMDA TS SRD
>  #  AU and BG regulatory domains use the same interpretation of cited FCC=
 and ETSI standards
> -# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm =
when TPC is implemented: IMDA TS SRD Table 1 (29)
> -# Note: The transmit power for 5470-5725MHz bands can be raised by 3dBm =
when TPC is implemented: IMDA TS SRD Table 1 (30)
> +# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm =
when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
> +# Note: The transmit power for 5470-5725MHz bands can be raised by 3dBm =
when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34

"... raised by 100 mW ..." given the new units?

Also, such a provision is not given for 5470-5725MHz in the spec. My
interpretation of the text is that a "reference" is referencing other
regulations for "reference" when designing the local rules, not that it
allows following those references directly, unless explicitly noted.

>  country SG: DFS-FCC
> -       (2400 - 2483.5 @ 40), (23)
> -       (5150 - 5250 @ 80), (23), AUTO-BW
> -       (5250 - 5350 @ 80), (20), DFS, AUTO-BW
> -       (5470 - 5725 @ 160), (27), DFS
> -       (5725 - 5850 @ 80), (30)
> -       (57000 - 66000 @ 2160), (40)
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5250 @ 80), (200 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
> +       (5470 - 5725 @ 160), (500 mW), DFS, AUTO-BW

This needs more justification. Unlike for the 5.15 ~ 5.35 GHz range,
the standard does _not_ give an option without TPC for this band.

> +       (5725 - 5850 @ 80), (1000 mW), AUTO-BW

Instead of AUTO-BW here, can you follow the examples from TW and US of
expanding the previous band by 5 MHz? That should cover the 160 MHz
channel.


ChenYu

> +       (5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
> +       (57000 - 66000 @ 2160), (10000 mW)
>
>  # SI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 30=
1 893)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 4=
40)
> --
> 2.41.0
>
>
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb

