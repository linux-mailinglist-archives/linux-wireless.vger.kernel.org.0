Return-Path: <linux-wireless+bounces-27970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A1BD9AFA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 369954F831B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Oct 2025 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC83314B8C;
	Tue, 14 Oct 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FDLpWcw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA966314B6E;
	Tue, 14 Oct 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448108; cv=none; b=pPNXt+CTWlYs+dreLYr0UDjp16SNB9OUfl2RU2WorprIFW0/Ms10q/OFfAhzyaIXsK7ZY6YXgyJItYVLmqJcvaeBpSUi0p5O6+wIOOHRwoZF1y4TFoU3j0XVkhcu1ajUoHJN+u3rC+i2MOUVIQsXDnWJGn2C8JOYXk2KhCXjBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448108; c=relaxed/simple;
	bh=zCgNIkIe81eviywn2khOOfKzvpgqFCye5+tn1JB2k8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSoQ2wUG+oPNGqUKIMJP+LasvXYzTn7qzQyapGppL2NA513c+NN/Vca57TNjUGmIzNQTFQ/C3IIjRYEX7GV/G90Wl5oUwqq1jK0A3C0jVSxcrcVCbqko4qiVDhTfxWL4NJ8NiLrfCSrT/CilJ/I6prRa2XU+lJoqXRu9WfbEbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FDLpWcw0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760448105;
	bh=zCgNIkIe81eviywn2khOOfKzvpgqFCye5+tn1JB2k8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FDLpWcw0QdVM7FZLv7GALWkFRQzRz88Rz/7SCz38RKgob7fEVhvcWSuo/lCAJJJg9
	 uCYNCecDlFyuYrFMeQDRbTtSOCUXJ0r9p2wd1jIXqUbKVKm9FC58046YYpOmE6LS4s
	 3FBi3WNJATGPXHWd+rp5QNHTBptH6vNr+XsvbonXtkyjYnso06FwSg6lN2/zzUMHkx
	 F5pqMIX/ZLulBNiVmXsyj8uhEVaHhc1rIhBz6BhjDAYX98SiQwvGwC3cm5RU1spxGG
	 yWk5JP5TnJkvcwcYRWjtovbL+zgHKB1Q5mO7VlMAiibduOMXzioEtvLn6EQGJa/SnX
	 ustCBjyvJeQRQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFBFF17E003B;
	Tue, 14 Oct 2025 15:21:44 +0200 (CEST)
Message-ID: <4e0d5f72-c35c-4c04-b0a0-dfcd5cb9ca59@collabora.com>
Date: Tue, 14 Oct 2025 15:21:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: mt76: Use of_reserved_mem_region_to_resource()
 for "memory-region"
To: "Rob Herring (Arm)" <robh@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250813214917.897113-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250813214917.897113-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/08/25 23:49, Rob Herring (Arm) ha scritto:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



