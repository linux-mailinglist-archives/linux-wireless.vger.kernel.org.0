Return-Path: <linux-wireless+bounces-4907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644087FFC1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 15:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13092838F6
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DA200BF;
	Tue, 19 Mar 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="qOiTWdFH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51E1CFB6
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859159; cv=none; b=FohiCM41diI6kJLrXEON6iLhcgzed5WtI5kxBpdjmV3G2B3v4X1jg38ylx8nH3BbTbRLSN7YlvMI22RUCxWkoUKX9aEbxIytLnL1IoiB7DGjBVrMG+TyOYMhnOyPrOsSZigUFeqDGNTb9BJ5N8Xas2ZBE/B4aZebGDT73R0kilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859159; c=relaxed/simple;
	bh=kodWpCbk6Fjyx9gbyJEge3tHUHs86j0se8IGiZyejlo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sBBY64QXnSbOoYea7YXJet2fZl++CkSK6MfHOJdj3EpmfmaJ3P2iNAuamGHrwhalgYt27HzuFDousaMF6bmOtnHKxavR+IK3bF/Qt8mR9Po/PqA4JtaK3wF7/TDSIyHtRKJZ3OJ3Fn4yODkCc0y/Nm1wIAXa3+gefDQMrAsF1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=qOiTWdFH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41467d697a2so3085625e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1710859153; x=1711463953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTTqi0Ckwq2Sihfq+s9KqZZVFQIFuJedm2u8w80K7K8=;
        b=qOiTWdFHgOZ3LPV22k3dD8DsU/sbitr7TgvoiLB3+V2o7t+oLC3Mpz8L/IuVlJJjlg
         4YTi3euHYqLotSbVH8WUeofnuXbjOONWn8/kh+bewzsJ81bMMNP7ImArbiWm7tjC2eFX
         bf7sWqGNkD0ZPkKaJ+T4v8mC72lLc20ZoAP8ULpxb/sq/ufbxaOaNFLkmnvh4977rdB3
         MhhWYOgzWILcMt/PvB6O+zEmYxSsycdOWh65FvrwWp7i6yjnuGX+l4i6egr+9d/G8oUw
         tgvRBTzxNVPX6MbZoHH1JrM88/hXYg+sZD2PVCq6S9k5hthUKVu4RefzL5qL9m3V69cX
         Unew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859153; x=1711463953;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTTqi0Ckwq2Sihfq+s9KqZZVFQIFuJedm2u8w80K7K8=;
        b=U+iyZKso6MRWEP2ZEi2icGcruP+Emft2WcJTzZpar/XlmJy3VxMig1d7SY0VVcpMuw
         v/LtahAnc74/R8vU+glyvJw7RK/hXV8Hc1N6RsbV9zP9KqlToWzQx4m+uFtnIEKi2Tj6
         9eVEpaV517PKJBeqw283C5/tP62sLeA8ZX3s16m6vLa6X6LelX+X+3r2hxmUvHYp2VY/
         5WnzdBptD14kjAs5ljcLQA5WTvUR+ildG2kNgcYwIu/Y8Xq/bdOVqT2nG6OTKk/xO+ra
         ztjQy8Qwxch7/1xjcKDumvxEwKUd1XDBAjThssfQm/3SV/CpsghaOptMR3c0xlS7AL0r
         LdGQ==
X-Gm-Message-State: AOJu0YxsOnHymUy2hqQc/Dvs2cPFtfFNAUuGe4XhbRgFThUZpGN3KQDf
	Kv6cOecCIdtLqR+1JpQE3UMCuTS+R+eFFV7H4rGFdBVKrF7liSTXZzDYnOBZvYM7FvuBnq90RAN
	h
X-Google-Smtp-Source: AGHT+IFgFh+pFmV4x2+bnZmPkNt/vYn+2BhFwjhjQMhGYWZCrjLNwcZLFwLNI718gozLcgO9lQ3I2A==
X-Received: by 2002:a05:600c:45c9:b0:413:ef04:d342 with SMTP id s9-20020a05600c45c900b00413ef04d342mr12491380wmo.9.1710859153469;
        Tue, 19 Mar 2024 07:39:13 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id fk5-20020a05600c0cc500b0041468b3b84dsm706047wmb.13.2024.03.19.07.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 07:39:13 -0700 (PDT)
