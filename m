Return-Path: <linux-wireless+bounces-26271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E63B210DC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 18:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526C1189B8B0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF02E11DE;
	Mon, 11 Aug 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvPXbUCv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908C2E11D1;
	Mon, 11 Aug 2025 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927057; cv=none; b=YuHEjzuKidtrBZS/79KmIyiewYjdtgpeR1ayaV9PI9Rte6aSwTeSA+2igxNZ5m82FA3J86ms2uplJhPR34D1pkDn0h+FZQaPYjLpMyRngQ8wwC04JNY1azxc0iO/RXQvcFBDF67Akh3bbFz+Jfi96c8N6foL3Ai8sZTQqUSCTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927057; c=relaxed/simple;
	bh=+ZafSPu4xL/UKuGsxxL1GvEE5JWzMOCzAIFJcdOdwHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYLLzkDyxpGPd847aP6csefjASaNcv4AVampc6hl0qDJL5mi7onXnaxenpcZLFt4wh9vV1WO1qHYZefhknDQUfgNb6NdwMS59NLVTsSHYx/nrQWUQ+ktIuP4MIVMCdPKAsZLWJpjqjs6unRhpdpezNYOdhjHKrSzJyIxK0EmgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvPXbUCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C125C4CEF5;
	Mon, 11 Aug 2025 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927056;
	bh=+ZafSPu4xL/UKuGsxxL1GvEE5JWzMOCzAIFJcdOdwHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BvPXbUCvlj4Xf1D2IQHKisy0OQo/KCIar+Kv2NnTG6mY0H1m2Q4IgauioHX0RANm6
	 8Ut7Aw8NHszmC35ncb4nXrUsb+HXgH+08tRf70qiZkgdPt8bNHKf3f43yOpDKvoD3f
	 uKHKXqvYUuU0Tcl/4ZKCGNN/uqfNV0ovMXCohp1OFFXUNeavi+XFJFG9uA1ZiA1T6V
	 EN1N1WLu+LYh7oY9v7UUq0FN39vMXqY/UtxAKy+S32ugM+Ydq69MjykOM8OhoUBWH4
	 hwnyOwzH0yjBhqiSpEuYfqVK1nzk1xdFDR3tSSPQfz/ba17Zrc1sn4UYskE8FQMTlQ
	 Pmu+T9vsu0sYA==
Date: Mon, 11 Aug 2025 08:44:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, Rex Lu
 <rex.lu@mediatek.com>
Subject: Re: [PATCH net-next v2] net: mediatek: wed: Introduce MT7992 WED
 support to MT7988 SoC
Message-ID: <20250811084414.6089720d@kernel.org>
In-Reply-To: <aJoK7e4aEKR96V4h@lore-rh-laptop>
References: <20250811-mt7992-wed-support-v2-1-e43024c05305@kernel.org>
	<aJoK7e4aEKR96V4h@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:23:25 +0200 Lorenzo Bianconi wrote:
> > Introduce the second WDMA RX ring in WED driver for MT7988 SoC since the
> > Mediatek MT7992 WiFi chipset supports two separated WDMA rings.
> > Add missing MT7988 configurations to properly support WED for MT7992 in
> > MT76 driver.  
> 
> I sent this email twice wrongly. Please ignore this one.

patchwork decided to ignore the other one.
Are they identical?

