Return-Path: <linux-wireless+bounces-16497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01019F5732
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABAF7A3ABB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBA1990CD;
	Tue, 17 Dec 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcR3WQu6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6B42A9B
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464902; cv=none; b=WF3b8G/mh72W1hBtTyuPTENRlMx9pD7QNv2u2zQ3F5qjnIcCgX4ijQcfhcQ9Oqji6f4d1zrydm4WM/6sy3VpF+KmeAjnjtSTgxt1VV6V22W4G/ncWDgfBp1jsEQDvD29cTT7YbNH4t5xlOUnjLy9uXUT3vGSwTMkoGz1D8ILN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464902; c=relaxed/simple;
	bh=qPPXG721ckxWX7mEwf8d3wbkYKZ2GRX3q0EiH53PbJ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=f+zgec2+GgW8kih9jwU9Q+hGQnvHbfgXh8X+NsW+dcndWtvh2l60zsbzpT7LdZdeK1HyBXWG8A9EbPL+j2+t/7Ubix2VqXURDn90EyPiuXpgvPZV/53k6s4CZsE4RB5GZdeh/1/SkHS5t/0W49+SU3ewtOlRxZaMc1YKRj0hn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcR3WQu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F81C4CED3;
	Tue, 17 Dec 2024 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464901;
	bh=qPPXG721ckxWX7mEwf8d3wbkYKZ2GRX3q0EiH53PbJ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fcR3WQu65s/LbkHy5Dx6cZaCLlwo5z+mBJrdw6++kaS6gRklVZM+IS+KQrIMMhONC
	 aOahsMJLB0rJyYm8SAR3n0kQxQ3VsX/C8KwgSp+Y0lBUK1qZESwaPogJVKDBFmyOo5
	 270xmK4ph13qFY8xT3Il4oVugOoBULB9btNccgygiBsfz03iU0YjS/X7o2P13L4fsu
	 2tSa4ATQeVc7hq3PdlUPRY6oudErXjG4Zc0Vt4b2q/G4s9XQwgl7e9HZV3nUhuG0WY
	 8xeJx9y0Y6NzmNfF7SlYA0g5PIjg9aIDPPlBdI6WKEVelTebX9ZKh96pYCUIzrPD4A
	 9JBs73TROMNww==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 3/8] wifi: ath12k: cleanup Rx peer statistics structure
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-4-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:48:19 +0200
In-Reply-To: <20241217084511.2981515-4-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:06 +0530")
Message-ID: <87zfkujdks.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, unused fields are present in the Rx peer statistics
> structure. These fields are already present in the same structure
> under the ath12k_rx_peer_rate_stats container structure. Therefore,
> remove the unused fields from the Rx peer statistics structure.
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

