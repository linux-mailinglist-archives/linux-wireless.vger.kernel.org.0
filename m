Return-Path: <linux-wireless+bounces-7148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C00D8BADA9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 15:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A231F2273B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35FC153575;
	Fri,  3 May 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9U3vP8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C3848A
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742507; cv=none; b=RGx817stwodDzivdJMXC/40VazCt1B5IOUb5qOIKKwsW9ZN2hq6gM1d1acor+qy3xLf2wywFL0mFal1N5azATb4lsD9+rTdUlQi/Ttc9qBErbBTy/N373XLceptvI0loamSXDzmgnemhBeS3OqrodbUHQHIBNitmw7jiBOo/19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742507; c=relaxed/simple;
	bh=5A+4VMOE5esq7k/mQ4qGrJuFbSYMx+6xtBVixfCxXpQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=A1mHHpG9g78r5WVnKlRyDMbK+24kST1DZkHIAnTxzqs978NWrPTI91+GHWEcTc69/Y5LEmnRmesj2SECRL6sgpop2iDq559eLk2uG+Zpd7z136fBsgUV1Wdtn+GtwitZNyKtLtc66cIxktXYCdHM1JssggiQT3jrB6HRpZ2cD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9U3vP8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF62C116B1;
	Fri,  3 May 2024 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714742507;
	bh=5A+4VMOE5esq7k/mQ4qGrJuFbSYMx+6xtBVixfCxXpQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b9U3vP8rnYJmMMr22HRkOkyFw58eEwGkBktVRbQ+0pjktXhncwH6udbD5laFFKkIe
	 LHPRna5SQz6L4hUYWz11O+IOusZKDypumhS0pt4QRUA5l8X3ud8MfHFobK+9wnNVFo
	 9HFebtg57govGRzZhKu/akIu5WI7gFXKN3B1/yddJ93jIfP1Du+LNEZNKmhqae6Qrj
	 aangT19HnyTd+Ncge9R4Dj8OxyRf1GqH6MaeLHv+YqZ6qu+Pbnkx/mYHpFg3vfCQQs
	 3yBr0dxQ8DINkYNV8j1bREGMFHT9OrroXyMdvtnActXw5DCgxqUhxWa31khFzS6Xag
	 TrKDe6EJ1ZL0g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Don't drop tx_status in failure case
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240430074313.885807-2-quic_kathirve@quicinc.com>
References: <20240430074313.885807-2-quic_kathirve@quicinc.com>
To: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Sven Eckelmann <sven@narfation.org>,
 Sarika Sharma <quic_sarishar@quicinc.com>, Karthikeyan Kathirvel
	<quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171474250421.1512332.1102670293581552421.kvalo@kernel.org>
Date: Fri,  3 May 2024 13:21:45 +0000 (UTC)

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> When a station idles for a long time, hostapd will try to send
> a QoS Null frame to the station as "poll". NL80211_CMD_PROBE_CLIENT
> is used for this purpose.
> And the skb will be added to ack_status_frame - waiting for a
> completion via ieee80211_report_ack_skb().
> 
> But when the peer was already removed before the tx_complete arrives,
> the peer will be missing. And when using dev_kfree_skb_any (instead
> of going through mac80211), the entry will stay inside
> ack_status_frames thus not clean up related information in its
> internal data structures. This IDR will therefore run full after
> 8K request were generated for such clients.
> At this point, the access point will then just stall and not allow
> any new clients because idr_alloc() for ack_status_frame will fail.
> 
> ieee80211_free_txskb() on the other hand will (when required) call
> ieee80211_report_ack_skb() and make sure that (when required) remove
> the entry from the ack_status_frame and clean up related
> information in its internal data structures.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Link: https://lore.kernel.org/r/20230802-ath11k-ack_status_leak-v2-1-c0af729d6229@narfation.org
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

5453bbd6fef4 wifi: ath12k: Don't drop tx_status in failure case
50971dc6694c wifi: ath12k: drop failed transmitted frames from metric calculation.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240430074313.885807-2-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


