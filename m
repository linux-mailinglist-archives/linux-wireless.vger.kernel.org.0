Return-Path: <linux-wireless+bounces-1992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E9982F444
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7155CB2391B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417071D540;
	Tue, 16 Jan 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XMuBNNPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D16B1D53F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429770; cv=none; b=qveaTUziaqXaFU/2G/B8DZg9d90HZOsfrIB8ooiZ+mSOUadmXIc61G+OlJNhYgXXKxCebgEVY+wt2cb0s1tC98MV7qhyJzaFEvhTTnAVTkFVC93LA/wzyc6IB0OPGgFtw691Iq8b4WJoXMMuOhRpm35PPcVuRBT/aEkDksNCVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429770; c=relaxed/simple;
	bh=qQD9QaeRqqLtiQzDajfCjYqqKa5K5/rCbHWMDRhCnHs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:CC:Date:Message-ID:In-Reply-To:References:User-Agent:Subject:
	 MIME-Version:Content-Type; b=YSlADTsOqNNbC1csNnupYTEIPiTAUu/n/FYITxvDzJTPb9waQyrj1f9c4/+N6fo7jaYiNdSCf/25h2Me39bXEpDJi+w2sN5cnkf9JZ20PH5US7pLR0yeees2MgHx3sSXEApIXmk6oa6CNp+m3scH4oEnVwS06a3HTlVVnTY4JwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XMuBNNPH; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7836de7757dso46582485a.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 10:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705429768; x=1706034568; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Srk0ym7kxvgXqJ++jCIiJXLde+w1edJLjv0lGTNziFE=;
        b=XMuBNNPHAZiD2TH+LygYUHv/pZZombDXgnP2QC9sw1nZkI1SmvNEBtbZzxcUXsjv5u
         iCUW8ZnblxVFEoTzcnwwpx3/R+GX1JKZfYJ04BJht5Aav9DS2MbbO/ki36gY2u6lD7N4
         sK2Rkj2uLZZhQU/2g+694RSh083oYmRvCze4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429768; x=1706034568;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srk0ym7kxvgXqJ++jCIiJXLde+w1edJLjv0lGTNziFE=;
        b=Zq5iWmBOcI4lCjWposOCMRNt/rEXss8rgFuvQiDAHoXnQSecFMepIrVrtIQI6YKo11
         X9+WETXgPIua/VUKvXTBuuLurrwL0vbbM4vmMsMCCUsmgcrS4TcRm2TysnuBvbxQISGo
         17gQjWsOi4yABc5OOIIU0o9Y62rvnw+EXhdL0gOGJnNSLJRonWCt0K/wNCrf2uxNVkOs
         umYLdUfnqMKgxwauzMemILGWqFsfJxcME9aQTIS5j/7xACMxnYVbXDAFBab7G8bR5o2M
         3Pk1R8uu/VIe87EjegH0WZgMWk6pin6GWbMhisIcLFK5mfOxlJW/mCX+XK/gz7pb39Pd
         xOaQ==
X-Gm-Message-State: AOJu0YzUw2bMyDPupesk9m7vHpS6WS51Bhooww2EfdstW2p8EiWIxuGV
	u0i7cgYxvjRFVBuRj/NIrGqzHQXfDpnY
X-Google-Smtp-Source: AGHT+IG9DAiMloGo8CVi8eAfmSNnlEYF6/wDAvSVCyH+aKB5WmpkCRdPwkzQtSsANRPUWpsF0CQEnA==
X-Received: by 2002:a05:620a:f13:b0:783:207e:bfab with SMTP id v19-20020a05620a0f1300b00783207ebfabmr12106237qkl.5.1705429767916;
        Tue, 16 Jan 2024 10:29:27 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id cn3-20020a05622a248300b00429c8ae9b94sm4819773qtb.85.2024.01.16.10.29.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 10:29:26 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, Stefan Wahren <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>
Date: Tue, 16 Jan 2024 19:29:21 +0100
Message-ID: <18d1388fbe8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19541618e400c95a448f7e8c79590c01df214782.camel@sipsolutions.net>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
 <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
 <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
 <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
 <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
 <89d3f34a-3427-4871-971c-d960a16918ac@broadcom.com>
 <004dabc3-c345-4d90-9348-5caa9b1f3849@gmx.net>
 <c3996f70-bb2a-4d26-a7e9-a1b062fa0474@broadcom.com>
 <0e5eba2f-e524-4f0d-8217-2770c57ad5ed@gmx.net>
 <18c8d7da558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f3af378f-fae4-4a98-a5b1-24173d17b64e@gmx.net>
 <18c921b1690.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <18c9224abb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <d90cc093-e3fc-4af4-9a4a-5f4bd9a7cb1f@gmx.net>
 <19541618e400c95a448f7e8c79590c01df214782.camel@sipsolutions.net>
User-Agent: AquaMail/1.49.1 (build: 104901407)
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000086b06b060f144fef"

