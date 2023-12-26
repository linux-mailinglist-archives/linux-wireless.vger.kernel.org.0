Return-Path: <linux-wireless+bounces-1286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC581E970
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Dec 2023 20:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F4D1F21ABA
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Dec 2023 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B565234;
	Tue, 26 Dec 2023 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QqOiujqH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554275227
	for <linux-wireless@vger.kernel.org>; Tue, 26 Dec 2023 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703618859; x=1704223659; i=wahrenst@gmx.net;
	bh=20nQzvs1q1VkcWRmtTsuXCKXMY6ivZ/PEdKqOrGYnkU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=QqOiujqHz5dMOQujTuHqsWb5vKNFQS/IwU0n4DXx4Q2kfdquEFgc4ySOIbMOBiZ2
	 B5PC4V5+poBN1MV01f2SPW2BODh1Cjt5omO4gfyqwpzJErDPAkh3/n4MdoUmVMeL1
	 aszzcP8qQfV+Ye2hmtV4NZexrYfprZvR1jj+aED/3LD3aVgUXCJgUu3bjp7D0pUgl
	 IA+vKUY57jauvtCaFdPKq67Bkj5ikkUr9gIKzwRtKzgsgk5zRl8OE+6NbQgxt5GcY
	 xOjuRAWRYYgrdntfsD3gtmmHsYdVEbX0uzlHSZj7dpKLiIW4hJajzy08UYUsIhyri
	 HCUssrxY4bgsnMvIIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1rUqOu3bVq-00Dsjh; Tue, 26
 Dec 2023 20:27:38 +0100
Message-ID: <d90cc093-e3fc-4af4-9a4a-5f4bd9a7cb1f@gmx.net>
Date: Tue, 26 Dec 2023 20:27:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>,
 Kalle Valo <kvalo@kernel.org>
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <18c9224abb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UwuyUy5VEc63s3hZfrq6x1VnwijCpAySqgoPJwvz7MGgCbNVfK6
 DumOYBgnbBcLVZKX1M5Hy+OOb87yV2mQdbmlVvMciPPQ8J/8rpR1ERKB3Bro0o2igQEZ76e
 yFe0XRYxGQrDTrNRXUCUYW71mqEfissOBF1wOKHhVv9YZrK+Jbo3b2uApaJ/+5iRsUQ3yW8
 7lMp0OFfe98Q60Liy3AgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xUxQA4nw7HA=;2iZsS3KrA+WW9WpLWMBkE9JtaiH
 PdXYLRZnRcAZVUFuR38LXnToEqoDkOADinGTQA5Tc4zQahlZtjJ1kNr8pWMDTExNPb70Zobk4
 QlR+beCXN9y1mApLfuFMNWbEY6iAY/QY5CvavRKbfmgfQ2rgUN9TF1i+FHpq1jRhtzWPcjghE
 v7HPfjkLV41woMsuJTkAISK6GHbq+vFmd4i9cPhUc9+xndJYF7l0F2+7ke6TqlWh1f2ulAJTy
 6nySOsAivI5OozOrzlFPbvwMsNt5qO8mBeVLZiC+18gbD1xMBfC0jrflGsXJgQZu7fCCvRPAq
 0+LSVrRKR96DFj/XtRTX0Ii+q5Ffbtd0xuS3+fBsKinTrAHF2vFrMor+sA6aeRu5IJoSZ52xU
 31Ta4fS6TTOw3aL/KU5Tnfo02vdmxXg8Wz/6HC3R4aznZuvXjn9O6X2jx/5TAIhzM37rBnrrG
 DVZD+egA0obbVZwfHuYZ5ZGwX+i82QxQ2mV1gcgDasn1Z7CW2ywgfqxrR7TnfXUkInfIFjOEX
 yOjhBcO/lXPhG+WvWKcYjd8LNp42X3mJ8DsWTaeEFQUYRLSTRB4H4605XNqdQ7FPfLCtymjhI
 ylaSEvQhwGVE+A0R/NxCZYd0sG/vYTUKPE2dN9cVd24bSFA4c9z0G4LmPGyMsJxHR6gjbrBQB
 SFTW6aA6VP7K4n7M96/VvCObuAkHfO8vB6POooYFOGCJLPX+yXH6pFXBXvMHI+rxnYwPTJos4
 IreidEdV5v2YQk/b2CuPjqM9onE3yvlistzRiAZEz5zM3penWDl2E+9s3cLyTKP1pgwfG74+k
 V8WjWPRTvnGBVwvB0adLg5yjxARneCxKbXE/sHTpd8nSuNLA9ZLs6UIMAHK/3EFzM4+BNcggO
 zBVClcG/zOEphxXRu5vHOp7BvDBm0jU3unNwUwOpKwpeSuw4iqiRai9cDxC373ET3EEN7xIHS
 hvSsXwxkUOfoh1zcDuSeCLjyF90=

