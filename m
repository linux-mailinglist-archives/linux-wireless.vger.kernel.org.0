Return-Path: <linux-wireless+bounces-3617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF39856106
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC01F20FDD
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927D127B6E;
	Thu, 15 Feb 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsTSiS1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853B966B2D
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995408; cv=none; b=Tb+hCt33FwAoc7knUQeZTpr/dqpRlHeGpeHOxcO7VlrOkWPHoNJq8FdWAUw0761DnrcgrU/DkkKxYOJSNCW778SauRVL46dsrSSdt8VM/D/4SndAk0oGvKmhnansqYpobniW42GnVS2wrtiGSLD4ILcyayQijAVdgjDY7mDwmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995408; c=relaxed/simple;
	bh=8NWl4Oafgs0R4ZTIhB4FbvOqEXbs6mbDP30fqWaED38=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=IzU7QDk7GokFLISiB+l8EAYdEvL0GRwmdk0nobwYXm9E2Yg4unbRa0iHld5GaKF7FvLJ7Xc9Cyj/cpbAuaEl4qmicPUVGTz3vjQxKu0f6RgCBqMlwVW+RSzZTtARKtMB5D3Gx5p5COzXxAyGyp67tmTnCBNRUDYwaVsjky5Tg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsTSiS1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F25FC433C7;
	Thu, 15 Feb 2024 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995408;
	bh=8NWl4Oafgs0R4ZTIhB4FbvOqEXbs6mbDP30fqWaED38=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=gsTSiS1Dz5IWtYjFS6NCec/0KWG4/cxLuf7eakN7WSqXiIvy/cblwcBiJ1//NnzQC
	 lqjHAL/eCxpA2S7V3xErquVRx0bjpGwBqEXHBGH61vaICeVPxowftPJkk9d3Gtk5S4
	 vzPBqAAvv3SruMyWPkztWnBOlsVuYY1+RdGZoCmx0JECEubKbkZrexM4FYLU3hZ7Cb
	 tEuW3W77ctAvlTViDIkiiDNyvwzZshYaw2+Vy6rVN72IRVcds5Mf3fRPjDcVn5LXhe
	 NuqWG+zr+BkYzMetQnUw1Ivl1cpTWqQFSFxmtNkSRXNTrnyfIdHV4/Jyfj3h4VI8X6
	 s0AXmIMemZWwA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: fw: add definition of H2C command and
 C2H
 event for MRC series
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240213073514.23796-2-pkshih@realtek.com>
References: <20240213073514.23796-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799540569.3764215.7868506365274223642.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:10:07 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> For Wi-Fi 7 chips, FW supports MRC (multi-role concurrent) functions
> including H2C commands and C2H events. We can consider FW MRC functions
> as a superset of FW MCC (multi-channel concurrent) functions. And, MRC
> functions can take MLO things into account.
> 
> Basically before MLO, SW can also manipulate FW MRC to work original
> SW MCC flow. So, we add them first and implement the handling in the
> following. And then, SW MCC will call different series of FW functions
> according to chip later.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

6ca3b88c320b wifi: rtw89: fw: add definition of H2C command and C2H event for MRC series
b8e59e553458 wifi: rtw89: mac: implement MRC C2H event handling
9de7829aa6fa wifi: rtw89: fw: implement MRC H2C command functions
f931cce310e0 wifi: rtw89: chan: support MCC on Wi-Fi 7 chips
441a6014d024 wifi: rtw89: 8922a: declare to support two chanctx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240213073514.23796-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


