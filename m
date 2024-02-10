Return-Path: <linux-wireless+bounces-3414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307E8504CD
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 15:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CB8B2257B
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B59E54659;
	Sat, 10 Feb 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGNHP2X7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC8879E5
	for <linux-wireless@vger.kernel.org>; Sat, 10 Feb 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707576908; cv=none; b=KT47GtKOa/W4eHaV5Bmi/s9PsejQrMaN6GR3aSNTdGk0EunpYpM1c9AM5op4gyApK98ssV1I2ELTVC5QD1Xv/gsKCmZmQFJAQgpqoNvqV/OtYdqmQqKYDq9wbCgrDl/NzpRvrnkD2/wStWXUVSQbU3CFjRUgtAt9J82IrO3R8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707576908; c=relaxed/simple;
	bh=kwWtRq/cGgRKw8frGepAbUX5lO+pDYcwk9bCJla8AoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lu5Rex/gtDzYMx1GKCnrxU+OVB+60X26ovGcGMH15k6UruNnhaMrVc4YHlJVuP9zAVNKmkhMCEV8lhRMDUI5N2N3cgVuLmQrUHBP4ZtJLEzFGasPTYkYFyLnAu9U5X7iaawD9rOFBkf27NJ0IY2AyAem5TDPiyOcefvCFoudyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGNHP2X7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C24C433C7;
	Sat, 10 Feb 2024 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707576908;
	bh=kwWtRq/cGgRKw8frGepAbUX5lO+pDYcwk9bCJla8AoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jGNHP2X7HJ+7gwMiRuPPi28U7ZxDsDY35HYC+TmTroOtRChfmx4Qa4EcbsHZoP/aT
	 JGYxJISU8sVo0tLDdwzl80nBAsYpMf1YzV3/PbqTNxbS8VfSbKTqFIgzKHEOzv0vzh
	 z1832DjkBJCUli5aPywX9K5Pzdku8Z+8Imi/uAxqjWhYvd7bO4u1AuhuI4nA4YB12T
	 tDOHbWAc6zpvLDIH76BrlJRDL1BiBQiwV4I1WAszs25On1kAr988tDCBMyTz+RKNIh
	 RzXK7qAFSMPOdS+PTLk/1deXavMEMGzB1hdJl0bYMzuYpCemY4cifmybPAmzmxP5ql
	 AJbgf8Che0dGA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2331210F5260; Sat, 10 Feb 2024 15:55:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
In-Reply-To: <20240209184730.69589-1-nbd@nbd.name>
References: <20240209184730.69589-1-nbd@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 10 Feb 2024 15:55:05 +0100
Message-ID: <87plx4s71y.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> Excessive broadcast traffic with little competing unicast traffic can easily
> flood hardware queues, leading to throughput issues. Additionally, filling
> the hardware queues with too many packets breaks FQ for broadcast data.
> Fix this by enabling AQL for broadcast packets.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/cfg80211.h     |  1 +
>  net/mac80211/debugfs.c     | 19 +++++++++++++++----
>  net/mac80211/ieee80211_i.h |  2 ++
>  net/mac80211/main.c        |  1 +
>  net/mac80211/sta_info.c    | 21 ++++++++++-----------
>  net/mac80211/tx.c          | 14 +++++++-------
>  6 files changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index a499bd7e1def..2f280c629aea 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
>  /* The per TXQ device queue limit in airtime */
>  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
>  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000

How did you arrive at the 50 ms figure for the limit on broadcast
traffic? Seems like quite a lot? Did you experiment with different
values?

-Toke

