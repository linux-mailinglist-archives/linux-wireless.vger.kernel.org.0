Return-Path: <linux-wireless+bounces-16597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C89F7A7E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C03189474F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9BB223E8A;
	Thu, 19 Dec 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP7UiQw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC907222D5E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608288; cv=none; b=KhZGp0VdS34TIJAoy1vKLMoU7TX7j84EnjmS8FEAC6h9R1PYwjfP85ERsXz+Rf+Bx/CskWsKlUIzBtXvu/ojhSQoZp4T66aGJzft5vxTYRWhrK/sVr6cYM/+LlC3ibwT5Xk29UybSswaLgnRHeHyf3fA1PDsn2FcVxlhZntajM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608288; c=relaxed/simple;
	bh=bHtqNa7Yayi1Rw61Coo9r6kUdcmqvQVYD+XOu8+PiPk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bKIC/+ZzERUSWCiC77DrVbO3vQhEftBynRwmRaw/URa6P6RRdRBgRUE71xwRjsjPzKGPT9BSnHUMcLnMcpB5Shb74IIV/t8yp61Qvqs648icvMCWlqnl8e+jGrvdlUWv4Thp+de2+ZUs2vSgaFxqwNoRevzvrkaGwHkg0IBvT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP7UiQw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1036C4CECE;
	Thu, 19 Dec 2024 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608288;
	bh=bHtqNa7Yayi1Rw61Coo9r6kUdcmqvQVYD+XOu8+PiPk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=sP7UiQw+2ijkXugo23F6orIwxk423kMDY3pa6QCVRueu2HNLa8WDG+z9BWs8orvNh
	 WbnS2MWCtCygjSnHaydErqkaN4ONTaa6mR5fuwR+IPZNaS9rrVp64AjB3dMAuYBEbB
	 dp+Z83jQJUZKagFAwmVRAKdVuYByI6DaalFfO87Vk3kW4rIevGm3zp6IdpEfmRI4Co
	 S4KEER9CL89MTRjg1NP5idSag0WrSuE7rru9qrY8WiZ3K/sp5GctTCIy/X4fC7wdC5
	 3K2oOlxTgiWYMrF+y2aLxXjU6CWAyH9Pzwcf6+bfXygp/THHUi3wAve3MWpM/8VoRc
	 c2y3McESAsjeA==
From: Kalle Valo <kvalo@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: Include MLO memory in firmware coredump
 collection
References: <20241218040149.4041728-1-quic_rajkbhag@quicinc.com>
Date: Thu, 19 Dec 2024 13:38:05 +0200
In-Reply-To: <20241218040149.4041728-1-quic_rajkbhag@quicinc.com> (Raj Kumar
	Bhagat's message of "Wed, 18 Dec 2024 09:31:49 +0530")
Message-ID: <87jzbvj42q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> The current firmware coredump collection in ath12k does not include
> the MLO_GLOBAL_MEM_REGION_TYPE memory. This memory region is essential
> for debugging issues related to Multi-Link Operation (MLO).
>
> Hence, add support to include MLO_GLOBAL_MEM_REGION_TYPE memory in
> firmware coredump collection.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

