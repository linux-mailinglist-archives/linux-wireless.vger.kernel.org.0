Return-Path: <linux-wireless+bounces-5175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B588A4E7
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CD21C3C928
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A6D179670;
	Mon, 25 Mar 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEFjsp5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B92194C65
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363873; cv=none; b=SgulVJELMp7g7VZwEqTSccI49CdwSM8XQxnwgjHViYi8x39C9kbFrywIC5WuXLcjQ52X1UmZxF84h65TrRr58cKzXOFKOvDVzQQH8Ylif9h2hKFxlkr3bOV8xNNECTKTmol+hWKAZddn+i0IVbXxgTHAwbZiJfXOMavOw7JKH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363873; c=relaxed/simple;
	bh=ub1uXUj1mvQNs0RxF/UpntzWqZRVunwZNfbSwsOo7cw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=LhctMVgUHzsriafQQN0Kop+EASZSIeXT0tAd38g93vWrtYm72kCElX0O+BKi82aRrU7idPb32JM62YzF7QH99wnSK8fbjnkPSPBrCnlfmXXlhLQaBrKblXzvD1kqExdG3DKLZsGGdoCvpPEEZS9ZjjaX+4u96wkEcyudEFcLmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEFjsp5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F9AC433B2;
	Mon, 25 Mar 2024 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711363871;
	bh=ub1uXUj1mvQNs0RxF/UpntzWqZRVunwZNfbSwsOo7cw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=GEFjsp5x8s2fxcM0xlhHXv3kALmMYHHsmdcTjRkguow0Tn+dij8ITC2wu02L5QLZa
	 I8RD6JcmHtLmUZIMDj9AYObGz0XLz6VtU9AKzoUUBFwTvME458FwT7Dg7KJ9uL5h6A
	 EhifVzjpKOhk2VJNAiQOekatIQ/kh2vadEAPQ+vvNfS2pQhdzWqCOIHZ/WuImvhtsT
	 CjhYuIPHie94X5RIwg5CX6eiLLzE7hF2G9eTU0WUQAZiUtZzuZE/Y0TIq0bTlHd+4Y
	 zk/YOE6oUihByIgqsAzkyoi2X1Kj6fgwBO04EPZYUcOckIxrPJ5ydqD+JVWGKt+6od
	 1Yor7hUuDFqeg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath6kl: fix sparse warnings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240320182449.3757215-2-kvalo@kernel.org>
References: <20240320182449.3757215-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171136386920.1022746.1645704218279653373.kvalo@kernel.org>
Date: Mon, 25 Mar 2024 10:51:11 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Sparse warns:
> 
> drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17:    expected restricted __le16 x
> drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17:    got unsigned short [usertype]
> drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: warning: incorrect type in assignment (different base types)
> drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9:    expected restricted __le16 x
> drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9:    got unsigned short [usertype]
> 
> Use put_unaligned_le16() so that the value is converted to little endian before
> storing it to the header.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

ed769314f55c wifi: ath6kl: fix sparse warnings
fba52950e59d wifi: wcn36xx: buff_to_be(): fix sparse warnings
1eb2ac4a9f3f wifi: wcn36xx: main: fix sparse warnings
1f4672fd1648 wifi: wil6210: fix sparse warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240320182449.3757215-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


