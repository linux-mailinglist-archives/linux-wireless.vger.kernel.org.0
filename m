Return-Path: <linux-wireless+bounces-12783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F77974C91
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF22B25D36
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEF137772;
	Wed, 11 Sep 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PbJ8JW+6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CbsBsdmB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a7-43.smtp-out.eu-west-1.amazonses.com (a7-43.smtp-out.eu-west-1.amazonses.com [54.240.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB4AD24;
	Wed, 11 Sep 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043129; cv=none; b=vAthSTg/9d6e8Ju8KMVofZSTIJiAEpLE9nkdG5abMRxGfmCO2a87G1ELpHi5ImiQ/U0bharkmjqIL4lWip/H0+jA8G94NuNW9dKN7O9HYAKLucCuIHNiINBtCwBBqNGapFaOmsuh1czi3qcL10VEwTvUzceRADI8A/UspmyBsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043129; c=relaxed/simple;
	bh=s63kZ6TAqCQ+zyauVVJwA7gnFvBuDWuKf1o6iwJAeGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXoT0PLRjBQ1IuVIEmEC+ku2JiMm7enDEyQrdCpe2KuV2ZOphJDy8QWirHi3w+CF02gEZdCKdRPYu2QChhqZ1ac2P+7whNSzuAWZ7UtMCbHQyTIUyvrKOerD0ZJeD7d18Whnf1jn4uIAc7q7fKsvYqMM4/X+gAkPW/qFMLrT4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PbJ8JW+6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=CbsBsdmB; arc=none smtp.client-ip=54.240.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726043126;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s63kZ6TAqCQ+zyauVVJwA7gnFvBuDWuKf1o6iwJAeGI=;
	b=PbJ8JW+67bU2vYYrsNXZQ2wWdgwSIZrAmELpA+gz+IHito2uHaQivkbxr1a/O8ja
	2LdaI4W+n7jy7eA/CpJ6vq8GpicqyEvyZXMMBK2OQPV3lAN5qMVL8DBQeIopLpzxTQX
	VLcBNazMBGJF4+Bdahm6q+mjs1NNS6nnZzAR1DI89T4q2OAYsysWroUqS9pD/2uspU9
	NDnp3U+hdA9g+P2ay/AYoA+0wk9zkzF97Ma4jahEv+qjC1d6CqprZ9rDRJYOd7fXp7I
	2fPUCzvQPfmJJENhQJs4x9aQETp6fy4x+l+6x8Tx7ofvyQ9NfLW0GMEsTjI6huxGy5X
	NfBkYt1pKQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726043126;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=s63kZ6TAqCQ+zyauVVJwA7gnFvBuDWuKf1o6iwJAeGI=;
	b=CbsBsdmBTTYE6i5ElDN3ywZR35E5JhFiSS6ucFzLV+VV7O11vva6ktAExi+tIGd1
	UUrKRZzRgz8b1+fi368dvp1pIqu6opaTCXPrUW+xwTHg+2v9MOXx9N/breJIdTFB00e
	xT8orsj53uBVVhBnur3pCaD2R+N550ImUu+3WGS4=
Message-ID: <01020191e02ffa5a-26aca14f-dede-4675-a177-92a1e3b5a27a-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 08:25:26 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: mt76: mt7615: Convert comma to semicolon
To: Shen Lichuan <shenlichuan@vivo.com>, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, kvalo@kernel.org, matthias.bgg@gmail.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, opensource.kernel@vivo.com
References: <20240911034243.31596-1-shenlichuan@vivo.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911034243.31596-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.43

Il 11/09/24 05:42, Shen Lichuan ha scritto:
> To ensure code clarity and prevent potential errors, it's advisable
> to employ the ';' as a statement separator, except when ',' are
> intentionally used for specific purposes.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



