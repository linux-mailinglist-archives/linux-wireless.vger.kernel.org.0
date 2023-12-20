Return-Path: <linux-wireless+bounces-1104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5081A4E3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 17:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F23F289E63
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2AC4777E;
	Wed, 20 Dec 2023 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmE7re5G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F6541841
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 16:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708E0C433C8;
	Wed, 20 Dec 2023 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089299;
	bh=ufAXbcvC8Kp9IfQuCHd/wngAU7A2XjdlPnKEjaWqsik=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AmE7re5GnDvlSbK+Czq1J1rKV6s+aVvyOYRQywF0wLdIfizmTbCN7ntaSYjyPpcSW
	 dG9X18iT4ihKpFEb6T/RH6JfFhD76qdNpiFyMwoprnJY3myn9XA1OYvRsSJDZUKXIw
	 UipY9LufVPZi4oq7kGAJDsWopGYpQS7f5RBQdOKHlwIpMokMzTmz+nfxa3D13k9vwT
	 KcdoYqZGiEjheu2QW79Anu41xDKImsZqfgCsJGT0NQTOkiHRVST1XtdLjixAztQPYc
	 1+YC6ZHLyXXuhoGy0cx2upXpLU3g4J6L6y0YvQ1NccucZE9vVvs3H6Mqu0SHHE2naJ
	 ZayRm1n1DL94g==
From: Kalle Valo <kvalo@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: orphan brcm80211 broadcom drivers
References: <20231220095750.307829-1-arend.vanspriel@broadcom.com>
Date: Wed, 20 Dec 2023 18:21:36 +0200
In-Reply-To: <20231220095750.307829-1-arend.vanspriel@broadcom.com> (Arend van
	Spriel's message of "Wed, 20 Dec 2023 10:57:50 +0100")
Message-ID: <87h6kcq1yn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> The maintainers listed can no longer meet the expectations
> of the community. Hence changing the status to Orphan.
>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> When joining Broadcom 13 years ago and assigned to work on
> upstreaming our wifi drivers it was a fun job. Getting it
> in shape to remedy John Linville's eye-ball cancer from the
> first look at it and adding stuff after getting it out of
> staging with Greg's blessing. Setting up a Jenkins CI rig to
> nightly test the chips we support. Refactoring the driver to
> pave the road for new features.
>
> Those days it was backed up by the company because there were
> paying customers demanding it. When that support ended I decided
> to hang on and play my role as a maintainer because I cared and
> could not let go. That was probably a mistake from which I can
> only learn. Hopefully I can stay involved as a valued reviewer,
> but I somehow doubt that. Too much emotions stir that I need to
> vent, but it would only put more oil on this stupid flame war.

I am so sad about this but I fully understand your decision. You have
the best knowledge of Broadcom devices and you were involved with
brcm80211 from the beginning. I can guess how difficult lately it has
been for you to find time for upstream work but even still you replied
to my mails and tried to support the community the best you can, which I
appreciated so much. Everyone else in the corporate world usually just
ignore, you did not do that.

Your mail made me think a lot about what has happened over the ~15 years
I have been involved with wireless. And this is not fun anymore, this is
more like a business with requirements and demands coming from
everywhere.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

