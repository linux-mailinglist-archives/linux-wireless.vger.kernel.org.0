Return-Path: <linux-wireless+bounces-16480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822269F4ECB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165341894304
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42261EBFE3;
	Tue, 17 Dec 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo+BQ0X0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA861F666B
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447668; cv=none; b=t7QORGaOyG5IgqllUpJLhlAfBfCo+XRqHOOTQJqghzsECb4bZTjpONKka/py2QCzPtZIyGIeVVblwVlOAPB6eWGCgVf608wFBb0qqRJiUqGFWzx+hZ0OBhAfEYCugRIpEXYF/W2FXcnN0lCg9UT0ei0OEAuvEDSsoWZ9WSijwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447668; c=relaxed/simple;
	bh=695XyT9HylzgQMl6LI188n8hrO1dbwChaw9J5Kqj0O0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=U+S5VT5RTgwlr2Rqh2RbxEs5K30hzD2LHKrUEpkh4kFCAt4D0z6tq7b5jwSZecgaNt69xn41UkWk9EOQ945kXVzyy6dMtFniYsKIFVCQ6ovpgOuYeanE4UzIEtvgQSToAN3eJTmaq4GP4vAePxSCDmGCSyS4IyvX6sP6eOOssv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo+BQ0X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75263C4CED3;
	Tue, 17 Dec 2024 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447668;
	bh=695XyT9HylzgQMl6LI188n8hrO1dbwChaw9J5Kqj0O0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Vo+BQ0X0J7VQWJA07OemM6PYOC1TZBr3PjDHYZVRW4xAeVyo8RmR8hc/aiASE0Y/N
	 FXZJQUOFMG01byk2MnFpx3cFXhkDivwLqwHmo+sNPjsRHfnpLM7poTjHJxkNMYjzQT
	 QxOvznGMetaEmelUxC0JDmKVpqYxDRulhgmlZg6Ba6c6xXEYxam4hJQfHa4X4dH5is
	 NBmICk9ECXCLdcZsTiSACL6IvB6mKNZeKg6nIb1LowpD0+XLcJ8r1IS0f6hXBihZUf
	 FavK0FG6vNPt6pl0S6MFLoKV2dKTyRTWODM97fNjc3tFBKOGlfxFBtkb6E+xZcz7N/
	 PgoMKQ9sB7O+A==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] wifi: ath12k: Support AST Entry Stats
References: <20241217055408.1293764-1-quic_rdevanat@quicinc.com>
	<20241217055408.1293764-2-quic_rdevanat@quicinc.com>
Date: Tue, 17 Dec 2024 17:01:05 +0200
In-Reply-To: <20241217055408.1293764-2-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 11:24:07 +0530")
Message-ID: <8734immk0e.fsf@kernel.org>
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

