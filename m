Return-Path: <linux-wireless+bounces-424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C98057B4
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B3A281B11
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5775B5C5;
	Tue,  5 Dec 2023 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJWROqHH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC539FE9
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 14:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C69C433C7;
	Tue,  5 Dec 2023 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701787555;
	bh=cErcNxuSq+KwDwGNIQMoU3Oz6YM+Ijm70S9VqePDyoo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JJWROqHH/czRco/daAN5+vEzbMTMOOFShTNzRfXpPc5yqzEvuNpmfOM63EGkcXSiY
	 LO1i0RnJehM6di/b+Yk0SmAAuHbkHUbzj5KXGUkQCrVwgaZh7oypLmP9K6OyRS4DXV
	 1MyzjaZSbhXaO9yJOR2N10xFWi+8jABl2TsJ9VRLL8GrqyjWJVvhXcdmx69RL+shm2
	 SPYZJ/sFremswXB4JMPY+xpHP3Vr3dvSCk9bNxb5V1sEVHLIqh9kasEw3gV94U/pqL
	 hqQ07L4U5jF7ZgA19LANGGSvoOxFBb5BiJOwjBmTeIa8Cy4dHIgynHIlcZ+FZYICjB
	 bkB2RDlJoLQKA==
From: Kalle Valo <kvalo@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,  Felix
 Fietkau <nbd@openwrt.org>,  Nick Kossifidis <mickflemm@gmail.com>,  Luis
 Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
References: <20231205111515.21470-1-jirislaby@kernel.org>
	<874jgwrgxu.fsf@kernel.org>
	<dde1fdb0-c905-4c46-baf6-cdc1011df4cc@kernel.org>
Date: Tue, 05 Dec 2023 16:45:51 +0200
In-Reply-To: <dde1fdb0-c905-4c46-baf6-cdc1011df4cc@kernel.org> (Jiri Slaby's
	message of "Tue, 5 Dec 2023 14:10:11 +0100")
Message-ID: <87msuopv1c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiri Slaby <jirislaby@kernel.org> writes:

> On 05. 12. 23, 13:07, Kalle Valo wrote:
>> "Jiri Slaby (SUSE)" <jirislaby@kernel.org> writes:
>> 
>>> clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
>>> unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
>>> parsing and add missing calibration data") added it, but did not use it
>>> in any way. Neither, there is a later user.
>>>
>>> So remove that unused member.
>>>
>>> [1] https://github.com/jirislaby/clang-struct
>>
>> clang-struct looks really nice, especially if it can also find unused
>> structures.
>
> It can...

Nice!

>> What about unused defines or enums, any chance to find those
>> in the future? :)
>
> All of that is IMO possible (I'm not completely sure about macros,
> despite clang ASTs provide a lot of info. Incl. info about them and
> their expansion).

Too bad, I wish that there would be a tool for that. I suspect wireless
drivers have unused defines and enums, it would be nice to clean up
that.

> It's all limited only by man-force: me.

Yeah, I guessed that. Thanks for making this tool available, hopefully
more people start using it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

