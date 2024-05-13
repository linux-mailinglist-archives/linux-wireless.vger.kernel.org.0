Return-Path: <linux-wireless+bounces-7591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157C08C41C9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BD8B241A7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC2C15216F;
	Mon, 13 May 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LMMcKOQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D91514E5
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606606; cv=none; b=IeTcRGLIQFXrOFgCTnBuyYRf0sQ/5quX4rmuSBZ64d3Y3haJZz/4L3lX7pXFNgr51TJan+i4HKeiJqboXU/mHCeowf47Mq+VimV/Nbi20l8dcYJQZ4E2YAswX5/eIOd8vrOOwIO3Eq2bJthngdEf4Qfov690mUQOWL9rAxYkf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606606; c=relaxed/simple;
	bh=t1H7HAV/m+hR/GfN+DOdTuWAsHyeaN+y7Y2Agzg+V3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrTFGBlOuciGeTDlvovjD78hTqrNLZgGJAZRIofnbArwoQklL60K+C4qC804/h2o27whWBZHeSCZJ3aMblEJHnkuuCoo72PWDzZQA3CX6UJcn5xduBx8h3NGz7tju92hL97Wd5bZ2edEer/zwjqY1Etu3FatxiLlfYx/nQTBpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LMMcKOQ3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715606603;
	bh=t1H7HAV/m+hR/GfN+DOdTuWAsHyeaN+y7Y2Agzg+V3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LMMcKOQ3nlPAVjMUrM1mld35tSehSr7BGfqtvdlQKDFpi6n4rxqWcS9xLZmVOUvJ1
	 I7O+uXDfjLyDUrSjcsKOrPp8SbJX3S4IWdSDkOr433V0PWMwORrZizwJw5KVGv+GFI
	 y7u2GhIZt09nZaPkZD3USVNuE9/oohZqsnrnck46YWQRSraK0uOTdqk+g7xPkY6xG6
	 WJmVw5657EyAnvdSXi0RrO12zwDbj4sEhrWSRgr1CSBpZLz3dine/oL0O7XEpuM5Uv
	 Zqxbou4d8phP41CaVoENSNBhfRRzqt2gXCDcczfPNXSYxgMNzxChJb7P4Mr/ILMcdj
	 7d8D9spaLz8kA==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2CE553782017;
	Mon, 13 May 2024 13:23:23 +0000 (UTC)
Message-ID: <dd997ba8-3d66-422a-b5df-ff2c0e6b96d1@collabora.com>
Date: Mon, 13 May 2024 15:23:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: mt76: mt7615: fix null pointer dereference bug
To: Sicong Huang <congei42@163.com>, nbd@nbd.name, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
 matthias.bgg@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240513122329.170380-1-congei42@163.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240513122329.170380-1-congei42@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/05/24 14:23, Sicong Huang ha scritto:
> Function mt7615_coredump_work will call vzalloc to allocate a large amount
> of memory space, the size of which is 1300KB. There should be a null
> pointer check after vzalloc. Otherwise, when the memory allocation fails

Otherwise, if the memory allocation fails ...

> and returns NULL, the function will cause a Kernel crash.
>  > Signed-off-by: Sicong Huang <congei42@163.com>

Please add the relevant Fixes tag and resend.

Cheers,
Angelo


