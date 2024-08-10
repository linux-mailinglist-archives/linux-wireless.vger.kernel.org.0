Return-Path: <linux-wireless+bounces-11246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2E94DB40
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 09:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7BA282716
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 07:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4C3D55D;
	Sat, 10 Aug 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS7ELL6a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46E4409
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723275781; cv=none; b=EaeO7z52W9AmWeHro+nDuBOaRdZdDfdnFujc7BLnWBIQsmNXibLyCRRWjS9pQVgV7Ds/a/vgTZNg07ntmdVYyeyJJiT+Gxu4oQJJkLAzXN54FM9fVeruAadhZCVaDCkUTb+nsp05kJInkHAdv9FGJoNhHcHCaRhKssRan3313rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723275781; c=relaxed/simple;
	bh=NOXQvowqkF/Wa4rwjnrhI+AjDpvuuTj7zS9rvVla3n4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MQBoMDF4od+TeENlDMEAkYS2muC5qD8MgKnL6c3WDVMbeXMMHWfTNthlUZU5/pBvNcD4Yj4yPEonw8x74V3oKFS7xOnHZDLKeM+JZU7RMclxri98QZtpGwxMjWPzxS8vX0hY2P4/hpEFZX7Fvqmepvf0J0ehX3UpQI8drv2Tpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS7ELL6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF7C32781;
	Sat, 10 Aug 2024 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723275781;
	bh=NOXQvowqkF/Wa4rwjnrhI+AjDpvuuTj7zS9rvVla3n4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AS7ELL6a+9vtSb4cjsHMQ5SNv9FQXko3uZ48Yr95V+SZrfBBvDMMfZi7p2uiRwJEs
	 LCRFEd6qaun8y1vMT1oS2dcQQ1mZzJLWSGo8zDK7Hm+MCWQmFaQmMtOYA5U4U/eGE6
	 haemLT2azX2bLSYhGou7WTaNk5JfTQ0rx9gq7eY+xq3SKslrklOlx3EjBITXOA4Jeq
	 ePD8ZMQsf0n9LyIRHOp83Cs/fIC4gn17D5e7WmRUJJq+j4QfbhvT/SMJ1lnwMvF7NG
	 O4BEd99YA26wegn0zsp3GmuRCclIsERwBjKXfJhPj6GRr1ZeSZGW70TTaZ56Q2lbyt
	 jv19oJN2/11xQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-08-09
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ac0c5d1d-ae4f-4c65-b7b3-93ac5d1384a7@RTEXMBS04.realtek.com.tw>
References: <ac0c5d1d-ae4f-4c65-b7b3-93ac5d1384a7@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172327577887.395581.16127904063279074424.kvalo@kernel.org>
Date: Sat, 10 Aug 2024 07:43:00 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

cc32e9fb380d Merge tag 'rtw-next-2024-08-09' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ac0c5d1d-ae4f-4c65-b7b3-93ac5d1384a7@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


