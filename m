Return-Path: <linux-wireless+bounces-16600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D89F7A97
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7E16CF1A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F5223E74;
	Thu, 19 Dec 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYjIJdQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484B223338
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608710; cv=none; b=rdbuvKMOOa092RIwlrbrXObyvtnAIiUS9ciIWtkblR7K5GqBJJoEJiMhV2dR3ANZqW6ab3Vl11U5Q9QsigG7ECfHP1ZNl4VAUmV8Yqxnolqooa2XuCzqBeNWfsX0HPKzuAHqUhPjwTDi3Z7d1xZfSSz7Yu0vgGl0cTneOV1AsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608710; c=relaxed/simple;
	bh=Fj25Garq+lXEMR3l0Ql+GQfTpwLe9QLa8x2yqoDpZQI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=a2edxH5w8XIJAXlroecGyh/VtgcMSn23bFIllRx5potug4i/x/10HE0xQCKZXUhFfVOhLTIyOVPD0+KuahrY2LHVGT7PfqdpL194+Q/BVOzpWOLdUxdizlO2hGMflyWpboh6SvU2HXXbgwszS69CI6BjzDJVsEl8xpb3/UDPjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYjIJdQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EBEC4CECE;
	Thu, 19 Dec 2024 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608710;
	bh=Fj25Garq+lXEMR3l0Ql+GQfTpwLe9QLa8x2yqoDpZQI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DYjIJdQiO5reW5RZtQrLS3aWOyHWeNaq/KBIc/xWixszYIFp79yeX5KnAJ5V97Rwu
	 /k0cmHLXIt+T9NSwF3BjP2jqgclTYmK2bvE8A3z0tr2vhFZobIa9LUS1tnx3FpEsRY
	 WY/pQI4atGA4cGFUdk/S1w5uVDzNRn+Qhgera3Zt+CnV5xZjHEiLKyPpR9ImetvcVU
	 HdaupOlzms7u387e4ro5RBDAE4XVHO+FNIswk0lzi4a7fXyrI35bobkQ1mlV+lyoN1
	 6CEy/TfMX5yDVnCBZUO3donrYEQIjg9+UL7DwQJzj02GH0Es/MUaTnGvcvl0MWtFuM
	 +tmq367LOE6uA==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH 2/6] wifi: ath12k: Support Latency Stats
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
	<20241217095216.1543923-3-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 13:45:07 +0200
In-Reply-To: <20241217095216.1543923-3-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 15:22:12 +0530")
Message-ID: <878qsbj3r0.fsf@kernel.org>
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
> Add support to request latency stats from firmware through HTT stats
> type 25. These stats give information about count of transmitted and
> received MAC Protocol Data Units(PDU) and Service Data Units(SDU)

I don't if this is a cultural difference (like adding two spaces after a
dot) but I'm used to having a space before open parenthesis.

> and other latency stats.
>
> Sample output:
> -------------
> echo 25 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_STATS_LATENCY_CTX_TLV:
> duration = 0
> tx_msdu_cnt = 0
> tx_mpdu_cnt = 0
> rx_msdu_cnt = 0
> rx_mpdu_cnt = 0
>
> HTT_STATS_LATENCY_PROF_TLV:
> Latency name = PROF_SCH_ENQ_TQM_CMDS
> count = 0
> minimum = 4294967295
> maximum = 0
> .....
>
> HTT_STATS_LATENCY_CNT_TLV:
> prof_enable_cnt = 39
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

