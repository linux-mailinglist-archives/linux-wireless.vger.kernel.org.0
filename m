Return-Path: <linux-wireless+bounces-11477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78824952C37
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 12:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2147C1F21F96
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6319EED0;
	Thu, 15 Aug 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1CqGHyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891519DF57;
	Thu, 15 Aug 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723714539; cv=none; b=Q4Pyc/mYwHmEyeHIld2tDCfq6CpTPAOVnfcXUGqiufdF5F1DakjV+GQ7JswzkH8BSCFRSzhHdzZ5XNhu7fkNZJIFZxznOMt3dMazbCpZyDeRzE2cgccZV36nWxuW1KXDlyzOl+kytSUQ8uq88BPh9wA8/RAflGzsVtwR78/OxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723714539; c=relaxed/simple;
	bh=PVQNOeMTQi8lV98jbFqNpHhoYEQEkzMaLvP7V2uLo6E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=jW+wozIEYUDxWKB4/lrSe5tsMnqkKTKk1Z6SZPqPboVzTIUERGd/UwKWczmBE3j8fqRk9flMZV/YIsJEDqj1EtVSosGg8COdfijUZOtspdW3utoKxRFZ8+4cduVEWm13/hp2JUr341wU1gv1yPrbgzPi2PI1k0ZhbmSrL1I0M2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1CqGHyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E202C32786;
	Thu, 15 Aug 2024 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723714538;
	bh=PVQNOeMTQi8lV98jbFqNpHhoYEQEkzMaLvP7V2uLo6E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=h1CqGHyC2Es2AS4DTk5X203oUiez5uxkxyebGLeRQrtekcZ1q+7Ynx/oXC07giFME
	 5fyXykLoelGXkYVgF1AYkYMx/I9fIikRO/emHnNrL+12UvqmZKKHk+JzvxfYSuVVQN
	 DpmZ+FxPnacwXGemUowVsqKoj/50Qpb/7KhLGDBTY6Osjm11ux+LN0HGGxQlzcxb+L
	 zCeztcLbFTgsxHMbRTPj1EBryGr9+uonqEyDhcbmhQvWaP3MOObtdWQXChHvuYbDiM
	 PxfmG8N9bNMV6R3Z94QZY8BufhnrDzQMnuRnKrzxny/mFKZHY3jArMZJ8DNd/p8Nfy
	 t6STs/4oV6yhQ==
From: Kalle Valo <kvalo@kernel.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "briannorris@chromium.org" <briannorris@chromium.org>,
  "francesco@dolcini.it" <francesco@dolcini.it>,  Pete Hsieh
 <tsung-hsien.hsieh@nxp.com>
Subject: Re: [PATCH v2 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
References: <20240809094533.1660-1-yu-hao.lin@nxp.com>
	<PA4PR04MB963858E759C8F61402B2275AD1872@PA4PR04MB9638.eurprd04.prod.outlook.com>
Date: Thu, 15 Aug 2024 12:35:35 +0300
In-Reply-To: <PA4PR04MB963858E759C8F61402B2275AD1872@PA4PR04MB9638.eurprd04.prod.outlook.com>
	(David Lin's message of "Wed, 14 Aug 2024 03:47:03 +0000")
Message-ID: <87frr6yvq0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lin <yu-hao.lin@nxp.com> writes:

> I found Nxpwifi patch v2 is put in "Deferred" state quickly.

The way I use patchwork states is described here:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork

Basically I try to follow the "Inbox Zero" method and keep the amount of
patches in New state (my "inbox") low and the Deferred state is my todo list. 

> Patch v2 is mainly to address the comments from Johannes and it
> actually took quite some efforts. We understand there are areas to
> improve and we are committed to continue enhance/maintain the driver.
>
> Could you let me know your plan for reviewing Nxpwifi?

Reviewing new drivers take a lot of time, at the moment I'm following
what other reviewers say before I'll look at it myself. The process is
so slow and patience is needed.

The last thing I want to see that once the driver is accepted NXP
disappears and we end up having an unmaintained driver. Way too many
companies do that.

> Is there anything we can do to move this forward?

Yes, get involved with the community and help us, don't just expect that
we do everything for you gratis. Especially helping Brian with mwifiex
review/testing helps us (we get a better driver) and also helps you (you
learn how the community works and you gain trust in the community).

An excellent example is Realtek. Few years back Realtek was not involved
with upstream development at all. But now Ping is doing an awesome job
with maintaining ALL Realtek drivers, including the old drivers, and I
even trust him so much that I pull directly from this tree. This is what
NXP should aim for.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

