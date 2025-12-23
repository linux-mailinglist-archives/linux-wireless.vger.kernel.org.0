Return-Path: <linux-wireless+bounces-30092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A53CDA12F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F5283002170
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 17:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5949112CDA5;
	Tue, 23 Dec 2025 17:17:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC913F4F1;
	Tue, 23 Dec 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766510253; cv=none; b=HCSw/vEy/orO8LIJJxb/DxHX4vKRMmTZRPjTnCe6Z6dpmgSf1Hq1g0uF/meobl+1I/KORCpG6/X89qSm8eAJ15ZvbTc2/MXGigQLbOWFljqMpI0Q3giso/lbD+mNXn/nYd1p8N/h/Oee69rtvLfgMLRgYZywBihTtLwwkgOgLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766510253; c=relaxed/simple;
	bh=5J5Z3j9TPc6hU60SsO4K9iGQi/SQx/ZYisWAA5RDiYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dSQieHSI+TxYKjFZQBl8GAo2hzQvuRDg4dLaSDFufFb460oheyP1ILOfErCr2QBFueCQiEwxIC9CUJklvAbA6X+2ItHNTrC/KmrA0TmgKs6iKrnHngt/q3rTTVva+e9Z93lzUIGuU1/01/SnWFQsG/mGK9XxIQU2uzBfvki3sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=telenor.net; spf=pass smtp.mailfrom=miraculix.mork.no; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=telenor.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BNHGJQY589406
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 17:16:20 GMT
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 5BNHGIXw540064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 18:16:19 +0100
Received: (nullmailer pid 993152 invoked by uid 1000);
	Tue, 23 Dec 2025 17:16:18 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bmork@telenor.net>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com,
        sean.wang@mediatek.com, shayne.chen@mediatek.com
Subject: Re: [PATCH 1/1] wifi: mt76: mt7996: fix mixed FEM check of mt7996
 chipset
In-Reply-To: <20251223140016.235771-1-amadeus@jmu.edu.cn> (Chukun Pan's
	message of "Tue, 23 Dec 2025 22:00:16 +0800")
Organization: Telenor
References: <87fr96tp7w.fsf@miraculix.mork.no>
	<20251223140016.235771-1-amadeus@jmu.edu.cn>
Date: Tue, 23 Dec 2025 18:16:18 +0100
Message-ID: <87a4z9f7a5.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Chukun Pan <amadeus@jmu.edu.cn> writes:

>> The problem is that the patch breaks the other device variant, which
>> used to work before.  If we assume the eeprom data from Zyxel is
>> correct, then this variant is iFEM.
>
> Do you have the specific model name and what the RF chips are?
> The eeprom seems to be fine.

Device with iFEM+eFEM+eFEM, working with your patch:
Zyxel EE4600-00

Readouts from the ADIE_ID registers:

root@ee4600:~# echo 0x0f00002c >/sys/kernel/debug/ieee80211/phy0/mt76/regidx
root@ee4600:~# grep . /sys/kernel/debug/ieee80211/phy0/mt76/rf_regval=20
0x79758a02
root@ee4600:~# echo 0x1f00002c >/sys/kernel/debug/ieee80211/phy0/mt76/regidx
root@ee4600:~# grep . /sys/kernel/debug/ieee80211/phy0/mt76/rf_regval=20
0x79778a10
root@ee4600:~# echo 0x2f00002c >/sys/kernel/debug/ieee80211/phy0/mt76/regidx
root@ee4600:~# grep . /sys/kernel/debug/ieee80211/phy0/mt76/rf_regval=20
0x79778a10

Device with iFEM+iFEM+iFEM, working before and breaking with your patch:
Zyxel WE4600-01

Readouts from the ADIE_ID registers:

root@we4600:~# echo 0x0f00002c >/sys/kernel/debug/ieee80211/phy0/mt76/regidx
root@we4600:~# grep . /sys/kernel/debug/ieee80211/phy0/mt76/rf_regval
0x79758a02
root@we4600:~# echo 0x1f00002c >/sys/kernel/debug/ieee80211/phy0/mt76/regidx
root@we4600:~# grep . /sys/kernel/debug/ieee80211/phy0/mt76/rf_regval
0x79778a11
root@we4600:~# echo 0x2f00002c >/sys/kernel/debug/ieee80211/phy0/mt76/regidx
root@we4600:~# grep . /sys/kernel/debug/ieee80211/phy0/mt76/rf_regval
0x79778a11


I don't know exactly what chips these are.  I have no specs or
datasheets and I haven't removed the heatsink and shielding




Bj=C3=B8rn