Message-ID: <a1dd2944-5d20-4fbe-84f3-b03a0cd5835d@freebox.fr>
Date: Tue, 19 Mar 2024 15:39:12 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
To: wireless <linux-wireless@vger.kernel.org>,
 ath10k <ath10k@lists.infradead.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 DT <devicetree@vger.kernel.org>, Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
 <f26dfcc6-5fd3-486d-b0f2-80168eb213c7@freebox.fr>
 <880e016a-d4d2-4bc9-8c75-bbe4848515ad@freebox.fr>
In-Reply-To: <880e016a-d4d2-4bc9-8c75-bbe4848515ad@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 14:47, Marc Gonzalez wrote:

> [   15.255763] remoteproc remoteproc0: powering up 4080000.remoteproc
> [   15.263925] remoteproc remoteproc0: Booting fw image mba.mbn, size 234152
> [   15.277228] ath10k_snoc 18800000.wifi: received modem starting event
> [   15.370471] qcom-q6v5-mss 4080000.remoteproc: MBA booted without debug policy, loading mpss
> [   16.020964] ath10k_snoc 18800000.wifi: received modem running event
> [   16.029559] remoteproc remoteproc0: remote processor 4080000.remoteproc is now up
> [   18.649633] ath10k_snoc 18800000.wifi: wifi fw qmi service found
> [   18.649870] ath10k_snoc 18800000.wifi: qmi wifi fw qmi service connected
> [   18.658200] ath10k_snoc 18800000.wifi: qmi indication register request completed
> [   18.666483] ath10k_snoc 18800000.wifi: qmi host capability request completed
> [   18.674486] ath10k_snoc 18800000.wifi: qmi msa mem region 0 addr 0x0x0000000094400000 size 0x4000 flag 0x00000001
> [   18.676164] ath10k_snoc 18800000.wifi: qmi msa mem region 1 addr 0x0x0000000094404000 size 0xfc000 flag 0x00000000
> [   18.686350] ath10k_snoc 18800000.wifi: qmi msa mem info request completed
> [   18.738546] ath10k_snoc 18800000.wifi: qmi msa mem ready request completed
> [   18.791705] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214 chip_family 0x4001 board_id 0xff soc_id 0x40010002
> [   18.792014] ath10k_snoc 18800000.wifi: qmi fw_version 0x100204b2 fw_build_timestamp 2019-09-04 03:01 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
> 
> Yet, I still don't have a wlan network interface.

