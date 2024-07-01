Return-Path: <linux-wireless+bounces-9788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4D91E80A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 20:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB05E282F7D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 18:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D0B16EC13;
	Mon,  1 Jul 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsXECD1/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E210F9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860280; cv=none; b=rAL1YUFra/A0A7iyGvrJ3SUp0BVSSElmdFSiqIjQsbuy6iNltlx4rkKkBDxDhReKm7cO3XU/efEqJc5Iwjw9aqc1y1kIAgF2379SMMuO/8liv3YxMyKclS8nZMImPiU247h6GnlYnPm2FhipFBEAszD41lIgDMfCVi6xm38ieB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860280; c=relaxed/simple;
	bh=a2zWdi8FyBy3/Glv695kZ8tMOoCrLOOvh2aga+UWQS4=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=i7uFU1vl4BDIwXMFRBJMBimmXjfS8A/cs3Xm58g++FinnCGghe8UK4y65JHqdT/WvJTGkvEVeVu4EPUGZkfWgiz+IrUhTg1YiBash/yYONhtM6GZYxTAqEEcTdgwdfdxT7yeYpLtvBlYzMJWYVgCtDvGf4l2UXnsLCBrYntNGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsXECD1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88312C116B1;
	Mon,  1 Jul 2024 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860279;
	bh=a2zWdi8FyBy3/Glv695kZ8tMOoCrLOOvh2aga+UWQS4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IsXECD1/PMtH6/6yl+fAdoamM7GAgkd0uEgYOk2EJhp5IQbbo0LuYfEmrYJjil5Xk
	 FMrC0zTtl8xDmvtKpZCUN3vi5u1C1NckpGB8W5QdnEk4Rx1UXw9Gviw1ZDbbWyjDRH
	 x4KfScOf2Ow5CyM7pfPB2vcHyRcfPTWB0XUKrwSnRr+9WFMPJm7ovH9RW605imFCkS
	 Q73oZPX3JUPB+pnACW0XlwRu+3T/PKS5RSrUQsvsvEYozJUt7pj2bK36G9O7lOQt88
	 GQv/k/rqBdTiAWnd8vY66rUsn8c2O7GMN2NINCgjYM7kGlXizS9rHBc/HmNPjkAlfP
	 LZrM8citm3jqA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: Support Transmit Scheduler stats
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240625042217.1303332-2-quic_rdevanat@quicinc.com>
References: <20240625042217.1303332-2-quic_rdevanat@quicinc.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Dinesh Karthikeyan
	<quic_dinek@quicinc.com>, Roopni Devanathan <quic_rdevanat@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171986027651.2958036.684437537530478512.kvalo@kernel.org>
Date: Mon,  1 Jul 2024 18:57:58 +0000 (UTC)

Roopni Devanathan <quic_rdevanat@quicinc.com> wrote:

> Add support to request transmission scheduler stats from firmware through
> HTT stats type 4. This stat gives information such as pdev stats
> scheduled per transmission queue, transmission queue command posted and
> reaped, scheduler order, scheduler ineligibility and supercycle triggers.
> 
> Sample output:
> -------------
> echo 4 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_STATS_TX_SCHED_CMN_TLV:
> mac_id = 0
> current_timestamp = 952546828
> 
> HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:
> mac_id = 0
> txq_id = 14
> sched_policy = 2
> .....
> 
> HTT_SCHED_TXQ_CMD_POSTED_TLV:
> sched_cmd_posted =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0
> 
> HTT_SCHED_TXQ_CMD_REAPED_TLV:
> sched_cmd_reaped =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0
> 
> HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV:
> sched_order_su =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0,
> 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0
> 
> HTT_SCHED_TXQ_SCHED_INELIGIBILITY:
> sched_ineligibility =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0,
> 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0, 17:0, 18:0, 19:0, 20:0, 21:0,
> 22:0, 23:0, 24:0, 25:0, 26:0, 27:0, 28:0, 29:0, 30:0, 31:0, 32:0, 33:0,
> 34:0, 35:0
> 
> HTT_SCHED_TXQ_SUPERCYCLE_TRIGGER:
> supercycle_triggers =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

4b6dfc758c2f wifi: ath12k: Support Transmit Scheduler stats
cf1187b3a683 wifi: ath12k: Support pdev error stats
5344fc76f894 wifi: ath12k: Support TQM stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240625042217.1303332-2-quic_rdevanat@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


