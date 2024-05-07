Return-Path: <linux-wireless+bounces-7276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D469C8BDF5B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB611F22C7C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159814E2F1;
	Tue,  7 May 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZKMXmQ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B414D443;
	Tue,  7 May 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076338; cv=none; b=LeDvZTVl4DbydG4EvRdCYw4KCct5RoQgczIzUZWFCFQYF+88nb1pwicOe9FGEdRWZn2tT6llfbQKEIh/5f1e6mW4F1cwPpko6lRWxpKQN3xsyXwCBhnNSJHTTt+I50gQb1k3s82sN3PL/3z5vEihMv6jyu4c+fBxnzSuyZslrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076338; c=relaxed/simple;
	bh=zVcUl3GHK4Klc1HbBXDvbpqqBLsYLjnWF6jdPaLOoDM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rc9BlWA0M4/XqLDbLxe2jnCGTm2di6NYN3DVQj50cbdeZcJMketZevmmAEvGslczSWwM+F5tpX2W0BO0vzl4mrMiOrDvPBacUI88jOxBKe/LtlUUS9QKBUraxPlVLXdAPcDOxw08i9VGaD6n6AZ/ChkPbdRcRv7xnEQoBXwZlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZKMXmQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E90C2BBFC;
	Tue,  7 May 2024 10:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715076337;
	bh=zVcUl3GHK4Klc1HbBXDvbpqqBLsYLjnWF6jdPaLOoDM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=hZKMXmQ0xyHUdME97VnF04JAmb8/ELTZq8yEFt8JIrNg1+PfRZDHJ14DgvA8E73Fp
	 0vZt2CWocJgyqTVZm1UqzpwTn5QGVSrcFDVPb+o5uwaKNUOPa9RtF9Xv/cINgOW2hV
	 eKqpmdlxCBE24dlcCSLI4ra/VbQkU1qqu7jqSnb4HvXL2MnMZx0W6KMIWyARwvYRVl
	 ymyg+zfVddH8Yh4JVHB+nzxTr+eLKeaqxsRl5YDxwo+q8XBXaZdEPSPnUEhKxw08Iv
	 Pqyh0vwVFsjJQcGxiFg4NrM5G1KoLewJ4geY7yoob6+DHgJPy5yp7+Ixxa9Xdr6MPh
	 jcUE2m5e7fkYA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next] wil6210: Do not use embedded netdev in
 wil6210_priv
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240503103304.339489-1-leitao@debian.org>
References: <20240503103304.339489-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, merez@codeaurora.org, quic_ailizaro@quicinc.com,
 linux-wireless@vger.kernel.org (open list:WILOCITY WIL6210 WIRELESS DRIVER),
 linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171507633406.3818005.5416249178784551917.kvalo@kernel.org>
Date: Tue,  7 May 2024 10:05:35 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct wil6210_priv by converting it
> into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
> the net_device object at wil_if_add(). The free of the device
> occurs at wil_if_remove().
> 
> Link: https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

10d2b4f4aa0b wifi: wil6210: Do not use embedded netdev in wil6210_priv

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240503103304.339489-1-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


