Return-Path: <linux-wireless+bounces-3288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E350B84CB94
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 14:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679AFB258C3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 13:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E47E76C93;
	Wed,  7 Feb 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvd80gqt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440BB2420B;
	Wed,  7 Feb 2024 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312705; cv=none; b=Yi+9jCUQR6b+x6CdnvOQUV1cLbj7+0LcjH+W7p+cnks58mcVI+/CqJev2si/vg/lvYg+4jSS4TwLSCWepYLlhuIJIaeFH7ossmuqW6GWGMiasb1Vdi0r+nTajS9im7givQ2g/S0LzKvikIOsrMEXRtnRrZisyeCIrftI56d/5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312705; c=relaxed/simple;
	bh=yVT8Ti21+Ydu/gLRV+nkvBy86ZVYjXvrfoQlsX0IikM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iD6RrUwoiKP1nnkIyizdKlChzAs+LcFGhAnQxlY3C56HXbhZ3TzN0dNQFg2DsKCJ+NG6V+1JVK0hwefvRE9DYiaa+I9jfR0ZjsTVL3V98bQbK2fsSRcgEKb6sZXjtibLIMfM68vccgCXxjXTrumSqfefiTSJD/1/7vKhNzR5MdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvd80gqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59609C433F1;
	Wed,  7 Feb 2024 13:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707312704;
	bh=yVT8Ti21+Ydu/gLRV+nkvBy86ZVYjXvrfoQlsX0IikM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bvd80gqtnAh9QaQeLtwQi0Gum8Txp2Nm7vBIYqfhptcXJSzpjF39+JWSq3TntZzWl
	 iIGntqDvme3lVamm5KOROKRNUDdFJJC8iz1/+AlslfMQEWWfw2GWzWqF4j8BERymAD
	 Y2kePZ3YIhx14mSA2PKw5Bk1eW/HuqP3DY2pYNOVSPxW92J0UyjhTrs7jHBYLxarhN
	 SCvR/HMfj8KhJli2M4BDXs4R4KK45qUn+QVAvbo7tfSZ8klwA31cI9LzwvcBa17617
	 IHYoNwEI6Ter56yajddED+zMlEuVFg5l08NN8W00WQXaFlOc/TYc6JnH8aX8GRrLGw
	 4AOWvcIUW+MlA==
From: Kalle Valo <kvalo@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>,  Shayne Chen
 <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>,  Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
  linux-wireless@vger.kernel.org,  linux-mediatek@lists.infradead.org,
  kernel-janitors@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][next] mt76: Remove redundant assignment to variable tidno
References: <20240207131113.2450297-1-colin.i.king@gmail.com>
Date: Wed, 07 Feb 2024 15:31:40 +0200
In-Reply-To: <20240207131113.2450297-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Wed, 7 Feb 2024 13:11:13 +0000")
Message-ID: <87il30h03n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Ian King <colin.i.king@gmail.com> writes:

> The variable tidno is being assigned a value that is not being read
> and is being re-assigned a new value a few statements later.
> The assignment is redundant and can be removed.
>
> Cleans up clang scan warning:
> drivers/net/wireless/mediatek/mt76/agg-rx.c:125:5: warning: Value stored
> to 'tidno' during its initialization is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

"wifi:" missing from title.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

