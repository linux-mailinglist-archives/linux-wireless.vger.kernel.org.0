Return-Path: <linux-wireless+bounces-24483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C35AE8502
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 15:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924043B3F9A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772962627E9;
	Wed, 25 Jun 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xpckavda"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4425BEF6;
	Wed, 25 Jun 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858967; cv=none; b=c+xgs1sGnd72jXfEAyr7OnSTKnJ78jMfxKtjq4Yl3b9h16XjdeAOrqJboLyOu7MTQ09xSvi3esQWIxbtpjONEe19YN7cRhNLvS6vYJ5T0lOSwFKTY9mXGJ284aZkTYl8HhKIkipFr4hXRniHOvuVQgGcNM6nH8XMT/GcPiImFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858967; c=relaxed/simple;
	bh=9Qc6KYO7RtqwQsPT7/J6J3b4FamcfNGBV+14cCp2izs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/nGtn0K4QKFsn1++YxxeS9+EfyelpnHTFlmDD1swC572SkS9Rc5HuC6lR/m9g5zEy2o/9Pcb5CE16G9HnJBdumJBJZyVoI9oTPIQ/gSZPQrtDUQXoLglGdTYzDNd6Y5L9vPNfNM/5eEzPZ3hcFmPDKrWubD+YTuUe6H7VdEU44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xpckavda; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750858962;
	bh=9Qc6KYO7RtqwQsPT7/J6J3b4FamcfNGBV+14cCp2izs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XpckavdawoX1DCh43/Am0LH/gsqEKUZj73AImthw2dp6FK0lU4hvB9PXTBn5usVvQ
	 YdodQs+fr4Vjhjj6SvrvcKUOr5aJWu7qpugh6iLTl93WQD1xvnNhUV+DecA6QlDIde
	 hezEBgKbPxlLgSLzOOI5rZLz75+ZzqFD45culiYggww+8HBLhZqFK5l/PB0CdXcj6N
	 ePPtPmEHR66MW5jxy+hWm7O+ITy4JCHGoXJeAeK2ZdFtiCIMu6AST8NJJRPKSFRw1Y
	 CQyopfFIwQe4Gsn1Ywf4WQs6tgIs9YGG8mJZhykiKn4YNzP8p+2vp5G2kTXLDKJkxT
	 LGomKnW8T0tRA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D7C017E0CE3;
	Wed, 25 Jun 2025 15:42:41 +0200 (CEST)
Message-ID: <4fc2d5d5-61a5-49f1-b381-4ada37cf3c20@collabora.com>
Date: Wed, 25 Jun 2025 15:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: mt76: mt7925: Fix null-ptr-deref in
 mt7925_thermal_init()
To: Henry Martin <bsdhenrymartin@gmail.com>, huntazhang@tencent.com,
 jitxie@tencent.com, landonsun@tencent.com, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 matthias.bgg@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Henry Martin <bsdhenryma@tencent.com>
References: <20250625124901.1839832-1-bsdhenryma@tencent.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250625124901.1839832-1-bsdhenryma@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/25 14:49, Henry Martin ha scritto:
> devm_kasprintf() returns NULL on error. Currently, mt7925_thermal_init()
> does not check for this case, which results in a NULL pointer
> dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.
> 
> Fixes: 396e41a74a88 ("wifi: mt76: mt7925: support temperature sensor")
> Signed-off-by: Henry Martin <bsdhenryma@tencent.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



