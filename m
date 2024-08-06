Return-Path: <linux-wireless+bounces-10999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EC8948A61
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 056F9B22122
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A8165EF6;
	Tue,  6 Aug 2024 07:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK+lr935"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E4161310
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930462; cv=none; b=B0UNEr3ND+qE/Vf1mP+XYRZsuCeazwruoTSxj0EB3TkIU5tCtPGrG+NPqgL1XsLuCeNikPN5jh62HRElGqr4nkgX3g0ZROjC/tunm28JRCvsC+wggoVeJ1fF9a1EiFudc2XHVyljJSXf6WMRV9GQYT4IvNm6znN2XCu94FAnQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930462; c=relaxed/simple;
	bh=1UbbIFrv0mSiqPTE1GE0Op9VJp8q3naA0OnSJVR7moY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=shnmo02kvhrgVNCk197qmo4M1jnJTlpFVDXeokwYf8UO1cN2Fq2OB2p7xou3+DIJZJAjcCwDIFzF09xHMsn+MQLXtofjk9HHF2gAG9B9CeyyaErsxsQY1DiR0aEUAOI3HLD2QX2kf5c0Tkha+wo56UE2Gj5o/wtaLruKZxQFJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK+lr935; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EC1C32786;
	Tue,  6 Aug 2024 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722930462;
	bh=1UbbIFrv0mSiqPTE1GE0Op9VJp8q3naA0OnSJVR7moY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BK+lr9354AvBISUEwphTDYVGIpSbPOz1Ux+by7a8qyHDDnGsgWB4Aox77Jh+OuhoQ
	 ASeWcKFprBZTAp/subGlK3Nb3nARr+XWp0Cck6BUGsibw3w5Vzkw5aJWN/VhJ9OK4S
	 dXRptJ/bjX1KQPJF36kQEN+/CPn2fLXpo6/KJb9f4QepJ2tbXnVHDf/2xrD0XDAWA9
	 e2HOfLzAdrjO8EExvh24rEaybpODu7bfULz6mJ4mEXReLHdS+r+pp2gI3gF+mmgcm/
	 UhK4LiI74YzDKFVV9tfZsfdO6KBnh+uxecRZg7VBHTm+4y99YW3gjS5zDN3hk9UM/O
	 d33AvQdA1qqgw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: ath11k: add tx delay to TSF
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1686636183-1026-1-git-send-email-quic_haric@quicinc.com>
References: <1686636183-1026-1-git-send-email-quic_haric@quicinc.com>
To: Hari Chandrakanthan <quic_haric@quicinc.com>
Cc: <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>,
 Hari Chandrakanthan <quic_haric@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172293045918.3540390.14108368692909594030.kvalo@kernel.org>
Date: Tue,  6 Aug 2024 07:47:41 +0000 (UTC)

Hari Chandrakanthan <quic_haric@quicinc.com> wrote:

> In ath11k AP, the TSF timestamp mod the beacon interval does not vary
> and is close to 0.
> It is expected to be around 384us for 2 GHz and  54us for 5 GHz/6 GHz.
> 
> The value of the TSF timer at TBTT is a multiple of the beacon interval,
> while the value of the TSF timestamp in the beacon accounts for medium access
> delay and physical implementation-specific delays through the PHY,
> which could cause the value of the TSF timestamp mod the beacon interval
> to vary.
> 
> An AP sending a beacon frame shall set the value of the beacon frame’s
> timestamp so that it equals the value of the STA’s TSF timer at the
> time that the data symbol containing the first bit of the timestamp
> is transmitted to the PHY plus the transmitting STA’s delays through
> its local PHY from the MAC-PHY interface to its interface with the WM.
> 
> In ath11k the physical implementation-specific delays were not accounted
> for TSF timer and it resulted in incorrent TSF timer values.
> 
> Add the physical implementation-specific delays in the TSF of beacon
> template and probe response, so that the TSF holds proper values in the
> beacon and probe response.
> 
> tx delay for 5 GHz/6 GHz:
> 20(lsig)+2(service)+32(6mbps, 24 bytes) = 54us + 2us(MAC/BB DELAY)
> tx delay for 2.4 GHz:
> 144 us (LPREAMBLE) + 48 (PLCP Header) + 192 (1Mbps, 24 bytes)
> = 384 us + 2us(MAC/BB DELAY)
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>

Dropping this, please rebase if still needed.

error: patch failed: drivers/net/wireless/ath/ath11k/core.h:365
error: drivers/net/wireless/ath/ath11k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/mac.c:1437
error: drivers/net/wireless/ath/ath11k/mac.c: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath11k/wmi.c:8627
error: drivers/net/wireless/ath/ath11k/wmi.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1686636183-1026-1-git-send-email-quic_haric@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


