Return-Path: <linux-wireless+bounces-4185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C086ADDE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 12:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182931F25CA4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0EA13A24A;
	Wed, 28 Feb 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUVFh/A8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62913A891
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120260; cv=none; b=lBxDJuJiUNLUJACxdDO8xkcNcVBNuypaPbwhZMeJlETTAz9SEwXUwuPT0u2knk56kRBMy26VS108nawaAQmj8+Taz9Tu/ObTrqinWyjnz+4C2rvqVoHZLwopkja2HavrqvBE/BhlLsqrq3KnsNGHqwwPjPqnc73rKMZI+BPzv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120260; c=relaxed/simple;
	bh=Qhr2PtyOvXLEP18TAZfMxWBwWoFos4zQZTyFkPf6bBg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=O+fQVXHyo/xDYi2+WcPAVauXQgaOanNDkhjnbHJbxW+QxFJ3MAZvLs1LFQHlthuaxACc7ZgG6ZduJ7l9KKgchy/gAZ2EkU/2tthVCC1ilscl0dJ+dt+hDmN9NDklhJu0qQgqrLx2eNcLKrlGqkVLVKUSsgQWRHO7/ezSenISlLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUVFh/A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8B2C433F1;
	Wed, 28 Feb 2024 11:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709120260;
	bh=Qhr2PtyOvXLEP18TAZfMxWBwWoFos4zQZTyFkPf6bBg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NUVFh/A8BbXATZnlNjS5ed8SF6oE1/mAJy+EbgLlfHh2ZisAKt+2gHe3FqbvjKxp1
	 nrRQbVkJ8iicdOScsxrzyLrJMeTdkfWvgAuGPynHEOB5DlG5FsgQV5i1774cWaHuwI
	 NWcycQmcbjgrKiljV3e/+9IyEyrntHRuGKqVQ7IFkkxZZ/0rmanFYL950aNYXpkdnI
	 ZXTZ6DQo3Evb/n5H809Mk5pRDCPRrHHrbP/6qXZb+LOiaLSLCCdWLIRMFg5aQw1Nqw
	 ZuN/InQoEeL6DZgcQwMefc4KynmaEevuH82k/DANaIX8ah94CNR0QJO9neI3dRgWAl
	 /c56YeuWtM1HA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: b43: silence sparse warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
References: 
 <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912025752.3742961.10014605061917523893.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 11:37:39 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> sparse complains on this code about casts that lose bits
> due to the usage of bitwise not, but really we do want
> 16 bits only, so clarify that by using masks.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

4 patches applied to wireless-next.git, thanks.

576b2015e7e0 wifi: b43: silence sparse warnings
17672ced7d73 wifi: brcmsmac: silence sparse warnings
e06324303662 wifi: rt2x00: silence sparse warnings
5a391813e7ef wifi: zd1211rw: silence sparse warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


