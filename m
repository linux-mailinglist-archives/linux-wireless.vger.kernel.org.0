Return-Path: <linux-wireless+bounces-16609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0CE9F7C31
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8098188F7C6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8D39FCE;
	Thu, 19 Dec 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlmTkVIG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18F7494
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614674; cv=none; b=CPDR6+W1isL86Zrjf+HZzYVRQq4G3M2F8411TP6AjPlhiG0xbcMJuClJMFKUYs/jo/e4/W0wLIYiawGgnCcKzYP76xxTXWl1iYiO42WMJ3JSTT4tBsOATezdEd4WwTwrI6EVYvWk+yAbyXwpTfsvt/M5PDT+KZ2plpAqjYz0NYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614674; c=relaxed/simple;
	bh=695XyT9HylzgQMl6LI188n8hrO1dbwChaw9J5Kqj0O0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lQ42UKgUzW2MgRbJnnIqsNpglO0xan5MAxgilBuXDFu3hk/3X1eqkKJOQjT/qt8ecw6rtcEAy/F5eBO5YPLIOllywwEk10lTPJh2SH9X2nNalvoJiZcCrEZQa1DyrMCpOEGREVvz/m0jvmz283GHKfiINU7zh1BsS8+TmYE0CZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlmTkVIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C65C4CECE;
	Thu, 19 Dec 2024 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734614674;
	bh=695XyT9HylzgQMl6LI188n8hrO1dbwChaw9J5Kqj0O0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AlmTkVIGJZETCPhFWfBn+VwQ0mb7Sc0/7p3cJH1rL8OJS7NDzMuV9pRtUmaSvqS8G
	 621Nnttui8+7IR6PD6uOZDCcMNLHDQ/NYZtwVRAIRS6GRROQcIcOvSOcntbRwnVwqY
	 PnZASxL7tnv2cQvONI2kEMCFbHzhldT11m6QEL1Ho5r3zsEuspExpNArQF17dWLOKI
	 Lo6x7MPSpX1kIUTBPAKuxls5v8CI0mHj5JdZbh6VMb4WFDulrSDy167LNer8ftoFyu
	 syhF2gGR7k4IyBRgutAt2Ku8UveQOnaE7r81uBnli62Hx9l8PAFCnJDgDuzKkbmc69
	 8zIW406jbnyOw==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] wifi: ath12k: Support AST Entry Stats
References: <20241218035711.2573584-1-quic_rdevanat@quicinc.com>
	<20241218035711.2573584-2-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 15:24:31 +0200
In-Reply-To: <20241218035711.2573584-2-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Wed, 18 Dec 2024 09:27:10 +0530")
Message-ID: <87msgrhkkw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> Add support to request Address Search Table(AST) entries stats
> from firmware through HTT stats type 41. These stats give AST entries
> related information such as software peer id, MAC address, pdev id,
> vdev, id, next hop, etc.
>
> Sample output:
> -------------
> echo 41 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_AST_ENTRY_TLV:
> ast_index = 10
> mac_addr = 00:00:00:01:00:00
> sw_peer_id = 0
> pdev_id = 3
> vdev_id = 255
> next_hop = 0
> mcast = 0
> monitor_direct = 0
> mesh_sta = 0
> mec = 0
> intra_bss = 0
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