--00000000000086b06b060f144fef
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 16, 2024 3:09:45 PM Johannes Berg <johannes@sipsolutions.net> wrote:

> On Tue, 2023-12-26 at 20:27 +0100, Stefan Wahren wrote:
>> Hi Arend,
>>
>> [add Johannes]
>
> Sorry this fell through, Intel address ...
>
> Was there a specific question you had?
>
>>>>> [  334.956787] cfg80211: Calling CRDA for country: DE
>>>>
>>>> I guess this message is a bit stale and there is no crda user-mode
>>>> helper.
>
> It may still try to call it, but I guess nothing will happen.
>
>>>>
>>>>> [  334.990709] cfg80211: Disabling freq 2484.000 MHz
>>>>
>>>> So 2GHz channel 14 gets disabled here probably due to country change
>>>> to DE.
>>>>
>>>> Not learned a whole lot more from this test round except that reg.c is
>>>> active during the reconnect so I suggest to zoom in there. Especially
>>>> around the "restoring" message.
>>>
>>> I wonder whether we end up in restore_custom_reg_settings() which does:
>>>
>>> chan->flags = chan->orig_flags;
>>>
>>> for each channel. That would re-enable those channels.
>> Bingo
>>
>> This caused the problem. Since brcmf_construct_chaninfo() is only called
>> once and only changes the flags but never orig_flags, the information
>> about disabled channels get lost (logs are focused on hw_value 34):
>>
>> [   10.294909] cfg80211: Loading compiled-in X.509 certificates for
>> regulatory database
>> [   10.717262] brcmfmac: brcmf_fw_alloc_request: using
>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>> [   10.718408] cfg80211: loaded regulatory.db is malformed or signature
>> is missing/invalid
>> [   10.718427] cfg80211: Restoring regulatory settings
>> [   10.718435] cfg80211: Kicking the queue
>> [   10.718452] cfg80211: Calling CRDA to update world regulatory domain
>> [   10.948418] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>> available (err=-2)
>> [   10.948764] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0:
>> Nov  1 2021 00:37:25 version 7.45.241 (1a2f2fa CY) FWID 01-703fd60
>> [   10.982088] cfg80211: handle_channel_custom: hw_value 34, orig_flags:
>> 00000000, flags 00000000
>> [   10.982346] cfg80211: Ignoring regulatory request set by core since
>> the driver uses its own custom regulatory domain
>>
>> The channel 34 has been disabled by brcmf_construct_chaninfo():
>> [   11.025681] brcmfmac: brcmf_construct_chaninfo: hw_value 34,
>> orig_flags: 00080000, flags 00000001
>> [   13.045508] cfg80211: Pending regulatory request, waiting for it to
>> be processed...
>> [   13.237669] cfg80211: Ignoring regulatory request set by core since
>> the driver uses its own custom regulatory domain
>> [   13.237692] cfg80211: World regulatory domain updated:
>> [   13.237696] cfg80211:  DFS Master region: unset
>> [   13.237701] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [   13.237709] cfg80211:   (755000 KHz - 928000 KHz @ 2000 KHz), (N/A,
>> 2000 mBm), (N/A)
>> [   13.237717] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   13.237726] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz, 92000
>> KHz AUTO), (N/A, 2000 mBm), (N/A)
>> [   13.237734] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   13.237742] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
>> [   13.237750] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [   13.237758] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz),
>> (N/A, 2000 mBm), (0 s)
>> [   13.237765] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   13.237772] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
>> (N/A, 0 mBm), (N/A)
>> [   13.237814] cfg80211: Calling CRDA for country: DE
>> [   13.262648] cfg80211: Disabling freq 2484.000 MHz
>> [   13.262687] cfg80211: handle_channel: hw_value 34, orig_flags:
>> 00080000, flags 00000001
>> [   13.262696] cfg80211: handle_channel_single_rule: hw_value 34,
>> orig_flags: 00080000, flags 00000001
>> [   13.359105] brcmfmac: brcmf_construct_chaninfo: hw_value 34,
>> orig_flags: 00080000, flags 00000001
>> [   13.360210] cfg80211: Regulatory domain changed to country: DE
>> [   13.360231] cfg80211:  DFS Master region: ETSI
>> [   13.360235] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [   13.360246] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   13.360256] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   13.360265] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [   13.360281] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [   13.360289] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [   13.360296] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   13.360303] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [   17.172301] cfg80211: Found new beacon on frequency: 5180.000 MHz (Ch
>> 36) on phy0
>> [   17.172326] cfg80211: Found new beacon on frequency: 5220.000 MHz (Ch
>> 44) on phy0
>> [   20.800666] cfg80211: Calling CRDA for country: DE
>> [   20.834453] cfg80211: Disabling freq 2484.000 MHz
>> [   20.834487] cfg80211: handle_channel: hw_value 34, orig_flags:
>> 00080000, flags 00000001
>> [   20.834503] cfg80211: handle_channel_single_rule: hw_value 34,
>> orig_flags: 00080000, flags 00000001
>> [   20.835045] cfg80211: Regulatory domain changed to country: DE
>> [   20.835057] cfg80211:  DFS Master region: ETSI
>> [   20.835063] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [   20.835075] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   20.835095] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   20.835109] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [   20.835122] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [   20.835135] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [   20.835148] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   20.835160] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [   84.952323] cfg80211: Verifying active interfaces after reg change
>> [  344.070588] cfg80211: All devices are disconnected, going to restore
>> regulatory settings
>> [  344.070619] cfg80211: Restoring regulatory settings while preserving
>> user preference for: DE
>>
>> Dump after restore_custom_reg_settings() is finished (channel 34 is
>> re-enabled):
>> [  344.070639] cfg80211: restore_custom_reg_settings: hw_value 34,
>> orig_flags: 00080000, flags 00080000
>> [  344.070660] cfg80211: Ignoring regulatory request set by core since
>> the driver uses its own custom regulatory domain
>> [  344.070675] cfg80211: World regulatory domain updated:
>> [  344.070684] cfg80211:  DFS Master region: unset
>> [  344.070692] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [  344.070706] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (600
>> mBi, 2000 mBm), (N/A)
>> [  344.070724] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz, 92000
>> KHz AUTO), (600 mBi, 2000 mBm), (N/A)
>> [  344.070741] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (600
>> mBi, 2000 mBm), (N/A)
>> [  344.070758] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (600 mBi, 2000 mBm), (N/A)
>> [  344.070775] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (600 mBi, 2000 mBm), (0 s)
>> [  344.070792] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz),
>> (600 mBi, 2000 mBm), (0 s)
>> [  344.070808] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (600
>> mBi, 2000 mBm), (N/A)
>> [  344.070824] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
>> (N/A, 0 mBm), (N/A)
>> [  344.070881] cfg80211: Disabling freq 2484.000 MHz
>> [  344.070893] cfg80211: handle_channel: hw_value 34, orig_flags:
>> 00080000, flags 00080000
>> [  344.070916] cfg80211: handle_channel_single_rule: hw_value 34,
>> orig_flags: 00080000, flags 00080000
>> [  344.071487] cfg80211: Regulatory domain changed to country: DE
>> [  344.071499] cfg80211:  DFS Master region: ETSI
>> [  344.071506] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [  344.071519] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [  344.071536] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [  344.071552] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [  344.071567] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [  344.071582] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [  344.071597] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [  344.071611] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [  344.071634] cfg80211: Kicking the queue
>> [  344.745318] cfg80211: Found new beacon on frequency: 5180.000 MHz (Ch
>> 36) on phy0
>> [  344.745369] cfg80211: Found new beacon on frequency: 5220.000 MHz (Ch
>> 44) on phy0
>> [  346.174985] brcmfmac: set chanspec 0xd022 fail, reason -52
>> [  346.175018] brcmfmac: hw_value 34, orig_flags: 00080000, flags 00080220
>>> Have you always seen this or at certain kernel update or
>>> wpa_supplicant maybe?
>> As written in the initial message i've tested Linux 6.3, 6.6 and 6.7-rc6
>> with wpa_supplicant 2.9 so far and saw this issue in these cases.
>>
>> How far should i go?
>>
>> I modified brcmf_construct_chaninfo() to store the
>> IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had it.
>> This avoid the issue. Not sure this is the proper solution.
>
> orig_flags are from when the wiphy is registered - does the driver only
> set up proper flags after that?

