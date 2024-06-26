Return-Path: <linux-wireless+bounces-9615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0356918A32
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8AD286BCD
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E21DEEDD;
	Wed, 26 Jun 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTdWv3w5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05113B5BB
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423360; cv=none; b=el+VDiTWvY6C2t2f5//DTtpQJig5zEGoGdBQOax8a8QyGbf4SFxhhTSSA7pT5d4qw0l4AYcgdyTb23C+pNAuTR5V1a77DIYchLdgmQuZgzQ+JAc/zB9GxZPgs2rrk1bNfB49wLv5HmObTqYF5MjobDU/KSq1kMaCey2JpbbFLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423360; c=relaxed/simple;
	bh=+zFF2pFopV5MhEOzrR6fFFjz0JFWtPlVmvBLhTX+n10=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jOVNyGvxn8gYglubmQaz83/vMAW3Jm6qyiAmNXkMQqWxvU94eu3r0QJNw2a12z8s5bt5HRe/PwCmXaVPURMpi/JlTlRgwW4GHCbmyrEZjFQ482WKN7u0DuYKv6wn49X04rT30F8WQH8RFq9YwS019NXBGDi55zMd4YOkXzh2meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTdWv3w5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591C8C116B1;
	Wed, 26 Jun 2024 17:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719423359;
	bh=+zFF2pFopV5MhEOzrR6fFFjz0JFWtPlVmvBLhTX+n10=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JTdWv3w5rwWuw/BrxvcUrS9MCAkb2TPoZT10zN+CaepIf8i/OmfW/Gay9EET+/Vcg
	 7F4DO/Lt0AyBOv84YCsXdweKHEu0AXa5PnvKAi1TYo2/d73BihBRXIZWYuRTg4SxxR
	 rKeiMFfGkMz8vDkP0jqmi1YHNWnLdPVQtpmsFTHdzARJEwVi+fYTp1R/wL2HJMjOTH
	 pla4j8aDCLiMd9Ee42vM5KdrkYPi87AxQE3AgLky5zsA/fejN1J1MrmLQmYAxM0pN7
	 l5dW5hFtIBzde9gwUcWXykzepMLQDco7PbU/JVCu5zeIqTq+lCQrjNoJTQHlB39DdE
	 h4P6/YYjq0pHQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] MAINTAINERS: wifi: update ath.git location
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240626102632.1554485-1-kvalo@kernel.org>
References: <20240626102632.1554485-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171942335638.1803120.11955784309369789042.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 17:35:58 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> ath.git tree has moved to a new location. The old location will be an alias to
> the new location and will work at least until end of 2024, but best to update
> git trees already now.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless.git, thanks.

c40ff9b662d0 MAINTAINERS: wifi: update ath.git location

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240626102632.1554485-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


