Return-Path: <linux-wireless+bounces-16595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA83B9F7A73
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5927A2AA4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEA2236E9;
	Thu, 19 Dec 2024 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptOe5SRB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345D221DB6
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608073; cv=none; b=LWwbbsvBHXRtetcuodS3VkPEwESUCUb+xr3xM2VwvILojaYFdBMCHNNari7Q/kF5JzpzjlhXs/frD6iKfCJoyr9CaOq7eaFFQJmrci8jksm7Ymbe+kWAOeyBZDsTUbexOQN3K86lKELVkfkxIvXwFrd0Hh6ZtL4RdtvNttu0Q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608073; c=relaxed/simple;
	bh=TiZNKQSPnucsT6sKEtG1JgreHsKZgBlc3aNLnD7FvqE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=d5IiRU8FHAWqoDWLJXPik42YcUHplyItRpSHBDqqsqUz/Ate2kA9jgtysFdlGuqLOY+h8sdyhu84dUvAxiAMF2wYgCq8Qr3OgmezeELMJ1sm2LIWOYcouNPcv4HuNdIk0s5GTcrnH7eSLpk0mTDQ3JSkxDCn20x7XfDVdegcP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptOe5SRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C42C4CECE;
	Thu, 19 Dec 2024 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608073;
	bh=TiZNKQSPnucsT6sKEtG1JgreHsKZgBlc3aNLnD7FvqE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ptOe5SRBS8NkamGgAbIUteaHHo50POZT++qNawJdsGWMB75lgGx5/raiDQZUQvnD+
	 680PI/cwCpEBTDyHyeFhf637CEreM6r2HxRUAZDxg6+C75Ir7Ge5cNPsT5UEEGg5UF
	 a6SMVfkdsQ78CQ65HoieLbZRFoI2r/Lr3bxyY92IAj9SgLUhImgM6tu5X2I6lrJ3SH
	 nfr2Y9F1i9b+kZdcSewpgLUL7D2UdIlVIWBWaNmMJTWPYa9i8Y1sLj1txfPmR0bi5g
	 E1N41Dp5aIq+K8YirifaeYweT7dvEkLO9tazLQitaw/BgAywmV6smFl22PWBvDsMVQ
	 ebfFNqjvAptaw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 3/3] wifi: ath12k: Refactor Rx status TLV parsing
 procedure argument
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
	<20241219001006.1036495-4-quic_periyasa@quicinc.com>
Date: Thu, 19 Dec 2024 13:34:30 +0200
In-Reply-To: <20241219001006.1036495-4-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 19 Dec 2024 05:40:06 +0530")
Message-ID: <87seqjj48p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, ath12k_dp_mon_rx_parse_status_tlv() takes the TLV tag, TLV data
> and TLV userid as separate arguments from the caller. These argument can
> be fetched from the TLV header itself. Therefore, pass the TLV header and
> retrieve the necessary fields from the header instead of passing them from
> the caller.

The commit message doesn't reply to "why?". Is there a clear benefit in
the future or are you just doing random code cleanup?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

