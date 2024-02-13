Return-Path: <linux-wireless+bounces-3537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3938530F9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34985B20A90
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB942075;
	Tue, 13 Feb 2024 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/inDF3/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DA42074
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828861; cv=none; b=U3eV29v23WUEr+A02tW4RxWBd80n5YVgkzjBMUYta8U2aEr2nNoo+ebt7EAsv+bp/9TfSguonP2HMIl1zGaMNzFKRuatgTk9Qqa1Sryge5gqd/YLFIZVpaXJeAWuMs5K5kmlfOvhmCqYcugDBLfIgWr87z3KF4iJh0wY2erD8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828861; c=relaxed/simple;
	bh=T4ZQ+AMx5YSea1DBWbVxIvUE2u72e2fGhWCsFqDTlXI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MZARf/bmP4jfDzOcs7ozDdxYjkEHzXBZT99Z5LKBW7+taGHeVO5aV3RelPKB+EPw1bIw6my4X7wF3pKFlHURSu/x5aACCC7QkwPJuH5RoSm69FSloWpf/cFX7b3YoiQkwVtBKCmyBk6n8Zu8QxWp8WI0lrQLsB/U8HAyBZF3Pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/inDF3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B9C433F1;
	Tue, 13 Feb 2024 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707828861;
	bh=T4ZQ+AMx5YSea1DBWbVxIvUE2u72e2fGhWCsFqDTlXI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Q/inDF3/P7IGAF4lg9RHqT4x8t0c6+zrIbuh/fo/I35ih5Zl0Tr89LMqkR5TngMVn
	 khKkPSKyrOi72CCJRQFg/kLlqp22S7oBdjEeY+Lbo5K56I5DRpe6TsJt/E1gdiVKZp
	 KDNCaFtWvG8TWoEjGG/vCqSeS9Z/pNCyKIhfLZOxVpKgk3C1xUH81N/T3Zt8mr5pvW
	 z6s6tkyGmKOy13vXP4QIyPcU9OdKf2gW2nTj1gS9nOsrdGPh3Ef1OF05Kxjult7zqG
	 slaE9XDDYG20hLRy3qU06PBLmAxks7N7wc1NZMaZhKK/A7YGR/D6VnA2Z/22+go66+
	 iHEmW8o96qO8Q==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <johannes.berg@intel.com>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: fw: remove unnecessary rcu_read_unlock()
 for punctured
References: <20240213122556.9593-1-pkshih@realtek.com>
Date: Tue, 13 Feb 2024 14:54:18 +0200
In-Reply-To: <20240213122556.9593-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Tue, 13 Feb 2024 20:25:56 +0800")
Message-ID: <87ttmced8l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> The rcu_read_unlock() is accidentally added, and sparse warn:
>
>   drivers/net/wireless/realtek/rtw89/fw.c:2807:17:
>     warning: context imbalance in 'rtw89_fw_h2c_assoc_cmac_tbl_g7' - unexpected unlock
>
> Fixes: b82730bf57b5 ("wifi: cfg80211/mac80211: move puncturing into chandef")
> Cc: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Commit b82730bf57b5 is in wireless-next so I'll queue this patch to
wireless-next as well, right?

This again shows how important it is to fix all the remainging sparse
warnings in wireless code so that we don't miss important warnings like
this. If there just would be a way to get the cleanup patch submitters
to fix the sparse warnings, sigh.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

