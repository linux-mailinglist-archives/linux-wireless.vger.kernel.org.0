Return-Path: <linux-wireless+bounces-8057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0E8CEE3D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 10:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21A11F2186C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 May 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12617996;
	Sat, 25 May 2024 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmXL8+v1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF4314AB4
	for <linux-wireless@vger.kernel.org>; Sat, 25 May 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716627344; cv=none; b=PyVcyOq7gSD0DyPgySAOh9Mlt1qThmJGxsuLu9ILo9tIxZvWUCkU/8xOZgm30bMOjXJovaRBbe/dP7eBk6rphQw/K66DxtHUQFl9N3dyn7RbEX6KzPqoxKK0zvkzJbFe9TTlrR1ibHXxI/sDcXlqt4pcY1HJdfwD20FMFExR4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716627344; c=relaxed/simple;
	bh=vRlLiGVQLYkGHgihrU5LRwI/0w5cQxdSPkQgFhFx2y8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=iAhKldUGXCRfyv75bfUyb3Vl8AJxkzvQRKFMS/sJirIYTTscwYcf4E1nHrOQvTMH89hjvc6rcV7l8TxzMHFwGPbOZZCCxu0dw+KWjQZ0eAUpNlYMqwGOxepGBZ/Qy8uzC2CpnC9JtLokpSmM0oMA7wHbatQq+lsJAxmgSzx1dVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmXL8+v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981F7C3277B;
	Sat, 25 May 2024 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716627343;
	bh=vRlLiGVQLYkGHgihrU5LRwI/0w5cQxdSPkQgFhFx2y8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OmXL8+v1UpLuh1mxY5YBCvz0TAJuxjscoKET04bhyxnrQArPQ88Q42NlnppXgxcv0
	 P/Se8l/5ozWx32BQnh2qXcCQ+Pqm9c9JRIDNFFZ/RSANQwRJ+vbSO35GFzIJdQZy5o
	 7QGLZJ7dirfQTu9WQQ4AlaoLCX5/vgU3YeroxXpwdexyEztQWNyGY9vUFYz2H2yYh9
	 l9ErEsgkhscXrFnjCaS3fTjIIGqNIX/0DkJP58ck8gQhoWh+TaYdeAeXhuWcqmFWjk
	 JnB7K8ExttfyvBqR1nTqUwqEM0C6M6SGuwX1jOAnMGu5laE+NkC1S7LM3ZfRkARwy8
	 SWxyEwaK1MIrw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: refactor setting country code logic
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240520024148.5472-2-quic_bqiang@quicinc.com>
References: <20240520024148.5472-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171662734104.564311.15000751988973105599.kvalo@kernel.org>
Date: Sat, 25 May 2024 08:55:42 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> ath11k_wmi_send_set_current_country_cmd() is called in several places
> and all of them are just simply repeating the same logic.
> 
> Refactor to make code clean.
> 
> Compile tested only.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

b363614c0c80 wifi: ath11k: refactor setting country code logic
7f0343b7b871 wifi: ath11k: restore country code during resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240520024148.5472-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


