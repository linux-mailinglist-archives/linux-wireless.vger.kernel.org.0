Return-Path: <linux-wireless+bounces-7687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7AC8C66EF
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 15:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C928502B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4A85649;
	Wed, 15 May 2024 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfnXTrc3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08E84A3E
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778747; cv=none; b=mFm62bFkERs5Wo16iYonN06gd9nc43VDwhLgLtPIRVwfSwEXP90HptEDmanpPJkZNgbGlOpwWyHPsJPNfPtjJatDJl1XAD0VG1jPBtNio/7RfjReBojq6CBI3RT9IkDOyk6y5w1D64bWjKsywx8ll0ub7XIBGJHY0xUKgSgm0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778747; c=relaxed/simple;
	bh=T5NSJcAYkaQ4GHi4wqWcKDaH2ZFAdkO7844Y7gXCf30=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uBQqPrEXEBnq9TIZG2hpGIDOGFIiN0EgntcpvroI+XMtQ/PDGp08hprrxDKcElUwzHTCqT9p2Ize/6C1b/Olv7L3cr91Q+5efDH69pB5Vf17lcbb2rJwFG2abC/vHfbVQsOXiRCl1kIw3M6H1a3euBbcQpUWIx1pC32gcCkv4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfnXTrc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5ADC116B1;
	Wed, 15 May 2024 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715778746;
	bh=T5NSJcAYkaQ4GHi4wqWcKDaH2ZFAdkO7844Y7gXCf30=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kfnXTrc3xD15QyBC5PO0DmshLr9lpWPCmsls4chc7CyG5gqufVwdfGoQlyxy5bbT9
	 qBk/IwaLo3s9Hx9K4Y5sPOp72Q5R9Nbav1AXQ4eSk0Q8w0DgbSOrkLoKJOWZdscq48
	 04V3LUoR66V6lCxq9KzrWuzotVrAc5Xlti73CEAN+ZWaX4Q56Zg9VWUiDwqZg+OL8N
	 5vWEgju5MLAA5jA5t7qSZW8FrXh3sldLhj/7MRqMCRBYKHGp8QQ3v9TcqnfShFiatK
	 9WBBbaH5UsF8gvq9gsracYqDPPFPZA74onud6l8Un+d9S0qCJikot2pfLkxZD0j560
	 ACMqC9WJV6vYQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 3/5] wifi: ath11k: fix TPE power levels
References: <20240506194536.102148-7-johannes@sipsolutions.net>
	<20240506214536.d99fcf5856b9.I359bb401ea74bf82dc981a86a7ca3fa44d169d2e@changeid>
Date: Wed, 15 May 2024 16:12:23 +0300
In-Reply-To: <20240506214536.d99fcf5856b9.I359bb401ea74bf82dc981a86a7ca3fa44d169d2e@changeid>
	(Johannes Berg's message of "Mon, 6 May 2024 21:37:55 +0200")
Message-ID: <87msorcj7s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The chanctx can be shared, but it seems like the TPE values for
> this vif should only reflect the channel that the vif uses, which
> is captured in bss_conf->chanreq.oper rather than the chanctx.
> Use that when calculating defaults, a similar issue is where the
> data from the AP is processed, but I'm moving that to mac80211.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

