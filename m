Return-Path: <linux-wireless+bounces-2564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BA83DA35
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 13:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B881F26F4D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EADC14AA7;
	Fri, 26 Jan 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1SrQnER"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07212E72;
	Fri, 26 Jan 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272305; cv=none; b=KbYZNYG3xr3fSzhyelDpRqJogxjsjLVTp/U4sfg2oGH5BXlieRvNAwNj/gfWQWaZhT+N7EefdF9FkHm3+CpvGzDu7wgX7jbhD7RzqMyR3E/KZ1GhWKMSDD6Xp79Iuy9PkS9fniGkQ7MpatLHowaU2BcCLv1wG1LnnKsyNavDiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272305; c=relaxed/simple;
	bh=ipCUSjnM/+mHuCmrIoG3yByfeAdeaGi0eaCJY0n0870=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rWKfPlVn2KHcAo/1vIRDjdUwbqJOfP3Ears574HVfT1ul3T1dWMDfKSc6eramB9aCCvn/eWzUsXxWpxpaGCQdJNTcGMpwoUSh/bEozWn309RziOSRkcTTkTMV5GxbDAtmHhWjfpVS6j58hLX8WtZeowp9x+EXIOObrnco7BP4Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1SrQnER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79932C433C7;
	Fri, 26 Jan 2024 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706272304;
	bh=ipCUSjnM/+mHuCmrIoG3yByfeAdeaGi0eaCJY0n0870=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=s1SrQnERVeIjv7orjXvCqdSU+t8tO4oWl68uokNWhWLpXR6qbtmqKWGLu9PXEabOs
	 RRLfO3BzY8c5fTeSwu8A0NriuDTFLSCg7ea5cTLquqlHRvKHcCmSqOADWTFbPBueiP
	 wZBDuBmrxXqMG/DUR3Znu09RJjrEqyd9q1BsYpVpQzPC1I9K+B0N987ulKpQO0QLz+
	 u9HHxiTLYCBflSNNyu/nJSNk6MvLmK9R77Dt+vSkZL17xv57ElW5BqMmT6NiTqKixh
	 jozUZSTzx23BfuX36XN8fLNovAOEQnHtyNDjqI8gCJ2JBKZaAQ8LOLiacUfQREuIyt
	 eQO+KlNqJM9zg==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,  brcm80211@lists.linux.dev
Subject: Re: [PATCH v3] wifi: cleanup brcm80211 drivers maintainer entry
References: <20240126105724.384063-1-arend.vanspriel@broadcom.com>
Date: Fri, 26 Jan 2024 14:31:41 +0200
In-Reply-To: <20240126105724.384063-1-arend.vanspriel@broadcom.com> (Arend van
	Spriel's message of "Fri, 26 Jan 2024 11:57:24 +0100")
Message-ID: <8734ukz36a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> There has been some discussion about what is expected from
> a maintainer and so a cleanup seems to be in order. A dedicated
> mailing list has been created to discuss brcm80211 specific
> development issues. Keeping the status as Supported although
> help in maintaining this driver is welcomed.
>
> Cc: brcm80211@lists.linux.dev
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> changelog:
>   V2: let's not orphan the drivers for now
>   V3: switch to my Broadcom email
>
> The discussion around the SAE password patch [1] was a lively one
> and at some point I wanted to drop the ball and be done with it.
> However, when the emotions subsided and people offered to help out
> with maintaining the brcm80211 drivers I decided to stay on for the
> job. The discussion had some valid points specifically on my actual
> involvement. Hopefully I can improve in that aspect. I sharpened my
> email filters to keep better eye on brcm80211 related queryies,
> patches and what not.
>
> Another step taken is the creation of a specific mailing list for
> brcm80211 development topics:
>
> <brcm80211@lists.linux.dev>

Arend, thanks for creating the list. Apparently to subscribe to the list
send email to:

brcm80211+subscribe@lists.linux.dev

Though I didn't get any reply yet, hopefully it's just slow.

> This patch was based on the wireless tree, but it probably applies
> to wireless-next as well. I am fine either way.

We usually take patches to MAINTAINERS file to wireless, less conflicts
that way. So I'll queue this to wireless.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

