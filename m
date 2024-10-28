Return-Path: <linux-wireless+bounces-14584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D963B9B2892
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 08:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B34B21DFB
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10E416A956;
	Mon, 28 Oct 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzBAOw8W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDEF1E517
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099763; cv=none; b=SorQ/xb/klBoBMvuul2ezWGjNUo0UsuAveaUl0C8Ep5GWNO0O0DYOemUZBwafq4Ao8H/+nDCLJZ6kEYUDfMdFppzxcIc4rNin3ccmoYPVvmnyOBFlL16yE5wLw53aybgMjyZ9GbPCymxnlOz4Vf1ISRfhRahB5r7grIb3C9Ts0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099763; c=relaxed/simple;
	bh=YCRiX6rCWlGtVs+1+GRhTAz+TnHmt3RhD1bC9kdiZ8g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JvuAyr/ZL39uklwMc+e0vLHHXC0y7MRYvpMD39D9h21iBkk3fiV44gYMp71Eju7YoLKgya/MN5mXayynn9FwMWhdIJel2wwLXI/0GPeG9W32MCE11J+5zsOTzwqr1lplo+yUlBRQFar5LmtG7KAU0RYXpMDu/zCOypMUAw8lXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzBAOw8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C955C4CEC3;
	Mon, 28 Oct 2024 07:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730099763;
	bh=YCRiX6rCWlGtVs+1+GRhTAz+TnHmt3RhD1bC9kdiZ8g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PzBAOw8WZHWerVyYt1bO7dGJjZe/suu/11O5OGB8TI5y6vxe7tcofmj0uDfRs0mZK
	 wg9Tw2vQLfzRIBmJLOkdjRifY4D4k8f/q0VmvpFkmy5tcPL0CTVeme0ucaMOd1XAPV
	 Wpr1HAZ3/eDDI7ctj6bnaSDlBNLbgJpQcCbaNqy/z+6dsnBq13rFXUmQziPfjYgXo8
	 cRw0/CUDEmfAHqXsSFAHHFFsPyJLjvjp2jKoE47K2t//uF8ds88iOBQtECEG4mbEoT
	 59xxz0M+8E/csGlH12mGX6dzTgUsLBTSOYDkMjeWKTFsamuHqVurBdOmfbm2G4Slpj
	 hjQ7A99xwaiOg==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 03/11] wifi: ath12k: fix struct
 hal_rx_ppdu_end_user_stats
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
	<20241016065700.1090-4-quic_kangyang@quicinc.com>
	<875xplrgj5.fsf@kernel.org> <87sespq1pa.fsf@kernel.org>
	<a0a3c468-6f6a-4236-9b09-45534ac51c37@quicinc.com>
Date: Mon, 28 Oct 2024 09:16:00 +0200
In-Reply-To: <a0a3c468-6f6a-4236-9b09-45534ac51c37@quicinc.com> (Kang Yang's
	message of "Mon, 21 Oct 2024 17:32:08 +0800")
Message-ID: <87cyjk3dfz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> On 10/21/2024 4:50 PM, Kalle Valo wrote:
>> Kalle Valo <kvalo@kernel.org> writes:
>> 
>>> Kang Yang <quic_kangyang@quicinc.com> writes:
>>>
>>>> Current struct hal_rx_ppdu_end_user_stats in hal_rx.h is not matched
>>>> with hardware descriptor definition.
>>>>
>>>> So update this structure and related code.
>>>>
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>>
>>>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
>>>
>>> What about QCN9274? The commit message doesn't mention anything about
>>> that.
>> I have the same question for patches 3-6. Also I would like to
>> understand the backwards compatibility with older WCN7850 firmwares.
>
> For QCN9274, we reuse the same struct for them.
> WIN team already checked them during internal review.
>
> The struct definitions in patch 3-6 are hardware descriptor
> definition, won't be affected by firmware and host. They are fixed.

Please always include this information to the commit message so that we
know that you have done the research properly and the patch is not
breaking other hardware. ath12k is not only about WCN7850.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

