Return-Path: <linux-wireless+bounces-23775-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C6ACF505
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 19:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2673AD875
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544941E7648;
	Thu,  5 Jun 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="k5QS/hwp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923E2750E3
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143345; cv=none; b=kQScPSzA9L0ohlu4C1Cy/IZY6/goHc56q8vebLVsxgKcD8vQ5z5skKQpElkc/eQ8HzZ8IvSrupE5IuJcFDnIKutaIafRfxc8JxiBIJwgHMOBbl1CQpqkxWTuvwq6NbWuNkFwtRknOyqvWQWKlFj88U+OsqYLV4m48VgR2dUgRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143345; c=relaxed/simple;
	bh=KKU7JGwV630uYHk6oyMArrGMBq6T30H84Y9tnAFAvKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fd8on2oendnnlubu2AOyd4OWUmVN8VskvIrcT7cVJzPYbQZ/A/737Vqcgt5HpImTY2ckogTRVg3WDCoom4pm7D9Mf2ZDtX2iGJoj3QJUlH8vE31xp0Ih5L/Wrop/vo7N6pwE/Wv4DdMW5zccfEi5g2e/zMInpadAbMjhfWrCW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=k5QS/hwp; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A6083506735
	for <linux-wireless@vger.kernel.org>; Thu,  5 Jun 2025 16:51:04 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.110.48.11])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 21E4060131;
	Thu,  5 Jun 2025 16:50:58 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EAF509C00B0;
	Thu,  5 Jun 2025 16:50:55 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3F18C13C2B0;
	Thu,  5 Jun 2025 09:50:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3F18C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1749142255;
	bh=KKU7JGwV630uYHk6oyMArrGMBq6T30H84Y9tnAFAvKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k5QS/hwpRfikGil4LjTvurxBGdjCrV4JEMC9nrpUGxiuATFcHAqyMRzxoSfAsowpY
	 Q2ltuMgyEKXz3BJ7Y9ukhK+r8oxb1HfTMG9vl/Tr1NmAfFxxAEDMrGFA66ZYkLcFGs
	 Zj217yiVs0I+uJE8ObcgjquzKcZ2YQT81tDH9Or8=
Message-ID: <909d2ca8-8409-997a-768f-8e9be4c5168e@candelatech.com>
Date: Thu, 5 Jun 2025 09:50:54 -0700
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
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bo Jiao <Bo.Jiao@mediatek.com>, Peter Chiu <chui-hao.chiu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250605-mt7996-sleep-while-atomic-v1-0-d46d15f9203c@kernel.org>
 <20250605-mt7996-sleep-while-atomic-v1-5-d46d15f9203c@kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250605-mt7996-sleep-while-atomic-v1-5-d46d15f9203c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1749142257-XPExwF6mYgA3
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1749142257;XPExwF6mYgA3;<greearb@candelatech.com>;cd09869c97ce2e719a3744df88686fd8
X-PPE-TRUSTED: V=1;DIR=OUT;

On 6/5/25 04:14, Lorenzo Bianconi wrote:
> Since mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field() can't
> run in atomic context, move RCU critical section in
> mt7996_mcu_add_rate_ctrl() and mt7996_mcu_set_fixed_field(). This patch
> fixes a 'sleep while atomic' issue in mt7996_mac_sta_rc_work().
> 
> Fixes: 0762bdd30279 ("wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Thanks for the quick fix on this, it appears to solve the problems we
saw related to this.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



