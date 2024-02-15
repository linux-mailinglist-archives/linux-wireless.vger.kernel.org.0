Return-Path: <linux-wireless+bounces-3619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5A856113
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 12:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C982928E0
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307BD12BE9A;
	Thu, 15 Feb 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSG0itI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57A12BE94
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995457; cv=none; b=NhFbVIZ5VNApdUmIwZFvh5utYnfoUT/RckNvJ2Y+OWGGt7vMk4EPlXJCuW2A49itX2VRh5qHACGODjAU7qfnAF+oSzHXD0egq7wCRZo/XF0mExwzf+D/hN0L2FX1xmNj+fGZ9ETkFo6OMaE5Dd5Efv0rYu+AMZUIpney0Cydo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995457; c=relaxed/simple;
	bh=vVvUI0Zd5BkquX4DfUyJx8xggQrW0+sr8+FuAXyTVtc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AO2vqzG6tscb+yMgr+3nrnGcGpE2XPBT0oy7uUMk5wcTGpUyGjrtTf5VhSENYpViPN7P1IYb7a6gxt2wMOy8AXP2puMcvhfcB6Q4XMcfOjNXb/DLW+dWKOsjpBbpAtj7E+CDGP7InPqZtNY02LZRZ/Ux7vI9azQ9/GzYwqcep7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSG0itI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0FFC433F1;
	Thu, 15 Feb 2024 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707995456;
	bh=vVvUI0Zd5BkquX4DfUyJx8xggQrW0+sr8+FuAXyTVtc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FSG0itI+g0zVM4tk8e1HYcxt9z6DrtEOoCIW+Lx5Pbh66W28Q83r6fKZkkuOHNdQr
	 DlB342nbGdf/OfOlmGwGuZqK38LD5Zk457UaqIve6phQlNTv1QKxFzf9LdP3adbDre
	 eh004HNR5hdK5JEtEqRuvXazd17VLsogA+JU//7fg55cwpV9gQxjGQKd7OsCkBnfE5
	 +Fb4blFoAtk2glDoFdMo2btTVHS6xyQ8tx1riXvdQWsuGU0c56z68Cbojzq10JG3MC
	 fBeS2xAg+qFe11aXko7fVd6SiM5nidnBxz06R5EPEcNZ++a5RcKKdOUTwWMuKKyBR4
	 ieqPzpWqClrmw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ed960059-5c77-422d-ac4e-fe9fc9d0d296@gmail.com>
References: <ed960059-5c77-422d-ac4e-fe9fc9d0d296@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170799545341.3764215.16526652466064365914.kvalo@kernel.org>
Date: Thu, 15 Feb 2024 11:10:55 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> rtl8192cu handles 1T1R devices (RTL8188CUS), 1T2R devices (RTL8191CU),
> and 2T2R devices (RTL8192CU). The 2T2R devices were incorrectly detected
> as 1T2R because of a mistake in the IS_92C_1T2R macro.
> 
> The visible effect of this is that the firmware was allowed to use
> TX rates only up to MCS7.
> 
> Fix the IS_92C_1T2R macro.
> 
> Now my 2T2R device has much better upload speed.
> Before: 46 Mbps.
> After:  82 Mbps.
> 
> Also fix a debug message which was printing "RF_1T1R" even for 1T2R
> chips.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

bcfcbf23a98c wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ed960059-5c77-422d-ac4e-fe9fc9d0d296@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


