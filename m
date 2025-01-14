Return-Path: <linux-wireless+bounces-17506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41448A1102B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD123A268E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B091C5F05;
	Tue, 14 Jan 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdwrLncP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C71C1AAA
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879566; cv=none; b=szduAwab4ZxQEJzKPqNugO6zcD1fTh3CuPUAbJMbWb5YkqPVvB3pv2SVZs4Zm4bPz5dX7tF19IIG8Au9ue/Le4Y/7wqVRsP6SrSIkIBHHDQ7ZrO0vytjUNQ/02Q9Yxt2dgZ2HxHs1UNLZp7ONS7LZVBOUokUTbaLzSc7jjpTlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879566; c=relaxed/simple;
	bh=23gDuo/pDGl97jIU8J84fFgtWGyHxomgLeWhUr+NDDk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dtEvJUIiNzL7eGkKqskHbuBcEcVYtHEhqGasqhs1+Mo0WFRY4oulcWPqKg/tJjnueclmg7aP/o3ZEPffZfolzAGCey5xZoGY7a54ShYEo+dTDA5cGW47aHeLeQhD+7AE3iRxwehXezA7W95CRzgg2aI2lNE/RTx6qL4id/Y9Ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdwrLncP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D885DC4CEDD;
	Tue, 14 Jan 2025 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879565;
	bh=23gDuo/pDGl97jIU8J84fFgtWGyHxomgLeWhUr+NDDk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DdwrLncPLo0GuRLTGYyWUjEBDtLpuidsm5/YruvOZZioSqFcdcRCVy0MHnmiO7F0F
	 GRQld23BAMJSbFqoj5oe0PtV3yICOqmm3QkYoYV/GXzt5HGhw+Ko7wiNJKlk+4PNS2
	 Q/eY7zVb8ElxNsGUXKv4BtrnfIirg9wM5GoWOvveM1DndnQPTJd1ERVcs0oy39S55/
	 +0CiphYAqyOJ4G1FQOpSMV9ziir7H5/GImIBXnA8vXEQbc6BnvkCORNin+QwFrJd5o
	 BjwGaMpd19jhQ+lFMdgQEiMHHHILOzu+rzTr0YGbtzledAnpzK+xEvjSU+J/3Qo5wY
	 MzJcBSokRSz3g==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 4/4] wifi: ath12k: Fix uninitialized variable access
 in ath12k_mac_allocate() function
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
	<20250112071630.4059410-5-quic_periyasa@quicinc.com>
Date: Tue, 14 Jan 2025 20:32:43 +0200
In-Reply-To: <20250112071630.4059410-5-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Sun, 12 Jan 2025 12:46:30 +0530")
Message-ID: <878qrdp7p0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the uninitialized variable 'ab' is accessed in the
> ath12k_mac_allocate() function. Initialize 'ab' with the first radio device
> present in the hardware abstraction handle (ah). Additionally, move the
> default setting procedure from the pdev mapping iteration to the total
> radio calculating iteration for better code readability. Perform the
> maximum radio validation check for total_radio to ensure that both num_hw
> and radio_per_hw are validated indirectly, as these variables are derived
> from total_radio. This also fixes the below Smatch static checker warning.
>
> Smatch warning:
> ath12k_mac_allocate() error: uninitialized symbol 'ab'
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Fixes: a343d97f27f5 ("wifi: ath12k: move struct ath12k_hw from per device to group")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

