Return-Path: <linux-wireless+bounces-5455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF288FFDA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292D71F23F4B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C297E767;
	Thu, 28 Mar 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjddod91"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265E7C6CA
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631316; cv=none; b=mwH0uzvmIVZWd1YCsolLpy7Lv/ItWVH1CSzT2wJM/SV3cuuOO8GKKf8pfB/UVaExwBvD2OoXs8sMjG4oEAESBNJT6evdSidF4RbPEoXuE3Sf6yY7HgpbVyhFF07PNdJKPARGcbdpPNWLQGmOOeKGtKSQVhCbtymy3VrN6f5QDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631316; c=relaxed/simple;
	bh=kXdzWFC1kEp9GAaGirc4OSSCJlSeXgeEvBSyEHimz60=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=HchOYFAmk/raIG8CVeaXDqoU5TJ1o58FE5K5iOPWAoYxQninz49cz+ujDHVElIRgX3GgPZyH31j37KZt+WA2di4PpyJM25BvOwa7Uq+UuZlRKg5ibfeXVLnDV7pYcrMpvBIFCdLXYZXwlzqAE9oCo66rclC7r39eUbtJc6jEGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjddod91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672EC433C7;
	Thu, 28 Mar 2024 13:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711631315;
	bh=kXdzWFC1kEp9GAaGirc4OSSCJlSeXgeEvBSyEHimz60=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Kjddod91oE+6kCh9PzI58r81cb2jvMDbMZFcK0gvP+UfBcVZ5JZVKDh0KM/ubOzei
	 mtXuUfQ40wCIb8itkR5moUNk9BKtv5pFble6FmE/nM0gg/ExXs19gNBh1GGifUCh7g
	 XkRVrPecveBBA3TjNUfPYbZ5UzXHwjgpptF9WApgHeJCLMo65SCq35S+Z+BjL3hBAS
	 Mb2ZSxPDSpEZn651NYwV/A3/MNbPGiCdb8UA5PbxdTbdShKr8D0wHMngvORpS37Vxy
	 lL8+zSr9XbxVXCnGzSLIBAOvGvRxJ0y5JfqGTNjzQ/KWiLOQTAlAZTR+zk1W6QnrXE
	 oGqRTH5fv6o7Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: mt76: mt7915: workaround dubious x | !y warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240325155838.1558680-1-kvalo@kernel.org>
References: <20240325155838.1558680-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: nbd@nbd.name, lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171163131263.129280.880052720214330735.kvalo@kernel.org>
Date: Thu, 28 Mar 2024 13:08:34 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Sparse warns:
> 
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:526:9: warning: dubious: x | !y
> 
> Workaround it by using the '?' operator. Compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-next.git, thanks.

b68b2beadfd3 wifi: mt76: mt7915: workaround dubious x | !y warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240325155838.1558680-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


