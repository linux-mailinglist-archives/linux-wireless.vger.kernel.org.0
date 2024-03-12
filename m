Return-Path: <linux-wireless+bounces-4624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8F87978F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E99B286952
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF7E7CF1C;
	Tue, 12 Mar 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOqWUo2y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274937CF1B
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257453; cv=none; b=jRMW/XFDEyRX0R7BooWkQour8qVXw2TtyQ5semTpuiMoXqY+KVJ4dWn9rM7aCtZIQQRYLEhjvlmeh0Q4oP5qwTqh8MJ5hWgtaWOW1hptGwaw7q+cFrxsCQLTqP9rLhkCafTdTv1ST5gKUAhsIq4YoCtW23SPv+piAnZxhSOdJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257453; c=relaxed/simple;
	bh=nRSC2gkXHJOCemrZbjTt5TRJeq4n/KlLM43RJcua2V4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=iG0DeIJh6SdQxNKB6P+e7KeCYdBOPXWLDzfHqMwuFpqA132elwjOgTsfXdl39Cr0EXEhfxnJvpJYe1bfoYmv3hAvxG+/sSiFqUdByFs8iddvZSQJ8iA0aa00BniXtjbE7Q7zs1bnGNA/lT/zX08HVad+25wUnEIswDb3Z4WXD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOqWUo2y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470D1C433F1;
	Tue, 12 Mar 2024 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257453;
	bh=nRSC2gkXHJOCemrZbjTt5TRJeq4n/KlLM43RJcua2V4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hOqWUo2y0f1gDfIqxZMRDg2ASKWNu5hCfXYvkxQh+R7YD4ZbcbuETzob2cTriTzJh
	 nOyKXHjz3uDteG8YEamVNzWeRwaBjlqtlsmgkJlDsjVacZA9pcrY1vud5sDXmCEE/+
	 IVtnbxR1/ca1E2hNrIi0YaHuf3kjY7MBf1gTYCVMLNVhnGXoMc+75+zYDSNwBFQ0d2
	 pEYs8ljB8xywpQNypAUPi9XMKNd+mXca7U6IgQTCt34MBNzPwSMutE7dmVytzud9Y4
	 kHLIxvJ5j803dNciE0H6Byq5A977yW3UGs2wau4rVmNAh0gj75tb1YwskQ5ELLMR5u
	 61iNFWNUNsE5A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: Correct EHT TX rate on 20MHz connection
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240305004502.6655-1-pkshih@realtek.com>
References: <20240305004502.6655-1-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <dian_syuan0116@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025745011.1969294.610440397124136261.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:30:52 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Dian-Syuan Yang <dian_syuan0116@realtek.com>
> 
> We used EHT capability of 20MHz-only as rate mask to RA (rate adaptive)
> H2C command when connecting with AP set EHT 20MHz. It would get the
> wrong rate mask and the MCS rate can only reach MCS11.
> 
> According to the description of 802.11be spec, if all supported channel
> bandwidth field of HE PHY capabilities are zero, then the EHT capability
> of 20MHz-only is valid. As a result, we adjust the code to set correct
> rate mask based on HE PHY bandwidth capability.
> 
> Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

f1dfcee2eae9 wifi: rtw89: Correct EHT TX rate on 20MHz connection

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240305004502.6655-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


