Return-Path: <linux-wireless+bounces-10894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1C946DD4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 11:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461811F21439
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE9208A7;
	Sun,  4 Aug 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqADwyQ3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE81F94A;
	Sun,  4 Aug 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762618; cv=none; b=h86yXX63qKvCBfiBbiP6Yp7lRRX3hQdLYYbRct0tn07zYos4/YBgTiKrZufzCAc1062StAxfB/yq7GXllhLtIsswqTQba2xFQITXziR6QMuYxGa1G5DVDFMuVh/aS5VAsbVmqWIGKqqksgQu8MiTOsG2s1pwdkg81I+D6EQJGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762618; c=relaxed/simple;
	bh=X5iYJKZ1DMEytvXt94ujo7wbLbrZOyakKYbub3cPy4o=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RySMbZaEkgONFzRS3fj+q+gcKMoYQ9UzxkJ9BsL9zK28qI/TPxk7tK/wDZPwC/+SoNOXc6jkkvyyNZ/aZH1ET914iqV9cwe6XplbVtC0R1C7P0SRrBR5Xf21PwNACMY8Rx3/ybulChy3juhMO9qkbD/gag09NQiaEwhKYqa8rx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqADwyQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9C5C32786;
	Sun,  4 Aug 2024 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722762618;
	bh=X5iYJKZ1DMEytvXt94ujo7wbLbrZOyakKYbub3cPy4o=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=SqADwyQ3a81G1mY4D0h0HZZG3g8c8xnrz+VQ+BqKyfsojw2+8xF2sedDV5SeSstmz
	 YQQ6k7njL78mARk+0Xng7U83cN+c61FAipvMrCDh9HsAadchr7qRpuKbW6BDmtbSQ3
	 aktxpBhoGr5CyIAxPJ/4Fnm9Eko0eTsiipgwcUutMBxYQknoLgwkqutBxK4YqODeRc
	 yxId9Aj9r7yGCABi8y7JLKB8Z3nXy4ckq7do4Yld16iKRFe47Gy2qeU47o3nB4IW9d
	 i3LzQlWL76/K1b6dszyzxHAU6GRi8LT1b5NbduEaoimPxz/0dLtlKiS5TZVf8s6BK/
	 g32Ey3QwW+alQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: introducing fwil query functions
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240727185617.253210-1-arend.vanspriel@broadcom.com>
References: <20240727185617.253210-1-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Arend van Spriel <arend.vanspriel@broadcom.com>, Su Hui <suhui@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172276261575.2804131.6150984819251929994.kvalo@kernel.org>
Date: Sun,  4 Aug 2024 09:10:17 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> When the firmware interface layer was refactored it provided various
> "get" and "set" functions. For the "get" in some cases a parameter
> needed to be passed down to firmware as a key indicating what to
> "get" turning the output parameter of the "get" function into an
> input parameter as well. To accommodate this the "get" function blindly
> copies the parameter which in some places resulted in an uninitialized
> warnings from the compiler. These have been fixed by initializing the
> input parameter in the past. Recently another batch of similar fixes
> were submitted to address clang static checker warnings [1].
> 
> Proposing another solution by introducing a "query" variant which is used
> when the (input) parameter is needed by firmware. The "get" variant will
> only fill the (output) parameter with the result received from firmware
> taking care of proper endianess conversion.
> 
> [1] https://lore.kernel.org/all/20240702122450.2213833-1-suhui@nfschina.com/
> 
> Fixes: 81f5dcb80830 ("brcmfmac: refactor firmware interface layer.")
> Reported-by: Su Hui <suhui@nfschina.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

c6002b6c05f3 wifi: brcmfmac: introducing fwil query functions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240727185617.253210-1-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


