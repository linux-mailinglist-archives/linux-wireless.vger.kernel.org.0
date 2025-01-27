Return-Path: <linux-wireless+bounces-18045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD56A1DD62
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 21:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C077A3BA1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772F1194A73;
	Mon, 27 Jan 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETGeTVvH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE6192D86;
	Mon, 27 Jan 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009754; cv=none; b=URefqmnyd4BnQfnMpDRmzovs+w0yxDZoEoG6eZoLGMAY2XwIB7yLnsJa42bKbEcFPLkch8qUic379SHVyzko2ilndtRpdlMbdwE00RM95OeurnoK+wjf9yfXGOod6zJUEmXnkUiUiMci+Ba+CTfhzmuYFg5fq8pNSkMLA1KCrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009754; c=relaxed/simple;
	bh=6id9f3WgauE77b1ncdI98pPy6plVxIz+rqbVv+3POCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZd5B5/bGWYiiF+4gJQ1vDkJOsllKopXZhcuWuWq2mZeRoCCJ77KR4RArU+2CDKxaTAruv0cMXf1S9I2zzQVHobbB8/ZqWw5z2/DT6VIkTjXbeD0+HZ0b9Nkw7RvPlcX1mjPZ/T89fgfcXj1DHtV/jGB/6L2Xk3BPCwnNC0lDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETGeTVvH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7be8efa231aso503676985a.2;
        Mon, 27 Jan 2025 12:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738009751; x=1738614551; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6id9f3WgauE77b1ncdI98pPy6plVxIz+rqbVv+3POCU=;
        b=ETGeTVvHMkgX8M5HU+VEBZ79na+I3nEoKwIajsI1bFU+FN5XhGhbJBRsDwfQ4g+GpT
         FUjd1pxuU6UEI+8yn6Ymzvo6NRx2GO4jM8QXBnr2xDq1cKi8v+nTpmCWh3MUw2W0UkVi
         XTXPTMJ1cnQHcUSscNkbsrGEHuo7TWW3S9un6iJovDNcg6nuBmC15cOjVmDSkWdDxJjQ
         S3LYdocd5bdJiKKsXsFh1m7tXiF141uKwnA69OUz7z30O7pHDo7hlJ3wRCddy+ylkjCW
         4Xm4zofsoFGipfblUUkD4CGAyOQe9ZRyPVHF9EkZg9+PuIc6/MBCL/ooz4xPcqEDthsC
         FirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738009751; x=1738614551;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6id9f3WgauE77b1ncdI98pPy6plVxIz+rqbVv+3POCU=;
        b=G4k0Tlk9QNZzrV+OMEt9u9gJlHJ7924QQsbNIpU7yB4riK3u8c4NeFNIVJ0cEgtyNs
         i2ln2f4pvQ35CVK3F/aVi+83NKYncv+is8mydZcynn1Gdzrci1nMn2VRTFB2u2wtigpO
         RsrsXeWU9ss+623EnV3gsVBtDGUcyutm8RZLUCWMNekE84/rM28HmJyO5+BM0+5SnvlW
         btidDO6MrDOXfaVC4EhL+F0XYluQ1kJ0W3aR0XgTzzCh5K3XcW0v2karUIwkK4GX6J3h
         libOVQI12gMefxWKRaHFJ4mOZGdkU75uFSFI40WqIouYscthGuRZstogl3GJVQ8HT+Sq
         EExA==
X-Forwarded-Encrypted: i=1; AJvYcCV3XX2rslQ64cFSHQwy1rK/sqc1n+LFrVINsfYz8ouZsn4JJ+sI3InxrGVLZqBcdUb03FRvbYTPQMDP2ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/10AsVVUgR0leoFo19HEevaB/tnCJPrWWoA5EfV4DvwZnWmb
	BTUZ4uTNPsvcAdPC46M+dq13wDxfSHc290KAd9RHB8NrH/0px0g8
X-Gm-Gg: ASbGncvkzw/Ja/0Lov67oWapAd+4tMO8O1rf8Vf8A1ecpNyY08wqnxtB3FoHMDFM0uw
	qwGSxNiy3VByhp7Qw6a8mLlmWNj+Izk7axk5kZZUrwBwebII8wP22HGh2IJ+md0cd6TRitxmDxN
	J5gqqMZqS+O0JzOS3xeD7Z4VySZs3zjSSO3ZrlRLizYJ6O7bHwRXGx4QHlN0viX+pyrOT9Hh1R8
	J/lTjnH76u1WdwCh/GFjcJqfCT3l5sXYvrIlv0xu5iTzNYh7kRxZEg0g6QqJNENc3AvACiPk2Jg
	AOHgQHJAOYT4++cgf/NZIw4W/CMGM8qizVdILHxG9XPvINDtBNVgvDXnHABOWRDPmho/ssKG
