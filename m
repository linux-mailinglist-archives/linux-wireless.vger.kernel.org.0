Return-Path: <linux-wireless+bounces-24492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105FAE8B7B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 19:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD875A12FB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF4E29B205;
	Wed, 25 Jun 2025 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2ELG/mJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147CA286425;
	Wed, 25 Jun 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872357; cv=none; b=hkHEvVMuSqceZyFA/+oZy1TkfMEieRrPgxs9H2FO6KRhlOR30EOUICKgDYtnju7w0U65PZtyLXHDkGrwt+uNvjFQ2YCCnkwWKYeaDcA46l2QrcyOS4BrDUlsuHviQNkx9srxaG/Q1d1vOt05F2nexspeoLfIV0PaTw2pvMUlVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872357; c=relaxed/simple;
	bh=RjwaVkDwG0wA9+4LhiqKV6sQ8E16YQNtVSdf04Kosu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPQg4s3ugqZmZ2+l3BmPUi2FAiecgremCvQOdnNWpcEWOIvS6yY+Dleof8cP7osFqEz3zyY8l7P0BQey8kQmqjblr5ClAToCgiDbrz3OpcG/52F2Zs/2Q9I44Egvd6uMWfK9G4B7bm4nAHyRC0IQSH8KrYOYQZ9y8UWtZKM8aQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2ELG/mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B322C4CEEA;
	Wed, 25 Jun 2025 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750872356;
	bh=RjwaVkDwG0wA9+4LhiqKV6sQ8E16YQNtVSdf04Kosu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2ELG/mJq2c1hfuhWol5lqPLSdb5lXqf6cNl7OlOXBE9BeuHvP9RznFP0RXHYBb2p
	 LW49rctl/BB3nyX6DehyL5HqflFjROcRPajiC83gfxShO8EQxZWxpuw2Dij6Q0Osj8
	 UPYBuXPIIRZWXNXF55rNaGU2aCxkUn3YDnELuvusnRsM9yG3NmHbdUgpHQRfWAcHAw
	 E3luR5lMyUV+6Okwofv5L8HfQQzXZa7yw8A449UClVHcISdoZVB6I1ZJOC8SjTaqot
	 8wEtHzSZq9D8XOy6XOriPSrai2rFNv9Nk/skc9QsZP81z1BT2mE5BWSIM2A7spneFL
	 ad8VLfUJpBdCg==
Date: Wed, 25 Jun 2025 10:25:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2025-06-25
Message-ID: <20250625102555.35d3509a@kernel.org>
In-Reply-To: <20250625120135.41933-55-johannes@sipsolutions.net>
References: <20250625120135.41933-55-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 14:00:22 +0200 Johannes Berg wrote:
> And for -next quite a bit more, but not all that much
> that really stands out either. iwlwifi picked up a bunch
> of really old cleanups from patchwork "spring" cleaning,
> and the rest just move along with regularly scheduled
> feature additions. No known merge conflicts here either.
> 
> Please pull and let us know if there's any problem.

Hm, cocci points out a real bug here I think:

drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans-gen2.c:550:2-8: preceding lock on line 496

Not major enough to delay pulling tho..