What a dweeb... bitten by the very bug I'm supposed to fix :(

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 38e939f572a9e..b4af48b7ec6db 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1040,6 +1040,7 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
                switch (event->type) {
                case ATH10K_QMI_EVENT_SERVER_ARRIVE:
                        ath10k_qmi_event_server_arrive(qmi);
+                       ath10k_qmi_event_msa_ready(qmi);
                        break;
                case ATH10K_QMI_EVENT_SERVER_EXIT:
                        ath10k_qmi_event_server_exit(qmi);


[   18.334050] ath10k_snoc 18800000.wifi: wifi fw qmi service found
[   18.334197] ath10k_snoc 18800000.wifi: qmi wifi fw qmi service connected
[   18.342968] ath10k_snoc 18800000.wifi: qmi indication register request completed
[   18.350886] ath10k_snoc 18800000.wifi: qmi host capability request completed
[   18.358927] ath10k_snoc 18800000.wifi: qmi msa mem region 0 addr 0x0x0000000094400000 size 0x4000 flag 0x00000001
[   18.360430] ath10k_snoc 18800000.wifi: qmi msa mem region 1 addr 0x0x0000000094404000 size 0xfc000 flag 0x00000000
[   18.370640] ath10k_snoc 18800000.wifi: qmi msa mem info request completed
[   18.421465] ath10k_snoc 18800000.wifi: qmi msa mem ready request completed
[   18.474494] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214 chip_family 0x4001 board_id 0xff soc_id 0x40010002
[   18.474675] ath10k_snoc 18800000.wifi: qmi fw_version 0x100204b2 fw_build_timestamp 2019-09-04 03:01 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
[   18.483671] ath10k_snoc 18800000.wifi: DT bdf variant name not set.
[   18.499350] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   18.505661] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   18.515352] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff'
[   18.555414] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/board-2.bin': 0
[   18.555820] ath10k_snoc 18800000.wifi: board name
[   18.563247] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.568043] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37                          rd-id=67
[   18.578242] ath10k_snoc 18800000.wifi: board name
[   18.587717] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.592589] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66                          rd-id=ff
[   18.602762] ath10k_snoc 18800000.wifi: board name
[   18.612283] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.617137] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.627419] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   18.637716] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 50 4f 4d 50 4f 4d                 t=GO_POMPOM
[   18.648036] ath10k_snoc 18800000.wifi: board name
[   18.657898] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.662707] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.672955] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   18.683317] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 50 4f 4d 50 4f 4d                    =GO_POMPOM
[   18.693598] ath10k_snoc 18800000.wifi: board name
[   18.703470] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.708190] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.718433] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   18.728763] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 4c 41 5a 4f 52                    t=GO_LAZOR
[   18.739081] ath10k_snoc 18800000.wifi: board name
[   18.748953] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.753676] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.763920] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   18.774283] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 4c 41 5a 4f 52                       =GO_LAZOR
[   18.784566] ath10k_snoc 18800000.wifi: board name
[   18.794089] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.799075] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.809339] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   18.819652] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 51 55 41 43 4b 49 4e 47 53 54 49 43  =GO_QUACKINGSTIC
[   18.829978] ath10k_snoc 18800000.wifi: 00000040: 4b                                               K
[   18.840276] ath10k_snoc 18800000.wifi: board name
[   18.849126] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.854109] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.864353] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   18.874672] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 51 55 41 43 4b 49 4e 47 53 54 49  t=GO_QUACKINGSTI
[   18.885022] ath10k_snoc 18800000.wifi: 00000040: 43 4b                                            CK
[   18.895333] ath10k_snoc 18800000.wifi: board name
[   18.904510] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.909231] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.919474] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   18.929802] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 51 55 41 43 4b 49 4e 47 53 54 49 43  =GO_QUACKINGSTIC
[   18.940147] ath10k_snoc 18800000.wifi: 00000040: 4b 5f 4c 54 45                                   K_LTE
[   18.950446] ath10k_snoc 18800000.wifi: board name
[   18.959627] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   18.964613] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 36 37 2c 71 6d 69 2d 63 68 69  rd-id=67,qmi-chi
[   18.974895] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   18.985256] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 51 55 41 43 4b 49 4e 47 53 54 49  t=GO_QUACKINGSTI
[   19.002585] ath10k_snoc 18800000.wifi: 00000040: 43 4b 5f 4c 54 45                                CK_LTE
[   19.013010] ath10k_snoc 18800000.wifi: board name
[   19.022479] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.029881] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.039078] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   19.049454] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 48 4f 4d 45 53 54 41 52           t=GO_HOMESTAR
[   19.059914] ath10k_snoc 18800000.wifi: board name
[   19.069703] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.077270] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.086469] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   19.096881] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 48 4f 4d 45 53 54 41 52              =GO_HOMESTAR
[   19.107202] ath10k_snoc 18800000.wifi: board name
[   19.116993] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.124477] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.133675] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   19.144128] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 57 4f 52 4d 44 49 4e 47 4c 45 52  t=GO_WORMDINGLER
[   19.154503] ath10k_snoc 18800000.wifi: board name
[   19.164791] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.172543] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.181702] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   19.192084] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 57 4f 52 4d 44 49 4e 47 4c 45 52     =GO_WORMDINGLER
[   19.202404] ath10k_snoc 18800000.wifi: board name
[   19.212616] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.220364] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.229564] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 34 33 32 30 2c 76 61 72 69 61 6e  p-id=4320,varian
[   19.239885] ath10k_snoc 18800000.wifi: 00000030: 74 3d 47 4f 5f 4d 52 42 4c 41 4e 44              t=GO_MRBLAND
[   19.250240] ath10k_snoc 18800000.wifi: board name
[   19.260102] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.267858] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.277048] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 32 30 2c 76 61 72 69 61 6e 74  p-id=320,variant
[   19.287390] ath10k_snoc 18800000.wifi: 00000030: 3d 47 4f 5f 4d 52 42 4c 41 4e 44                 =GO_MRBLAND
[   19.297730] ath10k_snoc 18800000.wifi: board name
[   19.307602] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.315384] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.324567] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 30 32 31 34 2c 76 61 72 69 61  p-id=30214,varia
[   19.334892] ath10k_snoc 18800000.wifi: 00000030: 6e 74 3d 54 68 75 6e 64 65 72 63 6f 6d 6d 5f 44  nt=Thundercomm_D
[   19.345267] ath10k_snoc 18800000.wifi: 00000040: 42 38 34 35 43                                   B845C
[   19.355577] ath10k_snoc 18800000.wifi: board name
[   19.364698] ath10k_snoc 18800000.wifi: 00000000: 62 75 73 3d 73 6e 6f 63 2c 71 6d 69 2d 62 6f 61  bus=snoc,qmi-boa
[   19.372459] ath10k_snoc 18800000.wifi: 00000010: 72 64 2d 69 64 3d 66 66 2c 71 6d 69 2d 63 68 69  rd-id=ff,qmi-chi
[   19.381631] ath10k_snoc 18800000.wifi: 00000020: 70 2d 69 64 3d 33 30 32 31 34                    p-id=30214
[   19.391978] ath10k_snoc 18800000.wifi: boot found match for name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   19.401933] ath10k_snoc 18800000.wifi: boot found board data for 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   19.411680] ath10k_snoc 18800000.wifi: using board api 2
[   19.426886] ath10k_snoc 18800000.wifi: qmi bdf download request completed
[   19.436034] ath10k_snoc 18800000.wifi: qmi cal report request completed
[   22.645730] ath10k_snoc 18800000.wifi: wifi fw ready event received
[   22.653332] ath10k_snoc 18800000.wifi: ath10k_snoc_hif_power_up:WCN3990 driver state = 0
[   22.660822] ath10k_snoc 18800000.wifi: soc power on
[   22.674974] ath10k_snoc 18800000.wifi: qmi mode 0 config 00000000d4ac2648
[   22.691524] ath10k_snoc 18800000.wifi: qmi config request completed
[   22.756845] ath10k_snoc 18800000.wifi: qmi wlan mode req completed: 0
[   22.764304] ath10k_snoc 18800000.wifi: boot init ce src ring id 0 entries 16 base_addr 000000008a771643
[   22.771723] ath10k_snoc 18800000.wifi: boot ce dest ring id 1 entries 512 base_addr 00000000456c5b44
[   22.779938] ath10k_snoc 18800000.wifi: boot ce dest ring id 2 entries 64 base_addr 00000000dacea75c
[   22.789124] ath10k_snoc 18800000.wifi: boot init ce src ring id 3 entries 32 base_addr 000000009d09a7e8
[   22.797937] ath10k_snoc 18800000.wifi: boot init ce src ring id 4 entries 2048 base_addr 000000001b01ecda
[   22.807246] ath10k_snoc 18800000.wifi: boot ce dest ring id 5 entries 512 base_addr 00000000d75a5547
[   22.816935] ath10k_snoc 18800000.wifi: boot init ce src ring id 7 entries 2 base_addr 000000000f5bef9f
[   22.826117] ath10k_snoc 18800000.wifi: boot ce dest ring id 7 entries 2 base_addr 0000000042113a43
[   22.835231] ath10k_snoc 18800000.wifi: boot ce dest ring id 8 entries 128 base_addr 00000000fc8c671c
[   22.844099] ath10k_snoc 18800000.wifi: boot ce dest ring id 9 entries 512 base_addr 0000000041b1f577
[   22.853348] ath10k_snoc 18800000.wifi: boot ce dest ring id 10 entries 512 base_addr 00000000670dc8b3
[   22.862415] ath10k_snoc 18800000.wifi: boot ce dest ring id 11 entries 512 base_addr 00000000fd62644d
[   22.871524] ath10k_snoc 18800000.wifi: Hardware name wcn3990 hw1.0 version 0x8
[   22.882456] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/pre-cal-snoc-18800000.wifi.bin': -2
[   22.890396] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/cal-snoc-18800000.wifi.bin': -2
[   22.897361] ath10k_snoc 18800000.wifi: trying fw api 6
[   22.907107] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-6.bin': -2
[   22.914837] ath10k_snoc 18800000.wifi: trying fw api 5
[   22.929033] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-5.bin': 0
[   22.937607] ath10k_snoc 18800000.wifi: found fw timestamp 1539237028
[   22.945416] ath10k_snoc 18800000.wifi: found firmware features ie (3 B)
[   22.953667] ath10k_snoc 18800000.wifi: Enabling feature bit: 6
[   22.961046] ath10k_snoc 18800000.wifi: Enabling feature bit: 18
[   22.969963] ath10k_snoc 18800000.wifi: Enabling feature bit: 19
[   22.978899] ath10k_snoc 18800000.wifi: features
[   22.986469] ath10k_snoc 18800000.wifi: 00000000: 40 00 0c 00 00 00 00 00                          @.......
[   22.992940] ath10k_snoc 18800000.wifi: found fw ie wmi op version 4
[   23.001282] ath10k_snoc 18800000.wifi: found fw ie htt op version 3
[   23.007632] ath10k_snoc 18800000.wifi: using fw api 5
[   23.013826] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
[   23.020081] ath10k_snoc 18800000.wifi: kconfig debug 1 debugfs 1 tracing 0 dfs 0 testmode 0
[   23.028162] ath10k_snoc 18800000.wifi: firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
[   23.036548] ath10k_snoc 18800000.wifi: snoc hif map service
[   23.047238] ath10k_snoc 18800000.wifi: boot htc service 'Control' ul pipe 0 dl pipe 2 eid 0 ready
[   23.053428] ath10k_snoc 18800000.wifi: boot htc service 'Control' eid 0 TX flow control disabled
[   23.061734] ath10k_snoc 18800000.wifi: htt tx max num pending tx 1056
[   23.070954] ath10k_snoc 18800000.wifi: htt rx ring size 2048 fill_level 2047
[   23.082569] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 20
[   23.085448] ath10k_snoc 18800000.wifi: htc rx completion ep 0 skb 00000000732bd6c4
[   23.100773] ath10k_snoc 18800000.wifi: boot hif start
[   23.106787] ath10k_snoc 18800000.wifi: Target ready! transmit resources: 1 size:2184 actual credits:2
[   23.112725] ath10k_snoc 18800000.wifi: Extended ready message RX bundle size 0 alt size 0
[   23.120836] ath10k_snoc 18800000.wifi: boot htc service HTT Data does not allocate target credits
[   23.129034] ath10k_snoc 18800000.wifi: ath10k_htc_build_tx_ctrl_skb: skb 00000000a29e6712
[   23.137965] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fed3e04c len 16 n_items 1
[   23.146114] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 0 skb 00000000a29e6712
[   23.151729] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 20
[   23.160549] ath10k_snoc 18800000.wifi: htc rx completion ep 0 skb 00000000ac1cd2b0
[   23.166556] ath10k_snoc 18800000.wifi: HTC Service HTT Data connect response: status: 0x0, assigned ep: 0x1
[   23.176988] ath10k_snoc 18800000.wifi: snoc hif map service
[   23.186436] ath10k_snoc 18800000.wifi: boot htc service 'HTT Data' ul pipe 4 dl pipe 1 eid 1 ready
[   23.192282] ath10k_snoc 18800000.wifi: boot htc service 'HTT Data' eid 1 TX flow control disabled
[   23.201085] ath10k_snoc 18800000.wifi: ath10k_htc_build_tx_ctrl_skb: skb 000000001e6b1281
[   23.209988] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe8f004c len 16 n_items 1
[   23.218595] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 0 skb 000000001e6b1281
[   23.223955] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 20
[   23.232767] ath10k_snoc 18800000.wifi: htc rx completion ep 0 skb 000000009a413c60
[   23.238803] ath10k_snoc 18800000.wifi: HTC Service WMI connect response: status: 0x0, assigned ep: 0x2
[   23.249130] ath10k_snoc 18800000.wifi: snoc hif map service
[   23.258271] ath10k_snoc 18800000.wifi: boot htc service 'WMI' ul pipe 3 dl pipe 2 eid 2 ready
[   23.264082] ath10k_snoc 18800000.wifi: ath10k_htc_build_tx_ctrl_skb: skb 0000000080367b62
[   23.272479] ath10k_snoc 18800000.wifi: HTC is using TX credit flow control
[   23.280676] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe32b04c len 20 n_items 1
[   23.287464] ath10k_snoc 18800000.wifi: snoc hif map service
[   23.287492] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 0 skb 0000000080367b62
[   23.290290] ath10k_snoc 18800000.wifi: unsupported HTC pktlog service id: 1536
[   23.295912] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 336
[   23.323227] ath10k_snoc 18800000.wifi: htc rx completion ep 2 skb 000000005a1336ea
[   23.326097] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 832
[   23.326421] ath10k_snoc 18800000.wifi: wmi tlv abi 0x01000000 ?= 0x01000000, 0x5f414351 ?= 0x5f414351, 0x00004c4d ?= 0x00004c4d, 0x00000000 ?= 0x00000000, 0x00000000 ?= 0x00000000
[   23.329720] ath10k_snoc 18800000.wifi: htc rx completion ep 2 skb 000000001342908e
[   23.329728] ath10k_snoc 18800000.wifi: Unknown eventid: 16393
[   23.371591] ath10k_snoc 18800000.wifi: wmi svc: 00000000: 0d 00 00 00 07 00 00 00 0d 00 00 00 03 00 00 00  ................
[   23.377879] ath10k_snoc 18800000.wifi: wmi svc: 00000010: 0f 00 00 00 09 00 00 00 0b 00 00 00 0f 00 00 00  ................
[   23.387677] ath10k_snoc 18800000.wifi: wmi svc: 00000020: 0a 00 00 00 09 00 00 00 02 00 00 00 0a 00 00 00  ................
[   23.398759] ath10k_snoc 18800000.wifi: wmi svc: 00000030: 01 00 00 00 0d 00 00 00 07 00 00 00 0f 00 00 00  ................
[   23.409868] ath10k_snoc 18800000.wifi: wmi svc: 00000040: 0b 00 00 00 04 00 00 00 04 00 00 00 0b 00 00 00  ................
[   23.420945] ath10k_snoc 18800000.wifi: wmi svc: 00000050: 07 00 00 00 00 00 00 00 08 00 00 00 01 00 00 00  ................
[   23.432079] ath10k_snoc 18800000.wifi: wmi svc: 00000060: 09 00 00 00 03 00 00 00 05 00 00 00 00 00 00 00  ................
[   23.443099] ath10k_snoc 18800000.wifi: wmi svc: 00000070: 01 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00  ................
[   23.454146] ath10k_snoc 18800000.wifi: wmi sys_cap_info 0x0
[   23.465226] ath10k_snoc 18800000.wifi: wmi event service ready min_tx_power 0x0000003f max_tx_power 0x0000003f ht_cap 0x0000381b vht_cap 0x739139b2 vht_supp_mcs 0x0000fffe sw_ver0 0x01000000 sw_ver1 0x000001ab fw_build 0x100204b2 phy_capab 0x00000003 num_rf_chains 0x00000002 eeprom_rd 0x00000000 low_2ghz_chan 2312 high_2ghz_chan 2732 low_5ghz_chan 4912 high_5ghz_chan 6100 num_mem_reqs 0x00000000
[   23.490641] ath10k_snoc 18800000.wifi: firmware 1.0.0.427 booted
[   23.506500] ath10k_snoc 18800000.wifi: wmi tlv init
[   23.512933] ath10k_snoc 18800000.wifi: htc ep 2 consumed 1 credits total 0
[   23.519410] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe165ac0 len 228 n_items 1
[   23.526324] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 2 skb 0000000062479e09
[   23.555734] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 60
[   23.558938] ath10k_snoc 18800000.wifi: htc rx completion ep 2 skb 0000000025ab7e7b
[   23.563704] ath10k_snoc 18800000.wifi: wmi event ready sw_version 0x01000000 abi_version 427 mac_addr 00:00:00:00:00:00 status 0
[   23.571446] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 16
[   23.571859] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe164740 len 12 n_items 1
[   23.579846] ath10k_snoc 18800000.wifi: htc ep 2 got 1 credits (total 1)
[   23.609073] ath10k_snoc 18800000.wifi: snoc rx ce pipe 1 len 12
[   23.616483] ath10k_snoc 18800000.wifi: htc rx completion ep 1 skb 000000000d2065ff
[   23.623317] ath10k_snoc 18800000.wifi: htt rx, msg_type: 0x0
[   23.630433] ath10k_snoc 18800000.wifi: htt target version 3.44
[   23.637214] ath10k_snoc 18800000.wifi: htt frag desc bank cmd
[   23.643861] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe15f240 len 72 n_items 1
[   23.650558] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe15ef40 len 56 n_items 1
[   23.658000] ath10k_snoc 18800000.wifi: htt h2t aggr cfg msg amsdu 3 ampdu 64
[   23.666647] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe15da40 len 12 n_items 1
[   23.674012] ath10k_snoc 18800000.wifi: wmi tlv pktlog disable
[   23.682390] ath10k_snoc 18800000.wifi: htc ep 2 consumed 1 credits total 0
[   23.689079] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe15c840 len 20 n_items 1
[   23.696575] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 16
[   23.697086] ath10k_snoc 18800000.wifi: qmi fw log request completed, mode: 0
[   23.703676] ath10k_snoc 18800000.wifi: htc ep 2 got 1 credits (total 1)
[   23.703733] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 2 skb 00000000ab3d1c86
[   23.703767] ath10k_snoc 18800000.wifi: htt-ver 3.44 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
[   23.745328] ath10k_snoc 18800000.wifi: wmi tlv pktlog disable
[   23.752813] ath10k_snoc 18800000.wifi: htc ep 2 consumed 1 credits total 0
[   23.760113] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe15ce40 len 20 n_items 1
[   23.766804] ath10k_snoc 18800000.wifi: wmi tlv pdev suspend
[   23.767283] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 16
[   23.767680] ath10k_snoc 18800000.wifi: htc insufficient credits ep 2 required 1 available 0 consume 1
[   23.798608] ath10k_snoc 18800000.wifi: htc ep 2 got 1 credits (total 1)
[   23.805223] ath10k_snoc 18800000.wifi: htc ep 2 consumed 1 credits total 0
[   23.811842] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 2 skb 000000001598dc5c
[   23.811886] ath10k_snoc 18800000.wifi: snoc tx item 0 paddr 0x00000007fe164040 len 24 n_items 1
[   23.833603] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 2 skb 000000001ad99932
[   23.842329] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 16
[   23.848856] ath10k_snoc 18800000.wifi: htc ep 2 got 1 credits (total 1)
[   23.855332] ath10k_snoc 18800000.wifi: snoc rx ce pipe 2 len 12
[   23.861748] ath10k_snoc 18800000.wifi: htc rx completion ep 0 skb 00000000b2951d6d
[   23.868182] ath10k_snoc 18800000.wifi: boot suspend complete
[   23.885505] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 1 skb 00000000688df7bf
[   23.892492] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 1 skb 0000000008c6dd9a
[   23.899862] ath10k_snoc 18800000.wifi: ath10k_htc_notify_tx_completion: ep 1 skb 0000000039d3abae
[   23.943506] ath10k_snoc 18800000.wifi: boot hif stop
[   23.984772] ath10k_snoc 18800000.wifi: boot hif power down
[   24.000360] ath10k_snoc 18800000.wifi: qmi wlan mode req completed: 4
[   24.006755] ath10k_snoc 18800000.wifi: soc power off
[   24.020185] ath10k_snoc 18800000.wifi: invalid MAC address; choosing random
[   24.026803] ath10k_snoc 18800000.wifi: fallback to eeprom programmed regulatory settings
[   24.033287] ath: EEPROM regdomain: 0x0
[   24.040513] ath: EEPROM indicates default country code should be used
[   24.046836] ath: doing EEPROM country->regdmn map search
[   24.053108] ath: country maps to regdmn code: 0x3a
[   24.059307] ath: Country alpha2 being used: US
[   24.066331] ath: Regpair used: 0x3a
[   24.074047] ath10k_snoc 18800000.wifi: WBRF is not supported


# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 34:27:92:82:48:ec brd ff:ff:ff:ff:ff:ff
3: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 2a:0b:f9:eb:00:57 brd ff:ff:ff:ff:ff:ff


Looking at commit b70b3a36ec33a2 with eyebrow raised over my head.


Regards



