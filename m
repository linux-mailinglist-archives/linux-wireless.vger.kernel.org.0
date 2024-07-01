Return-Path: <linux-wireless+bounces-9756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B691991DB4C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575E41F20EFB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7325622;
	Mon,  1 Jul 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJYlOuei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BB5C614
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825513; cv=none; b=I8YFGDritJYTsCCO/6SsE9qngbwlVHt+RyiZhO6B94+epv43B/4MdnbQFPgUx0QEXr5leje3C2NLTotcAy1sjRcbiP82BFrtK3xSzeGwkVmYO7bTdIqv2ksnp9/ZhtmVQ5au9n3v4iCZs8quHv5IRUhppTVqej9BfwVl0kQA0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825513; c=relaxed/simple;
	bh=eLrNP786r1nyDwVMD5zW1RtilLFeZn9DWE2Ef08E84s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SMzsiKykX5qO8/xk9m6nlPCimQ2gNUt4oiyVflWQo9e7Xkr+M0OmHloleYJxd41cGXexcr8FpbD0r/ytzF7zJ8N9a8GgNE79/3PUg8f44WZgQe5gqu2nsdC7GVFHzN3oUrzGD2DAhUVxRdWSDAFIYCHRPOeB+NNVTwy0dsO9Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJYlOuei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC1DC116B1;
	Mon,  1 Jul 2024 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719825512;
	bh=eLrNP786r1nyDwVMD5zW1RtilLFeZn9DWE2Ef08E84s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kJYlOueiqzJxdsJRrpGesaqV0SmP54o8oa567VMflPAeaxyBVphaLDA+q9N6k4Tum
	 NIktYhFjNY4jLjwx6YppoyPJG9hJ9ofRTRYY2wX/Gu8G5xicIqDBT8MU7HelWIKuSn
	 oZmUUbtkcn/v+Etf5YDK959LkmLWEdN9xHvAOfiEEmgWRo/lhboVeo5PygADVORiPj
	 nzCAoaUKRmUY3/ULTTSD1t75utnKeh04GmasOCUxXEyCxoCg5D8DnpRmdadv0HVIrf
	 vw4YVk0bR0IiPKszW3CCjAliyRXOL9/prF78c+S++h7F6p/9ifGfcdTWF9wkOvAPCJ
	 9PTm5RuHezsTg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 00E9B5FA01;
	Mon,  1 Jul 2024 17:18:28 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240624025623.6021-1-pkshih@realtek.com>
References: <20240624025623.6021-1-pkshih@realtek.com>
Subject: Re: (subset) [PATCH v2 1/4] wireless-regdb: Update regulatory info
 for Liechtenstein (LI) on 6GHz
Message-Id: <171982550898.1221830.493885225232689365.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 17:18:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 24 Jun 2024 10:56:20 +0800, Ping-Ke Shih wrote:
> CEPT ECC/DEC/(20)01 of 20 November 2020 on the harmonised use of the
> frequency band 5945-6425 MHz for Wireless Access Systems including Radio
> Local Area Networks (WAS/RLAN), which [1] defines
> 
>  - LOW POWER INDOOR (LPI) DEVICES
>    * Restricted to indoor use only
>    * Maximum mean e.i.r.p. 23 dBm
>    * Maximum mean e.i.r.p. density 10 dBm/MHz
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/4] wireless-regdb: Update regulatory info for Liechtenstein (LI) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/f8ef7da3d44c

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


