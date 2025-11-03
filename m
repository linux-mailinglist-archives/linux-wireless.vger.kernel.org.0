Return-Path: <linux-wireless+bounces-28508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681EC2CABC
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64474189B02B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDD326B742;
	Mon,  3 Nov 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MNht16rO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B325D1E9;
	Mon,  3 Nov 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182285; cv=none; b=marMEqaT7vDZfhiIUZLo1HVztGS5fFhRk3YBjoZQHgc1JqkoRZOweQMKq2+eSgyHWsxKYy3NJciJ5imSE/04ti1FDkHNjTEDkm2omOpsewDUdBqM0kBphPwNi27BMUCNB+1hNlezY+iMmpa5HzQKpBXCCqOjSHGZ0ofPL+N7Zj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182285; c=relaxed/simple;
	bh=fVtluIbeBjbr7fW4cjAQSGDP0SUNMAZ8QABeO5dcYv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICJTQnDFMMh4B+xgtViFV2vzQ0bI3ktYtO+rLDeiL1xlSFAZt/byY105lqLGwBKtZk98AEFr+SLwNlhgMufMsC+r/11qgDbuClFRb1XB16HfwzIayAkvYVl+z+Bo1c0ZicVoMc5XhmVhYAtbW1SeJpEeI50+qkbpdpko8LQD9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MNht16rO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762182281;
	bh=fVtluIbeBjbr7fW4cjAQSGDP0SUNMAZ8QABeO5dcYv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNht16rOJm0uEPV6QW8pJpQMbBjHB4vW1kmoKPUt+fZX3HWoDqTprbcqpG8ofuzyS
	 UjixtQ0+yii8ysd/iDJKXpQ8tbWnCb55DqV84SryBpWwaBTH2ErWx4d+JTSpVht1Sj
	 V2yzmqkrq50eoYiDV+1JDDHEb0KGZPaY2uknjtNr22WmUS+8prZy30qa0eusPqw7Qs
	 PRFAZnuuYy03LHYSkiwB7YZpGjRmQfMi3eN4ZM8Y21Q9fsOku89rMe9oaIWR3mIbOD
	 3Yxq80814QNRzW2VC7SvSZddTmeUsafKs+0WVzxs8y6kVDJtGH+NSiiNuKJ9PHZvS5
	 gIfyT5OjkpG6g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34AC817E00A6;
	Mon,  3 Nov 2025 16:04:41 +0100 (CET)
Message-ID: <0826821a-45f1-4793-94bb-575f08eac83f@collabora.com>
Date: Mon, 3 Nov 2025 16:04:40 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: mt76: Use of_reserved_mem_region_to_resource()
 for "memory-region"
To: "Rob Herring (Arm)" <robh@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20251031175113.1453100-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251031175113.1453100-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/10/25 18:51, Rob Herring (Arm) ha scritto:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



