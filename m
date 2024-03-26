Return-Path: <linux-wireless+bounces-5291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D7B88CB34
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EE71F6643A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD241F60A;
	Tue, 26 Mar 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="OFhYFA8Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EA1D555
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475153; cv=none; b=d6xIz633sGcguWOGiKKpqfs2uRH7CobqCYJEa4QEN5BpCPC2/PWjipq5vZ/tHbxVtcCd81AMno1BUyFQ/PjczW26fydECbwvGtwtOEZOW8uoQI1DfPBs7QoSFHScmzwbuJCna3nuXhcAXHI4OrVa/c5GbYYq051mf/jWcRsS59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475153; c=relaxed/simple;
	bh=kYN1qBXVPpea5wpHmWAoWIJD8vgHqwAGZWK1blPMAZw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FT6BsrTHlj28UZE1xiba04C60zaMD/lKQdel8m2BhgRMdlpgwByKgltacL2NnJmk1/ogm1Q7NtSfaxqKLElYniWOKYN8PX2sZsAAAij9dKLKt1AeqCVhZ2GDThtYGeBMaQWFtu3zyeHJ7xOUPznqL6rdd9VZHsSpvgpiB7AkZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=OFhYFA8Q; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso36663f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711475148; x=1712079948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/y1qOPkejs8X1bOSHDx0E/6/hkuaD2Fm/Hz2OloR5X4=;
        b=OFhYFA8QU27/q4QbZIClM43Go7NdrzRX3wGduCGHu90TtamkD7Fzaibm9g09NjJF77
         0POv36OThKxfh3iSfwtkyVGcLlZd5iSyLmH7Sgf2eusr8cII43y1NlEtCLx8U+d8nOT2
         sFWp4AoPzq/r2j4G6ch7VVarUZD30F0gUMsMShJg8f0mC6rGmlP7t8TzWkZ31R+3Dccw
         IXebrflb+t8s/HMe1PLo4GBPaoOHYcVEncj7UEYb4CLxgE3x0bXRxo1uXsHHybFtjaDm
         7SkYpmd4zFjA5GockRAK2XxJvasxPEPQygBDwJcJKeUpX/X3FGZLHpETlWezHfvjts+c
         abKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475148; x=1712079948;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/y1qOPkejs8X1bOSHDx0E/6/hkuaD2Fm/Hz2OloR5X4=;
        b=E8gmSBnOR2aEimldVpEFo/eMxWjM+ijXbG85nZ/LZ+IdJ17xe8FhxKmIVGu+zF78CP
         1LpT8/a8h3R/0/whdw+575sAG1+ddqWzpkg0Tzzy8vMfIxfsozGAuMcnhS5X/Yya+yIE
         9yv+VOwPNSxFHckeyyR//cQMvVqfCBnhHLP+7QYDz40htloCKneEQPATshxVO3erSXmm
         0xLg4kqChusF/JnqOGw718/NszMOlmgehLg5EZ8+OStZvQ7vUIZmrCPb3ASipbwP4Ef6
         faAEjF7qlOMn5XYruVbw1aXiDlSUOSb6xxdfa3gAT8W5RzMUxssooKcuqKwsvelZYYaU
         9tlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA42BtGXh5vgNejPZmjgp3H4SL7kKYHL1LfbmGO2mnnGV+ESLEPWzj02Ium5IoTn2sxS3Ybsgr3eUK/wGPrSHqPhoB4jX5lJMZZSrOnmY=
X-Gm-Message-State: AOJu0Yw2pypcmblJfs5fiMVtaVx7lNp6I3uFJRcB3/mCE4DjmQBkPR+4
	F5Dx0WK74IND6cEWAqLM30rd2GaImg0nM/aH79j2SeGCnirFSblrxcCkoYMLiNM=
X-Google-Smtp-Source: AGHT+IEZem2GeICsHwTHku5djg0GSiMQo8n8vqvfsd3TDAMEvSrQzrh8zmzNOfnJeN8IsJJA+3MVhw==
X-Received: by 2002:a5d:50c9:0:b0:33e:ca1f:1401 with SMTP id f9-20020a5d50c9000000b0033eca1f1401mr2164039wrt.4.1711475148546;
        Tue, 26 Mar 2024 10:45:48 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ck8-20020a5d5e88000000b00341ba91c1f5sm11595159wrb.102.2024.03.26.10.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:45:47 -0700 (PDT)
Message-ID: <9293793d-00e8-42ce-87b2-05abc3b49387@freebox.fr>
Date: Tue, 26 Mar 2024 18:45:47 +0100
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
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <243a97b7-c298-4307-9f06-8b3a7c3e24fd@freebox.fr>
In-Reply-To: <243a97b7-c298-4307-9f06-8b3a7c3e24fd@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[ It has been pointed out to me that the previous message was unclear. ]
[ Below is my 2nd attempt at a clearer message. ]

Problem: firmware-5.bin has not been parsed yet when we have to handle
the ATH10K_QMI_EVENT_SERVER_ARRIVE case, so we can't rely on feature bits
to work around the lack of MSA_READY indicator.


On 26/03/2024 16:04, Marc Gonzalez wrote:

