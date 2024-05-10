Return-Path: <linux-wireless+bounces-7453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966B48C2544
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF9287876
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC0117109E;
	Fri, 10 May 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="i9qzGfpu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524317083F
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345931; cv=none; b=ChXYbEU09a4Y0MAqC4q+AYV+phk7j3q6dZHHaDXCHTaEgKkONU/fRS+a8fLP7zoDItXqPjPGVCs2aZM8BOfO4fcoB2pz9fIGhVjOOcFD9Pmz5UGC8bLhwkvvg7x4lKlO/LBqDPttBy9srUjUj0kaPZAhdplwhewt4c7RSwfcc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345931; c=relaxed/simple;
	bh=NpHfaaN1/P4fFrM2w9p61KEY7Yfbvp/UkRQdQtMSi3I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hbm4xVNLJlNyPNRi2xenRnWtfot3av1DVHuJwBeHqvfQM/JOj6bOVXCNzJ0Y9IyyQCCtKNiG/HFYlNnDUSZNKN2lJevYQQvCtaV0BjQF47jocozthZHv9cV/YIDjuc3UT+ZrhmdAOoEVj7FFgWe42TbNVQ9kvkcb0lJ8rMQUBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=i9qzGfpu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fb14816f6so2517923e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1715345926; x=1715950726; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxBivlOxaqlEEbDLMFV0vCEHdd4iPG+/gEoM2OoSt2w=;
        b=i9qzGfpuRsoUrMpVBWOA0xmRIZ1AyowGahiOFAGXmuGcjLzWgJwvG5tdAglGAwUNYA
         WODkkJTybH21+GOfAGOswySz6Xx2vUhux4+NM3ssL68lfHa+bW8zGmLpchLJyrqij9vz
         LK8GxccRoi9kcbU8pQYsDOjCcKemspDtn4WBThDwrZjYCkB9roCFkVEl8P/iLq/wSoy1
         wNIvBkYTKsURo7AUOT4Zo06AFBUGwPXQjOhUm7SG2f3eXRSmhtDnDzokmUpQ4rQDIvpS
         oBQdo/5nWuE7hlYB5My5sPYYwjskGE7lD+zuEvmKCnn/UzlAkEiuVxUox3ck9g+MI5b/
         Tkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345926; x=1715950726;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YxBivlOxaqlEEbDLMFV0vCEHdd4iPG+/gEoM2OoSt2w=;
        b=WqlfPBHX7UGJW0xSNKlppuVEmQN2mdhBaIQ2HnkCsnwX+R3j6FaEJybfWvTzoQDbK8
         jNj99YU9E5nwuBW3Ok+BVLpSg/KpKsDI13tTxupmZ73/vKE/5o3tVhyZX2kQFC7j2VgU
         BTwHIac1XB0jqK9A9UMYrefgNAWtun6USt2duQKXhozHyJNSmpXLKv8VoG64MLvp7kP8
         +ulyrKcL7zBqA+0u/nWxwIDqw+W2enxCNp94Zd3NBCAAPX9Ywx9+/pmz8iiUWlGVUGzw
         r7QSJrPfyHLCawPkre2C0Z3IZcRPMJ790LXM/GpbMdoBtCwra7M50WdJcLJVGK1kxMlP
         y82g==
X-Gm-Message-State: AOJu0YxvTaVCgElTbuA5oI14+sRWPYj90MYHgv0XqsHpGy+V8v6RYlJK
	08dtg2SVaUGHKwhhSKnup/DpOF0IDrXJ7I0aVqZajNIrOWnMFlCGLcXThNWGU5w=
X-Google-Smtp-Source: AGHT+IEJc48G9N+OCYhNeHSuoRPf1sFLAwGbCobrMfI83OAtAJVZs4zbU6bnpX0pa9EFumY2HbQANg==
X-Received: by 2002:a05:6512:b81:b0:51e:f7de:d8eb with SMTP id 2adb3069b0e04-5220fb76879mr2125869e87.10.1715345926208;
        Fri, 10 May 2024 05:58:46 -0700 (PDT)
