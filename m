Return-Path: <linux-wireless+bounces-23776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6EACF512
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4010164A5B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 17:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725F32750E3;
	Thu,  5 Jun 2025 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Zs5n9OOn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C71F4701
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143603; cv=none; b=UsxT9QwOgHLMVAQR5+y2u7Wo5aAKL9+Y5E6UHSDJnK4DO+z2TsBnAyj3pAnUvYRgIcGyaY91qEGwZdZW7jvfzsdyZ8L2OE2gMpjff5iuOj7n2fpASnicMl4QhdKukyo4Ci6OI/WZnzvPW7f2fCpmZAV+/qlETZ2j/do8fzLwjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143603; c=relaxed/simple;
	bh=fEROW6MFubzLVLqFEB6ROeIf15UZMOQpmD58TNf1v0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA88tb/c3+laHKjbgwh0G5LNqDcLouWD2VRUPHsfdy0aMgtMPR2pj+JeEqwoJ5wZ6HxzhTzzf8b1V6IIk6QZscAotL+YsfhUFZvcYYLNJpZSbp7peJQC89kFGMIQzzxsZ82AJj7eA3bnYyxmLodWzAXCy7MEicQ3FdU/nUUHJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Zs5n9OOn; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D14972C66DC
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 17:13:20 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.7.65.214])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E53446011B;
	Thu,  5 Jun 2025 17:13:13 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 52A34600094;
	Thu,  5 Jun 2025 17:13:10 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8650B13C2B0;
	Thu,  5 Jun 2025 10:13:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8650B13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1749143589;
	bh=fEROW6MFubzLVLqFEB6ROeIf15UZMOQpmD58TNf1v0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zs5n9OOnY8zbMLuruhSsWqafeFMZa+qlzws0syCdOdcLWUKJyBRP2Wul1jfQREgsu
	 FYU4AyYwz42y0u95dlIyuIYxdjwVsHfknbP77Y7Q5y00pRFd2vpxwCtuCNWs32DkJZ
	 vQlSVeJnwpP0iGGu0xw+yCid8wY+IvHIpLR7z7Ro=
Message-ID: <7b381baa-61a5-2a19-1bd6-47ad4abfdf3d@candelatech.com>
Date: Thu, 5 Jun 2025 10:13:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH mt76 5/5] wifi: mt76: Remove RCU section in
 mt7996_mac_sta_rc_work()
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
 <20250605-mt7996-sleep-while-atomic-v1-5-d46d15f9203c@kernel.org>
 <909d2ca8-8409-997a-768f-8e9be4c5168e@candelatech.com>
 <aEHMZe0_vuml8eI9@lore-desk>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <aEHMZe0_vuml8eI9@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1749143591-RkLwwLRq3_vm
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1749143591;RkLwwLRq3_vm;<greearb@candelatech.com>;cd09869c97ce2e719a3744df88686fd8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 6/5/25 09:57, Lorenzo Bianconi wrote:
>> On 6/5/25 04:14, Lorenzo Bianconi wrote:
>>> Since mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field() can't
>>> run in atomic context, move RCU critical section in
>>> mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field(). This patch
>>> fixes a 'sleep while atomic' issue in mt7996_mac_sta_rc_work().
>>>
>>> Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>
>> Thanks for the quick fix on this, it appears to solve the problems we
>> saw related to this.
> 
> ack, thx. Can you please add your 'tested-by' tag in this case?

Tested-by: Ben Greear <greearb@candelatech.com>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