Hi Arend,

[add Johannes]

Am 22.12.23 um 16:28 schrieb Arend Van Spriel:
>
>
> On December 22, 2023 4:18:19 PM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>
>> On December 21, 2023 7:40:46 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>>
>> Do you know if this happens before or after the reconnect has completed=
?
>> You could enable CONN debug level in brcmfmac to determine that.
before the reconnect
>>
>>> [=C2=A0 334.956787] cfg80211: Calling CRDA for country: DE
>>
>> I guess this message is a bit stale and there is no crda user-mode
>> helper.
>>
>>> [=C2=A0 334.990709] cfg80211: Disabling freq 2484.000 MHz
>>
>> So 2GHz channel 14 gets disabled here probably due to country change
>> to DE.
>>
>> Not learned a whole lot more from this test round except that reg.c is
>> active during the reconnect so I suggest to zoom in there. Especially
>> around the "restoring" message.
>
> I wonder whether we end up in restore_custom_reg_settings() which does:
>
> chan->flags =3D chan->orig_flags;
>
> for each channel. That would re-enable those channels.
Bingo

This caused the problem. Since brcmf_construct_chaninfo() is only called
once and only changes the flags but never orig_flags, the information
about disabled channels get lost (logs are focused on hw_value 34):

[=C2=A0=C2=A0 10.294909] cfg80211: Loading compiled-in X.509 certificates =
for
regulatory database
[=C2=A0=C2=A0 10.717262] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[=C2=A0=C2=A0 10.718408] cfg80211: loaded regulatory.db is malformed or si=
gnature
is missing/invalid
[=C2=A0=C2=A0 10.718427] cfg80211: Restoring regulatory settings
[=C2=A0=C2=A0 10.718435] cfg80211: Kicking the queue
[=C2=A0=C2=A0 10.718452] cfg80211: Calling CRDA to update world regulatory=
 domain
[=C2=A0=C2=A0 10.948418] brcmfmac: brcmf_c_process_txcap_blob: no txcap_bl=
ob
available (err=3D-2)
[=C2=A0=C2=A0 10.948764] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM434=
5/6 wl0:
Nov=C2=A0 1 2021 00:37:25 version 7.45.241 (1a2f2fa CY) FWID 01-703fd60
[=C2=A0=C2=A0 10.982088] cfg80211: handle_channel_custom: hw_value 34, ori=
g_flags:
00000000, flags 00000000
[=C2=A0=C2=A0 10.982346] cfg80211: Ignoring regulatory request set by core=
 since
the driver uses its own custom regulatory domain

The channel 34 has been disabled by brcmf_construct_chaninfo():
[=C2=A0=C2=A0 11.025681] brcmfmac: brcmf_construct_chaninfo: hw_value 34,
orig_flags: 00080000, flags 00000001
[=C2=A0=C2=A0 13.045508] cfg80211: Pending regulatory request, waiting for=
 it to
be processed...
[=C2=A0=C2=A0 13.237669] cfg80211: Ignoring regulatory request set by core=
 since
