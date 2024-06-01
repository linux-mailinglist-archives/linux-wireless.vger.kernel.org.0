Return-Path: <linux-wireless+bounces-8373-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D58D6F48
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92DBFB229CB
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Jun 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F480635;
	Sat,  1 Jun 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rttwk3+M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE96F2EB;
	Sat,  1 Jun 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717236601; cv=none; b=nHjsjtzEWbaeXmw9oloMkbqHc+59PRwnCI9YpD4ODjOx6pUJ3Jlm/F0ZiKDyGU4CejrZxHS8HyblEHkAnIkjGRejpOSGFukeJC2tZflVD3GRd6FXhBuTi1GEZvngNaG3kZrLy5k5GUHSYOAeLmM/O5iue6Vfp0/P1j8J1dfrL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717236601; c=relaxed/simple;
	bh=a0/W5by6/xec9h+UXLZSahAaezpbZxiKHRI27sSNl2I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=X5H86TZBezLUsYnqvCu02FqkkhptZ8Xuw6J3roVKTPz3gbeiiyLx7+0qw92akdC/du11Gu2LGVWVG64KaLNcGBNqEuIHkt4kHzzIn7el3L37BAwFE0wvsVhNzqNdaS3Z3De+etSzZr1iL7GtEBCnwVWVT9kJjjjQs5FE1scKe9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rttwk3+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D12C116B1;
	Sat,  1 Jun 2024 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717236600;
	bh=a0/W5by6/xec9h+UXLZSahAaezpbZxiKHRI27sSNl2I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rttwk3+MAfGCnyG7t4kJq/knG9qH7Bcuz6V2DUhVgX7ualv2wWv7MMpUVC8vqLNaw
	 LA+h6jciz8cBCgYHqE/WxNoMog3P1cb6QNOzT622zbSFkmgDoQfi7AMNaKDlnXKlLl
	 yEFpzPa/zkXgnZs2Zc3HZMj6UpDWLuUzbYZ/CkOnk5PK4Jio2XNFPz0Hsa59wd7KVm
	 8SwcSXVRaj+rJfudw1rRHmc3jkBvDhAflpLLQ3DQyJke2FHZMRN66tfYtOtvBYUSXL
	 tccGDF/P1BWPMkc/l584dFvjZa8/kHtd12DITIGSKQ4XoxXN6nwN0S/ysFWrRLrvuy
	 2OeOcNtRNuMSA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcm80211: remove unused structs
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240526234553.286773-1-linux@treblig.org>
References: <20240526234553.286773-1-linux@treblig.org>
To: linux@treblig.org
Cc: arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org, "Dr. David Alan Gilbert" <linux@treblig.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171723659704.1034023.17135703392957281288.kvalo@kernel.org>
Date: Sat,  1 Jun 2024 10:09:58 +0000 (UTC)

linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'brcmf_pcie_core_info' was added in
> commit 9e37f045d5e7 ("brcmfmac: Adding PCIe bus layer support.")
> but never used.
> 
> 'brcms_c_bit_desc' last use was removed in
> commit cdf4352f5c59 ("brcmsmac: Improve tx trace and debug support").
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

5bcd9a0a5995 wifi: brcm80211: remove unused structs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240526234553.286773-1-linux@treblig.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


