Return-Path: <linux-wireless+bounces-545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CF380895B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 14:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8D31F21305
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782640BEB;
	Thu,  7 Dec 2023 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgGQ8NZ4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF163DB99
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 13:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C2CC433C8;
	Thu,  7 Dec 2023 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701956381;
	bh=s7jYxlzNX2yYW5vVt8RohmUajx++qo4dRr8Rg4mal/g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GgGQ8NZ4PcR3ka5ZOwKjavJqVLskdjudvyceGDwnmWAU+dd400scPzPGHvhUk+23Y
	 qh9mYm7SeaRJR+h/DKJzqO33mpZqo8hOdUPUmK0go56vz9LeALrMswd3LHj6blYGMt
	 WgfRHhbfFCjQ2QeaJn/ek15m0H7MZamVExqiFA6QbHR4/Y2VUertAbB9ayggAuLZXE
	 gOSUQl21+z8EMyxbHbeJgg6LSUKAvl/TSvHPDkMYjGMdeDyOWrYhkjb3TNEWHzpAbI
	 l35u7hZ8CwBbk19Gb10VMG4G5BBZm+kvBHwqjbaAHQRDJbkwooJNqIwkTFLzELI2k4
	 nwR88E5ncWFCA==
From: Kalle Valo <kvalo@kernel.org>
To: Allen Ye <allen.ye@mediatek.com>
Cc: <linux-wireless@vger.kernel.org>,  Johannes Berg
 <johannes.berg@intel.com>,  Felix Fietkau <nbd@nbd.name>,  Lorenzo
 Bianconi <lorenzo.bianconi@redhat.com>,  Evelyn Tsai
 <evelyn.tsai@mediatek.com>,  "Money . Wang" <money.wang@mediatek.com>,
  <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mac80211: Update bssid indicator with real BSS
 numbers
References: <20231206024911.7668-1-allen.ye@mediatek.com>
Date: Thu, 07 Dec 2023 15:39:38 +0200
In-Reply-To: <20231206024911.7668-1-allen.ye@mediatek.com> (Allen Ye's message
	of "Wed, 6 Dec 2023 10:49:11 +0800")
Message-ID: <87cyvi5dyd.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Allen Ye <allen.ye@mediatek.com> writes:

> From: "Allen.Ye" <allen.ye@mediatek.com>
>
> The cnt member in mbssid is the count of total number of MBSSID elements
> instead of BSSID. Therefore, we fix this by reading the MaxBSSID Indicator
> field directly.
>
> Signed-off-by: Evelyn.Tsai <evelyn.tsai@mediatek.com>
> Signed-off-by: Money.Wang <money.wang@mediatek.com>
> Signed-off-by: Allen.Ye <allen.ye@mediatek.com>

All the names, both in From and s-o-b, use '.' instead of space in names.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

