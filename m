Return-Path: <linux-wireless+bounces-27895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C68BC78E2
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 08:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC0A18984B5
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9629AB1D;
	Thu,  9 Oct 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kha4SIp2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845331EA7D2
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992115; cv=none; b=Izh90Ede+41xeiVYnBJyNKeAhc2iYkqA0QX42Xiror4MDdgadd8BV+8jcwIWHm85zXcr9crQ6mSTIy4B45P98QWCJEAzmPuw/a/Vln+lrx8nc2Qe5Y9dfHsyvSRaE2dz6n1FzXv0CMZ9KdU6HafgxVN/T4yBq+fe1Jr5g5S5cC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992115; c=relaxed/simple;
	bh=VjSj1Jr+SsT//LVbQP7nMBmN14oJpVgPCAz/81xcof0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ulujPRMcE6zaNQdp4uaWW9ZY1oCbk7k4EpPba6bJAoeTlIPqQ3Ie+EL2IaqQ47kUW6B7uVoz4eCnHFh1kAujkNmnJYphY9I3PZuVYFvMhtTyZoYV2cAt9fBFnvwhY7onJ7c9IOp8E1f662fxmWwfL3JrP5DFoeNeDO6+cz58yoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kha4SIp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D2FC4CEF9;
	Thu,  9 Oct 2025 06:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759992115;
	bh=VjSj1Jr+SsT//LVbQP7nMBmN14oJpVgPCAz/81xcof0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kha4SIp2ZKeJi3l+qsawBgZQ/eiDLNghybLRGZJcZweXM4TqDqeRA1w49UF1zFJBt
	 YEKiqTpONfnPDZuSE5PVEQ2Ivv4WSJ5gAUN89QTwuczprW5myN4RPDggUjZk3B7eB4
	 epGjNrXTJIunfcHKhVgosqzdQwRjs0QX9HIHOVeBHx03tefklb8jI1+I3j+t6nVT03
	 rEjbqKz984nmER8+oyD4yVIBH2sC3UysXQFAs/tS67/oyUzhxf7avjncGtHUFErAYC
	 +igpQ/BsTg/Ayg8KKfPoiJ/zZo550aswHv5mtPfheDlEIOkNH5HmU3SLs6Y1vDc2dx
	 00Xba7SbuxZtw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 33A415FAC2;
	Thu, 09 Oct 2025 14:41:52 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Richard Huynh <voxlympha@gmail.com>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20251008112104.8558-1-voxlympha@gmail.com>
References: <20251008112104.8558-1-voxlympha@gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for
 Australia (AU) for 2025
Message-Id: <175999211217.3194772.10317350496194840605.b4-ty@kernel.org>
Date: Thu, 09 Oct 2025 14:41:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 08 Oct 2025 22:21:04 +1100, Richard Huynh wrote:
> As of October 1 2025, a new class licence is in effect[1]
> Update the link and references in the comments to it
> 
> Also align the 915-928mhz block with the document
> 
> Additionally for the lower part of 6Ghz spectrum:
> - Allow for EHT-320 as it complies with PSD limits
> - Expand the upper range up to 6585 as permitted in new licence
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Australia (AU) for 2025
      https://git.kernel.org/wens/wireless-regdb/c/75bedc589589

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