> QMI stuff happens much EARLIER than firmware-5.bin handling.
> (ar->running_fw is still NULL)
> 
> 
> [   14.547563] ath10k_snoc 18800000.wifi: qmi wifi fw qmi service connected
> [   14.555054] ath10k_snoc 18800000.wifi: qmi indication register request completed
> [   14.561406] ath10k_snoc 18800000.wifi: qmi host capability request completed
> [   14.568365] ath10k_snoc 18800000.wifi: qmi msa mem region 0 addr 0x0x0000000094400000 size 0x4000 flag 0x00000001
> [   14.573775] ath10k_snoc 18800000.wifi: qmi msa mem region 1 addr 0x0x0000000094404000 size 0xfc000 flag 0x00000000
> [   14.583896] ath10k_snoc 18800000.wifi: qmi msa mem info request completed
> [   14.630179] ath10k_snoc 18800000.wifi: qmi msa mem ready request completed
> [   14.681647] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214 chip_family 0x4001 board_id 0xff soc_id 0x40010002
> [   14.681726] ath10k_snoc 18800000.wifi: qmi fw_version 0x100204b2 fw_build_timestamp 2019-09-04 03:01 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
> *** ATH10K_QMI_EVENT_SERVER_ARRIVE is handled at this point
> [   14.690657] ath10k_snoc 18800000.wifi: DT bdf variant name not set.
> [   14.706423] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
> [   14.712587] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
> [   14.722309] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff'
> [   14.745634] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/board-2.bin': 0
> ... snip boards dump
> [   15.560607] ath10k_snoc 18800000.wifi: boot found match for name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
> [   15.570590] ath10k_snoc 18800000.wifi: boot found board data for 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
> [   15.580393] ath10k_snoc 18800000.wifi: using board api 2
> [   15.591465] ath10k_snoc 18800000.wifi: qmi bdf download request completed
> [   15.595786] ath10k_snoc 18800000.wifi: qmi cal report request completed
> [   18.667441] ath10k_snoc 18800000.wifi: wifi fw ready event received
> [   18.667519] ath10k_snoc 18800000.wifi: ath10k_snoc_hif_power_up:WCN3990 driver state = 0
> [   18.672579] ath10k_snoc 18800000.wifi: soc power on
> [   18.684550] ath10k_snoc 18800000.wifi: qmi mode 0 config 00000000313ae0ca
> [   18.692591] ath10k_snoc 18800000.wifi: qmi config request completed
> [   18.748262] ath10k_snoc 18800000.wifi: qmi wlan mode req completed: 0
> [   18.748370] ath10k_snoc 18800000.wifi: boot init ce src ring id 0 entries 16 base_addr 00000000b9feff9c
> [   18.753792] ath10k_snoc 18800000.wifi: boot ce dest ring id 1 entries 512 base_addr 000000005f850e88
> [   18.762971] ath10k_snoc 18800000.wifi: boot ce dest ring id 2 entries 64 base_addr 000000002467084e
> [   18.772375] ath10k_snoc 18800000.wifi: boot init ce src ring id 3 entries 32 base_addr 00000000ded78c3f
> [   18.781122] ath10k_snoc 18800000.wifi: boot init ce src ring id 4 entries 2048 base_addr 00000000c9e8883a
> [   18.790482] ath10k_snoc 18800000.wifi: boot ce dest ring id 5 entries 512 base_addr 00000000309e9375
> [   18.800220] ath10k_snoc 18800000.wifi: boot init ce src ring id 7 entries 2 base_addr 00000000e5e3fb73
> [   18.809395] ath10k_snoc 18800000.wifi: boot ce dest ring id 7 entries 2 base_addr 00000000c08890b2
> [   18.818507] ath10k_snoc 18800000.wifi: boot ce dest ring id 8 entries 128 base_addr 000000006af0777e
> [   18.827466] ath10k_snoc 18800000.wifi: boot ce dest ring id 9 entries 512 base_addr 00000000f2c0ce43
> [   18.836770] ath10k_snoc 18800000.wifi: boot ce dest ring id 10 entries 512 base_addr 00000000269a2564
> [   18.845863] ath10k_snoc 18800000.wifi: boot ce dest ring id 11 entries 512 base_addr 00000000f4a8c90e
> [   18.855002] ath10k_snoc 18800000.wifi: Hardware name wcn3990 hw1.0 version 0x8
> [   18.865605] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/pre-cal-snoc-18800000.wifi.bin': -2
> [   18.871747] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/cal-snoc-18800000.wifi.bin': -2
> [   18.880307] ath10k_snoc 18800000.wifi: trying fw api 6
> [   18.889520] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-6.bin': -2
> [   18.894020] ath10k_snoc 18800000.wifi: trying fw api 5
> *** firmware-5.bin is handled at this point
> [   18.904176] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-5.bin': 0
> [   18.907802] ath10k_snoc 18800000.wifi: found fw timestamp 1539237028
> [   18.916460] ath10k_snoc 18800000.wifi: found firmware features ie (3 B)
> [   18.923027] ath10k_snoc 18800000.wifi: Enabling feature bit: 6
> [   18.929373] ath10k_snoc 18800000.wifi: Enabling feature bit: 18
> [   18.935279] ath10k_snoc 18800000.wifi: Enabling feature bit: 19
> [   18.941085] ath10k_snoc 18800000.wifi: features
> [   18.946975] ath10k_snoc 18800000.wifi: 00000000: 40 00 0c 00 00 00 00 00                          @.......
> [   18.951534] ath10k_snoc 18800000.wifi: found fw ie wmi op version 4
> [   18.961235] ath10k_snoc 18800000.wifi: found fw ie htt op version 3
> [   18.967390] ath10k_snoc 18800000.wifi: using fw api 5
> 
> 
> 
> I don't know how to solve this problem.
> (If we just skip waiting for MSA_READY, there is no problem)
> 
> Kalle, Jeff, do you see a way out of this conundrum?

Regards.


