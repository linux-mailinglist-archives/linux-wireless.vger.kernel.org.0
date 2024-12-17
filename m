Return-Path: <linux-wireless+bounces-16500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814849F5743
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3570B1891005
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF61F7074;
	Tue, 17 Dec 2024 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZSF24PX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6D148850
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465263; cv=none; b=PtI0LmEqIG6GtrGM/i0Ef/VvWS9y6C2f8WEcu1FypYBPMyI8Ul3dcF7BrGLDS5pldBedwUAL87qo67URvpt9cnCUZbtwtGdTXmLOlk54ce5r3igQD4ynyFJ/W6UZ/ZM+NwStlxjwUvPCVRJKcm+mTJwJ1QbaOzqWyHGOq8Xq4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465263; c=relaxed/simple;
	bh=Ip8++RevUr73qmcoQSNejgVohU9ec7/h7Q+pmIpAEIs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J+XvkUdpIYRi1fSLaqFOnM5RIzJZMdnb8TzW9ZuWQFNsmCZwmeQDYrFF3jCUci5tH23nOLAfai1VPyl5MiYTi+n2KCDrYoi/vGuyWd3o0o2KRuPOhFOcOy1ArLczRdqt4HSOj8054fg4SmnOZhWly13SdlmWdz6iDahyDkfVe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZSF24PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A919CC4CED3;
	Tue, 17 Dec 2024 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734465262;
	bh=Ip8++RevUr73qmcoQSNejgVohU9ec7/h7Q+pmIpAEIs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=GZSF24PXxFvmcWdBWgte0+debZRIqZHF3PcJKVL5Fh5iaTF9bgfz+xdiPmWWIepGm
	 wweMgf2ZcfUKDWnRZnIk3cLxdBaJGLtaaucfkggpK6gCLjzHaos+PazKKJXMKI3QfM
	 5q2hrO6BYBQsooWND22B0NU8zqwK+ydddL6P/8mFZ2JGnRoQplAruwhGifX4w65c+o
	 3L5iINwIX3UvjnX5o87rpQ0b7pH2c9SjgigKC0Ile7VFkG94/VtJxrWBg3r65rlcxl
	 DQ2TcZSLTdksSj0T6jksSe6mFqDJLys8Rf6J35NyetiDZ1c5udIO5WicqX/jh+fv25
	 1hkHTtYlmDIDA==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 6/8] wifi: ath12k: Remove unused HAL Rx mask in DP
 monitor path
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-7-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:54:20 +0200
In-Reply-To: <20241217084511.2981515-7-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:09 +0530")
Message-ID: <87msgujdar.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, CODING and TXBF are unused masks defined in the HAL Rx monitor
> status TLV parsing code path. Therefore, remove the unused masks to
> prevent incorrect assumptions for code readers.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

