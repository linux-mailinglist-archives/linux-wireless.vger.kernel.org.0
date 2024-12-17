Return-Path: <linux-wireless+bounces-16496-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BC9F572B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982B4171750
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E39148850;
	Tue, 17 Dec 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wid4Bg8H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5342A9B
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464857; cv=none; b=rxQj4plrB+oBfzTqOuvOrip4xk+Q/SQYvknATU/pbWJbA5zKrCY4k8ZWfDhtCNu+EOh7lpSg4nLZQs9xDj/5D+WRRBdMK4BKEdoKMI2aelql+wKvai/du1GhDyaGUFe0URw5FUnFJpsWzh76iOl/czsiqOr1bWSs4Sb2UlYZuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464857; c=relaxed/simple;
	bh=qPPXG721ckxWX7mEwf8d3wbkYKZ2GRX3q0EiH53PbJ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jv9iFrZAZ2i4OHuNTZv4VHiS9OopgxRhmBvwu5V+k5+bd0OXwZzkfvEm6bQ4nH00n8dw6o/jVdu/Lm2P3Y3jk3ZWHPVA8UCUd+uVCJTo0MrAnyMOUth9ph7dWW+6ah25T7fJsQm7npi7Xdb3qZ5oUXhcEzNaoSBXA0rQsArXrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wid4Bg8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B71C4CED7;
	Tue, 17 Dec 2024 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464857;
	bh=qPPXG721ckxWX7mEwf8d3wbkYKZ2GRX3q0EiH53PbJ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Wid4Bg8H8Km0YwGC7G27quHTDgWpzHo3HUCM1ZR4eI5QLFsIZmRUQ7PJxUma0q0U+
	 9AQSCjFsotsBjcgwMI7Q2WhHD9FdhLrnrHgJarIPbiZMAh9PyeUKknLTjnVqNcllBT
	 N1ADdLbHQj2nTMMqIwJ3pfJFpm1JO/9Y2ELMtZeBZsP0wciKMAe2jTTin9X5VA1zHs
	 8eieWMh5521zZ6lLMFl7AWTqNdtc+OyfZgA/FIjUIed6r3kicnbB27KBF9wFnBQuc3
	 kMm/RpXULmoBabFueu7WkQaRKAa93LDIOPbqzjO+aW02P6y0wseF3XtAFFy4dGVqd5
	 029rOVJOPK59g==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 3/8] wifi: ath12k: cleanup Rx peer statistics structure
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-4-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:47:34 +0200
In-Reply-To: <20241217084511.2981515-4-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:06 +0530")
Message-ID: <874j32ks6h.fsf@kernel.org>
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