X-Google-Smtp-Source: AGHT+IFBvJKB9/271x7EC/HbpLXtXmNS0EldRKCcWmYXWl2xmcN9HQj8IOMAWLBYzZocdoSnhtC2Fw==
X-Received: by 2002:a05:6214:4988:b0:6dd:5f90:16bd with SMTP id 6a1803df08f44-6e1b22349dbmr623768666d6.41.1738009751330;
        Mon, 27 Jan 2025 12:29:11 -0800 (PST)
Received: from ?IPv6:2600:4041:5b0d:f100:fec2:7085:7ce5:711c? ([2600:4041:5b0d:f100:fec2:7085:7ce5:711c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2051369a1sm37908016d6.3.2025.01.27.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 12:29:10 -0800 (PST)
Message-ID: <77358eda94737ae3b98cfb40e96d40a829712b2b.camel@gmail.com>
Subject: Follow-Up: mt7915e card fails to init on Linux 6.3 and newer
From: Jared Van Bortel <jared.e.vb@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 27 Jan 2025 15:29:10 -0500
In-Reply-To: <3600f032dc921e44459c266aab76806428267c5e.camel@gmail.com>
References: <3600f032dc921e44459c266aab76806428267c5e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi. Just following up since I haven't seen a reply yet. The original e-
mail follows. I would like to get the eyes of a maintainer on this.

On Sun, 2025-01-19 at 21:24 -0500, Jared Van Bortel wrote:
> Hi all,
>=20
> I recently purchased a WallysTech DR7915 mPCIe Wi-Fi card (PCI ID
> 14c3:7915) for my ThinkPad W500. It is ostensibly based on the MT7915
> and MT7975 chips, using the mt7915e driver. I tried it on linux-stable
> 6.12.10 and was unable to get it to work. But it works fine on 6.1
> LTS.
>=20
> (As an aside - why is the latest firmware provided by mainline Linux
> version 20220929104113a, while OpenWRT is providing 20240429200502?)
>=20
> I bisected the issue to commit
> 9e81c2c7b9af6a5f160e0a9a7f009c37910402ee
> ("wifi: mt76: mt7915: enable per-phy led support"), which is included
> in
> kernel 6.3. This is what I get in dmesg before this commit (good
> behavior):
>=20
> [=C2=A0=C2=A0 34.976575] mt7915e 0000:03:00.0: HW/SW Version: 0x8a108a10,=
 Build
> Time: 20220929104113a
> [=C2=A0=C2=A0 34.990089] mt7915e 0000:03:00.0: WM Firmware Version: ____0=
00000,
> Build Time: 20220929104145
> [=C2=A0=C2=A0 35.012664] mt7915e 0000:03:00.0: WA Firmware Version: DEV_0=
00000,
> Build Time: 20220929104205
> [=C2=A0=C2=A0 35.178619] mt7915e 0000:03:00.0 wlp3s0: renamed from wlan0
> [=C2=A0=C2=A0 44.588223] wlan0: authenticate with XX:XX:XX:XX:XX:XX
> [=C2=A0=C2=A0 44.598831] wlan0: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
> [=C2=A0=C2=A0 44.601589] wlan0: authenticate with XX:XX:XX:XX:XX:XX
> [=C2=A0=C2=A0 44.601594] wlan0: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
> [=C2=A0=C2=A0 44.611058] wlan0: authenticate with XX:XX:XX:XX:XX:XX
> [=C2=A0=C2=A0 44.611064] wlan0: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
> [=C2=A0=C2=A0 44.612714] wlan0: authenticated
>=20
> This is what I get after that commit (bad behavior):
>=20
> [=C2=A0=C2=A0 37.507795] mt7915e 0000:03:00.0: HW/SW Version: 0x8a108a10,=
 Build
> Time: 20220929104113a
> [=C2=A0=C2=A0 37.521157] mt7915e 0000:03:00.0: WM Firmware Version: ____0=
00000,
> Build Time: 20220929104145
> [=C2=A0=C2=A0 37.541817] mt7915e 0000:03:00.0: WA Firmware Version: DEV_0=
00000,
> Build Time: 20220929104205
> [=C2=A0=C2=A0 37.707782] mt7915e 0000:03:00.0 wlp3s0: renamed from wlan0
> [=C2=A0=C2=A0 42.984991] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Link D=
own
> [=C2=A0=C2=A0 42.984999] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Card n=
ot
> present
> [=C2=A0=C2=A0 64.651072] mt7915e 0000:03:00.0: Message 00001eed (seq 9) t=
imeout
> [=C2=A0=C2=A0 85.131081] mt7915e 0000:03:00.0: Message 000007ed (seq 11) =
timeout
> [=C2=A0=C2=A0 85.132693] mt7915e 0000:03:00.0 wlp3s0f0: renamed from wlan=
0
> [=C2=A0 105.614421] mt7915e 0000:03:00.0: Message 000007ed (seq 1) timeou=
t
> [=C2=A0 107.701101] mt7915e 0000:03:00.0: Timeout for initializing firmwa=
re
> [=C2=A0 107.701154] mt7915e 0000:03:00.0: Failed to exit mcu
> [=C2=A0 107.844646] pci 0000:03:00.0: Removing from iommu group 6
> [=C2=A0 107.844679] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Card presen=
t
> [=C2=A0 109.541013] pcieport 0000:00:1c.1: pciehp: Slot(1-2): No link
> [=C2=A0 109.541024] pcieport 0000:00:1c.1: pciehp: Slot(1-2): Card presen=
t
> [=C2=A0 111.234338] pcieport 0000:00:1c.1: pciehp: Slot(1-2): No link
>=20
> On kernel 6.12.10, this failure leads to a page fault, sometimes
> immediately:
>=20
> [=C2=A0 127.807503] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] mt7915e 0000:03:00.0: =
Message 00001eed (seq
> 7) timeout
> [=C2=A0 127.914244] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] BUG: unable to handle =
page fault for
> address: ffffabc5c0628ff0
> [=C2=A0 127.914294] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] #PF: supervisor write =
access in kernel mode
> [=C2=A0 127.914329] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] #PF: error_code(0x0002=
) - not-present page
> [=C2=A0 127.914363] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] PGD 100000067 P4D 1000=
00067 PUD 100209067
> PMD 103e7f067 PTE 0
> [=C2=A0 127.914406] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Oops: Oops: 0002 [#1] =
PREEMPT SMP NOPTI
> [=C2=A0 127.914429] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] CPU: 0 UID: 0 PID: 73 =
Comm: kworker/u16:6
> Kdump: loaded Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.12.10-arch1-1 #1
> ac0cff2c6581af0a10f6e278cbc98026cc1e3dec
> [=C2=A0 127.914489] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Tainted: [I]=3DFIRMWAR=
E_WORKAROUND
> [=C2=A0 127.914510] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Hardware name: LENOVO =
40612ZU/40612ZU, BIOS
> 6FET93WW (3.23 ) 10/12/2012
> [=C2=A0 127.914538] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Workqueue: mt76 mt7915=
_mac_reset_work
> [mt7915e]
> [=C2=A0 127.914578] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] RIP: 0010:mt76_dma_rx_=
fill+0x157/0x4c0
> [mt76]
> [=C2=A0 127.914615] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Code: 8b 54 24 40 85 c=
0 4c 8b 44 24 18 4c 8b
> 4c 24 20 4c 8b 5c 24 28 0f 88 2a 03 00 00 c1 e0 10 44 89 ce 44 09 d8
> 81 ce 00 01 00 00 <45> 89 34 24 41 89 44 24 08 41 89 74 24 04 41 c7 44
> 24 0c 00 00 00
> [=C2=A0 127.914677] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] RSP: 0018:ffffabc5c03a=
fcf8 EFLAGS: 00010246
> [=C2=A0 127.914699] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] RAX: 0000000000000000 =
RBX: ffff9b694630d800
> RCX: 0000000000000000
> [=C2=A0 127.914726] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] RDX: 0000000000000000 =
RSI: 0000000006c00000
> RDI: 0000000000000000
> [=C2=A0 127.914753] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] RBP: ffff9b6947ef45d8 =
R08: ffff9b6948210000
> R09: 0000000006c00000
> [=C2=A0 127.914779] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] R10: 00000000000006c0 =
R11: 0000000000000000
> R12: ffffabc5c0628ff0
> [=C2=A0 127.914806] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] R13: ffff9b69c630d800 =
R14: 00000000ffd15800
> R15: 0000000000000000
> [=C2=A0 127.914833] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] FS:=C2=A0 000000000000=
0000(0000)
> GS:ffff9b6a77c00000(0000) knlGS:0000000000000000
> [=C2=A0 127.914868] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] CS:=C2=A0 0010 DS: 000=
0 ES: 0000 CR0:
> 0000000080050033
> [=C2=A0 127.914891] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] CR2: ffffabc5c0628ff0 =
CR3: 000000004b622000
> CR4: 00000000000426f0
> [=C2=A0 127.914918] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Call Trace:
> [=C2=A0 127.914930] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 <TASK>
> [=C2=A0 127.914942] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? __die_body.col=
d+0x19/0x27
> [=C2=A0 127.914967] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? page_fault_oop=
s+0x15a/0x2d0
> [=C2=A0 127.914992] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? search_bpf_ext=
ables+0x5f/0x80
> [=C2=A0 127.915016] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? exc_page_fault=
+0x18a/0x190
> [=C2=A0 127.915035] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? asm_exc_page_f=
ault+0x26/0x30
> [=C2=A0 127.915056] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? mt76_dma_rx_fi=
ll+0x157/0x4c0 [mt76
> 8ebc1f1034fdcf4b82c21f7f79b6854fd3dd0e30]
> [=C2=A0 127.915096] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? mt76_dma_rx_fi=
ll+0x1ef/0x4c0 [mt76
> 8ebc1f1034fdcf4b82c21f7f79b6854fd3dd0e30]
> [=C2=A0 127.915137] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? mt76_dma_rx_cl=
eanup.part.0+0x5e/0x160
> [mt76 8ebc1f1034fdcf4b82c21f7f79b6854fd3dd0e30]
> [=C2=A0 127.915185] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? mt76_dma_rx_cl=
eanup.part.0+0x6c/0x160
> [mt76 8ebc1f1034fdcf4b82c21f7f79b6854fd3dd0e30]
> [=C2=A0 127.915233] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 mt7915_dma_reset=
+0x1e1/0x230 [mt7915e
> 7945e3c7bfde237a78fef4a04127eb6221537724]
> [=C2=A0 127.915280] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 mt7915_mac_reset=
_work+0x67e/0xcd0 [mt7915e
> 7945e3c7bfde237a78fef4a04127eb6221537724]
> [=C2=A0 127.915323] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 process_one_work=
+0x17b/0x330
> [=C2=A0 127.915343] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 worker_thread+0x=
2ce/0x3f0
> [=C2=A0 127.915365] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? __pfx_worker_t=
hread+0x10/0x10
> [=C2=A0 127.915389] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 kthread+0xcf/0x1=
00
> [=C2=A0 127.915406] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? __pfx_kthread+=
0x10/0x10
> [=C2=A0 127.915428] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ret_from_fork+0x=
31/0x50
> [=C2=A0 127.915449] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ? __pfx_kthread+=
0x10/0x10
> [=C2=A0 127.915470] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 ret_from_fork_as=
m+0x1a/0x30
> [=C2=A0 127.915494] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 </TASK>
> [=C2=A0 127.915507] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] Modules linked in: mt7=
915e mt76_connac_lib
> mt76 mac80211 libarc4 cfg80211 snd_seq_dummy snd_hrtimer snd_seq
> snd_seq_device ip6t_REJECT nf_reject_ipv6 ipt_REJECT xt_multiport
> xt_cgroup xt_mark xt_owner xt_tcpudp nft_compat amdgpu amdxcp drm_exec
> gpu_sched nft_masq drm_buddy nft_ct nft_reject_ipv4 nf_reject_ipv4
> nft_reject act_csum cls_u32 sch_htb nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables bridge stp llc btusb btrtl
> btintel btbcm btmtk bluetooth crc16 joydev mousedev snd_hda_codec_hdmi
> snd_hda_codec_conexant kvm_intel iTCO_wdt snd_hda_codec_generic
> intel_pmc_bxt radeon snd_hda_intel mei_wdt iTCO_vendor_support
> snd_intel_dspcfg kvm i2c_algo_bit snd_intel_sdw_acpi pcmcia i2c_i801
> drm_suballoc_helper snd_hda_codec drm_ttm_helper i2c_smbus
> snd_hda_core sha512_ssse3 ttm i2c_mux sha1_ssse3 snd_hwdep
> yenta_socket psmouse acpi_cpufreq pcspkr e1000e r592 pcmcia_rsrc
> pktcdvd mei_me snd_pcm memstick ptp drm_display_helper pcmcia_core
> lpc_ich intel_agp snd_timer mei pps_core cec intel_gtt
> [=C2=A0 127.915596] [=C2=A0=C2=A0=C2=A0=C2=A0 T73]=C2=A0 think_lmi mac_hi=
d firmware_attributes_class
> wmi_bmof coretemp thinkpad_acpi platform_profile sparse_keymap rfkill
> snd soundcore video wmi sg crypto_user dm_mod loop nfnetlink ip_tables
> x_tables btrfs blake2b_generic libcrc32c crc32c_generic serio_raw
> sdhci_pci xor atkbd raid6_pq libps2 vivaldi_fmap firewire_ohci cqhci
> sr_mod sdhci firewire_core sha256_ssse3 mmc_core cdrom i8042 crc_itu_t
> serio
> [=C2=A0 127.916035] [=C2=A0=C2=A0=C2=A0=C2=A0 T73] CR2: ffffabc5c0628ff0
>=20
>=20
> It would be nice to be able to use this card on a more recent kernel.
> I
> can assist with debugging and testing, assuming I haven't somehow
> gotten
> a defective unit - but I don't think that would really explain why I
> can
> use it just fine on 6.1 LTS.
>=20
> Thanks,
> Jared Van Bortel

