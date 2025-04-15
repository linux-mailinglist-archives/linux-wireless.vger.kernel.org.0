Return-Path: <linux-wireless+bounces-21569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F6A8AAF6
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 00:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C528190351D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D32566CC;
	Tue, 15 Apr 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIz78YEW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F20274666;
	Tue, 15 Apr 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755066; cv=none; b=qf7GDYEsXAmZgRI0jSsz8nQhlvoBlB3tTa+VYWMojg3eG3qmsChOfEY/m7Qfcf2nzJLIcheezR8acEsFWGPHT7boBWNkZiHeau/8+Yuz0BggDtmzE8+lmXlC/f+ZxoxTvL/lZUFI0cHVy4V/MeA6Fs/+a+viWXU7YParItcIQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755066; c=relaxed/simple;
	bh=DJt3/Gcb4vgPCwXb7e++ID1PnmPHDBl88OMt95revsQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WcIKB/N7SHcbASkgSkFa0DYbJqhxmgOKoPF0TIquKQiZ9Q3bcjsNWBbCA+IiCj+nTdydU+JSomFo5Iy0hRugUIYfAoxRYx5dG5ABDmjDu1mJZ2CF8d/Pmn+qiTQOuRHCnHzackPumzyieqPOnQKscgjhANa6tmeM+MfsK67q8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIz78YEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF74C4CEE9;
	Tue, 15 Apr 2025 22:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744755065;
	bh=DJt3/Gcb4vgPCwXb7e++ID1PnmPHDBl88OMt95revsQ=;
	h=Date:To:Cc:From:Subject:From;
	b=bIz78YEWeP3AWvJfw4q6rsupqpa5/4ukrzQ7KVNLRKoLdYMzqXxjwect+IJ8YtElV
	 zmK1KGH9kPQRv1EZASmJ5/PiJ7rv8GIdrhOsfRbKBLOrlIy30+HlAuszrMNz3dQ2cU
	 zgfXsHghqNzsuVdrpiHGk+3VU5xN86Pgb+20cazT3DEb9R3NecJmhuKUNtDi6LJ5jx
	 BfU58jdMQer+e5t65MIfY0VH0Gc8DY7H5jTbtQQ4/+M8As/KGLUKtFwBA4HZQLBc9O
	 5iIM8D/PNAxJM2wOnRviRYf3QU/Bxs/6Tui2TX8+eMgEnShUhiwkgiBCv4piVLDRRZ
	 wEDVBiGThszNQ==
Message-ID: <cab8e07a-84fa-48f3-ac6f-382148b20744@kernel.org>
Date: Tue, 15 Apr 2025 17:11:04 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: 6.14.y regression in ath11k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Matt Schwartz (cc) found a regression in 6.14.2 that the Steam Deck OLED 
took 45s to find a network after suspend/resume waiting for a timeout.
This was a regression from 6.14.1.

The regression happened because:

commit 933ab187e679 ("wifi: ath11k: update channel list in reg notifier 
instead reg worker")
was backported to 6.14.y without the other commit in the series:

commit 02aae8e2f957 ("wifi: ath11k: update channel list in worker when 
wait flag is set")

Backporting commit 02aae8e2f957 ("wifi: ath11k: update channel list in 
worker when wait flag is set") to 6.14.2 fixes the regression.

Can you please take this commit back to stable too?

Thanks!

