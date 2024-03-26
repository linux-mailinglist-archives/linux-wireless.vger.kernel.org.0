Return-Path: <linux-wireless+bounces-5281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3354B88C63D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40B01F65ED5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9812D76F;
	Tue, 26 Mar 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="UITHZG1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1813C3F4
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465475; cv=none; b=ZDs+7KtjH/bJuIJX+y1C6+4DB6yI5moXuDTL4zizFxOPfQv4LRysKoE0FkPC+9aB4M02ls4IMx65BOt+YgMFX37x6nfShLa7xcaWp9OPWRbWDodYnw2AweSXahX49QhAegiOODPjYEJ93IyOZh/R9UhoqBwq3K/E/17ENuuw7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465475; c=relaxed/simple;
	bh=MzAKNO9+ujLgaazKPerZu125q6yWmCs2schnRyeP7Ac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AAJxtMP/CjdHQz03UiTf0COd/ajpbEOUJg9qUNZGVusaJFRQ72C2nKYOx1lJtgR8c8xcSFc0iB9uzfVNUlle4m8x8f7BtmzHaIoQ8GcHsg6ZrGwEMQI6sbsMsOrYs4Z3Dbl78O1RfKI9elOKBhgoaUsDgBymoI2uKjMxXTeSedc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=UITHZG1D; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4148c65e890so9065625e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1711465470; x=1712070270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xp0ZqxvoikI/gzbwx7ZxndebT/e0HiSQICaCfy/twKs=;
        b=UITHZG1DxhnTUkEllqbXObVAYCfA6OQ81GTOyBPQqL5bQlKvWVAcLn6U0K9+JsyVBc
         lqVPUPYF0mj8ym4Kou0p9HrtxG6DnoTZxECOpfVwRF7tuEUCbvgsbAalfMqYKfuzbPne
         +mBkgbN4F6+9Qr8AhXbT5ZICQluLfSMO7u0A0UyhF05qVP+JJskOBgbvcoPYMtx6+cJE
         YxRecvw3thAbAGuycZ2GhFo2xSrfmKCbFJmkohL58gecDkvnlwW+y3dgAjaZ1M70TqO8
         RiUlbJ6w/qKoPyPitL7vHpq8TczRedwNIoeygaq7OyY53vQKaxEA34y1kHc+Go+cOQCe
         CfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711465470; x=1712070270;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp0ZqxvoikI/gzbwx7ZxndebT/e0HiSQICaCfy/twKs=;
        b=eqGHb0poYBOriFwcH7zQDQf73EHlwUr5OoJE81Wjczls4qjZB5vaDDyFXjHqZ8zqov
         WQPiG5ONIoNQDS0CS2Cm6wQHus/32rYFMCJ0b+CUzrTPUJDm1821YnFzXIWQF+ny+E5Z
         08pLBUXHuErco6KIxKxsb63xgpfcAW8cKmFBodG0tdQ2MUcI+Px1iuyVxMrV2bch+fYL
         akg4pthOI8qt6aEPYtm2iuO6bbhs1BTFzTXFUoX7Iqy5YL8187DDbn2EWbRKMF6/mfOx
         V2ciJ+X99DMymYGsgJByPn9KzXG+kiQpz3plcddwUqHcn1/u77/dB+YWXb8vAvF21TwV
         oTkA==
X-Forwarded-Encrypted: i=1; AJvYcCX0XmVVgd+c24iBueZNuAubGm+fGUimHF2u8cylbezYhyNkjgE5FMplr44QYxUZOCBvKFF1Adqq0eNqogf/QMb1W1PZkgQhBj5H34gP600=
X-Gm-Message-State: AOJu0Yy0Rey+a9FIu3ptB0btZjTcH1DiPkYkyY7M/MF1nRU0oEsGg/Sh
	Pei5Ok3S7er2IMiFoQBK3N7LYyKHj4Xr47tyiGYZSLN1G6wB6rue+WLAHExcBgU=
