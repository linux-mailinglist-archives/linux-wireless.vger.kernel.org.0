Return-Path: <linux-wireless+bounces-9250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B150590F036
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 16:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C616E1C22DE6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46517BDC;
	Wed, 19 Jun 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ0QnPS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7817BAA
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806748; cv=none; b=HqkirA3e0911rhM2Gq25WQRTVGXDp69JSmvmW1CEE4HK8UYD3DCyWa3Q3N14DxMo+JKgC+E5DldfYiTNUelKJzLnNSvyAz4l1skdAHf9I3T4dIVXb3Gk9haybj8uBdAPNvPOMfHKCMT68xa+6RU9lCcyIVmhovCDQqZgJjl5Liw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806748; c=relaxed/simple;
	bh=vD2Up9i4qk6AnPoJeI+9alphwx6tMA2LrV03Bcepd7Q=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=WO9MDHI4THmeycbokIkVSWuFUyGT+DqHgD9bu1dcIkW5RYNQvtih1QrcsjUoo1CGbK1HVdKnHKfxstOry5QxiwY7GeHQypm0/22PW4AYLRxDcmfYsT+mlTwHfetFwxAXjMGsD1La/fkIyggqk03tLZDfut+rjxG0Gts5IK/4PnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ0QnPS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC18C2BBFC;
	Wed, 19 Jun 2024 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806748;
	bh=vD2Up9i4qk6AnPoJeI+9alphwx6tMA2LrV03Bcepd7Q=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WQ0QnPS6PVMHpdFGLVZJY5LYh5TOx3d8TfZji/owDGI4RGnb9d9NGV5XI1QLXJu6F
	 ARie9UFEquawApl9V8jZ4xL0D5YvWs0nz5WWW9HFgJGF2AFIlAnHlZHcuZV+9hOI29
	 fyZpTOlrYXCNjJ6PWrxjv0oYbe60jOf02FOxluZeh9s4kPj+wbrLtnhy3ncLo9kkRu
	 J/WQY98BqbYkMO6bxe5a91hsTEwh753wCoknA3c/MPkS0sVouTpqfT4E+bClTF6DAA
	 TmrKz0b5wt8NxvFv9QNeX2g0ypynHhifzwTZgJ4wB5QEahvoY9106GC9zZiRuWcxj/
	 LZPTL4tI+ZVOQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix firmware crash due to invalid peer nss
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240613053528.2541645-1-quic_ajithc@quicinc.com>
References: <20240613053528.2541645-1-quic_ajithc@quicinc.com>
To: Ajith C <quic_ajithc@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Ajith C <quic_ajithc@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171880674564.605247.6790441017714967286.kvalo@kernel.org>
Date: Wed, 19 Jun 2024 14:19:07 +0000 (UTC)

Ajith C <quic_ajithc@quicinc.com> wrote:

> Currently, if the access point receives an association
> request containing an Extended HE Capabilities Information
> Element with an invalid MCS-NSS, it triggers a firmware
> crash.
> 
> This issue arises when EHT-PHY capabilities shows support
> for a bandwidth and MCS-NSS set for that particular
> bandwidth is filled by zeros and due to this, driver obtains
> peer_nss as 0 and sending this value to firmware causes
> crash.
> 
> Address this issue by implementing a validation step for
> the peer_nss value before passing it to the firmware. If
> the value is greater than zero, proceed with forwarding
> it to the firmware. However, if the value is invalid,
> reject the association request to prevent potential
> firmware crashes.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

db163a463bb9 wifi: ath12k: fix firmware crash due to invalid peer nss

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240613053528.2541645-1-quic_ajithc@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


