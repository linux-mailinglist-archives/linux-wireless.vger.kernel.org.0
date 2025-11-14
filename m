Return-Path: <linux-wireless+bounces-28989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3ACC5E226
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19C1A540964
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEB12264B0;
	Fri, 14 Nov 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="rGsrr7ME"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7C23F26A
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133763; cv=none; b=AdX8S0rT495rmc0wBnEdRCqJKviudj4ENFuUb4AsRw7vC2woM++kwxXVedmDzMifrEgn6g//xGgvM8kzmxc0mFArnL6hdgBvee66sIxtiRFWNYGEsKnOEeQ0sHTbE2i8mBU0VrT9+WaNXQiHdiYAqy0tnTIjMIUe7GI9a8m13Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133763; c=relaxed/simple;
	bh=TH+Nrt7q+9X2Vdyupy3/Fo/i1Q9MVIoHvgkBfF0TRQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKPP2gMy3eAlc80CErwY9gBebe7yqNxnZ9gWSj6XEZnAq4wgw8GPbyX8XfQ+R2T+FHYIXhEuDXNvcvM6tTOeFIt5cUOZEvdZ/F7T2WZlstKtXFBDCdHj0JLbMepStJYPBhR9NVoKa5wCSp97sKM2hfSy4e4dLb/q3kZADoYAvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=rGsrr7ME; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 15802340090;
	Fri, 14 Nov 2025 15:22:30 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.36.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 491CD13C2B0;
	Fri, 14 Nov 2025 07:22:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 491CD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1763133748;
	bh=TH+Nrt7q+9X2Vdyupy3/Fo/i1Q9MVIoHvgkBfF0TRQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rGsrr7MEikNS+O47qapdoYAOl1p1pcuMKx9KZ0Zz8GjYTDeqZkIZ+NnL0/cW0S3LX
	 1vvonONhtWa6XkD+WWcl0xlntzf8iqEtph35XKov92SMKDuhuTYf/EUlHffJxqIbj5
	 D1OrcUio065QNbA0L9N0YiHqJNFh8FkGKnYDzw+M=
Message-ID: <c0dd1c92-982c-49aa-a4cf-fcf4b105e839@candelatech.com>
Date: Fri, 14 Nov 2025 07:22:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mt76 0/4] wifi: mt76: mt7996: Fix some locking issues for
 MLO
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20251114-mt76-fix-missing-mtx-v1-0-259ebf11f654@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1763133752-K2xk0p8JVr5y
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1763133752;K2xk0p8JVr5y;<greearb@candelatech.com>;cd09869c97ce2e719a3744df88686fd8
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello Lorenzo,

These 4 patches appear to fix some of the problems, but the mac802.11/key.c lockdep
splat remains.  I sent you email with the details.

The kernel crash due to NPE that I was previously hacking around appears gone now,
or at least harder to reproduce.

You are welcome to add:

Tested-by: Ben Greear <greearb@candelatech.com>

Thanks,
Ben


On 11/14/25 05:16, Lorenzo Bianconi wrote:
> 
> ---
> Lorenzo Bianconi (4):
>        wifi: mt76: mt7996: grab mt76 mutex in mt7996_mac_sta_event()
>        wifi: mt76: mt7996: Move mt7996_update_beacons inside mt76 mutex critical section
>        wifi: mt76: Move mt76_abort_scan out of mt76_reset_device()
>        wifi: mt76: mt7996: skip deflink accounting for offchannel links
> 
>   drivers/net/wireless/mediatek/mt76/mac80211.c    |  2 --
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c  |  2 ++
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c  |  5 +++--
>   drivers/net/wireless/mediatek/mt76/mt7996/main.c | 21 ++++++++++++++-------
>   4 files changed, 19 insertions(+), 11 deletions(-)
> ---
> base-commit: c99ebb6132595b4b288a413981197eb076547c5a
> change-id: 20251114-mt76-fix-missing-mtx-db664ffcce1a
> 
> Best regards,

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


