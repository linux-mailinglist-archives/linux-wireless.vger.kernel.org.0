Return-Path: <linux-wireless+bounces-27696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91427BA8E93
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 12:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BCC188DC41
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Sep 2025 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7829BD83;
	Mon, 29 Sep 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bJ/G51Cv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5B1A9FBD
	for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142610; cv=none; b=nNfwb3siPNtuPoML5IfC4Iwylv7vMnBoEM0A5qgzApXuNUVxK2gowPx+titZv5Z4up8ra5PTrWlhznuwKBWAn1OJNOeOkb0hcjhi/eSy83BX/FzxFGOY+UWZEakobrsvNeW4BvfIniJDfVO5PXLUf7e5bUMxMx1X0zxaB6I95yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142610; c=relaxed/simple;
	bh=tReOAykf5vjaZ4hWe3+AO58F3yFrvH759h1eiJJ2MIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcvb1zJUCulFI24QAmdqT6beGZ6ojoqaXpQjlPdUO4O+klTISQNRetIM40FjcJAzqHP8oRpdrFu5BGdqWFxgi1ZPbLI9Tnpp6VRTIZqkbMdTzBVrmLdlPX7nHw76Bh7inCL0ym5CSSrybKXGxaLACm+DxKB5mYuNfkgC6H8Qw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bJ/G51Cv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759142606;
	bh=tReOAykf5vjaZ4hWe3+AO58F3yFrvH759h1eiJJ2MIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bJ/G51CvVwbJl+3LMpYYWgo7h0Z8q5DWkVt+lG5Eg9efIxYzvhqWZ+boXRQL33P2B
	 JW7IHn18C7q36Dkcpd2g+znP3oOdC6U9j04tZleA3Mi2XfYPGpW/VjiDSpqdRSE4Y1
	 KXIiPS4v8Q4yYgvhpAZNJetGmfbctZ4cbNAl+cMvVlaa9dVe1A1vT9lPk0yJXeflsd
	 0JxQnNEYdgiAIkPs4/T3pnzN6PlUSldTz0B0yTTMjwp1ilTXxdJAClU0vSzRydnHqV
	 TRNBE8ni6UVRR2sDstKGBDr6UuvSq3DPIxKxI/RD2n3MYq/xEgLfhKojAaRjx8X2JX
	 2WR0wa/OlCRlA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 539D717E12DD;
	Mon, 29 Sep 2025 12:43:26 +0200 (CEST)
Message-ID: <0bef7e84-415d-4324-94d0-a2adb261a18e@collabora.com>
Date: Mon, 29 Sep 2025 12:43:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mt76] wifi: mt76: mt7996: Add missing CHANCTX_STA_CSA
 property
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250928-mt7996_chanctx_sta_csa-v1-1-82e455185990@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250928-mt7996_chanctx_sta_csa-v1-1-82e455185990@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/09/25 18:27, Lorenzo Bianconi ha scritto:
> Enable missing CHANCTX_STA_CSA property required for MLO.
> 
> Fixes: f5160304d57c ("wifi: mt76: mt7996: Enable MLO support for client interfaces")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