Received: from localhost (2a02-a210-20ba-5a00-9ceb-707b-2d57-26f7.cable.dynamic.v6.ziggo.nl. [2a02:a210:20ba:5a00:9ceb:707b:2d57:26f7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb57asm1771827a12.26.2024.05.10.05.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 05:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 May 2024 14:58:45 +0200
Message-Id: <D15ZDRFYKJPD.20C0WDZQOZSOH@fairphone.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Carl Huang" <quic_cjhuang@quicinc.com>, <ath11k@lists.infradead.org>
X-Mailer: aerc 0.17.0
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com>
 <4b7719c7-22bf-4644-9705-2518031782d3@quicinc.com>
In-Reply-To: <4b7719c7-22bf-4644-9705-2518031782d3@quicinc.com>

On Fri May 10, 2024 at 1:35 PM CEST, Carl Huang wrote:
>
>
> On 2024/5/10 16:22, Luca Weiss wrote:
> > On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
> >> Add hardware parameter support_dual_stations to indicate
> >> whether 2 station interfaces are supported. For chips which
> >> support this feature, limit total number of AP interface and
> >> mesh point to 1. The max interfaces are 3 for such chips.
> >>
> >> The chips affected are:
> >>   QCA6390 hw2.0
> >>   WCN6855 hw2.0
> >>   WCN6855 hw2.1
> >> Other chips are not affected.
> >>
> >> For affected chips, remove radar_detect_widths because now
> >> num_different_channels is set to 2. radar_detect_widths can
> >> be set only when num_different_channels is 1. See mac80211
> >> function wiphy_verify_combinations for details.
> >>
> >> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILIC=
ONZ_LITE-3
> >=20
> > Hi Carl,
> >=20
> > Unfortunately this commit breaks wifi on a QCM6490 smartphone
> > (qcm6490-fairphone-fp5) and makes the board crash.
> >=20
> > Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi=
:
> > ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
> > provide address list if chip supports 2 stations")) makes wifi work
> > again.
> >=20
> > Here's the crash log:
> >=20
> > [   43.458118] ath11k 17a10040.wifi: Adding to iommu group 11
> > [   43.459075] ath11k 17a10040.wifi: wcn6750 hw1.0
> > [   43.461219] remoteproc remoteproc2: powering up 8a00000.remoteproc
> > [   43.490363] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fa=
irphone5/wpss.mbn, size 7435056
> > [   43.614039] remoteproc remoteproc2: remote processor 8a00000.remotep=
roc is now up
> > [   43.746227] ath11k 17a10040.wifi: chip_id 0x1 chip_family 0xb board_=
id 0xff soc_id 0xffffffff
> > [   43.746262] ath11k 17a10040.wifi: fw_version 0x1011855b fw_build_tim=
estamp 2023-09-03 07:43 fw_build_id WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> > [   53.116443] qcom_q6v5_pas 8a00000.remoteproc: fatal error received: =
cmnos_thread.c:4645:Asserted in cmnos_allocram.c:cmnos_allocram_base_with_a=
lignment_recurse:497 with Args:0x3,0x3,0x0
> > [   53.116503] remoteproc remoteproc2: crash detected in 8a00000.remote=
proc: type fatal error
> > [   53.116734] remoteproc remoteproc2: handling crash #1 in 8a00000.rem=
oteproc
> > [   53.116749] remoteproc remoteproc2: recovering 8a00000.remoteproc
> > [   53.125088] ath11k 17a10040.wifi: failed to send WMI_PDEV_SET_PARAM =
cmd
> > [   53.125116] ath11k 17a10040.wifi: failed to enable PMF QOS: (-108
> > [   53.125167] remoteproc remoteproc2: stopped remote processor 8a00000=
.remoteproc
> > [   53.127827] ath11k 17a10040.wifi: failed to send WMI_PDEV_SET_PARAM =
cmd
> > [   53.127848] ath11k 17a10040.wifi: failed to enable PMF QOS: (-108
> > [   53.258990] remoteproc remoteproc2: remote processor 8a00000.remotep=
roc is now up
> > [   53.390288] ath11k 17a10040.wifi: chip_id 0x1 chip_family 0xb board_=
id 0xff soc_id 0xffffffff
> > [   53.390319] ath11k 17a10040.wifi: fw_version 0x1011855b fw_build_tim=
estamp 2023-09-03 07:43 fw_build_id WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> > [   53.404765] ath11k 17a10040.wifi: Last interrupt received for each C=
E:
> > [   53.404789] ath11k 17a10040.wifi: CE_id 0 pipe_num 0 580ms before
> > [   53.404804] ath11k 17a10040.wifi: CE_id 1 pipe_num 1 476ms before
> > [   53.404818] ath11k 17a10040.wifi: CE_id 2 pipe_num 2 476ms before
> > [   53.404831] ath11k 17a10040.wifi: CE_id 3 pipe_num 3 580ms before
> > [   53.404844] ath11k 17a10040.wifi: CE_id 5 pipe_num 5 4294720700ms be=
fore
> > [   53.404858] ath11k 17a10040.wifi: CE_id 7 pipe_num 7 4294720700ms be=
fore
> > [   53.404871] ath11k 17a10040.wifi: CE_id 8 pipe_num 8 4294720700ms be=
fore
> > [   53.404883] ath11k 17a10040.wifi:
> >                 Last interrupt received for each group:
> > [   53.404894] ath11k 17a10040.wifi: group_id 0 4294720700ms before
> > [   53.404907] ath11k 17a10040.wifi: group_id 1 4294720700ms before
> > [   53.404918] ath11k 17a10040.wifi: group_id 2 4294720700ms before
> > [   53.404929] ath11k 17a10040.wifi: group_id 3 4294720700ms before
> > [   53.404940] ath11k 17a10040.wifi: group_id 4 4294720700ms before
> > [   53.404952] ath11k 17a10040.wifi: group_id 5 4294720700ms before
> > [   53.404964] ath11k 17a10040.wifi: group_id 6 4294720700ms before
> > [   53.404976] ath11k 17a10040.wifi: group_id 7 4294720700ms before
> > [   53.404987] ath11k 17a10040.wifi: group_id 8 4294720700ms before
> > [   53.404998] ath11k 17a10040.wifi: group_id 9 4294720700ms before
> > [   53.405009] ath11k 17a10040.wifi: group_id 10 4294720700ms before
> > [   53.405021] ath11k 17a10040.wifi: dst srng id 0 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405037] ath11k 17a10040.wifi: dst srng id 1 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405052] ath11k 17a10040.wifi: dst srng id 2 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405066] ath11k 17a10040.wifi: dst srng id 3 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405082] ath11k 17a10040.wifi: dst srng id 4 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405097] ath11k 17a10040.wifi: src srng id 5 hp 0, reap_hp 248, c=
ur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405114] ath11k 17a10040.wifi: src srng id 8 hp 0, reap_hp 2550, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405130] ath11k 17a10040.wifi: dst srng id 9 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405145] ath11k 17a10040.wifi: src srng id 16 hp 0, reap_hp 16376=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405162] ath11k 17a10040.wifi: src srng id 17 hp 0, reap_hp 16376=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405179] ath11k 17a10040.wifi: src srng id 18 hp 0, reap_hp 16376=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405196] ath11k 17a10040.wifi: src srng id 24 hp 0, reap_hp 248, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405213] ath11k 17a10040.wifi: dst srng id 25 tp 0, cur hp 0, cac=
hed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405228] ath11k 17a10040.wifi: src srng id 32 hp 12, reap_hp 8, c=
ur tp 12, cached tp 12 last tp 8 napi processed before 580ms
> > [   53.405244] ath11k 17a10040.wifi: src srng id 35 hp 4, reap_hp 0, cu=
r tp 4, cached tp 4 last tp 0 napi processed before 580ms
> > [   53.405260] ath11k 17a10040.wifi: src srng id 36 hp 20, reap_hp 0, c=
ur tp 20, cached tp 12 last tp 12 napi processed before 460ms
> > [   53.405276] ath11k 17a10040.wifi: src srng id 39 hp 0, reap_hp 124, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405294] ath11k 17a10040.wifi: src srng id 57 hp 1022, reap_hp 10=
22, cur tp 2, cached tp 2 last tp 2 napi processed before 476ms
> > [   53.405310] ath11k 17a10040.wifi: src srng id 58 hp 18, reap_hp 18, =
cur tp 22, cached tp 22 last tp 22 napi processed before 476ms
> > [   53.405327] ath11k 17a10040.wifi: src srng id 61 hp 1020, reap_hp 10=
20, cur tp 0, cached tp 0 last tp 0 napi processed before 584ms
> > [   53.405345] ath11k 17a10040.wifi: dst srng id 81 tp 4, cur hp 4, cac=
hed hp 4 last hp 4 napi processed before 476ms
> > [   53.405361] ath11k 17a10040.wifi: dst srng id 82 tp 44, cur hp 44, c=
ached hp 44 last hp 44 napi processed before 476ms
> > [   53.405378] ath11k 17a10040.wifi: dst srng id 85 tp 0, cur hp 0, cac=
hed hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405394] ath11k 17a10040.wifi: src srng id 104 hp 65532, reap_hp =
65532, cur tp 0, cached tp 0 last tp 0 napi processed before 588ms
> > [   53.405411] ath11k 17a10040.wifi: src srng id 105 hp 0, reap_hp 504,=
 cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405427] ath11k 17a10040.wifi: dst srng id 106 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405443] ath11k 17a10040.wifi: dst srng id 108 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405458] ath11k 17a10040.wifi: dst srng id 109 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405474] ath11k 17a10040.wifi: dst srng id 110 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.405491] ath11k 17a10040.wifi: src srng id 128 hp 8190, reap_hp 8=
