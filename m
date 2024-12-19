Return-Path: <linux-wireless+bounces-16607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ABB9F7C28
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A7A1677BF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694B53596F;
	Thu, 19 Dec 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur8tGVKW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C282111
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614335; cv=none; b=j+pJaepnBs/oUT/lZtGPovC6D3+PcDcYuHMrAUDvmT+D9x3KOAuOWU24BcQOe8rpG6gjdQtfT0RcpdMRbeDEyXvielhqrvOhLgH5TDOqvquLW02fBK8Qw19KGnr2O/gFaxSOKWAtnMv7wXiRKg7ntlFNYDXzIuuPLy25irQ4qSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614335; c=relaxed/simple;
	bh=9mvFxMcblzSvuF/BKCnA6aW0HtVE9ED6kWiGTSkVmEo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Zejlk4gt6dGv2GnXW9KN4W5xYBncUrSii8Ol2yHjxMJYZNInOSR8mp+WcDkALQmJLHB3aLXN+oKQcKViJMharQ3OgeX3UkmwmxiQxX0w8vE8zx5T/Yyp/7nHvA3rNL3svG1PDeu/sAFI4pI4SQMEDgac720mQIgHWEa118r5GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur8tGVKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD335C4CECE;
	Thu, 19 Dec 2024 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734614334;
	bh=9mvFxMcblzSvuF/BKCnA6aW0HtVE9ED6kWiGTSkVmEo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Ur8tGVKWsYsew9PyGu54EwdkgiKZR9b8rOcwVwlf9mDZKoF+mmFypwO9t5M8BN9pa
	 rEzr9QkHV/7dy0Skf17jfxWLaWsJUk7PdZJeZZ4ydlWpLh7apgYyiQLjh3H8D9r94o
	 uyqXpOZ4kTroGDdME3zJOLREwqaEzFbbYuIh5Swr5U19/DMCrlQ3P/dOUr5jPWdNnx
	 7kUeielzwxYm6JrytejDG06I3Cmqp8MWNasAuGa+8ZNjQsJRROc90M/AXghLBBgg3R
	 R52n16ka0m+F9pCrAzHgDg/71alrwDWRQ6zZGZklBsYhS8NIzVgc+NU7HHEiLcKVzO
	 svqol3rYifIzQ==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH 5/6] wifi: ath12k: Support Uplink MUMIMO Trigger Stats
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
	<20241217095216.1543923-6-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 15:18:51 +0200
In-Reply-To: <20241217095216.1543923-6-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 15:22:15 +0530")
Message-ID: <87v7vfhkuc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>
> Add support to request uplink MUMIMO trigger stats from firmware
> through HTT stats type 27. These stats give information about
> bandwidth, RSSI of signal received, dB mean of pilots received,
> etc., of all users.
>
> Note: MCC firmware version WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> does not support tags HTT_STATS_RX_PDEV_UL_TRIG_STATS_TAG(94) and
> HTT_STATS_RX_PDEV_UL_OFDMA_USER_STATS_TAG(95), currently.
>
> Sample output:
> -------------
> echo 27 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_RX_PDEV_UL_MUMIMO_TRIG_STATS_TLV:
> mac_id = 0
> rx_11ax_ul_mumimo = 0
> ul_mumimo_rx_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_mumimo_rx_gi_0 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> ul_mumimo_rx_gi_1 =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> .....
> ul_mumimo_rx_nss =  1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0
> ul_mumimo_rx_bw =  0:0, 1:0, 2:0, 3:0
> half_ul_mumimo_rx_bw =  0:0, 1:0, 2:0, 3:0
> quarter_ul_mumimo_rx_bw =  0:0, 1:0, 2:0, 3:0
> ul_mumimo_rx_stbc = 0
> ul_mumimo_rx_ldpc = 0
> rx_ul_mumimo_rssi_in_dbm: chain0  =  0:6, 1:0, 2:0, 3:0
> rx_ul_mumimo_rssi_in_dbm: chain1  =  0:0, 1:0, 2:0, 3:0
> .....
> rx_ul_mumimo_target_rssi: user_0  =  0:-128, 1:-128, 2:-128, 3:-128
> rx_ul_mumimo_target_rssi: user_1  =  0:-128, 1:-128, 2:-128, 3:-128
> .....
> rx_ul_mumimo_fd_rssi: user_0  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ul_mumimo_fd_rssi: user_1  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> .....
> rx_ulmumimo_pilot_evm_db_mean: user_0  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> rx_ulmumimo_pilot_evm_db_mean: user_1  =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> .....
> ul_mumimo_basic_trigger_rx_qos_null_only = 0
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

