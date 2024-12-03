Return-Path: <linux-wireless+bounces-15839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD69E0F7B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 01:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3535B21DE1
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1B646;
	Tue,  3 Dec 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRgH8+go"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE0645
	for <linux-wireless@vger.kernel.org>; Tue,  3 Dec 2024 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184273; cv=none; b=b16DMvcCmpRb9pXpb7XKKoNHdY06FFT1jvVS4Upss1vKVDibQ1lCPblujK1YFETbuGlrDm+NtLDQgwOAz5pI98lzk2IvUbYgYEOB1qxebjY25fPJptl+UvOd8YF+CupjJCp9aM9r448OooEbvAqfQtLrxPeyHwj6lGxprui+bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184273; c=relaxed/simple;
	bh=hw6FnVa5vFrqLftPuCTEe23nXWJG217ueihs4BGmRv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2xvlGmog4cIqEV/L3ZNFckUV1reOnPTOGo70WdTM/exxW2islaH+oWEwMgA1sKgb27Wj5NRdZcGQkvd20bkuInLyunw6CQ1Zd5V6li/Sn2soWC6NI9usQSrtn8gr34KCxwKGZ3kWgmQz6BAL1hSo0XlPTOjTepXuzHGaFEBmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRgH8+go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE70C4CED2;
	Tue,  3 Dec 2024 00:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733184272;
	bh=hw6FnVa5vFrqLftPuCTEe23nXWJG217ueihs4BGmRv4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MRgH8+goTM3SRnmzY0aYWZ1iI2+RpvEzFrvnJHwmPzaBrbnHRN2RSJCttObH5KUtt
	 2pIL0kyCBzrZ/etSdQS1dKd/NCKFLMMeb9ntB73EbnfXBVROQQ7vjcLZKcinC6BYsH
	 ZAn8l/Vm48zv0YzeSAOxbvOng9Gp8JOsmpNVi0GH5GMdMZrOJ2qTRopuq8FYOiQkPN
	 qlTNOIeohlw8gpgjfVU0dzzSwXMPOmPTC7XTpBCabNu2CyfYcwOf2/0ePdn61O5eZa
	 5TGijgfH0oEqGSsvXJLWWG8dAw+oXju78rA9eTAcwhntQZ340qbXXSsaY/XcNHs5q9
	 N+yPUdSh9HVnA==
Message-ID: <c3641fa9-b016-465c-ad16-bd7d952b090e@kernel.org>
Date: Mon, 2 Dec 2024 16:04:31 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Support Transmit Rate Buffer Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
 Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
 <20241128110949.3672364-2-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jjohnson@kernel.org>
Content-Language: en-US
In-Reply-To: <20241128110949.3672364-2-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/2024 3:09 AM, Roopni Devanathan wrote:
> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> 
> Add support to request transmit rate buffer stats from firmware through
> HTT stats type 31. These stats give information such as MCS, NSS and
> bandwidth of transmit and input buffer.
> 
> Sample output:
> -------------
> echo 31 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_STATS_PDEV_TX_RATE_TXBF_STATS:
> Legacy OFDM Rates: 6 Mbps: 0, 9 Mbps: 0, 12 Mbps: 0, 18 Mbps: 0
> 24 Mbps: 0, 36 Mbps: 0, 48 Mbps: 0, 54 Mbps: 0
> tx_ol_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> tx_ibf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> tx_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> tx_ol_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> tx_ibf_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> tx_txbf_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> half_tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> quarter_tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> half_tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> quarter_tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> half_tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> quarter_tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> 
> HTT_STATS_PDEV_TXBF_FLAG_RETURN_STATS:
> TXBF_reason_code_stats: 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Jeff Johnson <jjohnson@kernel.org>