Long time ago we discussed about this. So brcmfmac provides a superset of 
channels during wiphy_register() and none of them are disabled as they 
could never be enabled. After that the driver may disable a subset as it 
syncs with the device. I think we used strict custom reg flag, but that 
seems to have gone. Could that have the result Stefan is observing?

Regards,
Arend

> johannes




--00000000000086b06b060f144fef
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB7WqSk8Gy9n1eSvPiM
Hgs8YsM4FzPU2drEc55TmvGXHzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMTYxODI5MjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASLTBsv1PW486rV2YbX7tsqNOPESV46hyAv3b
isVg+Y6kzP/wETDPQ9OWQN6p2iwcg303zq08RixblMjSptBq0nFnyUbwqI9EnV6Lea7e/sNxHlhV
KnB17w1OLlV8TDHTG5RCAAl42HZvoiO9KquIeLSoo/LxhUPHT66jEoCk0A1sOyWZ42/Zm2NwKC2Q
8oapfIA1MvRh1J6yxg22x2ZaaCtffvZF1qEMfiVigAhRKf98UctQW+5wyBgiBmTVfy55qwyhWyxC
KwVfVXJ2Di3P0s3/38kBKhmuRG703SC8OWY4t8kL4cz8mxVtD8up5HYyT9GxfwlhwyiQ46RSRJ1J
UQ==
--00000000000086b06b060f144fef--

