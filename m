Return-Path: <linux-wireless+bounces-2389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA16839538
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 17:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935791F2EB74
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2807F7E5;
	Tue, 23 Jan 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NET4hMit"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E607F7D0;
	Tue, 23 Jan 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028306; cv=none; b=O8wtJKL3QZ1PsNkCwDfpsyDqKXPtZV5vhd60aAOxo9CU7gWkaqrGNcMtmHBky+XqhjFcqEwIXLLFxp5TLDN0Pua4NhvaGsRSSC+k64Gsf2KaqsRzk+Im4Bx+zabwBgEt/cxkgaqus2zmT1RuLoOtmZjabxEUofgM8IFBw8wchGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028306; c=relaxed/simple;
	bh=F3yZKfbSfGqSCQVhRIgzdE/wONdkOItuHu1X1himeew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxSE3dve1T0kXtujLHhy3TQCHHeYcSk09PfukFMtYX04KxHHmCykQuwDNw68FfQvImJVtqjXHY/kYwg2cTPsGWoG8/UReSqgW+qEvrXMQNQtBuhkPBG8769fbOSFf42lZC6PwcZF/vI/xLAXttyqI521yuwsJZfDZSCDQh+rnew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NET4hMit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A937C433C7;
	Tue, 23 Jan 2024 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706028305;
	bh=F3yZKfbSfGqSCQVhRIgzdE/wONdkOItuHu1X1himeew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NET4hMitTZfT/SXqjvXo3N5C7BLCe207L4JuhL5kqe2qy1o+6+l9MSgk7nlYHIfww
	 0Ig2qOkXObXh+e1giqhqtWzDpXqLZptArHSaDTyHLIxCw342Nxs9m4w3x5ly8qZaPV
	 kP4wslE7X9RQdC3aOdve6KnopAiR98mBugB8Wst3kzl+qx4UULzyPBW69y3YDVc2TI
	 z6X8U0pDn2bKloKTZRY05yUXAUR/aQGXLXX6pctxVBtTiIgBhPiEZUmLo+dnBII9Tj
	 FGfQIhM74Gok+G2C7UUubX3yl0HbKnmjA+rqApWmOmhUc1EnrynqqNeZX/pSLvqDYL
	 Pj+nRevwkEq5g==
Date: Tue, 23 Jan 2024 08:45:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-2024-01-22
Message-ID: <20240123084504.1de9b8ac@kernel.org>
In-Reply-To: <20240122153434.E0254C433C7@smtp.kernel.org>
References: <20240122153434.E0254C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:34:34 +0000 (UTC) Kalle Valo wrote:
> Lukas Bulwahn (1):
>       wifi: cfg80211/mac80211: remove dependency on non-existing option

BTW we run all kernel's kunit tests on netdev periodically by doing:

./tools/testing/kunit/kunit.py run --all

and AFAICT the WiFi tests don't pop up there :(

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-23--15-00&executor=kunit

Is that on purpose?

