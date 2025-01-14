Return-Path: <linux-wireless+bounces-17511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F673A11055
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B4D1889FF6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455B1FCFC5;
	Tue, 14 Jan 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPCValXz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A01FCCF2;
	Tue, 14 Jan 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879975; cv=none; b=a051KabkQmUCCn587HjofwM65NzVDptpriwiumXrrDK7RfbMLiNlygF77jq6lJXQzwL+0RIHIPxtMME+NGT/FifBqhX1ZmlpFaqlNfyrDxSabPqR9AkT3YQX8+L7UHcsWXAqmpUcfac2uKmxvB68KJ1nYj8LfRs/ViEL6QaQY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879975; c=relaxed/simple;
	bh=lFW8xhnm4FmFpEtoCShRybDMlrjwPRMLXP3eIbz4nHU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iqxUg8zTkDwhTN1kps2+vXyXiUSqOYcuZijOcX5iqFFUtTKSY0wRwOEegYLXyY2z5oBxNv+xEXgeDVTitI1aHB8XQzTeNMV7wKvYDKffem3ZxwPIql4ttW3+kZnP5WqAMuZ1b9bfL1AZzywZw50sOh+oQeA2yhP1oMDCeW+IB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPCValXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD54FC4CEDD;
	Tue, 14 Jan 2025 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879975;
	bh=lFW8xhnm4FmFpEtoCShRybDMlrjwPRMLXP3eIbz4nHU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iPCValXzCGVwJm2eLC4ZSqlRQZxyMFcM8avnXhNquiJYIPKbLPOEEsGbFNbOBdUxs
	 UhvpmFjHBlIaGtO5LWN+zrWSIxz0qy69Yb7ZQo3IdIPBC9lXto7AIkwMfmQ4//go9p
	 J4vjrLadgvfZZcLiJCK0+6dKoelN9wVNFeTkCQ0BopLJQ+5bd+EI+Yid9ohWBx4hZH
	 99OH+BagD5GOywq8WQttstwYYxUIC5/XrSb8fXpQP3UqKY0hU5HFjFYjFkOHBwuTUI
	 twVfuEnmW/sqLIZi2xPuxih2LBYkuvMV0F0AvrQpvDJUhqEe4sgWblkLwxH8RfGbLn
	 QgJ6sJbEIUVLA==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath12k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath12k: handle
 ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
	<20250110-fix_link_sta_bandwidth_update-v1-2-61b6f3ef2ea3@quicinc.com>
Date: Tue, 14 Jan 2025 20:39:32 +0200
In-Reply-To: <20250110-fix_link_sta_bandwidth_update-v1-2-61b6f3ef2ea3@quicinc.com>
	(Aditya Kumar Singh's message of "Fri, 10 Jan 2025 00:13:13 +0530")
Message-ID: <87v7uhnst7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> Currently ath12k_mac_ieee80211_sta_bw_to_wmi() handles the bandwidth from
> sta's deflink member. This works only for non-ML station. Now that MLO
> support is there, extend this function to use link sta instead of deflink.
>
> Additionally, in ath12k_mac_handle_link_sta_state(), the link sta structure
> is not accessible, making it difficult to fetch the bandwidth there.
> However, ath12k_mac_station_assoc() does reference the link sta structure.
> Therefore, move the initial assignment of the arsta bandwidth member to
> ath12k_mac_station_assoc().
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

So how does this help in practice? Ie. what are the user visible
symptoms this patch is fixing?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

