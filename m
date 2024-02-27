Return-Path: <linux-wireless+bounces-4054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EE9868913
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 07:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A758284C6D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AAB41A84;
	Tue, 27 Feb 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvotJIHt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7F28366;
	Tue, 27 Feb 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015932; cv=none; b=k3k3fUo/EhCcH9ty9nlscrqRe7/PcD13llV2td59TxWf1+jtirwrqL7xaGIJqCBpQz30UpmXEtMaokm0saOt+7hZHu2KveI5BIWucsLYogqrqaI0zt9i6ZOZNUBb7LZbJLfY8yJ6pA9N7/4YgJF+7rH8RKHqA3RzPI2YXVBLXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015932; c=relaxed/simple;
	bh=75cBmLAtHoi99vV8/5q5IHnRffXQOEx1mYMI/BFFE2Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=t/+ML2CLwaQG0Ds7EvBJ2bGxuG4FInfzX/5CMi2mRVjKLEZZnsCOZPJAV62qqnXw6lxLONhsKLpPDaGrIzLBu1yfVZCbY98Uv2hFsLIXISoOJK1fjWUyb7SjFZN9BiUouuxqjk9a5Oh92ZNKrU18utnZ9Ew4X/NF2HW14prWfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvotJIHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7BAC433C7;
	Tue, 27 Feb 2024 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709015932;
	bh=75cBmLAtHoi99vV8/5q5IHnRffXQOEx1mYMI/BFFE2Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pvotJIHtb7PsrU/bAiinmaDj3RClHpIdK+F+629VlHhK/qDIY7o7OCBjz/eWs99CB
	 NrHPOrJPl+orsh+v52NZf3TXHkeRq5nTbJmwxU9WlXumNa4mQD019iMoAbG+1BtGkj
	 HOliRtOdVcmFw428yngwFkEPN+S3qBpYvT8y9e6rQ4/Vv11zRY3umHL/nmxz8gOuRv
	 GD6QBb6ANYOBGBASTvrkcWEP53yvbXGb3ZGZ3QYRI6sPa/BoUiZi0plhv/HwkQz0HB
	 YEQPJdngL2mvui+d65HpLKYVBMW2DUERzndz42WdC8ATu8a7P2A1XOha2oJAk3rrrx
	 NAHuLzQ2I6kig==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@gmail.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "Nick Morrow" <morrownr@gmail.com>,
  Larry Finger <Larry.Finger@lwfinger.net>,  "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and
 8821CU
References: <4ume7mjw63u7.XlMUvUuacW2ErhOCdqlLkw2@1EHFQ.trk.elasticemail.com>
	<aab5bb779e1f470daeb0a4258e4bb764@realtek.com>
Date: Tue, 27 Feb 2024 08:38:48 +0200
In-Reply-To: <aab5bb779e1f470daeb0a4258e4bb764@realtek.com> (Ping-Ke Shih's
	message of "Tue, 27 Feb 2024 02:56:43 +0000")
Message-ID: <87h6hu9zt3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Hi Larry,
>
>> -----Original Message-----
>> From: Larry Finger <Larry.Finger@gmail.com>
>> Sent: Tuesday, February 27, 2024 10:35 AM
>> To: Kalle Valo <kvalo@kernel.org>
>> Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.org; Nick Morrow
>> <morrownr@gmail.com>; Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@realtek.com>;
>> stable@vger.kernel.org
>> Subject: [PATCHi V2] wifi: rtw88: Add missing VID/PIDs doe 8811CU and 8821CU
>
> Not sure if "doe" is typo?

I think it means "for" but Larry's finger was one key off to the left :) I can fix that.

>> From: Nick Morrow <morrownr@gmail.com>
>> 
>> Purpose: Add VID/PIDs that are known to be missing for this driver.
>> - removed  /* 8811CU */ and /* 8821CU */ as they are redundant
>> since the file is specific to those chips.
>> - removed /* TOTOLINK A650UA v3 */ as the manufacturer. It has a REALTEK
>> VID so it may not be specific to this adapter.
>> 
>> Source is
>> https://1EHFQ.trk.elasticemail.com/tracking/click?d=I82H0YR_W_h175Lb3Nkb0D8i6IqvuhESe0WLnY6P7IVwR1UKvB
>> 0SPxd1Olp3PNJEJTqsu4kyqBXayE0BVd_k7uLFvlTe65Syx2uqLUB-UQSfsKKLkuyE-frMZXSCL7q824UG3Oer614GGEeEz-DNEWHh
>> 43p_e8oz7OouS6gRBEng0
>> Verified and tested.
>> 
>> Signed-off-by: Nick Morrow <morrownr@gmail.com>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>> 
>
> Did you keep a blank line intentionally? 

I can fix this as well. I'll also move 'cc: stable' to the beginning of
tags.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

