Return-Path: <linux-wireless+bounces-3127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F44849E59
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 16:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8CD28A9C9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9EF2D042;
	Mon,  5 Feb 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ6H9gv5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BBE2D050
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147208; cv=none; b=VLbHi1R/tsHJpkvtz+Mzt4lc602swe5PJs8oQ+Ex1obmv8agvou2/oKWEjG9hyCaiB4XPJ09lr+HJQydVLuT18BgR6/6cgQeiqn/sz0I0DOdHCCZ7AD+GRWMw7OLvU0qdovVmen2288UXIJ9nBtjEyo7oB0jqp3FNWKVTeAAe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147208; c=relaxed/simple;
	bh=6iTFrvJAlXrTQK6rSTcfoffNSGiD1ihYuYHfELRZ3H0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WmB1UhnbjP/TKNWtvPiZKMDmmptUP48ROK8Zbu6D+3WjrnwErmUB9BkYerw22y7BpXylhG4mZYWsSr4QvPmeZSgrjCCrLvg6S7o6WBYMWFfBbFA0CW5HUwgqmKtYnRvdF3v1zAIDzlRUKBzIENQQa/yzzivaHiV2meGfpP0BfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ6H9gv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80476C433F1;
	Mon,  5 Feb 2024 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707147207;
	bh=6iTFrvJAlXrTQK6rSTcfoffNSGiD1ihYuYHfELRZ3H0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YJ6H9gv5XVWGRXRfH/CwMgxmQCGECuj8tXdLp2Sg82MBAL9uKTuWVKbHoxTiXQQA9
	 TU3ZYkoyzjudyl+t/Loo0/Sv9gHFhQzFD+TwfsFHBU15mVUWeXbNnpn0/BqG3KTkiD
	 RkzKAoKiqbBDld6uj9q9ujZQeYIos2BkOuBD/hZEr+8eezElLBhCgro58+/01MOSbM
	 wpIkNhKdYufJFxo26mkd3CbQNZKzA2wsEgSaeI+dTzXiFE+CFoFcFey0IJnBgG3kAh
	 H3F2iHZnyVUNUeak72J/uuiXASJaehW4BMdhSIjf7T1p7z9jbaO4zE89RMmzc+08H3
	 lAXb5kakT5Gng==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kang Yang <quic_kangyang@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 02/11] wifi: ath12k: fix incorrect logic of
 calculating vdev_stats_id
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-3-quic_kangyang@quicinc.com>
	<ebd1b476-7de7-4cd2-96b0-ae4965348ccb@quicinc.com>
Date: Mon, 05 Feb 2024 17:33:24 +0200
In-Reply-To: <ebd1b476-7de7-4cd2-96b0-ae4965348ccb@quicinc.com> (Jeff
	Johnson's message of "Tue, 30 Jan 2024 08:51:06 -0800")
Message-ID: <87sf27rkmz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/29/2024 8:02 PM, Kang Yang wrote:
>> During calculate vdev_stats_id, will compare vdev_stats_id with
>> ATH12K_INVAL_VDEV_STATS_ID by '<='. If vdev_stats_id is relatively
>> small, then assign ATH12K_INVAL_VDEV_STATS_ID to vdev_stats_id.
>> 
>> This logic is incorrect. Firstly, should use '>=' instead of '<=' to
>> check if this u8 variable exceeds the max valid range.
>> 
>> Secondly, should use the maximum value as comparison value.
>> 
>> Correct comparison symbols and use the maximum value
>> ATH12K_MAX_VDEV_STATS_ID for comparison.
>> 
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> should be blank line between unofficial Tested-on tag and official Fixes tag
>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
>> 
> And no blank line here since all the official tags should be together
>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>
> Kalle can fix the above when he moves into the pending branch

Yes, fixed those now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

