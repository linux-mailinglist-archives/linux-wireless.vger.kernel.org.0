Return-Path: <linux-wireless+bounces-7733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7FE8C7299
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 10:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1B41F21373
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB94501A;
	Thu, 16 May 2024 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3FPZQZz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DC282EF
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847337; cv=none; b=oDBKt5kA87Y/G4E3/ItIyAwUuPl98IieXOVxpV80Fp8Z3vqPRDA9kSBh9vZEv/JvZDozDoA91zHrJldGk8x7+hh3+pLYgQAyPBlHzmGViiOi6AOcB39n/EB5ew9LKLlRGpnhEMwi+LNsPKJNIiVRyP184Sf6RTqpvEwPB5B2/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847337; c=relaxed/simple;
	bh=xDaNkHNQXzpDPw+YewmPEWMqT5K3zGQy05CkUwlt848=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ZbFAuj04KpiHvRPOsJ3ZXMwVmIsiMJjAHfjAi6Hr22RvnnSfYHI98zn8U/gB8AgRDNcTfJ7gx5Z7D1ypHlZsfV2eEo3dl1+GEXnBw6DTXU9TF9Q70SebIwVzcflaYyUR5GOgJS7yqXEmQ6fWIeC5DogQybeVXD8zPE2QvkSZeIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3FPZQZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C76DC113CC;
	Thu, 16 May 2024 08:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715847336;
	bh=xDaNkHNQXzpDPw+YewmPEWMqT5K3zGQy05CkUwlt848=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=i3FPZQZzY2ZfEsoxsomjTVPyzAKZ53Rhb0EhAKXeT6xFFmld1lJBcti9Mr4CKgImw
	 hbY+OsAXxEaUdaZDls27pqbVZHD0J50z1LBEoYW6L9rAwcwwVSy+eOsbwHH7Qqo5pC
	 4nC8vAePHmhBV34PfSLCeSdG6vgBgxlN1IgiD5G+FDl7ISrzlBxeHAX0jY/e0UnZaz
	 QNBwWsAxwbvDKE6t8tbZmrMVhyUqk+Q5PWkAvc/hVOd9g591SeqzQASlc427bFebKP
	 qr82FY6uGZnl8DyYFq8hpM4F8VuTHSuz5cdYS9pmg18TUg9WYAYhFGHtNOGOvjWBRl
	 9DyNQbKGyKwEg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] wifi: ath12k: advertise driver capabilities for
 MBSSID
 and EMA
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240508202912.11902-2-quic_alokad@quicinc.com>
References: <20240508202912.11902-2-quic_alokad@quicinc.com>
To: Aloka Dixit <quic_alokad@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aloka Dixit <quic_alokad@quicinc.com>, Jeff Johnson
	<quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171584733371.2755978.4141116655256699503.kvalo@kernel.org>
Date: Thu, 16 May 2024 08:15:35 +0000 (UTC)

Aloka Dixit <quic_alokad@quicinc.com> wrote:

> Advertise the driver support for multiple BSSID (MBSSID) and
> enhanced multi-BSSID advertisements (EMA) by setting extended
> capabilities.
> 
> Configure mbssid_max_interfaces and ema_max_profile_periodicity
> fields in structure wiphy which are used to advertise maximum number
> of interfaces and profile periodicity supported by the driver.
> 
> Add new WMI fields to configure maximum vdev count supported for
> MBSSID and profile periodicity in case of EMA.
> 
> Set WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET flag to allow
> firmware to track and update the DTIM counts for each nontransmitted
> profile.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

9 patches applied to ath-next branch of ath.git, thanks.

519a545cfee7 wifi: ath12k: advertise driver capabilities for MBSSID and EMA
ea68f1bba616 wifi: ath12k: configure MBSSID params in vdev create/start
5fbd97f25c4c wifi: ath12k: rename MBSSID fields in wmi_vdev_up_cmd
51c47463543e wifi: ath12k: create a structure for WMI vdev up parameters
84edf47bcb31 wifi: ath12k: configure MBSSID parameters in AP mode
9fd28936b641 wifi: ath12k: refactor arvif security parameter configuration
8c6faa56bfb2 wifi: ath12k: add MBSSID beacon support
f27fbd76a98f wifi: ath12k: add EMA beacon support
c740a18f62f5 wifi: ath12k: skip sending vdev down for channel switch

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240508202912.11902-2-quic_alokad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


