Return-Path: <linux-wireless+bounces-9665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD8491ACDE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 18:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1593428B4A5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BC199EA4;
	Thu, 27 Jun 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgzWJScU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BC199EA8
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505879; cv=none; b=EuO2UNkQh8EBhkYC59T1h77cXatEGMcY/fVckG7KXWiCU+9SmZHcKoWCwCnenbalHifeWQmgFzcWOoYyKr37KkRSnFq31sM4xWxwip4t9BvQQc5MsL9lYPznmIj8cpd7IvR3PdgNl8sXhhHM3AvsfZtMHKIk5JfM5LtG+qqycMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505879; c=relaxed/simple;
	bh=PTfSZMp3jafutVyry1fb2Jx4NzvL0t1ODQaqXdP9FxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=l+YKy8UJZHdCgzQDnEXE+UINyJDKCH7G14t/vi/TzEs0CrBtHzwg0A/5j//pVYOo5na5KlIDfc4OZESKxQptapSrdssNG75awOsRaF9PNA2xs7j04+AnOZeq4oLPNHZmOhyukTVdF6XP3yeqex5dHWZAaVhU1HemMtGrjZMlmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgzWJScU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837A9C2BBFC;
	Thu, 27 Jun 2024 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505879;
	bh=PTfSZMp3jafutVyry1fb2Jx4NzvL0t1ODQaqXdP9FxE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZgzWJScU6J5Nd4VMrBLl3jgvPjnEw6WS6ajngOF56fz9euZndjdJed2BYLWxTSUyq
	 aCHKH7BHEAVVT0M2aOSSSb6cOvX1/TSsXPHqRlf5+huLpGT0UKm09mi96cdNCEQGw7
	 ypnMMYGW95sCWlH5W7Wpj8K9PwXAVNctv0DPRLp+Pwu281bxksOfDNL41kZwurqSsT
	 HKkhEvXVrTv1Eu9uCUoHPC9fh4cEwwxgRCEeUzBLzrxYZnXwEsfoHHqCTViw/I9F2R
	 eNCDfeL5+ySkh24Q6vvwigh+69NeiswDnorTJEskVaupYQMx3K4gDcIkR6fo/VOuEh
	 tHfqtYdI6KiEA==
From: Kalle Valo <kvalo@kernel.org>
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Rajat
 Soni <quic_rajson@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: Add WMI control path stats infra
References: <20240529180920.1472003-1-quic_rgnanase@quicinc.com>
	<8d3fc6d4-abcc-4551-9837-afe7dc482cbe@quicinc.com>
Date: Thu, 27 Jun 2024 19:31:16 +0300
In-Reply-To: <8d3fc6d4-abcc-4551-9837-afe7dc482cbe@quicinc.com> (Ramya
	Gnanasekar's message of "Thu, 27 Jun 2024 17:31:28 +0530")
Message-ID: <87ed8igxez.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramya Gnanasekar <quic_rgnanase@quicinc.com> writes:

> On 5/29/2024 11:39 PM, Ramya Gnanasekar wrote:
>> From: Rajat Soni <quic_rajson@quicinc.com>
>> 
>> Currently, firmware stats is requested by host through HTT interface.
>> Since HTT interface is already overloaded for data path stats,
>> leveraging control path to request other stats through WMI interface.
>> 
>> Add debugfs to request the stats and dump the stats forwarded by firmware.
>> 
>> ath12k
>> `-- pci-0000:06:00.0
>>     |-- mac0
>>         `-- wmi_ctrl_stats
>> 
>> This patch also adds support to request PDEV Tx stats, parse and dump
>> the data sent from firmware.
>> 
>> Usage:
>> echo <stats id> <action> > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
>> 
>> Sample:
>> echo 1 1 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
>> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/wmi_ctrl_stats
>> WMI_CTRL_PATH_PDEV_TX_STATS:
>> fw_tx_mgmt_subtype =  0:0, 1:2, 2:0, 3:0, 4:0, 5:37, 6:0, 7:0, 8:908, 9:0, 10:0, 11:18, 12:2, 13:3, 14:0, 15:0,
>> fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0,
>> scan_fail_dfs_violation_time_ms = 0
>> nol_chk_fail_last_chan_freq = 0
>> nol_chk_fail_time_stamp_ms = 0
>> tot_peer_create_cnt = 7
>> tot_peer_del_cnt = 7
>> tot_peer_del_resp_cnt = 7
>> vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
>> Co-developed-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
>> ---
>> Depends-On: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request for WCN7850
>> Link: https://lore.kernel.org/linux-wireless/20240510050806.514126-1-quic_rgnanase@quicinc.com

[removing over 600 lines unnecessary quotes]

> Please drop this patch. I'll send a re-based version

Dropped, thanks for letting us know. But please edit your quotes,
including the full patch in the reply makes the use of patchwork
practically unusable:

https://patchwork.kernel.org/project/linux-wireless/patch/20240529180920.1472003-1-quic_rgnanase@quicinc.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

