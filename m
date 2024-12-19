Return-Path: <linux-wireless+bounces-16598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDBD9F7A91
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B96B1884B68
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F15223E8A;
	Thu, 19 Dec 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4loX0/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96C223E88
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608473; cv=none; b=UFpSJS3M/Fp0TYwrGNJdw/TGe/AeHIJMUxLkf8RMuYQlxpGICCO06oVjWstbKteHy7xSopJIgSjS34/kZ+4LqHnlyPgvOuBmiPdbN6VtY+/BQf2qftW3Td8w2ZTxaF0x4Y2jDvz+7XX7db2zb4XY2Gmyg4uTpS+p3RPmsl6xvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608473; c=relaxed/simple;
	bh=D9IK9iJGvuIGe8Pgo91CSh72XhyjWrz511rNj93r3O8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NUJs62naKzljKKxhZr626JLRDYk61MJgSpiBAr2JNq2Z9ira8yZY8eVKronad0CwuclHxQv45eDbdhiv8e9UOhxCrL53qnfyplwwT5BMYzl+myhAvJ5xHoEtk+Xtuu3RDDoZf0GaNhfPA4GiLm+QcjG0Gp5/Wu2l9RSkVa5/jqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4loX0/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CEAC4CED0;
	Thu, 19 Dec 2024 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608473;
	bh=D9IK9iJGvuIGe8Pgo91CSh72XhyjWrz511rNj93r3O8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=o4loX0/otCQKPU9R4sB8fQZ3SZIDcKk+Xv5alICsFr8JO3ushrZnvGoKo8NRkMe8Y
	 KQQj8/xxZSFvVZJZyjrkFllmLIxCn4JQasKYvnBhHh2aqMnA7Aeym28JsYnOLc1Zd3
	 hnxLuHAMN3e9eqz4JCtIfG3wSpuO7++OQNi+TFrKUnnHQOj8IOmOdUI7+iA6MYT6vF
	 tMbCF8g6zKE2tj1Jtt7X88u7RzywZIjxpGbVRIqkS7Af9N7jetkfoSFSVZ+nmD0Vsc
	 phGb5gEPyeAUCpJQbN24di0kDETiEyhZawvQ4/hEFXdnXAe1DFZ+OxI+Wj+LsyuigC
	 82kP9km2hEpyA==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH 1/6] wifi: ath12k: Support Sounding Stats
References: <20241217095216.1543923-1-quic_rdevanat@quicinc.com>
	<20241217095216.1543923-2-quic_rdevanat@quicinc.com>
Date: Thu, 19 Dec 2024 13:41:10 +0200
In-Reply-To: <20241217095216.1543923-2-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 15:22:11 +0530")
Message-ID: <87frmjj3xl.fsf@kernel.org>
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
> Add support to request sounding stats from firmware through HTT stats
> type 22. These stats give sounding information of different Wi-Fi
> standards, channel vector upload status and correlation details.
>
> Sample output:
> -------------
> echo 22 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TX_AC_SOUNDING_STATS_TLV:
> ac_cbf_20 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
> ac_cbf_40 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
> .....
> Sounding User_0 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
> Sounding User_1 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
> .....
>
> HTT_TX_AX_SOUNDING_STATS_TLV:
> ax_cbf_20 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
> ax_cbf_40 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
> .....
> Sounding User_0 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
> Sounding User_1 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0
> .....
>
> HTT_TX_BE_SOUNDING_STATS_TLV:
> be_cbf_20 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
> be_cbf_40 = IBF: 0, SU_SIFS: 0, SU_RBO: 0, MU_SIFS: 0, MU_RBO: 0
> .....
> Sounding User_0 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0, 320MHz: 0
> Sounding User_1 = 20MHz: 0, 40MHz: 0, 80MHz: 0, 160MHz: 0, 320MHz: 0
> .....
>
> CV UPLOAD HANDLER STATS:
> cv_nc_mismatch_err = 0
> cv_fcs_err = 0
> cv_frag_idx_mismatch = 0
> cv_invalid_peer_id = 0
> .....
>
> CV QUERY STATS:
> cv_total_query = 0
> cv_total_pattern_query = 0
> cv_total_bw_query = 0
> cv_invalid_bw_coding = 0
> .....
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

