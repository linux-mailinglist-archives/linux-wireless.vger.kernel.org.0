Return-Path: <linux-wireless+bounces-11460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6F95296C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234A41C2215B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E223176FAE;
	Thu, 15 Aug 2024 06:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSS0v0sp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8241804A;
	Thu, 15 Aug 2024 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703705; cv=none; b=PeQDNbFg/K8nEgONoaHicRORaR3Rz8cULTCMbMJc5HNUMDq6ylQCkOLWTa4jrWlNGjA/u8vTSu39woAYFMRC5K1ODf0h3UUQe7hz0kCbAW052KHTKqNnkwYqP2W9Uxsvp66o/nTWRvMVaj3+h0uA1IW2qqDCZ1Hqv/WcJlBYouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703705; c=relaxed/simple;
	bh=clKxpVeKT5MroGVxZ5Gc42ASeLcuZqPArJZmuYBkEgc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lYTBULz0HzRsJGuSaumhuAD0xkXRlaTdmRdlIu2SDIYf1WVLZt0DLQOwtW6tS9pGfPVRV1d3UFiaIl413RNZiF/A6cjD2RmjzMnuTGJJoM/vISybb8JBEKP9CpOCoHPaKajF5O1B/lVOdzfj3i9jqgYfyn4HWUOWcTf7UJz6iFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSS0v0sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CB4C4AF0A;
	Thu, 15 Aug 2024 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723703704;
	bh=clKxpVeKT5MroGVxZ5Gc42ASeLcuZqPArJZmuYBkEgc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iSS0v0spPJHVkKoqOra1Q1b/5SvGDK8Q2O2cWHmNq14aL67J5MbL1be7CXjS4uQbx
	 KbYYNYnE7l90C9/ZGN/5BCfS2Oy1N8VrumIh9pSRqTG/KL2K7x0UpnYKDSsYyExH97
	 DtBvFrFzULNITEeeK/+xM6oxgDcDa37NUo8tTaz9/hi/zuY0rcWaFam/swV3lpx9jF
	 hdU5shqOX83u0dqkeL/UGKhF8Mhd6QTtv8IK7VO1cFfDhJLcIleWIy0TU36QApGWG4
	 sannn22rdI1jy3p8C+/221sSZ62XALOqOLcQiZ/SqdljZjZIfm4gT8LEag19cYC7Aa
	 VAUifvtCoH7+g==
From: Kalle Valo <kvalo@kernel.org>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: lkp@intel.com,  johannes@sipsolutions.net,
  linux-wireless@vger.kernel.org,  llvm@lists.linux.dev,
  mathias.kretschmer@fit.fraunhofer.de,  oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] cfg80211: Set the channel definition for the different
 Wi-Fi modes when starting CAC
References: <202408130337.tnSP4Qys-lkp@intel.com>
	<20240813111210.2463951-1-ih@simonwunderlich.de>
Date: Thu, 15 Aug 2024 09:35:00 +0300
In-Reply-To: <20240813111210.2463951-1-ih@simonwunderlich.de> (Issam Hamdi's
	message of "Tue, 13 Aug 2024 13:12:10 +0200")
Message-ID: <87o75ugup7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Issam Hamdi <ih@simonwunderlich.de> writes:

> When starting CAC in a mode other than AP mode, it return a
> "WARNING: CPU: 0 PID: 63 at cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]"
> caused by the chandef.chan being null at the end of CAC.
>
> Solution: Ensure the channel definition is set for the different modes
> when starting CAC to avoid getting a NULL 'chan' at the end of CAC.
>
>  Call Trace:
>   ? show_regs.part.0+0x14/0x16
>   ? __warn+0x67/0xc0
>   ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
>   ? report_bug+0xa7/0x130
>   ? exc_overflow+0x30/0x30
>   ? handle_bug+0x27/0x50
>   ? exc_invalid_op+0x18/0x60
>   ? handle_exception+0xf6/0xf6
>   ? exc_overflow+0x30/0x30
>   ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
>   ? exc_overflow+0x30/0x30
>   ? cfg80211_chandef_dfs_usable+0x20/0xaf [cfg80211]
>   ? regulatory_propagate_dfs_state.cold+0x1b/0x4c [cfg80211]
>   ? cfg80211_propagate_cac_done_wk+0x1a/0x30 [cfg80211]
>   ? process_one_work+0x165/0x280
>   ? worker_thread+0x120/0x3f0
>   ? kthread+0xc2/0xf0
>   ? process_one_work+0x280/0x280
>   ? kthread_complete_and_exit+0x20/0x20
>   ? ret_from_fork+0x19/0x24
>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> Signed-off-by: Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>

'wifi:' missing from the subject.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

