Return-Path: <linux-wireless+bounces-1981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A182F04B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619391C20C63
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF81BF24;
	Tue, 16 Jan 2024 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EH7rJeqc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822961BF20
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HKO1nfhEmvfQAGzaIzR0ujHq4vVQqtDJQ9/2m3yj4E8=;
	t=1705414188; x=1706623788; b=EH7rJeqcPt/iNEHtxGx509dzI6UCu6WAcSOCJzte6pkCXeL
	4zxzrL3DBVh+rm/OwrhSgKu/m6vjz9IkS1SwYNer//BYqyAcRdynljclxS5JjR4JlsDCo0VMaoi+q
	DE5LCGiGWTSDl1rbGpCfQvteaR8rxpIFxE4Bu3aJzLp5PK+GRSaM+QTCre2er4wX/uTDVQoQCmaaT
	Wce5waNihiUuG+7GGNSJWWfHtZn4+ta9y8zDSRX3mBkhMrkdFHzhmH00LYZeu3LE7dvZko0ECYPD8
	5+dW6c9U4NK9Tx9I6Vip5FqNVAUu+buh+qglZILR6ejuOjnGlbFB98w57QoHaneg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPk8O-000000051Pl-0LlN;
	Tue, 16 Jan 2024 15:09:44 +0100
Message-ID: <19541618e400c95a448f7e8c79590c01df214782.camel@sipsolutions.net>
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022
 fail, reason -52 - Part 2
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Wahren <wahrenst@gmx.net>, Arend Van Spriel
 <arend.vanspriel@broadcom.com>, Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>, Hante Meuleman
 <hante.meuleman@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
 SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>, Kalle
 Valo <kvalo@kernel.org>
Date: Tue, 16 Jan 2024 15:09:42 +0100
In-Reply-To: <d90cc093-e3fc-4af4-9a4a-5f4bd9a7cb1f@gmx.net>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-26 at 20:27 +0100, Stefan Wahren wrote:
> Hi Arend,
>=20
> [add Johannes]

Sorry this fell through, Intel address ...

Was there a specific question you had?

> > > > [=C2=A0 334.956787] cfg80211: Calling CRDA for country: DE
> > >=20
> > > I guess this message is a bit stale and there is no crda user-mode
> > > helper.

It may still try to call it, but I guess nothing will happen.

> > >=20
> > > > [=C2=A0 334.990709] cfg80211: Disabling freq 2484.000 MHz
> > >=20
> > > So 2GHz channel 14 gets disabled here probably due to country change
> > > to DE.
> > >=20
> > > Not learned a whole lot more from this test round except that reg.c i=
s
> > > active during the reconnect so I suggest to zoom in there. Especially
> > > around the "restoring" message.
> >=20
> > I wonder whether we end up in restore_custom_reg_settings() which does:
> >=20
> > chan->flags =3D chan->orig_flags;
> >=20
> > for each channel. That would re-enable those channels.
> Bingo
>=20
> This caused the problem. Since brcmf_construct_chaninfo() is only called
> once and only changes the flags but never orig_flags, the information
> about disabled channels get lost (logs are focused on hw_value 34):
>=20
> [=C2=A0=C2=A0 10.294909] cfg80211: Loading compiled-in X.509 certificates=
 for
