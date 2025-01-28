Return-Path: <linux-wireless+bounces-18084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A102FA210AA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA1F3A2E4C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D261B040E;
	Tue, 28 Jan 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HilBwh4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4019ABAB
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088398; cv=none; b=bDB9//hXegPkjntMMS6gJqtPXe719cYNyFy0aUe4/9DVzCWv0vYcXcOEaeLEHzfKg+yT7ayYX+PQFJ6DBAcNt2v/XOvjPnmW/8TocTL0e9syrEG5YsN6aD1F93m7OWEV/d5yxkGzMpJOOTZMe/rCsEj4R07BakJ7+0dX+14dvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088398; c=relaxed/simple;
	bh=IJ4s4wbxmvi7WlbVja1PWuObnoO89o4CJKiawUCQvz8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=lATE+DjiSzsL2BZqIo4OpMLb9HZIJuux/6MKL2liAC8BwWlasFEbL1qnelFtNC8nLGFq3lLxshErSLoLRaHlQo21tHwfWNzM8+S+Ut040kEjizuc1sqa27sZHnSSzOzmv6bEYvKENUjRY8/cvV0AtKipy0Ygt4NqfMlNMm5kbH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HilBwh4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52162C4CED3;
	Tue, 28 Jan 2025 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088398;
	bh=IJ4s4wbxmvi7WlbVja1PWuObnoO89o4CJKiawUCQvz8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HilBwh4WeFTUFHEmit/Mtn0GULsgGNjf02f2Otr0gm/p0PhwvGQtsKmz+KGpZB8TL
	 lZkRs6lrmOFBmR7sbKXgRFhbwC7hCKkQecwzOTEw9fHau9MnZWA0HHTxUdiWMnQJG1
	 v7azmU736wBqlw25+pBrTn+6+AqH+gKVXooxb1uWwtAHH2Cc1GZy/elILpxdVnQu/i
	 Hh4dVhb5JrL/X1BXIauWV3uPNIBxir6B3fJYywT0dnSK3d/jhzP/cC3iVmNOT6XDVB
	 9Z+F2Ove635aEWc+hLsJa6kdSbAISfTWEbDZAXH/fjVeSWsPy3Ms7Foc8o71VDIjr9
	 f0EiYkPbKy1VA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: ath-current-20250124
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <3311fea1-c7c0-4929-b92c-16ab933de33c@oss.qualcomm.com>
References: <3311fea1-c7c0-4929-b92c-16ab933de33c@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, jjohnson@kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173808839535.1321818.16289363523697290711.kvalo@kernel.org>
Date: Tue, 28 Jan 2025 18:19:57 +0000 (UTC)

Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:

> The following changes since commit 146b6057e1fd28fb1a38d300bf76a38dfba7f9fb:
> 
>   wifi: cw1200: Fix potential NULL dereference (2024-12-18 19:58:27 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250124
> 
> for you to fetch changes up to 64a1ba4072b34af1b76bf15fca5c2075b8cc4d64:
> 
>   wifi: ath12k: fix handling of 6 GHz rules (2025-01-24 10:32:44 -0800)
> 
> ----------------------------------------------------------------
> ath.git patch for v6.14-rc
> 
> Fix an issue in the ath12k driver where 6 GHz operation no longer
> works with new firmware.
> 
> ----------------------------------------------------------------
> Aditya Kumar Singh (1):
>       wifi: ath12k: fix handling of 6 GHz rules
> 
>  drivers/net/wireless/ath/ath12k/wmi.c | 61 ++++++++++++++++++++++++++---------
>  drivers/net/wireless/ath/ath12k/wmi.h |  1 -
>  2 files changed, 45 insertions(+), 17 deletions(-)

Pulled, thanks.

3319569bf9d8 Merge tag 'ath-current-20250124' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3311fea1-c7c0-4929-b92c-16ab933de33c@oss.qualcomm.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