X-Google-Smtp-Source: AGHT+IFGMFihtiw4m95cEeox2j0zeEgiSBGlNyWPJHtAxkpGn8kd+Xf3+XJOwlP4HoqRiME5wwJHMg==
X-Received: by 2002:a05:600c:4749:b0:414:902c:f8ba with SMTP id w9-20020a05600c474900b00414902cf8bamr1163281wmo.1.1711465469884;
        Tue, 26 Mar 2024 08:04:29 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b00341d1aa0245sm4103918wrb.106.2024.03.26.08.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:04:29 -0700 (PDT)
Message-ID: <243a97b7-c298-4307-9f06-8b3a7c3e24fd@freebox.fr>
Date: Tue, 26 Mar 2024 16:04:27 +0100
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
In-Reply-To: <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 16:09, Marc Gonzalez wrote:

> I'm still not quite sure where linux-firmware.git fits into all this.

https://packages.debian.org/sid/firmware-atheros

As far as I understand, Debian package "firmware-atheros (20230625-2)" includes:

  ath10k/WCN3990/hw1.0/firmware-5.bin
  ath10k/WCN3990/hw1.0/board-2.bin
  ath10k/WCN3990/hw1.0/wlanmdsp.mbn


# dmesg | grep ' fw '
[    2.769265] remoteproc remoteproc1: Booting fw image adsp.mdt, size 7260
[   14.923181] remoteproc remoteproc0: Booting fw image mba.mbn, size 234152
[   17.087567] ath10k_snoc 18800000.wifi: wifi fw qmi service found
[   17.087642] ath10k_snoc 18800000.wifi: qmi wifi fw qmi service connected
[   17.298173] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/board-2.bin': 0
[   20.995327] ath10k_snoc 18800000.wifi: wifi fw ready event received
[   21.189610] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/pre-cal-snoc-18800000.wifi.bin': -2
[   21.195201] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/cal-snoc-18800000.wifi.bin': -2
[   21.203285] ath10k_snoc 18800000.wifi: trying fw api 6
[   21.212893] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-6.bin': -2
[   21.216866] ath10k_snoc 18800000.wifi: trying fw api 5
[   21.229645] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-5.bin': 0
[   21.230840] ath10k_snoc 18800000.wifi: found fw timestamp 1539237028
[   21.274453] ath10k_snoc 18800000.wifi: found fw ie wmi op version 4
[   21.284111] ath10k_snoc 18800000.wifi: found fw ie htt op version 3
[   21.290301] ath10k_snoc 18800000.wifi: using fw api 5
[   21.939112] ath10k_snoc 18800000.wifi: qmi fw log request completed, mode: 0


$ ./ath10k-fwencoder --info /lib/firmware/ath10k/WCN3990/hw1.0/firmware-5.bin 
FileSize: 60
FileCRC32: b3d4b790
FileMD5: d16e3444f68ee48c548a891b9f9279e1
Timestamp: 2018-10-11 05:50:28
Features: wowlan,mgmt-tx-by-ref,non-bmi
WMIOpVersion: tlv
HTTOpVersion: tlv

    wowlan,mgmt-tx-by-ref,non-bmi = b6,b18,b19 = 0xc0040



However, the vendor kernel hard-codes value = 0x82E = b11,b5,b3,b2,b1
https://git.codelinaro.org/clo/la/kernel/msm-4.4/-/blob/caf_migration/kernel.lnx.4.4.r38-rel/drivers/net/wireless/ath/ath10k/hw.c#L529

WMI_10X (Deprecated)
HAS_WMI_MGMT_TX
NO_P2P
MULTI_VIF_PS_SUPPORT
SUPPORTS_ADAPTIVE_CCA


Not sure which value I should encode for this board's firmware-5.bin ...

I'll try the upstream value.

diff --git a/tools/scripts/ath10k/ath10k-fwencoder b/tools/scripts/ath10k/ath10k-fwencoder
index ceb26b4..44fef64 100755
--- a/tools/scripts/ath10k/ath10k-fwencoder
+++ b/tools/scripts/ath10k/ath10k-fwencoder
@@ -65,7 +65,9 @@ ATH10K_FW_FEATURE_MGMT_TX_BY_REF = 18
 ATH10K_FW_FEATURE_NON_BMI = 19
 ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL = 20
 ATH10K_FW_FEATURE_PEER_FIXED_RATE = 21
