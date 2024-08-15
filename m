Return-Path: <linux-wireless+bounces-11476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF7952B51
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 11:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1CE283250
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283021AB53B;
	Thu, 15 Aug 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0ngCW3i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73129CFB;
	Thu, 15 Aug 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712009; cv=none; b=ZJ5keZ9UzfYUOXL0r9desp4+OZz+nSUUtDbKHJzMYkacRnfbdLHI9PgF/lET7VqJSv73Tt8dUQsE6o3UFH8kmUVDBcjSBNCZnILwxw1eCOEZRPxlqjwm3bBLfMqWh1W2iabXFjZse+ymhKJMIm7ha6ud4xj/a28fWv1XIA12vtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712009; c=relaxed/simple;
	bh=uvWuZMpoU48JcHOeJrAEactdukPHmQFQcCZXV9R72Iw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CoUQhA1QtREQSoxeTZP2XFco45Dobto4ta+Zk880E5WHb9ih/oRCOUK70A2hgmoP035jb+WKRd8g83gaIxV9jdT4g4ZOaHB5OtcLZyG9EClAaCp10U77fw+5tY6WOCdWqWvrqivktF/13l4cRPtXBzg4c+ieon2R69x+hc9IxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0ngCW3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2A2C32786;
	Thu, 15 Aug 2024 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723712008;
	bh=uvWuZMpoU48JcHOeJrAEactdukPHmQFQcCZXV9R72Iw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=T0ngCW3iUiTlGPBlsjJxAbhdz7gvOonRcp3Fpy4fDirFjmg7EaoMqTwCCqVH4zHMZ
	 /GYY3UzHAZT/xwSX4NSY5JbTLNpoY92XuJ6TyKJ4f+UNKjBNKiM7iDfKxRz2imwGx0
	 JxcylDWzOTfl6AaNgQpHp5fKBm3e1bZx1wOPX0zPXdQGoYEm14VFelEcuT/PgGpsBx
	 M8yNJrpjPgyd3o1jjmADmbSg7Ra6MwP2jtzKAIScKJ1nPcfe0+MkngL3zwYqaIOqlo
	 patR7vrTpMfdxlU/nFbV6WXzz/nR8s7PshuHA7L+GmLuEYdK/IR0U63YkcX26ZQKGc
	 I1l4iEKgWtbrQ==
From: Kalle Valo <kvalo@kernel.org>
To: Issam Hamdi <ih@simonwunderlich.de>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,
  lkp@intel.com,  llvm@lists.linux.dev,
  mathias.kretschmer@fit.fraunhofer.de,  oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] wifi: cfg80211: Set the channel definition for the
 different Wi-Fi modes when starting CAC
References: <87o75ugup7.fsf@kernel.org>
	<20240815075439.2198346-1-ih@simonwunderlich.de>
Date: Thu, 15 Aug 2024 11:53:24 +0300
In-Reply-To: <20240815075439.2198346-1-ih@simonwunderlich.de> (Issam Hamdi's
	message of "Thu, 15 Aug 2024 09:54:39 +0200")
Message-ID: <87jzgiyxob.fsf@kernel.org>
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

When you submit a new version you should mark it as v2 and include a
change log what has changed from v1. More info:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

And please read the whole wiki page.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

