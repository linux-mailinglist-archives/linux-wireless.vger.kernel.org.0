Return-Path: <linux-wireless+bounces-15871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FA9E30F5
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BDFB2254B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E19616426;
	Wed,  4 Dec 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHgx9Ad1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A35227;
	Wed,  4 Dec 2024 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277414; cv=none; b=Q3HXjUdcr/xgF5ME/wywCJCUq+oYeDYw9WTCJ0B+kFD0lsJmWljBbFyRS3KtVlMEV7P7WTGiYH3gLnEUurYsx1Dk03dpKt6Tzq23B62K73r08lA0DMZLmB7PTPiRXy6F7e979BQ+PJqx4okcmzrX5e7QBvNfrXrOZ6vicRfmbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277414; c=relaxed/simple;
	bh=SpsBIF4YNr8yx+67TWJ8Q3zaHqwesUotMLtLAVgtTPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PY+MJ7I9fP8SOLaTzCvhsPoLCp8LIXTdbPC+IA0ChL/o0cCpKXxdMVZR5Ms+d9nsQkIZ0vFkc/EM0aZNguGP64+2I0OSsR7RAF/IU2WC41aNYyiP/+vleYrYtnpul/q0NYknhmSR0etz4iS/2olcGYVKXVFkd17utESZbl73cIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHgx9Ad1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9A7C4CEDC;
	Wed,  4 Dec 2024 01:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733277413;
	bh=SpsBIF4YNr8yx+67TWJ8Q3zaHqwesUotMLtLAVgtTPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHgx9Ad194MzNjZUBlQ6Q/fXp9uF692DDWoDQWrGgcSlklmQRuXfHbLUfCq5Yc8IM
	 /iDr4DWULD1vYIbsWiUFUd1KPnrqptb9oQJIq2XBNFTycUiCXDiad7bft8dfcO9fni
	 FKiDCnKY+kG5l1AqH1s2zMpfKTXzD3UMF5cuL6RrFY+Oz4iMCPSElnDE1i3fglEIVo
	 PSFfR5Ph0KId92Xt+b+QXw8LjmKr8XIwx5QkcAlYk2FQkSN9fdpZ2TQb1y7+qzr6Kb
	 CYnnIfC8+6U8TyuwFOyKfp9u0nuNvohZbYs2H/XLvYNIOvYNQiu+7/8mdgXy+QlMxv
	 Ks7ZIw4LclgGA==
Date: Tue, 3 Dec 2024 17:56:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/7] tools/net/ynl: remove extraneous plural
 from variable names
Message-ID: <20241203175652.5cf2434b@kernel.org>
In-Reply-To: <20241203130655.45293-2-donald.hunter@gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	<20241203130655.45293-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:06:49 +0000 Donald Hunter wrote:
> _decode_array_attr() uses variable subattrs in every branch when only
> one branch decodes more than a single attribute.
> 
> Change the variable name to subattr in the branches that only decode a
> single attribute so that the intent is more obvious.

Acked-by: Jakub Kicinski <kuba@kernel.org>