> regulatory database
> [=C2=A0=C2=A0 10.717262] brcmfmac: brcmf_fw_alloc_request: using
> brcm/brcmfmac43455-sdio for chip BCM4345/6
> [=C2=A0=C2=A0 10.718408] cfg80211: loaded regulatory.db is malformed or s=
ignature
> is missing/invalid
> [=C2=A0=C2=A0 10.718427] cfg80211: Restoring regulatory settings
> [=C2=A0=C2=A0 10.718435] cfg80211: Kicking the queue
> [=C2=A0=C2=A0 10.718452] cfg80211: Calling CRDA to update world regulator=
y domain
> [=C2=A0=C2=A0 10.948418] brcmfmac: brcmf_c_process_txcap_blob: no txcap_b=
lob
> available (err=3D-2)
> [=C2=A0=C2=A0 10.948764] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43=
45/6 wl0:
> Nov=C2=A0 1 2021 00:37:25 version 7.45.241 (1a2f2fa CY) FWID 01-703fd60
> [=C2=A0=C2=A0 10.982088] cfg80211: handle_channel_custom: hw_value 34, or=
ig_flags:
> 00000000, flags 00000000
> [=C2=A0=C2=A0 10.982346] cfg80211: Ignoring regulatory request set by cor=
e since
> the driver uses its own custom regulatory domain
>=20
> The channel 34 has been disabled by brcmf_construct_chaninfo():
> [=C2=A0=C2=A0 11.025681] brcmfmac: brcmf_construct_chaninfo: hw_value 34,
> orig_flags: 00080000, flags 00000001
> [=C2=A0=C2=A0 13.045508] cfg80211: Pending regulatory request, waiting fo=
r it to
> be processed...
> [=C2=A0=C2=A0 13.237669] cfg80211: Ignoring regulatory request set by cor=
e since
> the driver uses its own custom regulatory domain
> [=C2=A0=C2=A0 13.237692] cfg80211: World regulatory domain updated:
> [=C2=A0=C2=A0 13.237696] cfg80211:=C2=A0 DFS Master region: unset
> [=C2=A0=C2=A0 13.237701] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ b=
andwidth),
> (max_antenna_gain, max_eirp), (dfs_cac_time)
> [=C2=A0=C2=A0 13.237709] cfg80211:=C2=A0=C2=A0 (755000 KHz - 928000 KHz @=
 2000 KHz), (N/A,
> 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.237717] cfg80211:=C2=A0=C2=A0 (2402000 KHz - 2472000 KHz=
 @ 40000 KHz),
> (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.237726] cfg80211:=C2=A0=C2=A0 (2457000 KHz - 2482000 KHz=
 @ 20000 KHz, 92000
> KHz AUTO), (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.237734] cfg80211:=C2=A0=C2=A0 (2474000 KHz - 2494000 KHz=
 @ 20000 KHz),
> (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.237742] cfg80211:=C2=A0=C2=A0 (5170000 KHz - 5250000 KHz=
 @ 80000 KHz,
> 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.237750] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5330000 KHz=
 @ 80000 KHz,
> 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [=C2=A0=C2=A0 13.237758] cfg80211:=C2=A0=C2=A0 (5490000 KHz - 5730000 KHz=
 @ 160000 KHz),
> (N/A, 2000 mBm), (0 s)
> [=C2=A0=C2=A0 13.237765] cfg80211:=C2=A0=C2=A0 (5735000 KHz - 5835000 KHz=
 @ 80000 KHz),
> (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.237772] cfg80211:=C2=A0=C2=A0 (57240000 KHz - 63720000 K=
Hz @ 2160000 KHz),
> (N/A, 0 mBm), (N/A)
> [=C2=A0=C2=A0 13.237814] cfg80211: Calling CRDA for country: DE
> [=C2=A0=C2=A0 13.262648] cfg80211: Disabling freq 2484.000 MHz
> [=C2=A0=C2=A0 13.262687] cfg80211: handle_channel: hw_value 34, orig_flag=
s:
> 00080000, flags 00000001
> [=C2=A0=C2=A0 13.262696] cfg80211: handle_channel_single_rule: hw_value 3=
4,
> orig_flags: 00080000, flags 00000001
> [=C2=A0=C2=A0 13.359105] brcmfmac: brcmf_construct_chaninfo: hw_value 34,
> orig_flags: 00080000, flags 00000001
> [=C2=A0=C2=A0 13.360210] cfg80211: Regulatory domain changed to country: =
DE
> [=C2=A0=C2=A0 13.360231] cfg80211:=C2=A0 DFS Master region: ETSI
> [=C2=A0=C2=A0 13.360235] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ b=
andwidth),
> (max_antenna_gain, max_eirp), (dfs_cac_time)
> [=C2=A0=C2=A0 13.360246] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz=
 @ 40000 KHz),