-ATH10K_FW_FEATURE_MAX = 22
+ATH10K_FW_FEATURE_IRAM_RECOVERY = 22
+ATH10K_FW_FEATURE_NO_MSA_READY = 23
+ATH10K_FW_FEATURE_MAX = 24
 
 feature_map = {
     'ext-wmi-mgmt-rx': ATH10K_FW_FEATURE_EXT_WMI_MGMT_RX,
@@ -91,6 +93,8 @@ feature_map = {
     'non-bmi': ATH10K_FW_FEATURE_NON_BMI,
     'single-chan-info-per-channel': ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL,
     'peer-fixed-rate': ATH10K_FW_FEATURE_PEER_FIXED_RATE,
+    'iram-recovery': ATH10K_FW_FEATURE_IRAM_RECOVERY,
+    'no-msa-ready': ATH10K_FW_FEATURE_NO_MSA_READY,
 }
 
 # from enum ath10k_fw_wmi_op_version in ath10k/hw.h


$ ./ath10k-fwencoder -d --modify --features=wowlan,mgmt-tx-by-ref,non-bmi,no-msa-ready firmware-5.bin 
DEBUG: adding id 1 len(value) 4padding_len 0
DEBUG: adding id 2 len(value) 3padding_len 1
DEBUG: adding id 5 len(value) 4padding_len 0
DEBUG: adding id 6 len(value) 4padding_len 0
firmware-5.bin modified: 60 B

$ ./ath10k-fwencoder --info firmware-5.bin 
FileSize: 60
FileCRC32: 3ec1ac4b
FileMD5: dcfd93d86255c481d908af85c30a23b5
Timestamp: 2024-03-26 13:45:25
Features: wowlan,mgmt-tx-by-ref,non-bmi,no-msa-ready
WMIOpVersion: tlv
HTTOpVersion: tlv


Don't know how to say:
"Use THIS firmware-5.bin for all msm8998 platforms"


Testing patch proposed on March 5...
"Houston, we have a problem."

QMI stuff happens much EARLIER than firmware-5.bin handling.
(ar->running_fw is still NULL)


[   14.547563] ath10k_snoc 18800000.wifi: qmi wifi fw qmi service connected
[   14.555054] ath10k_snoc 18800000.wifi: qmi indication register request completed
[   14.561406] ath10k_snoc 18800000.wifi: qmi host capability request completed
[   14.568365] ath10k_snoc 18800000.wifi: qmi msa mem region 0 addr 0x0x0000000094400000 size 0x4000 flag 0x00000001
[   14.573775] ath10k_snoc 18800000.wifi: qmi msa mem region 1 addr 0x0x0000000094404000 size 0xfc000 flag 0x00000000
[   14.583896] ath10k_snoc 18800000.wifi: qmi msa mem info request completed
[   14.630179] ath10k_snoc 18800000.wifi: qmi msa mem ready request completed
[   14.681647] ath10k_snoc 18800000.wifi: qmi chip_id 0x30214 chip_family 0x4001 board_id 0xff soc_id 0x40010002
[   14.681726] ath10k_snoc 18800000.wifi: qmi fw_version 0x100204b2 fw_build_timestamp 2019-09-04 03:01 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
*** ATH10K_QMI_EVENT_SERVER_ARRIVE is handled at this point
[   14.690657] ath10k_snoc 18800000.wifi: DT bdf variant name not set.
[   14.706423] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   14.712587] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   14.722309] ath10k_snoc 18800000.wifi: boot using board name 'bus=snoc,qmi-board-id=ff'
[   14.745634] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/board-2.bin': 0
... snip boards dump
[   15.560607] ath10k_snoc 18800000.wifi: boot found match for name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   15.570590] ath10k_snoc 18800000.wifi: boot found board data for 'bus=snoc,qmi-board-id=ff,qmi-chip-id=30214'
[   15.580393] ath10k_snoc 18800000.wifi: using board api 2
[   15.591465] ath10k_snoc 18800000.wifi: qmi bdf download request completed
[   15.595786] ath10k_snoc 18800000.wifi: qmi cal report request completed
[   18.667441] ath10k_snoc 18800000.wifi: wifi fw ready event received
[   18.667519] ath10k_snoc 18800000.wifi: ath10k_snoc_hif_power_up:WCN3990 driver state = 0
[   18.672579] ath10k_snoc 18800000.wifi: soc power on
[   18.684550] ath10k_snoc 18800000.wifi: qmi mode 0 config 00000000313ae0ca
[   18.692591] ath10k_snoc 18800000.wifi: qmi config request completed
[   18.748262] ath10k_snoc 18800000.wifi: qmi wlan mode req completed: 0
[   18.748370] ath10k_snoc 18800000.wifi: boot init ce src ring id 0 entries 16 base_addr 00000000b9feff9c
[   18.753792] ath10k_snoc 18800000.wifi: boot ce dest ring id 1 entries 512 base_addr 000000005f850e88
[   18.762971] ath10k_snoc 18800000.wifi: boot ce dest ring id 2 entries 64 base_addr 000000002467084e
[   18.772375] ath10k_snoc 18800000.wifi: boot init ce src ring id 3 entries 32 base_addr 00000000ded78c3f
[   18.781122] ath10k_snoc 18800000.wifi: boot init ce src ring id 4 entries 2048 base_addr 00000000c9e8883a
[   18.790482] ath10k_snoc 18800000.wifi: boot ce dest ring id 5 entries 512 base_addr 00000000309e9375
[   18.800220] ath10k_snoc 18800000.wifi: boot init ce src ring id 7 entries 2 base_addr 00000000e5e3fb73
[   18.809395] ath10k_snoc 18800000.wifi: boot ce dest ring id 7 entries 2 base_addr 00000000c08890b2
[   18.818507] ath10k_snoc 18800000.wifi: boot ce dest ring id 8 entries 128 base_addr 000000006af0777e
[   18.827466] ath10k_snoc 18800000.wifi: boot ce dest ring id 9 entries 512 base_addr 00000000f2c0ce43
[   18.836770] ath10k_snoc 18800000.wifi: boot ce dest ring id 10 entries 512 base_addr 00000000269a2564
[   18.845863] ath10k_snoc 18800000.wifi: boot ce dest ring id 11 entries 512 base_addr 00000000f4a8c90e
[   18.855002] ath10k_snoc 18800000.wifi: Hardware name wcn3990 hw1.0 version 0x8
[   18.865605] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/pre-cal-snoc-18800000.wifi.bin': -2
[   18.871747] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/cal-snoc-18800000.wifi.bin': -2
[   18.880307] ath10k_snoc 18800000.wifi: trying fw api 6
[   18.889520] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-6.bin': -2
[   18.894020] ath10k_snoc 18800000.wifi: trying fw api 5
*** firmware-5.bin is handled at this point
[   18.904176] ath10k_snoc 18800000.wifi: boot fw request 'ath10k/WCN3990/hw1.0/firmware-5.bin': 0
[   18.907802] ath10k_snoc 18800000.wifi: found fw timestamp 1539237028
[   18.916460] ath10k_snoc 18800000.wifi: found firmware features ie (3 B)
[   18.923027] ath10k_snoc 18800000.wifi: Enabling feature bit: 6
[   18.929373] ath10k_snoc 18800000.wifi: Enabling feature bit: 18
[   18.935279] ath10k_snoc 18800000.wifi: Enabling feature bit: 19
[   18.941085] ath10k_snoc 18800000.wifi: features
[   18.946975] ath10k_snoc 18800000.wifi: 00000000: 40 00 0c 00 00 00 00 00                          @.......
[   18.951534] ath10k_snoc 18800000.wifi: found fw ie wmi op version 4
[   18.961235] ath10k_snoc 18800000.wifi: found fw ie htt op version 3
[   18.967390] ath10k_snoc 18800000.wifi: using fw api 5



I don't know how to solve this problem.
(If we just skip waiting for MSA_READY, there is no problem)

Kalle, Jeff, do you see a way out of this conundrum?


Regards.


