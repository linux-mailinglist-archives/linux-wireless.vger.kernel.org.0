Return-Path: <linux-wireless+bounces-18601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95578A2AD5F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 17:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F3437A3963
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85922DFAD;
	Thu,  6 Feb 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQkAjk/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3E1EDA08;
	Thu,  6 Feb 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858356; cv=none; b=iJH1q4yknSq1plYrCAgK4sPKzX/VCTsQec+SbCdwxKFZaO4lq9Omod5PjCye5vd5Je8tV54359x+7kwY/riEStMSBYrZtLWuaSrTRh0WgGgu/b4rWEP3CBQFruMEOk8SPtgN5YeaccIYUccRzC2IjCWdVlQzFwflVj2pcDb66rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858356; c=relaxed/simple;
	bh=L3Gwob9pZCusJ0M4c2lN2uPavPeBUTgR6PaXEsdkFCg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts3xaksaNDdE7iNuyeG+zmIuMWo1BlOZDk5HVW21e0TXHrOvsvn8p9oz7MdZ+YBy5fDkzI9X6gI/BwLMxW+m8cnsyyhkj7+Qe+n4LJpU8Sa3oGBaHEk8LwGRH0UqF5mHxYGMyUZNJNSGyIz3Jp+hLiP8+Sko2gxyTrCDYMU6/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQkAjk/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C2AC4CEE2;
	Thu,  6 Feb 2025 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738858355;
	bh=L3Gwob9pZCusJ0M4c2lN2uPavPeBUTgR6PaXEsdkFCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQkAjk/hIjfowMkazEFA5JWMJi0JWcJbRKghlO6t4s1yvJ4JHUmhBWgLjfFft+qN1
	 pmEJi5R9lowBMuqGsDBa3L7Qujs0VWXINsi1wKWeRtEgJlt+ziOiZkLqAFkbwL0yHr
	 R8rtey99kil1LC5VXPzf+YXGhvTPI/J9Kf3gRRXjIhaNtmH3vuMeLoTGKtxt/uFH0u
	 WeE+4Qc6g2KyAI/FrJTKqG5qOm75ccwcDeb7hndqNZiMGKe5OApRXbdW8GO9AFrfVx
	 g9bHLBal5Y9q3Oe63OhhPbXKotX6r4M3ublaK8MkkadvbfLE+GNxxRzWnCGhakzQAF
	 xeY1z8HTqH/nA==
Date: Thu, 6 Feb 2025 08:12:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 07/10] tools/net/ynl: add indexed-array
 scalar support to ynl-gen-c
Message-ID: <20250206081234.487d3739@kernel.org>
In-Reply-To: <20250206092658.1383-8-donald.hunter@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	<20250206092658.1383-8-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 09:26:55 +0000 Donald Hunter wrote:
> Extend ynl-gen-c.py with support for indexed-array that has a scalar
> sub-type.

Acked-by: Jakub Kicinski <kuba@kernel.org>

