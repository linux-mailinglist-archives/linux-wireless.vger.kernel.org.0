Return-Path: <linux-wireless+bounces-10893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10A3946DCE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F418281523
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCC720B04;
	Sun,  4 Aug 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA25U3Kg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640D1F94A;
	Sun,  4 Aug 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762570; cv=none; b=F55oAkjY4qerqMX8yXHZDAj1c2Vz9+azoVFNuX5QLCY2xGDgQM9gQRWVWtxtrK6ACTn5MFjkalWE7uayv/XCwxe4D1yYL67hGgFtKHjcWr3dAa+ZzOInq7rWnt6KLpOKSeHigZNfDkj2n7QSFf5nMvN5wNAjGTLBYoHJO+itFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762570; c=relaxed/simple;
	bh=5K0JqgWBSyP508UKS4b4thXnYjHaE4ytgB/mhkj33qA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=t4G/ESL5Se928dd2725CX4gqRlDNWszaL4attWeHRE/9VMcStiXzHfTTzrgFY8YzCANA/C3myGRmwjR9a2DyHpRqSRtJes8CMLFR9tMpee13XiR8tT+TInKywqAj+rI4quN9eCN3WKVIXpHmlklMaL1/bAiLe0aAP4YhZQgqsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA25U3Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D6C32786;
	Sun,  4 Aug 2024 09:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722762569;
	bh=5K0JqgWBSyP508UKS4b4thXnYjHaE4ytgB/mhkj33qA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=bA25U3Kg1wZu0KQtOHvHJlRTmPvBJFAeUHV955id7fUixv0KvP6MSuPQa7KEUU44Z
	 05Hf2a9D9b3Wwm3ioF5B616l/do8gpq7pQ73VACO08nCu0aFzZqTa6cT4cJGFdiTN8
	 rpPcAlO7qNjJ00dF6ykvaMAyJfMUDD1S5jjMda55g7roKVpZYjBc77UO2CVZ4JAgRl
	 mZ1MGmiMen9XYXQn+gpktdg6tet0mY/GV/NG8oInPIdV6xhEYvxvAQBM6HIIW+S7cC
	 g7sTn+mvSADaUjC3WYT/pfz2oPrcA41V1Tl2F6h+dSzq7xnuS1wZ4ful/8NGuni2OG
	 jlYeSqlNAB35g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: brcmfmac: fwsignal: Use struct_size() to simplify
 brcmf_fws_rxreorder()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <f4ca6b887ca1290c71e76247218adea4d1c42442.1721547559.git.christophe.jaillet@wanadoo.fr>
References: 
 <f4ca6b887ca1290c71e76247218adea4d1c42442.1721547559.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172276256603.2804131.6125500029059282435.kvalo@kernel.org>
Date: Sun,  4 Aug 2024 09:09:27 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> In the "struct brcmf_ampdu_rx_reorder", change the 'pktslots' field into
> flexible array.
> 
> It saves the size of a pointer when the memory is allocated and avoids
> an indirection when the array is used.
> It also removes the usage of a pointer arithmetic and saves a few lines of
> code.
> 
> Finally, struct_size() can be used. It is not a must have here, because
> it is easy to see that buf_size can not overflow, but still, it is a good
> practice.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

16b31ecb8029 wifi: brcmfmac: fwsignal: Use struct_size() to simplify brcmf_fws_rxreorder()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f4ca6b887ca1290c71e76247218adea4d1c42442.1721547559.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