the driver uses its own custom regulatory domain
[=C2=A0=C2=A0 13.237692] cfg80211: World regulatory domain updated:
[=C2=A0=C2=A0 13.237696] cfg80211:=C2=A0 DFS Master region: unset
[=C2=A0=C2=A0 13.237701] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ ba=
ndwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0=C2=A0 13.237709] cfg80211:=C2=A0=C2=A0 (755000 KHz - 928000 KHz @ =
2000 KHz), (N/A,
2000 mBm), (N/A)
[=C2=A0=C2=A0 13.237717] cfg80211:=C2=A0=C2=A0 (2402000 KHz - 2472000 KHz =
@ 40000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 13.237726] cfg80211:=C2=A0=C2=A0 (2457000 KHz - 2482000 KHz =
@ 20000 KHz, 92000
KHz AUTO), (N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 13.237734] cfg80211:=C2=A0=C2=A0 (2474000 KHz - 2494000 KHz =
@ 20000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 13.237742] cfg80211:=C2=A0=C2=A0 (5170000 KHz - 5250000 KHz =
@ 80000 KHz,
160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 13.237750] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5330000 KHz =
@ 80000 KHz,
160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 13.237758] cfg80211:=C2=A0=C2=A0 (5490000 KHz - 5730000 KHz =
@ 160000 KHz),
(N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 13.237765] cfg80211:=C2=A0=C2=A0 (5735000 KHz - 5835000 KHz =
@ 80000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 13.237772] cfg80211:=C2=A0=C2=A0 (57240000 KHz - 63720000 KH=
z @ 2160000 KHz),
(N/A, 0 mBm), (N/A)
[=C2=A0=C2=A0 13.237814] cfg80211: Calling CRDA for country: DE
[=C2=A0=C2=A0 13.262648] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0=C2=A0 13.262687] cfg80211: handle_channel: hw_value 34, orig_flags=
:
00080000, flags 00000001
[=C2=A0=C2=A0 13.262696] cfg80211: handle_channel_single_rule: hw_value 34=
,
orig_flags: 00080000, flags 00000001
[=C2=A0=C2=A0 13.359105] brcmfmac: brcmf_construct_chaninfo: hw_value 34,
orig_flags: 00080000, flags 00000001
[=C2=A0=C2=A0 13.360210] cfg80211: Regulatory domain changed to country: D=
E
[=C2=A0=C2=A0 13.360231] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0=C2=A0 13.360235] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ ba=
ndwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0=C2=A0 13.360246] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz =
@ 40000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 13.360256] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 13.360265] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 13.360281] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz =
@ 160000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0=C2=A0 13.360289] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz =
@ 80000 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0=C2=A0 13.360296] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz =
@ 160000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 13.360303] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KH=
z @ 2160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0=C2=A0 17.172301] cfg80211: Found new beacon on frequency: 5180.000=
 MHz (Ch
36) on phy0
[=C2=A0=C2=A0 17.172326] cfg80211: Found new beacon on frequency: 5220.000=
 MHz (Ch
44) on phy0
[=C2=A0=C2=A0 20.800666] cfg80211: Calling CRDA for country: DE
[=C2=A0=C2=A0 20.834453] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0=C2=A0 20.834487] cfg80211: handle_channel: hw_value 34, orig_flags=
:
00080000, flags 00000001
[=C2=A0=C2=A0 20.834503] cfg80211: handle_channel_single_rule: hw_value 34=
,
orig_flags: 00080000, flags 00000001
[=C2=A0=C2=A0 20.835045] cfg80211: Regulatory domain changed to country: D=
E
[=C2=A0=C2=A0 20.835057] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0=C2=A0 20.835063] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ ba=
ndwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0=C2=A0 20.835075] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz =
@ 40000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 20.835095] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 20.835109] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 20.835122] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz =
@ 160000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0=C2=A0 20.835135] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz =
@ 80000 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0=C2=A0 20.835148] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz =
@ 160000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 20.835160] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KH=
z @ 2160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0=C2=A0 84.952323] cfg80211: Verifying active interfaces after reg c=
hange
[=C2=A0 344.070588] cfg80211: All devices are disconnected, going to resto=
re
regulatory settings
[=C2=A0 344.070619] cfg80211: Restoring regulatory settings while preservi=
ng
user preference for: DE