> (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 13.360256] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz=
 @ 80000 KHz,
> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
> [=C2=A0=C2=A0 13.360265] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz=
 @ 80000 KHz,
> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [=C2=A0=C2=A0 13.360281] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz=
 @ 160000 KHz),
> (N/A, 2698 mBm), (0 s)
> [=C2=A0=C2=A0 13.360289] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz=
 @ 80000 KHz),
> (N/A, 1397 mBm), (N/A)
> [=C2=A0=C2=A0 13.360296] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz=
 @ 160000 KHz,
> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
> [=C2=A0=C2=A0 13.360303] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 K=
Hz @ 2160000 KHz),
> (N/A, 4000 mBm), (N/A)
> [=C2=A0=C2=A0 17.172301] cfg80211: Found new beacon on frequency: 5180.00=
0 MHz (Ch
> 36) on phy0
> [=C2=A0=C2=A0 17.172326] cfg80211: Found new beacon on frequency: 5220.00=
0 MHz (Ch
> 44) on phy0
> [=C2=A0=C2=A0 20.800666] cfg80211: Calling CRDA for country: DE
> [=C2=A0=C2=A0 20.834453] cfg80211: Disabling freq 2484.000 MHz
> [=C2=A0=C2=A0 20.834487] cfg80211: handle_channel: hw_value 34, orig_flag=
s:
> 00080000, flags 00000001
> [=C2=A0=C2=A0 20.834503] cfg80211: handle_channel_single_rule: hw_value 3=
4,
> orig_flags: 00080000, flags 00000001
> [=C2=A0=C2=A0 20.835045] cfg80211: Regulatory domain changed to country: =
DE
> [=C2=A0=C2=A0 20.835057] cfg80211:=C2=A0 DFS Master region: ETSI
> [=C2=A0=C2=A0 20.835063] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ b=
andwidth),
> (max_antenna_gain, max_eirp), (dfs_cac_time)
> [=C2=A0=C2=A0 20.835075] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz=
 @ 40000 KHz),
> (N/A, 2000 mBm), (N/A)
> [=C2=A0=C2=A0 20.835095] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz=
 @ 80000 KHz,
> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
> [=C2=A0=C2=A0 20.835109] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz=
 @ 80000 KHz,
> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [=C2=A0=C2=A0 20.835122] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz=
 @ 160000 KHz),
> (N/A, 2698 mBm), (0 s)
> [=C2=A0=C2=A0 20.835135] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz=
 @ 80000 KHz),
> (N/A, 1397 mBm), (N/A)
> [=C2=A0=C2=A0 20.835148] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz=
 @ 160000 KHz,
> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
> [=C2=A0=C2=A0 20.835160] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 K=
Hz @ 2160000 KHz),
> (N/A, 4000 mBm), (N/A)
> [=C2=A0=C2=A0 84.952323] cfg80211: Verifying active interfaces after reg =
change
> [=C2=A0 344.070588] cfg80211: All devices are disconnected, going to rest=
ore
> regulatory settings
> [=C2=A0 344.070619] cfg80211: Restoring regulatory settings while preserv=
ing
> user preference for: DE
>=20
> Dump after restore_custom_reg_settings() is finished (channel 34 is
> re-enabled):
> [=C2=A0 344.070639] cfg80211: restore_custom_reg_settings: hw_value 34,
> orig_flags: 00080000, flags 00080000
> [=C2=A0 344.070660] cfg80211: Ignoring regulatory request set by core sin=
ce
> the driver uses its own custom regulatory domain
> [=C2=A0 344.070675] cfg80211: World regulatory domain updated:
> [=C2=A0 344.070684] cfg80211:=C2=A0 DFS Master region: unset
> [=C2=A0 344.070692] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwi=
dth),
> (max_antenna_gain, max_eirp), (dfs_cac_time)
> [=C2=A0 344.070706] cfg80211:=C2=A0=C2=A0 (2402000 KHz - 2472000 KHz @ 40=
000 KHz), (600
> mBi, 2000 mBm), (N/A)
> [=C2=A0 344.070724] cfg80211:=C2=A0=C2=A0 (2457000 KHz - 2482000 KHz @ 20=
000 KHz, 92000
> KHz AUTO), (600 mBi, 2000 mBm), (N/A)
> [=C2=A0 344.070741] cfg80211:=C2=A0=C2=A0 (2474000 KHz - 2494000 KHz @ 20=
000 KHz), (600
> mBi, 2000 mBm), (N/A)
> [=C2=A0 344.070758] cfg80211:=C2=A0=C2=A0 (5170000 KHz - 5250000 KHz @ 80=
000 KHz,
> 160000 KHz AUTO), (600 mBi, 2000 mBm), (N/A)
> [=C2=A0 344.070775] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5330000 KHz @ 80=
000 KHz,
> 160000 KHz AUTO), (600 mBi, 2000 mBm), (0 s)
> [=C2=A0 344.070792] cfg80211:=C2=A0=C2=A0 (5490000 KHz - 5730000 KHz @ 16=
0000 KHz),
> (600 mBi, 2000 mBm), (0 s)
> [=C2=A0 344.070808] cfg80211:=C2=A0=C2=A0 (5735000 KHz - 5835000 KHz @ 80=
000 KHz), (600
> mBi, 2000 mBm), (N/A)
> [=C2=A0 344.070824] cfg80211:=C2=A0=C2=A0 (57240000 KHz - 63720000 KHz @ =
2160000 KHz),
> (N/A, 0 mBm), (N/A)
> [=C2=A0 344.070881] cfg80211: Disabling freq 2484.000 MHz
> [=C2=A0 344.070893] cfg80211: handle_channel: hw_value 34, orig_flags:
> 00080000, flags 00080000
> [=C2=A0 344.070916] cfg80211: handle_channel_single_rule: hw_value 34,
> orig_flags: 00080000, flags 00080000
> [=C2=A0 344.071487] cfg80211: Regulatory domain changed to country: DE
> [=C2=A0 344.071499] cfg80211:=C2=A0 DFS Master region: ETSI
> [=C2=A0 344.071506] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwi=
dth),
> (max_antenna_gain, max_eirp), (dfs_cac_time)
> [=C2=A0 344.071519] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz @ 40=
000 KHz),
> (N/A, 2000 mBm), (N/A)
> [=C2=A0 344.071536] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz @ 80=
000 KHz,
> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
> [=C2=A0 344.071552] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz @ 80=
000 KHz,
> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
> [=C2=A0 344.071567] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz @ 16=
0000 KHz),
> (N/A, 2698 mBm), (0 s)
> [=C2=A0 344.071582] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz @ 80=
000 KHz),
> (N/A, 1397 mBm), (N/A)
> [=C2=A0 344.071597] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz @ 16=
0000 KHz,
> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
> [=C2=A0 344.071611] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KHz @ =
2160000 KHz),
> (N/A, 4000 mBm), (N/A)
> [=C2=A0 344.071634] cfg80211: Kicking the queue
> [=C2=A0 344.745318] cfg80211: Found new beacon on frequency: 5180.000 MHz=
 (Ch
> 36) on phy0
> [=C2=A0 344.745369] cfg80211: Found new beacon on frequency: 5220.000 MHz=
 (Ch
> 44) on phy0
> [=C2=A0 346.174985] brcmfmac: set chanspec 0xd022 fail, reason -52
> [=C2=A0 346.175018] brcmfmac: hw_value 34, orig_flags: 00080000, flags 00=
080220
> > Have you always seen this or at certain kernel update or
> > wpa_supplicant maybe?
> As written in the initial message i've tested Linux 6.3, 6.6 and 6.7-rc6
> with wpa_supplicant 2.9 so far and saw this issue in these cases.
>=20
> How far should i go?
>=20
> I modified brcmf_construct_chaninfo() to store the
> IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had it.
> This avoid the issue. Not sure this is the proper solution.
>=20

orig_flags are from when the wiphy is registered - does the driver only
set up proper flags after that?

johannes

