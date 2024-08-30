Return-Path: <linux-wireless+bounces-12220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC796546D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD221F26245
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5281D12EE;
	Fri, 30 Aug 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0dTybzI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C317F6
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980075; cv=none; b=JVvpYvwJX7mzCF6hOAPrwQmxelKQ2/k6BGwXUrFEW2H2XLA4j3WDNKTRUx+Kugw4WzupEV8vAUJerFZEC/g/Y7wHpJG3wki2yAtlMAtd49YNxHin11JIhHA+7A9pTDdc2AHPSximFsE/s+SFxQIqhj26josgZRx++lP/jGbp17U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980075; c=relaxed/simple;
	bh=2FHY8Quc4szV77a2D4rntb/EAYwy+mQMYzBOSG+Y76g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXflGYq0CaEP55h7bypjL+ubdfr4hjGb4D55hHmYjk+e2lHZ/o4JqOauqCACTTSdpqRpSLqQM6lmhYF4hA8ztfAd5whT/JBoTRSVyN876gCs8cWnTE9fUwQQSQSwQqPTRNhFh3ch7coFlg8sKPpo8+DlPVLy1jju9eu1BlIRX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0dTybzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FCFC4CEC1
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724980075;
	bh=2FHY8Quc4szV77a2D4rntb/EAYwy+mQMYzBOSG+Y76g=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=P0dTybzIKvwmQZRQacLID/SDgC90g2RBhCR6zya2lyqnzYdLlteuTRqoZSJYDcQFk
	 bRNsNJ3tk+IPOTEJuGTEex3Upmu8Wo/0WRSvnBQFzO7TdxaUz1z+kyalqPRmW5CrfX
	 XyWGKjuFRmHu63n07ttJ1iyHWlFPxuhrWIR98rAVZnbomOTur1Oy13trddviEjMm8z
	 q7YQr1KQZvzL9EQIwym55yDyyw4+q9WEarMAVM7khpRnMRds59wqjUoAJZymZ/cDso
	 L56cZt6FMySRefO1XzsOM/Q7P7Svi+EbZKNAzgkAJilxo2O/G3gPW/7Cpb8fPF9hNd
	 8LtdYZd7nmGvA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f5064816edso13296091fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 18:07:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTFjKf+eq9f91jO6l+NhCMpMZW8IE3RUgVeZMI11hzVs4PfoP2
	ILK+R9yHVP/vIUWCquFnoxkO3GykUCFVRTVLu4BLNDIaca+eORecGOJQi29EsyRPxlxKjYAI9c/
	kayRDnB9rxwGcmqhM5HZkZh7rT5s=
X-Google-Smtp-Source: AGHT+IF6b96BNsVFCDePVLyE+aN9H4S278CRJOw0NxissvFB8pVbFjVvaelamZ72szM9Q/DR1TOU8XP7WavA1ymiVZ8=
X-Received: by 2002:a2e:bc1f:0:b0:2f3:f168:f91 with SMTP id
 38308e7fff4ca-2f6103a4a8fmr37525101fa.11.1724980073549; Thu, 29 Aug 2024
 18:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828084706.12257-1-pkshih@gmail.com> <20240828084706.12257-3-pkshih@gmail.com>
In-Reply-To: <20240828084706.12257-3-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 30 Aug 2024 10:07:40 +0900
X-Gmail-Original-Message-ID: <CAGb2v66xNmSY782csEi04rT-qrk-+tcxnV1ce7ByNMgNSAYNsw@mail.gmail.com>
Message-ID: <CAGb2v66xNmSY782csEi04rT-qrk-+tcxnV1ce7ByNMgNSAYNsw@mail.gmail.com>
Subject: Re: [PATCH 3/4] wireless-regdb: Update regulatory info for Israel
 (IL) for 2021
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:32=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Israel released the wireless telegraph regulations (certificates of
> conformity) on 2021 [1]. Update regulation of Radio Local Area Network
> (RLAN) below.
>
>  * 5150 - 5250 MHz
>    - 200 mW; 10 dBm/MHz (adopt 200 mW)
>    - EN 301 893
>    - inside a building only
>  * 5250 - 5350 MHz
>    - without TPC: 100 mW; 7 dBm/MHz (adopt 100 mW)
>    - EN 301 893, DFS
>    - inside a building only
>  * 5470 - 5725 MHz
>    - without TPC: 500 mW; 14 dBm/MHz (adopt 500 mW)
>    - EN 301 893, DFS
>    - inside a building only
>  * 5945 - 6425 MHz
>    - 200 mW; 10 dBm/MHz (adopt 200 mW)
>    - EN 303 687
>    - inside a building only
>
>  * No touch 2402 - 2482 and 5725 - 5875 MHz, because the regulation not
>    clearly point out RLAN for the frequency ranges.

For 2400 - 2483.5 MHz, see item 49.
For 5725 - 5875 MHz, you can use the SRD one.

For all rules, please reference the item number from [1]. The ESTI
reference is secondary.

ChenYu


>
> [1] https://www.nevo.co.il/law_html/law01/502_483.htm#Seif9
> [2] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/=
02.01.01_60/en_301893v020101p.pdf
> [3] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/=
01.01.01_60/en_303687v010101p.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/db.txt b/db.txt
> index 50ebd50becbd..0bc40db2d9b5 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -905,14 +905,16 @@ country IE: DFS-ETSI
>  # IL: https://www.gov.il/he/departments/legalInfo/telegraph_law
>  # IL: official document (pdf): https://rfa.justice.gov.il/SearchPredefin=
edApi/Documents/IdngyMn~ojdQSrkxuAqfZqiM8c1foi3TSZQhp7OMszo=3D
>  # IL: also available as unofficial word doc: https://www.nevo.co.il/Hand=
lers/LawOpenDoc.ashx?id=3D199708
> +# https://www.nevo.co.il/law_html/law01/502_483.htm#Seif9
>  country IL: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
>         (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> -       (5250 - 5350 @ 80), (200 mW), NO-OUTDOOR, DFS, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW
>         # Table B List of conditions, row 63, indoor short range device w=
ithout TPC (ETSI EN 301 893)
>         (5470 - 5725 @ 160), (500 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=
=3DETSI
>         # Table B List of conditions, row 68, wireless device using 802.1=
1a/n/ac protocol
>         (5725 - 5875 @ 80), (200 mW), AUTO-BW
> +       (5945 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
>  # Source:
>  # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gs=
r-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> --
> 2.25.1
>
>

