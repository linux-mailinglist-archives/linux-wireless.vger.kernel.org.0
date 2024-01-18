Return-Path: <linux-wireless+bounces-2181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AF9831A06
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 14:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506B61F213CE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53572250E4;
	Thu, 18 Jan 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx3oeMIK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304B1250E1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583252; cv=none; b=kjiqVrcOlBTg5jltzCdJpsp4YWet3xZEIslCpTjEFWEm6lvZVs4qGuq6bcYxbRcQm0CqfywSdLcAfAjJqj0npi0M8GxFQSZcFzWrYZ3U24aSwg31wAcwnWtFLTjjpuua4+zs28NOZ0DRLUy11oN5faKYQwteH2P32Vm5DKf/upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583252; c=relaxed/simple;
	bh=8n1qMvdhePDwaY9HjjikmpcVO8WTz22ori7cLmW0szM=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=nO9MQ7iMneDHIEupGpQvj5Fdirc2lZ+nZP7pK/PgReaKJgmzlF58+v9wsudGaR8A6eExe3QWqqbU1hjjxI6R0hqMsPnk/K3K7fRVemKveISOLxbQslbLstN68J1lcMX/KkGuaRHtPQVzfgqCNUruzgwsdPGjVi+HxRiWIQlQq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx3oeMIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6796FC43390;
	Thu, 18 Jan 2024 13:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705583251;
	bh=8n1qMvdhePDwaY9HjjikmpcVO8WTz22ori7cLmW0szM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Qx3oeMIKWf64rY4yRHx/YrL0Tx/Bt4xCftwBpmHlXnDKT2BAP7URbKa/g7EYuirJ2
	 VI1iWS3HbQWBkVbEo+s+0C1/jgFI3ziCcbtQa7tco17wLW9aaXRW3MhDAzlI4OObji
	 AKgY9AQ+1c4i1zhiUIBNCHZUI4ga426ArfY/QWyeWNC6g/FygC7PTK2wsYr1bRW/bt
	 xDmwUmiC1NVLUl6fvl6u0yuKr/1y3fZFsooAcViT1O6r4xSL+t0iBtKwisXHe3jgVb
	 v8/qjDOD5jAd7Ck1vXaxrQTpHY0MWmYxPgsmLijd7TJ9wWV1mXoZKBGq3TZsW9kHVj
	 rWT7K1pVqExSA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: simplify rt2x00crypto_rx_insert_iv()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019070750.17911-1-dmantipov@yandex.ru>
References: <20231019070750.17911-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
 Helmut Schaa <helmut.schaa@googlemail.com>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170558324865.2924528.4635614423834135682.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 13:07:30 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'rt2x00crypto_rx_insert_iv()', added alignment can't exceed 3
> bytes and ICV size is either 4 or 8 bytes, so skb space adjustment
> may be simplified. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Patch applied to wireless-next.git, thanks.

173b0fb47c3d wifi: rt2x00: simplify rt2x00crypto_rx_insert_iv()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019070750.17911-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


