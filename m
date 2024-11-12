Return-Path: <linux-wireless+bounces-15197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1E9C530E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 11:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92058B2BCCB
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8D2123DC;
	Tue, 12 Nov 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLyO475+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6220EA32
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406352; cv=none; b=uWJpddkQ6C1GXn73yjdFEm1v7foc7tR+mOJlwlZFLV+Vx4De7UHcQUjxoAGfpLLNCRDQUh5EYL3iDlnCJSWdGmEgbUJHUfIt6rEmVikB70e1e6FVhFAA/d3Dn0mz2OLxnvua2x/QsSDL9hxOZt24rxzxU7kPTm6wZsWTscgbcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406352; c=relaxed/simple;
	bh=Fd1Ey/xvSs8MLl8eDHlLf2EcdKORJxcgeuDQKWpdshs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=G9Pe2WsSzp78WDVdRppQ1dLLODcxIgnRR5Mx5tFO7QHACfo1DPJR5cmm9heqHIixk96cdrPoW+cbhqxoTBJBw+TtajO2WskoARJEmtp3gkTvJOCVG0btGPi0p+k4k0nWNcnESxVZeJQv32JnTDCccWH7Q5Ha0DTRj1akwJdoJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLyO475+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C4BC4CED4;
	Tue, 12 Nov 2024 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406352;
	bh=Fd1Ey/xvSs8MLl8eDHlLf2EcdKORJxcgeuDQKWpdshs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KLyO475+MkOHS+QlXJIWcWJpS4vYGlVV8YgR7JhXtnDzGDVBpfNj/irerqLU9RCEz
	 AvJBvQNOBhwotDtAgqCURQaEL14o9Q6aFAOzO8ss+u8Lf7n4UFjnyAXaWy3noCp+HV
	 +nQ7piFPsmtzCwAOSP5EqmOwCmqgwSAipfo3StVUYfzvcrNMRHF/v1ffPPmB5nUrsv
	 oxvpt8rDWFHTxEXz/dfJCQ6GGvr5mrLNEXW9Ia5HBWFuZCKxKUO9B91Dew4sVwWRcU
	 XNaAyw49DXhnkUtskuZ3jaakFlK+ZBLmE5TNc4jGrNYh5vMqdYSp8xeV2xyFYeYCYe
	 a5EvT/KUQzlzQ==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Sidhanta Sahu <quic_sidhanta@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: Support MBSSID Control Frame Stats
References: <20241105052854.2118987-1-quic_rdevanat@quicinc.com>
Date: Tue, 12 Nov 2024 12:12:29 +0200
In-Reply-To: <20241105052854.2118987-1-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 5 Nov 2024 10:58:54 +0530")
Message-ID: <87jzd8wyk2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
>
> Add support to request MBSSID control frame stats from firmware
> through HTT stats type 54. These stats give information such as
> basic trigger, BSR trigger, multi-user RTS and uplink MUMIMO
> trigger within and across various BSS.
>
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support HTT stats type 54.
>
> Sample output:
> -------------
> echo 54 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_MBSSID_CTRL_FRAME_STATS_TLV:
> mac_id = 0
> basic_trigger_across_bss = 0
> basic_trigger_within_bss = 0
> bsr_trigger_across_bss = 0
> bsr_trigger_within_bss = 0
> mu_rts_across_bss = 0
> mu_rts_within_bss = 0
> ul_mumimo_trigger_across_bss = 0
> ul_mumimo_trigger_within_bss = 0
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

