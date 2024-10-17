Return-Path: <linux-wireless+bounces-14158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EEA9A296F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2342B1C27398
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0801DF256;
	Thu, 17 Oct 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkMtgx1r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EBB1DEFFD;
	Thu, 17 Oct 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183592; cv=none; b=Z64/DUYYZbyODPFB4Fp17eVL+lu05Ok85ScB0a1oB4WnhI21ww/PNrr9+kLLytH9ObbxY4u69+Ci6VMfWUbM9ofX0UGW0KDWj/4UwN5jSes0IM4ykVMlefvfMcypoB3f9CkEkeMio8Lte5gm3T6ZPYZIvDiq4M1HDsWVJevUFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183592; c=relaxed/simple;
	bh=TDbdxhVZZzih2nUDJHFIk5gHCWmEpwe2coghER+qgBw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=mZjtn9wwwF0g743PwqmnuMrWkURuIIHdbpjPrbqfqXe/4QDvPt6W9uW30Z9tbOAsAmx2r6uDCOviemZmRxoqcvOYAw3Z01nhX9X0qqFDc/fqxZwKZSzUu72rJYzyk6aMwY1bK3KZ9gvMllUcDN4pMiiCd72kyauGOR4DJDbUKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkMtgx1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A7EC4CEC3;
	Thu, 17 Oct 2024 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183592;
	bh=TDbdxhVZZzih2nUDJHFIk5gHCWmEpwe2coghER+qgBw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IkMtgx1rZ9TGOQX1DFPZBV5Re5zpq3V7eysZaa27xFHrsC84+kMrfCzcD2MCb9D8k
	 c9JggdvMQAOEXD2FU5Q/e4BDvrPaWnt7sIgagl+PJGhSPPqH68s9/zb5qI3D7PYyyy
	 YPeloz/YxU+OgkKUhC2P2EbYZeJaO6S3tGez1dImnebXeOFvivW5S/QKsXo3+ajT8+
	 IZFoK+eScA8tVQ/ARDqLRf1ZtzcrSE5zrCy/TL50/TPX8RL+bFG4HS+KTPoE3gr7nR
	 adb1lDa47M5iK6/jMedgZhVA72PTSm1tw0cDGtS4OKWxar09zONshxbZMcCxXepceE
	 YhYHDJzm4b8+A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] wifi: rt2x00: convert comma to semicolon
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240920025917.1959932-1-yanzhen@vivo.com>
References: <20240920025917.1959932-1-yanzhen@vivo.com>
To: Yan Zhen <yanzhen@vivo.com>
Cc: stf_xl@wp.pl, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
 Yan Zhen <yanzhen@vivo.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918358903.970100.10603837582823876898.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:46:30 +0000 (UTC)

Yan Zhen <yanzhen@vivo.com> wrote:

> To ensure code clarity and prevent potential errors, it's advisable
> to employ the ';' as a statement separator, except when ',' are
> intentionally used for specific purposes.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

c8945c8cd41a wifi: rt2x00: convert comma to semicolon

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240920025917.1959932-1-yanzhen@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


