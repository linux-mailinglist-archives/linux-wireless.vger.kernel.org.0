Return-Path: <linux-wireless+bounces-15038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A79BFF8E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041CF284446
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 08:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8FF1993B5;
	Thu,  7 Nov 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM73p2Hw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5061993B4
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966601; cv=none; b=Rkx3/ZX0K8OrvdZgaErtAAgGg1PN3G1Q5AZqDpzJuaEMlimZCzDUPrFOig/fI8tcT7d5brTiPukxZsj/uvzKGu7bIyqMSU8l/YBhml/TJR/11T/CvQbanag19ibnU1AkRiYVhU0zMWNLGJzm9ZiKd+OFxUL54kktfjy7M+emPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966601; c=relaxed/simple;
	bh=6VeVWX0HDmdQJ9GE6ZiA1Ow3BK/vPqLG4mVnAqZqgO0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bPw3zuBQuzbzc8/nWyfY4E2KicY7Wi+pgEHqaRVbx/bA9mQQwqUUu1ua2XKa5ggxXhrkxPm+zrwxBDP+X81wrJSJYynzVZ+fGHGfarXgojseHaXE9JvDGAUyzk9yAr26YrSKP/VDG9rgSHHKnut/2rsdPguNMIe8gUMEmFSGvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM73p2Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B1EC4CECC;
	Thu,  7 Nov 2024 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730966601;
	bh=6VeVWX0HDmdQJ9GE6ZiA1Ow3BK/vPqLG4mVnAqZqgO0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eM73p2HwhxiyHiVpfM+JxYKU8iTBGDsP1slrHXpJZEPGZeu1rQCB1JXbJnG36TjhS
	 PU7uTen6fnYxUz15dRBvIzwRfj5sxZA7UZY4acIV7AdgYnNgdE66QKzDRjHvub9VnV
	 pO8iFUDJqcJGDaC8DZikMHW3Hx8sOaLVOeC7bmHh+ZD4UePR4Kxg0FsiWh2Iv6vgbO
	 fL5NOOtC73eAikbiQ3Lm5oyD73He22ml1Y4ihHU5GaAdt0A0xiC6P8l10o/4J8u2SK
	 MEZVXqt09UMRuLhHWgN14QUDf83ByCxVX4dTXYpPZXd6d/TPNYukETLm2w/DF0Wrxx
	 L0nE8awZW1ssQ==
From: Kalle Valo <kvalo@kernel.org>
To: Sven Eckelmann <se@simonwunderlich.de>
Cc: ih@simonwunderlich.de,  sw@simonwunderlich.de,
  johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,
  mathias.kretschmer@fit.fraunhofer.de
Subject: Re: [PATCH v2 2/2] wifi: ath9k: Reset chip on potential deaf state
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
	<20241106090439.3487958-1-ih@simonwunderlich.de>
	<20241106090439.3487958-2-ih@simonwunderlich.de>
	<865447434.0ifERbkFSE@ripper>
Date: Thu, 07 Nov 2024 10:03:17 +0200
In-Reply-To: <865447434.0ifERbkFSE@ripper> (Sven Eckelmann's message of "Wed,
	06 Nov 2024 11:05:57 +0100")
Message-ID: <87fro3xygq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sven Eckelmann <se@simonwunderlich.de> writes:

> On Wednesday, 6 November 2024 10:04:39 CET Issam Hamdi wrote:
> [...]
>> This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
>> and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"
>
> Am I the only person which finds this style of adding information about "Co-
> authors" weird?

No, you are not. I also find it weird.

> [...]
>> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
>> Signed-off-by: Sven Eckelmann <se@simonwunderlich.de>
>> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
>> ---
>> v2: change the "Co-developed-by" to "Signed-off-by", remove the dependency
>
> I think Kalle meant that "Co-developed-by" should be followed by a 
> "Signed-off-by" - not that "Co-developed-by" should be removed.

Correct, to my understanding having both c-d-b and s-o-b is the
preferred format.

>> on CONFIG_ATH9K_DEBUGFS and add more information in the commit description
>
> And please don't reply to the old thread when sending a new patchset - this 
> becomes really unreadable after a while. You can simply use the method which 
> b4 uses and just reference the old thread in your mail. Something like:
>
> Changes in v2:
> - change the "Co-developed-by" to "Signed-off-by"
> - remove the dependency on CONFIG_ATH9K_DEBUGFS
> - add more information in the commit description
> - Link to v1: https://lore.kernel.org/r/20241104171627.3789199-1-ih@simonwunderlich.de

Yes, this style is very much recommended. Having links to older versions
helps reviewers.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

