Return-Path: <linux-wireless+bounces-12971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8147897BFF0
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B449B20D53
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F81C9EBA;
	Wed, 18 Sep 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUXjXjVW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DEA13B787;
	Wed, 18 Sep 2024 17:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726682262; cv=none; b=QDJsEhHRWUnXEd0WTTwjJfpDevLqvfJAPrnfrscGDEN/fXIHLrIpWoJ4iBiS9qoZbnGbN4AH0H9rHqvBSuEYwCjJRV3mfFiR69TsxpBhABsisItmqQd2d8R+DmMAjCouMKD8CB6wKF4JXEP6MtoGqXA5nNJ+pMONkvOZYwebp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726682262; c=relaxed/simple;
	bh=zkH8wwPv0cUBAv4Fi7G3AVPnScyY1XEyGjRsvKtx3u8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZCe2tVSZxJuUJljoUoUKr9zsDVSIDO/HXpM6ZZZiIO3A3awlH3+AwtXWOaFbvmuat1wKO2qd3XuxzNfTcIJvzdovK3ayVtbz0LBKuDKwWqB7LfpiY0rfEKLLdYmB+l8j+9Ek6+jh+nUk8VTtD//RWl5gEBqDF+9u2Z7Tbv3qLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUXjXjVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11026C4CEC2;
	Wed, 18 Sep 2024 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726682261;
	bh=zkH8wwPv0cUBAv4Fi7G3AVPnScyY1XEyGjRsvKtx3u8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CUXjXjVWXfIRVBQQ3lvPiou48MByNfKAA80/xrO0Btx1xkOg071ZRoQRpaJr5ngD7
	 hXjxuoEJptVRypCHXZiIUyoqjz0EEwsd26LZAMUOhwplzXFwk3OeJ7RoWZuEEQ2BUO
	 co++B3GHMzVhu1U0ilxFAAebYht2MnQDH46odFISEpIbynocr8M12CxE9cM7dX+xUH
	 fenSBOvnuX2te5kysFGPlOPMnulPNPSvk7FNMIk+HWuT2ifTvgKkM29EpcvlK85c6S
	 KdU/6ThOlNNAkzBvb3WNALTTuoOoQKOhl6G6nKgOI7oZebrVvoRB2qd4Xj9sN0PTko
	 xHhaEyV3wp+DQ==
From: Kalle Valo <kvalo@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: David Lin <yu-hao.lin@nxp.com>,  l.stach@pengutronix.de,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  briannorris@chromium.org,  tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: fix firmware crash for AP DFS mode
References: <20240830080719.826142-1-yu-hao.lin@nxp.com>
	<ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it>
Date: Wed, 18 Sep 2024 20:57:38 +0300
In-Reply-To: <ZuFjtc70r6CGbzcW@gaggiata.pivistrello.it> (Francesco Dolcini's
	message of "Wed, 11 Sep 2024 11:32:37 +0200")
Message-ID: <871q1gdeul.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Francesco Dolcini <francesco@dolcini.it> writes:

> +Lucas (in case he missed this patch)
>
> On Fri, Aug 30, 2024 at 04:07:19PM +0800, David Lin wrote:
>> Firmware crashes when AP works on a DFS channel and radar detection occurs.
>> This patch fixes the issue, also add "fake_radar_detect" entry to mimic
>> radar detection for testing purpose.
>
> Do we want such kind of "fake" code in the driver?

BTW in ath11k we have dfs_simulate_radar debugfs file for testing DFS, I
assume this is something similar. So there are benefits from having it.

> I do not agree that we mix an actual bug fix with additional testing code,
> and if I understand correctly the commit message this is what we are doing
> here.

Yeah, we have a rule "one logical change per patch". So the debugfs
addition needs to be in a separate patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

