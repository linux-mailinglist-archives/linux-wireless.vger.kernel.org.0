Return-Path: <linux-wireless+bounces-6006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AC89D87B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 13:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E079628806E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869D85C58;
	Tue,  9 Apr 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikt20URz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DE80629
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663254; cv=none; b=rykjMECB3aIu3elasUqWoDDILibnnFY8Tcxr1GWHKQz34TLF1cuKDD0w2SBcdDKLNjQPhwlciTjfjzc/KnH4hb1uJYdiln7ikDEOSzWmR9mjgGL/1h65FUUWVKn7TY0NeWHGrzx5FjMC1DvY8p90XUNUlPfALjJrHxcLfVydQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663254; c=relaxed/simple;
	bh=NmvLM1sOjZAvzKIwPzVoLWwGrDkjhXoEpGYTq24dtbc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Ly503B//M0aN4XGOYMQIfxMUMH9O6jH/CPPzBu6Hx33QCPmxK6i20vVMViadi1alefBdvCQwweicFsMn1oJNXHOPlI8cakq2vMdL81uQeukOh/0XHUHkHoFF592/8o+Nn3wuWQAoZZAhnOsT6C0KAJ+E4/Q4MYq0CBqkDIyxzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikt20URz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4694C433C7;
	Tue,  9 Apr 2024 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712663253;
	bh=NmvLM1sOjZAvzKIwPzVoLWwGrDkjhXoEpGYTq24dtbc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ikt20URzd2sHZawhvH3y3uczgDi/j/XjqzTp+Iq5TqJL8mZz0LV+VlmQ2HiR2Uqz4
	 4+h2VB4vAGSV1iJ+GsZixeqiRWDVtXLL0nVJ+SwKxwBClnkXb+cjTNmSu0XjzQvAhP
	 0Rhal7808mZMnxGLEUQlC+3+CbDw4IK5mq0VUp/seeA8We/o7IEdCkVPgGRscxg+gE
	 zwatwFlPGH4f1oi6MFkw52spbX1mZNQb4EMEKVL0YYewwvc+VEhFmIatRk9MRXBG4x
	 /3JsfzqSRtMBjtmgYMmsLrYVYDJfHxw6Xpg/6gQcNj71bmqXu4MV3RbJtPv6KfKjud
	 OszUSkBRFxNRQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: correct the capital word typo
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240405144524.1157122-1-quic_periyasa@quicinc.com>
References: <20240405144524.1157122-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171266325125.3197288.14300733414199687268.kvalo@kernel.org>
Date: Tue,  9 Apr 2024 11:47:32 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Rename the "ATH12k" word to "ATH12K" for consistent capitalization in the
> word.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

df1f2b947ffa wifi: ath12k: correct the capital word typo

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240405144524.1157122-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


