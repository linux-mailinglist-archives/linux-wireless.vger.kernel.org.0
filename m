Return-Path: <linux-wireless+bounces-3882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC8B85E6CC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC0428A865
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD75A8565F;
	Wed, 21 Feb 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2tFQzsi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAE85642
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541794; cv=none; b=OqyONe2YgRFufVTIFAfXrBeeOXIxiPtw82ILaiLw1wIiBKr3QzLV00PeasH8xiVjBtAUv08gzka9BM8FgTIxLHQ1b/hUfFwrzwdgnttgiZcv/bieta+W9Bb+N1t1kwnWCLVCD3MUbEyRlL69inWAXysHrf78xdXoNVYV+shKTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541794; c=relaxed/simple;
	bh=LRbL/GJWJHekSNZBbFRgblA4t+YACUE0jeTVAfn169w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=FHuJM1ULFQ7w2+mRGceha0UR0h4srEPuNrcAK5/stX0Dgr7maOp7uYU011hMSj63wK1FZkpSK19atkbgqChBb5NvY5eiBUqcwv3GQVZ/cSijN2ngjd98qnoT1hXAubEkIrPS8KzJHbX43l0V+dqiY+mCOn/C5iRUUGoeRTd7vhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2tFQzsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94860C433F1;
	Wed, 21 Feb 2024 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541794;
	bh=LRbL/GJWJHekSNZBbFRgblA4t+YACUE0jeTVAfn169w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c2tFQzsiP5nAF0l2h8oi/BR80W6t93NeWrtwgK9SWhPOvRC7pGsgwXMQniWv7dbvd
	 OdWrVZg8z+RsS7Fr8QqN6KFw0yBRptWuQN3sHb4Ev+aC9AY6Zko8CNtbtg+T1TM1VA
	 nR4zZVsXzBGXlXvywAi1H0zR4NSMHDuhUZffz/PsvCTTehWzZ+TIvXHIEyc4oXSaDn
	 MyYov80zSDWhZUl54gpFgmAMd34wwfx4UnJ/2U6MKwo48sULytKcGOe8bQAD0wr77C
	 syWc7xyM4m+QlRZw+oELXQBxHjsm03KhF0pxBPl05kq9WYEmtr4ZxjvFhDJXdDzjf9
	 6CLOMTxDnCFyQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5
 Pro
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240216213649.251718-1-hdegoede@redhat.com>
References: <20240216213649.251718-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854179043.1918455.5901929299708483573.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:56:32 +0000 (UTC)

Hans de Goede <hdegoede@redhat.com> wrote:

> The ACEPC W5 Pro HDMI stick contains quite generic names in the sys_vendor
> and product_name DMI strings, without this patch brcmfmac will try to load:
> "brcmfmac43455-sdio.$(DEFAULT_STRING)-$(DEFAULT_STRING).txt" as nvram file
> which is both too generic and messy with the $ symbols in the name.
> 
> The ACEPC W5 Pro uses the same Ampak AP6255 module as the ACEPC T8
> and the nvram for the T8 is already in linux-firmware, so point the new
> DMI nvram filename quirk to the T8 nvram file.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

32167707aa5e wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240216213649.251718-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


