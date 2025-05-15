Return-Path: <linux-wireless+bounces-23015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C20AB8A9E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954343A21B4
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4042A82;
	Thu, 15 May 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ato9ET+A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48E18FC91
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322493; cv=none; b=UruSKHOLBz/LCzzbKKAQroWjdXTk0e2sJ+7ONAuvB74SXueBPPoCpGizccVHBYEUkY158iOe6wOgJR2q8N3yWCRFO4fc+OWRLJIhy9wN4KIc6dOdC/+g1zCQ90l9G6EklElAPw12Y+6uW9PwqQ57NGV1zTyQljygVxeaISINxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322493; c=relaxed/simple;
	bh=aTNIZYLycQ0W9C464nw7KO1ReITHuW9wxbkjTqgzSy4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OBkRHaIDoOopeLfWlrjn34A7waSMC291ciJu+AEnGnycuRapEUwseQX3VbTsu3B2WKygfYdYaUjBdNNtb4DRDbY8ntyJF4EHeqsl6gyNkks7zso1bO/95R+nN//e4SUdXTNYrA4jFYfShv9YUun0PoivovJjZy4EkDVwtHkAJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ato9ET+A; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6D4FC5013CF
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 15:12:49 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.110.50.132])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 81C1A60124;
	Thu, 15 May 2025 15:12:42 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6760C9C00BA;
	Thu, 15 May 2025 15:12:40 +0000 (UTC)
Received: from [192.168.101.118] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 5C17F13C2B0;
	Thu, 15 May 2025 08:12:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5C17F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1747321959;
	bh=aTNIZYLycQ0W9C464nw7KO1ReITHuW9wxbkjTqgzSy4=;
	h=Date:To:Cc:From:Subject:From;
	b=ato9ET+A0kWc8GOJo86DpK3CdhEMpOdGrQ9E0suohP/jXELAihz7L5PULR0qc8J1q
	 FzDRBMJq0khbqRJkqg7X9cih+yChhkkkSwe3XwSd/CPmHAR5VUIFGYt2ojRz055uxD
	 vTEkuTpylGNxCCp5dIpVgOR4gSPetn6wFULWh4GM=
Message-ID: <28e3f8c3-13ef-47f6-818a-36ccf1055f9e@candelatech.com>
Date: Thu, 15 May 2025 08:12:39 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>
Content-Language: en-US
Cc: linux-wireless@vger.kernel.org, Yi-Chia Hsieh
 <Yi-Chia.Hsieh@mediatek.com>, JackCM Wu <JackCM.Wu@mediatek.com>,
 Shurong Wen <Shurong.Wen@mediatek.com>, Kurtis Ke <kurtis.ke@mediatek.com>
From: "Dylan E." <dylan.eskew@candelatech.com>
Subject: [Bug Report] mt7996: Many stations authentication bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1747321961-04CmW5TVVLWO
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1747321961;04CmW5TVVLWO;<dylan.eskew@candelatech.com>;02188a835256fb83d90270bd0a51d00c
X-PPE-TRUSTED: V=1;DIR=OUT;

Hi,

We have found a bug with the mt7996 where only 3 or 4 stations will
successfully associate with an AP. Any additional stations are
deauthenticated by the AP while EAPOL messages are being passed.

When looking at the packet capture of a failing station, the station
fails to respond to the AP's first EAPOL message as the message is
sent to itself.

Excerpt from station's EAPOL response to AP using WPA2:
---
EAPOL - Key (Message 2 of 4)
...
IEEE 802.11 QoS Data, Flags: .......T
     ...
     Receiver address: Adtran_8f:a3:24 (38:f8:f6:8f:a3:24) <--- Station
     Transmitter address: Adtran_8f:a3:24 (38:f8:f6:8f:a3:24) <--- Also 
Station
     Destination address: AsiaRF_68:35:f1 (00:0a:52:68:35:f1) <--- AP
     Source address: Adtran_8f:a3:24 (38:f8:f6:8f:a3:24)
...
---

We see a similar issue when connecting to an Open AP when
the station does DHCP discovery:
---
DHCP Discover - Transaction ID 0x3ccf5f2c
...
IEEE 802.11 QoS Data, Flags: .......T
     ...
     Receiver address: Adtran_8f:a3:24 (38:f8:f6:8f:a3:24) <--- Station
     Transmitter address: Adtran_8f:a3:24 (38:f8:f6:8f:a3:24) <--- Also 
Station
     Destination address: AsiaRF_68:35:f1 (00:0a:52:68:35:f1) <--- AP
     Source address: Adtran_8f:a3:24 (38:f8:f6:8f:a3:24)
...
---

We have narrowed down the bug to within these two patches in the
linux-wireless tree:
commit 69d54ce7491d046eaae05de7fb2493319a481991
Author: Felix Fietkau <nbd@nbd.name>
Date:   Thu Jan 2 17:35:00 2025 +0100

     wifi: mt76: mt7996: switch to single multi-radio wiphy

commit c56d6edebc1f59afec7a59117ab50abd89879006
Author: Felix Fietkau <nbd@nbd.name>
Date:   Thu Jan 2 17:34:57 2025 +0100

     wifi: mt76: mt7996: use emulated hardware scan support

Commit c56d6ede introduces a scanning bug which is fixed in commit 
69d54ce7,
so to verify, we moved c56d6ede to right before 69d54ce7 in the history
(it was a clean merge) and found that the station connection issue is not
present before these commits.

Hardware info:

FW Build Date: 2025-03-28

$ lspci -nn -s 04:00.0
04:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7990]

$ lspci -nn -s 05:00.0
05:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7991]

$ lspci -vvvk
04:00.0 Network controller: MEDIATEK Corp. Device 7990
     Subsystem: MEDIATEK Corp. Device 6639
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 169
     Region 0: Memory at 6000c00000 (64-bit, prefetchable) [size=2M]
     Region 2: Memory at 80800000 (64-bit, non-prefetchable) [size=32K]
     Capabilities: <access denied>
     Kernel driver in use: mt7996e
     Kernel modules: mt7996e

05:00.0 Network controller: MEDIATEK Corp. Device 7991
     Subsystem: MEDIATEK Corp. Device 6639
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 170
     Region 0: Memory at 6000a00000 (64-bit, prefetchable) [size=2M]
     Region 2: Memory at 80700000 (64-bit, non-prefetchable) [size=32K]
     Capabilities: <access denied>
     Kernel driver in use: mt7996e_hif
     Kernel modules: mt7996e

-- Dylan Eskew