190, cur tp 0, cached tp 0 last tp 0 napi processed before 464ms
> > [   53.405507] ath11k 17a10040.wifi: src srng id 129 hp 0, reap_hp 2046=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294720700ms
> > [   53.405525] ath11k 17a10040.wifi: src srng id 132 hp 2046, reap_hp 2=
046, cur tp 0, cached tp 0 last tp 0 napi processed before 460ms
> > [   53.405542] ath11k 17a10040.wifi: dst srng id 133 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294720700ms
> > [   53.747641] qcom_q6v5_pas 8a00000.remoteproc: fatal error received: =
platform_msl.c:513:PCIE ACMT error debug0 0x6030, debug1 0x101
> > [   53.747677] remoteproc remoteproc2: crash detected in 8a00000.remote=
proc: type fatal error
> > [   53.747864] remoteproc remoteproc2: handling crash #2 in 8a00000.rem=
oteproc
> > [   53.747875] remoteproc remoteproc2: recovering 8a00000.remoteproc
> > [   53.758632] remoteproc remoteproc2: stopped remote processor 8a00000=
.remoteproc
> > [   53.886889] remoteproc remoteproc2: remote processor 8a00000.remotep=
roc is now up
> > [   54.017475] ath11k 17a10040.wifi: chip_id 0x1 chip_family 0xb board_=
id 0xff soc_id 0xffffffff
> > [   54.017505] ath11k 17a10040.wifi: fw_version 0x1011855b fw_build_tim=
estamp 2023-09-03 07:43 fw_build_id WLAN.MSL.1.0.1-01371-QCAMSLSWPLZ-1
> > [   54.027605] ath11k 17a10040.wifi: Last interrupt received for each C=
E:
> > [   54.027627] ath11k 17a10040.wifi: CE_id 0 pipe_num 0 1204ms before
> > [   54.027642] ath11k 17a10040.wifi: CE_id 1 pipe_num 1 1100ms before
> > [   54.027655] ath11k 17a10040.wifi: CE_id 2 pipe_num 2 1100ms before
> > [   54.027667] ath11k 17a10040.wifi: CE_id 3 pipe_num 3 1204ms before
> > [   54.027680] ath11k 17a10040.wifi: CE_id 5 pipe_num 5 4294721324ms be=
fore
> > [   54.027692] ath11k 17a10040.wifi: CE_id 7 pipe_num 7 4294721324ms be=
fore
> > [   54.027704] ath11k 17a10040.wifi: CE_id 8 pipe_num 8 4294721324ms be=
fore
> > [   54.027716] ath11k 17a10040.wifi:
> >                 Last interrupt received for each group:
> > [   54.027726] ath11k 17a10040.wifi: group_id 0 4294721324ms before
> > [   54.027738] ath11k 17a10040.wifi: group_id 1 4294721324ms before
> > [   54.027749] ath11k 17a10040.wifi: group_id 2 4294721324ms before
> > [   54.027760] ath11k 17a10040.wifi: group_id 3 4294721324ms before
> > [   54.027771] ath11k 17a10040.wifi: group_id 4 4294721324ms before
> > [   54.027782] ath11k 17a10040.wifi: group_id 5 4294721324ms before
> > [   54.027794] ath11k 17a10040.wifi: group_id 6 4294721324ms before
> > [   54.027805] ath11k 17a10040.wifi: group_id 7 4294721324ms before
> > [   54.027816] ath11k 17a10040.wifi: group_id 8 4294721324ms before
> > [   54.027827] ath11k 17a10040.wifi: group_id 9 4294721324ms before
> > [   54.027838] ath11k 17a10040.wifi: group_id 10 4294721324ms before
> > [   54.027850] ath11k 17a10040.wifi: dst srng id 4 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.027866] ath11k 17a10040.wifi: src srng id 5 hp 0, reap_hp 248, c=
ur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.027882] ath11k 17a10040.wifi: src srng id 8 hp 0, reap_hp 2550, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.027898] ath11k 17a10040.wifi: dst srng id 9 tp 0, cur hp 0, cach=
ed hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.027914] ath11k 17a10040.wifi: src srng id 16 hp 0, reap_hp 16376=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.027930] ath11k 17a10040.wifi: src srng id 17 hp 0, reap_hp 16376=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.027947] ath11k 17a10040.wifi: src srng id 18 hp 0, reap_hp 16376=
, cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.027964] ath11k 17a10040.wifi: src srng id 24 hp 0, reap_hp 248, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.027980] ath11k 17a10040.wifi: dst srng id 25 tp 0, cur hp 0, cac=
hed hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.027997] ath11k 17a10040.wifi: src srng id 32 hp 0, reap_hp 60, c=
ur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.028014] ath11k 17a10040.wifi: src srng id 35 hp 0, reap_hp 124, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.028030] ath11k 17a10040.wifi: src srng id 36 hp 0, reap_hp 8188,=
 cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.028045] ath11k 17a10040.wifi: src srng id 39 hp 0, reap_hp 124, =
cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.028063] ath11k 17a10040.wifi: src srng id 57 hp 1020, reap_hp 10=
20, cur tp 0, cached tp 0 last tp 0 napi processed before 440ms
> > [   54.028079] ath11k 17a10040.wifi: src srng id 58 hp 1020, reap_hp 10=
20, cur tp 0, cached tp 0 last tp 0 napi processed before 436ms
> > [   54.028095] ath11k 17a10040.wifi: src srng id 61 hp 1020, reap_hp 10=
20, cur tp 0, cached tp 0 last tp 0 napi processed before 436ms
> > [   54.028112] ath11k 17a10040.wifi: dst srng id 81 tp 0, cur hp 0, cac=
hed hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.028128] ath11k 17a10040.wifi: dst srng id 82 tp 0, cur hp 0, cac=
hed hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.028143] ath11k 17a10040.wifi: dst srng id 85 tp 0, cur hp 0, cac=
hed hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.028160] ath11k 17a10040.wifi: src srng id 104 hp 65532, reap_hp =
65532, cur tp 0, cached tp 0 last tp 0 napi processed before 448ms
> > [   54.028177] ath11k 17a10040.wifi: src srng id 105 hp 0, reap_hp 504,=
 cur tp 0, cached tp 0 last tp 0 napi processed before 4294721324ms
