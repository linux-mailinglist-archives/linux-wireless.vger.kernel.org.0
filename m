Return-Path: <linux-wireless+bounces-4861-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3F087EF43
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 18:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C13F284405
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DD55C28;
	Mon, 18 Mar 2024 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzUcX5p+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8A55C07
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784487; cv=none; b=hhTeE9B6vedtW3xvb9/r9CBMLj19QJW3T3sHrWwJvQmX3lweJOwG1UA1ov3uMjHnFXnT3rrdzsdiDtX//YwZ1CGoHEiIYYJU4sWFPMl6CeaA0b5CGYtD8eotxUFcqGUV14Gl7/43FgAlMFdf10Hz33yJlagHYgd8A7PNbO3fBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784487; c=relaxed/simple;
	bh=qepjLFBOtzZoOmQQb1bfwPWOL137DOQO8cSoa8pFgnU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rgDzlB1dElE44J+Qz6xyVXYIpQwLi1iZmUfb2XAof5Ck1goRUlsw7AjB1XBqyzX79lXJbmebNkLlt5iuXfSZ2oxNGj6oRF/hsmrIYz9v12psU9hietK+a+Vr9leYYN9u3n0Hom+xfKi2dQP+kGgNAVAaezP1DhufTJhlTsZevog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzUcX5p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D987EC433F1;
	Mon, 18 Mar 2024 17:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710784486;
	bh=qepjLFBOtzZoOmQQb1bfwPWOL137DOQO8cSoa8pFgnU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nzUcX5p+/rvDh513vLqNqZ9WBbrRWIIE0qI/66bHS5ahGZh3X8bIgMaxlQnKJqhbj
	 IIC0G6QpTlbU8lIggbKq/jOUSmuWybnOZi//ScNw+q6Nk/83ecHLhRBvVfBTWRJ68z
	 lM8wkS5DxhilM6okT9EmH8L6JUF+SlTbA0KNcb1z8PgvsYmnyPymVFZsIXLlWiOf1l
	 egIeSEdp3FpP2mvQ1o70+muS2Vo4rlvjGJWjF5KQNiQzu5E8LJWZg81RY/se5WFrkT
	 bHhJ0HOkqsdqx0KowWN/MZI+JKf0VTgRblVWwphXGpHKDoa7rIdqpu3mJA32+4Xf02
	 m4Mb1DdimTR+g==
From: Kalle Valo <kvalo@kernel.org>
To: Aloka Dixit <quic_alokad@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: use correct flag field for 320 MHz
References: <20240314204651.11075-1-quic_alokad@quicinc.com>
	<87sf0nczca.fsf@kernel.org>
Date: Mon, 18 Mar 2024 19:54:43 +0200
In-Reply-To: <87sf0nczca.fsf@kernel.org> (Kalle Valo's message of "Mon, 18 Mar
	2024 17:51:49 +0200")
Message-ID: <878r2fctng.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Aloka Dixit <quic_alokad@quicinc.com> writes:
>
>> WMI_PEER_EXT_320MHZ (0x2) is defined as an extended flag, replace
>> peer_flags by peer_flags_ext while sending peer data.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: 6734cf9b4cc7 ("wifi: ath12k: peer assoc for 320 MHz")
>> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
>
> What does this fix from user's point of view? Does it mean that 320 MHz
> chanels were broken before and this commit fixes that? I can ammend the
> commit message.

And what about WCN7850? Does it work the same?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

