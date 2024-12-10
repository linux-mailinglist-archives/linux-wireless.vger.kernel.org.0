Return-Path: <linux-wireless+bounces-16151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDB9EAA96
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 09:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352A2168B07
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299022F3BB;
	Tue, 10 Dec 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkoix8vf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD921230982
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819162; cv=none; b=i9fMq3Y8xg3wX9aH7/RVpyL2JmsTBRJqAJGYAJCKuMvN154NFpnCqYtlgQMTsTor9wMTzDQYqfyMXobjE5EO2U2I7MPino74mINB+YZn5dJo5yv9YAW9YWwCkpTgjrY4WmdY3YLTW5KVKwzycurhwxgeVw2EeQmnJ2cidgzwID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819162; c=relaxed/simple;
	bh=wIslMXPf6g6d6drxaf+NhnS5S/15I4YZ2uGx61UaOyM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=AADQamdeeiyml3FocFNe1Rt4xt9L2TL5XMYUvVHhLPVve/Izr5FfTaqiQ8VOKVigoyMEN3DOaQvgEYR+Bb+Ib38UGtyZM0zkMRvD5l3WGLuDD144j9oceUgVdO2teKPyyn3mF4/vI2rGo0aSvLq1fxVeJi6irzf9UxsQnTaWNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkoix8vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94777C4CED6;
	Tue, 10 Dec 2024 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733819162;
	bh=wIslMXPf6g6d6drxaf+NhnS5S/15I4YZ2uGx61UaOyM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Gkoix8vfFtKCnxxtliBLiMt1zyycM7MPba/MdcBuSU47JgrbFPUFQq68W+2zwR6vh
	 E7C7Z7/bPI9EzaxSZiP9w63MUV7yxlJfVZgaF5w9z4B8N+msJyKSK0ZcgM/hPnna7H
	 HPtIEutPr5PojwlOojNqJGI4ge/8cVFbWxFZxqm/WAn5BDUwjg7EcAAs1H0JM+puo5
	 L/hjTi1UwP7xku1OttU8M6SUHP+qlXNTwKezFnkV6Fqvx0RxOlq0/eeyF2Lc5AgN8g
	 fK53dEW6fpGiQgMAf9JTJVgsOX/AieH2vTlacHcy+IDCa1EuGFRC9sXAzekTszPmiB
	 UbtTTYQaS8CeA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/9] wifi: ath12k: MLO support part 8
References: <20241209185421.376381-1-kvalo@kernel.org>
Date: Tue, 10 Dec 2024 10:25:59 +0200
In-Reply-To: <20241209185421.376381-1-kvalo@kernel.org> (Kalle Valo's message
	of "Mon, 9 Dec 2024 20:54:12 +0200")
Message-ID: <871pygrlk8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Getting MLO to work with QCN9274 is getting close, this should be the second to
> last patchset. Small patches this time. Minor changes to data path to support
> MLO, some interface combination rework and few fixes.
>
> Please review.

I forgot to mention that this (naturally) depends on part 7:

https://patchwork.kernel.org/project/linux-wireless/cover/20241209153034.50558-1-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