> > [   54.028194] ath11k 17a10040.wifi: dst srng id 106 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.028210] ath11k 17a10040.wifi: dst srng id 108 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.028226] ath11k 17a10040.wifi: dst srng id 109 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.028242] ath11k 17a10040.wifi: dst srng id 110 tp 0, cur hp 0, ca=
ched hp 0 last hp 0 napi processed before 4294721324ms
> > [   54.622819] ath11k 17a10040.wifi: failed to receive control response=
 completion, polling..
> > [   55.646232] ath11k 17a10040.wifi: ctl_resp never came in (-110)
> > [   55.646259] ath11k 17a10040.wifi: failed to connect to HTC: -110
> > [   55.653201] ath11k 17a10040.wifi: failed to start core: -110
> >=20
> >=20
> > Let me know if you need any more information.
> >=20
> > Regards
> > Luca
> >=20
> >>
> >> Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
> >> ---
> >>   drivers/net/wireless/ath/ath11k/core.c | 14 ++++--
> >>   drivers/net/wireless/ath/ath11k/hw.c   |  2 +-
> >>   drivers/net/wireless/ath/ath11k/hw.h   |  1 +
> >>   drivers/net/wireless/ath/ath11k/mac.c  | 62 +++++++++++++++++-------=
--
> >>   4 files changed, 53 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wire=
less/ath/ath11k/core.c
> >> index bebfd342e28b..739a8d13d57d 100644
> >> --- a/drivers/net/wireless/ath/ath11k/core.c
> >> +++ b/drivers/net/wireless/ath/ath11k/core.c
> >> @@ -120,6 +120,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tcl_ring_retry =3D true,
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >> +		.support_dual_stations =3D false,
> >>   	},
> >>   	{
> >>   		.hw_rev =3D ATH11K_HW_IPQ6018_HW10,
> >> @@ -202,6 +203,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >>   		.support_fw_mac_sequence =3D false,
> >> +		.support_dual_stations =3D false,
> >>   	},
> >>   	{
> >>   		.name =3D "qca6390 hw2.0",
> >> @@ -251,7 +253,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.cold_boot_calib =3D false,
> >>   		.cbcal_restart_fw =3D false,
> >>   		.fw_mem_mode =3D 0,
> >> -		.num_vdevs =3D 16 + 1,
> >> +		.num_vdevs =3D 2 + 1,
> >>   		.num_peers =3D 512,
> >>   		.supports_suspend =3D true,
> >>   		.hal_desc_sz =3D sizeof(struct hal_rx_desc_ipq8074),
> >> @@ -286,6 +288,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >>   		.support_fw_mac_sequence =3D true,
> >> +		.support_dual_stations =3D true,
> >>   	},
> >>   	{
> >>   		.name =3D "qcn9074 hw1.0",
> >> @@ -367,6 +370,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >>   		.support_fw_mac_sequence =3D false,
> >> +		.support_dual_stations =3D false,
> >>   	},
> >>   	{
> >>   		.name =3D "wcn6855 hw2.0",
> >> @@ -416,7 +420,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.cold_boot_calib =3D false,
> >>   		.cbcal_restart_fw =3D false,
> >>   		.fw_mem_mode =3D 0,
> >> -		.num_vdevs =3D 16 + 1,
> >> +		.num_vdevs =3D 2 + 1,
> >>   		.num_peers =3D 512,
> >>   		.supports_suspend =3D true,
> >>   		.hal_desc_sz =3D sizeof(struct hal_rx_desc_wcn6855),
> >> @@ -451,6 +455,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >>   		.support_fw_mac_sequence =3D true,
> >> +		.support_dual_stations =3D true,
> >>   	},
> >>   	{
> >>   		.name =3D "wcn6855 hw2.1",
> >> @@ -498,7 +503,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.cold_boot_calib =3D false,
> >>   		.cbcal_restart_fw =3D false,
> >>   		.fw_mem_mode =3D 0,
> >> -		.num_vdevs =3D 16 + 1,
> >> +		.num_vdevs =3D 2 + 1,
> >>   		.num_peers =3D 512,
> >>   		.supports_suspend =3D true,
> >>   		.hal_desc_sz =3D sizeof(struct hal_rx_desc_wcn6855),
> >> @@ -533,6 +538,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >>   		.support_fw_mac_sequence =3D true,
> >> +		.support_dual_stations =3D true,
> >>   	},
> >>   	{
> >>   		.name =3D "wcn6750 hw1.0",
> >> @@ -613,6 +619,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE_WCN6750,
> >>   		.smp2p_wow_exit =3D true,
> >>   		.support_fw_mac_sequence =3D true,
> >> +		.support_dual_stations =3D false,
> >>   	},
> >>   	{
> >>   		.hw_rev =3D ATH11K_HW_IPQ5018_HW10,
> >> @@ -693,6 +700,7 @@ static const struct ath11k_hw_params ath11k_hw_par=
ams[] =3D {
> >>   		.tx_ring_size =3D DP_TCL_DATA_RING_SIZE,
> >>   		.smp2p_wow_exit =3D false,
> >>   		.support_fw_mac_sequence =3D false,
> >> +		.support_dual_stations =3D false,
> >>   	},
> >>   };
> >>  =20
> >> diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wirele=
ss/ath/ath11k/hw.c
> >> index d7b5ec6e6904..3b56ba1b8534 100644
> >> --- a/drivers/net/wireless/ath/ath11k/hw.c
> >> +++ b/drivers/net/wireless/ath/ath11k/hw.c
> >> @@ -58,7 +58,7 @@ static void ath11k_hw_wcn6855_tx_mesh_enable(struct =
ath11k_base *ab,
> >>   static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
> >>   					   struct target_resource_config *config)
> >>   {
> >> -	config->num_vdevs =3D 4;
> >> +	config->num_vdevs =3D ab->hw_params.num_vdevs;
>
> Hi Luca, I guess above line caused WCN6750 crash.
> For a quick try, you can change it back to "config->num_vdevs =3D 4".
>
> A more reasonable fix coule be to define a dedicated function like=20
> ath11k_init_wmi_config_wcn6750() so wcn6750 doesn't use the same=20
> function as QCA6390 and WCN6855, and everything changed in this patch=20
> will not affect wcn6750.

Hi Carl,

Thanks for the quick response!

It seems you're right, applying the following patch without the reverts
on 6.9-rc6 doesn't make the phone crash anymore and wifi seems to work
fine, thanks!

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/at=
h/ath11k/hw.c
index caa6dc12a790..77d8f9237680 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -58,7 +58,7 @@ static void ath11k_hw_wcn6855_tx_mesh_enable(struct ath11=
k_base *ab,
 static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
 					   struct target_resource_config *config)
 {
-	config->num_vdevs =3D ab->hw_params.num_vdevs;
+	config->num_vdevs =3D 4;
 	config->num_peers =3D 16;
 	config->num_tids =3D 32;
=20