Dump after restore_custom_reg_settings() is finished (channel 34 is
re-enabled):
[=C2=A0 344.070639] cfg80211: restore_custom_reg_settings: hw_value 34,
orig_flags: 00080000, flags 00080000
[=C2=A0 344.070660] cfg80211: Ignoring regulatory request set by core sinc=
e
the driver uses its own custom regulatory domain
[=C2=A0 344.070675] cfg80211: World regulatory domain updated:
[=C2=A0 344.070684] cfg80211:=C2=A0 DFS Master region: unset
[=C2=A0 344.070692] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwid=
th),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0 344.070706] cfg80211:=C2=A0=C2=A0 (2402000 KHz - 2472000 KHz @ 400=
00 KHz), (600
mBi, 2000 mBm), (N/A)
[=C2=A0 344.070724] cfg80211:=C2=A0=C2=A0 (2457000 KHz - 2482000 KHz @ 200=
00 KHz, 92000
KHz AUTO), (600 mBi, 2000 mBm), (N/A)
[=C2=A0 344.070741] cfg80211:=C2=A0=C2=A0 (2474000 KHz - 2494000 KHz @ 200=
00 KHz), (600
mBi, 2000 mBm), (N/A)
[=C2=A0 344.070758] cfg80211:=C2=A0=C2=A0 (5170000 KHz - 5250000 KHz @ 800=
00 KHz,
160000 KHz AUTO), (600 mBi, 2000 mBm), (N/A)
[=C2=A0 344.070775] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5330000 KHz @ 800=
00 KHz,
160000 KHz AUTO), (600 mBi, 2000 mBm), (0 s)
[=C2=A0 344.070792] cfg80211:=C2=A0=C2=A0 (5490000 KHz - 5730000 KHz @ 160=
000 KHz),
(600 mBi, 2000 mBm), (0 s)
[=C2=A0 344.070808] cfg80211:=C2=A0=C2=A0 (5735000 KHz - 5835000 KHz @ 800=
00 KHz), (600
mBi, 2000 mBm), (N/A)
[=C2=A0 344.070824] cfg80211:=C2=A0=C2=A0 (57240000 KHz - 63720000 KHz @ 2=
160000 KHz),
(N/A, 0 mBm), (N/A)
[=C2=A0 344.070881] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0 344.070893] cfg80211: handle_channel: hw_value 34, orig_flags:
00080000, flags 00080000
[=C2=A0 344.070916] cfg80211: handle_channel_single_rule: hw_value 34,
orig_flags: 00080000, flags 00080000
[=C2=A0 344.071487] cfg80211: Regulatory domain changed to country: DE
[=C2=A0 344.071499] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0 344.071506] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwid=
th),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0 344.071519] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz @ 400=
00 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0 344.071536] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz @ 800=
00 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0 344.071552] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz @ 800=
00 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0 344.071567] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz @ 160=
000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0 344.071582] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz @ 800=
00 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0 344.071597] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz @ 160=
000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0 344.071611] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KHz @ 2=
160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0 344.071634] cfg80211: Kicking the queue
[=C2=A0 344.745318] cfg80211: Found new beacon on frequency: 5180.000 MHz =
(Ch
36) on phy0
[=C2=A0 344.745369] cfg80211: Found new beacon on frequency: 5220.000 MHz =
(Ch
44) on phy0
[=C2=A0 346.174985] brcmfmac: set chanspec 0xd022 fail, reason -52
[=C2=A0 346.175018] brcmfmac: hw_value 34, orig_flags: 00080000, flags 000=
80220
> Have you always seen this or at certain kernel update or
> wpa_supplicant maybe?
As written in the initial message i've tested Linux 6.3, 6.6 and 6.7-rc6
with wpa_supplicant 2.9 so far and saw this issue in these cases.

How far should i go?

I modified brcmf_construct_chaninfo() to store the
IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had it.
This avoid the issue. Not sure this is the proper solution.

Best regards


