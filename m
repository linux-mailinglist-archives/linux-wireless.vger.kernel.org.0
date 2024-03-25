Return-Path: <linux-wireless+bounces-5225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1CC88ACDE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 19:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC7A1C3BD4D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B614A8E;
	Mon, 25 Mar 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM49x+yJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8AFEEA8
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387361; cv=none; b=odNVu6mv0tgCngkdYftfCWaP8dmo69p3FMjbZ8Aq6ach1ED5bRL6BTttnz7YFooG9U95V2Mp5V48vEsSPBNBxlLjMmvwv1cZb3xwoV4ljT8XvTTpuageJj0VeyoBGRoWygkNGxuGOE6YCeBSnSNkmigtTecSyeedL+MH/+ViLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387361; c=relaxed/simple;
	bh=JZTxDP0SzyHpcG7qdAUA28Ye/YlJBVeBvrW2Vf5JUEI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iU+02Gs9vyhAElMS9Bpel6polJK4oPunADdDvq2+yukeOwVkHh371VJgXVsv63wsuUsdEiGELjaTag37dxmXL1DN/j58exEfrtipHHs5hT+6d7uEUyUo2T0tdYGnskApe65jn3R2tNk26ICALsUd8IEAPCJyXxTpgGkZjmIREYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM49x+yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B920C433F1;
	Mon, 25 Mar 2024 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711387360;
	bh=JZTxDP0SzyHpcG7qdAUA28Ye/YlJBVeBvrW2Vf5JUEI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=eM49x+yJAaeZLs2lFuNZ0Ivs6Fdb5fEBl0rn0sikquEQ1zAilfaPUjiHNEnwx4pvp
	 qsADHPiZgR5KAfzvYS3x86OaMbTMG8JNeJ42keQAZU2a77Frb6pf1Z0avXXseNsjA+
	 wLqC3+J0FdWwoBmdyPlsRkV6bwLwzLnVP2q1Evx2Y2QZ211LHaSf7987p3AaWAtPMt
	 +Pyk82EiGEgYF1jjJ+qqCpt+1g+219d/egHHzyb0mMAhj5HRxGhphqtmCROVV8MK82
	 PMZHVUemEinJtR+Ciu5ScvFrCxbN9pjlGQZaSUtd87lYxzfv8qWxg4RmwoGl/jvdcj
	 +wlQohrOPoaMg==
From: Kalle Valo <kvalo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo.bianconi@redhat.com,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mt76: mt7915: workaround dubious x | !y warning
References: <20240325155838.1558680-1-kvalo@kernel.org>
Date: Mon, 25 Mar 2024 19:22:38 +0200
In-Reply-To: <20240325155838.1558680-1-kvalo@kernel.org> (Kalle Valo's message
	of "Mon, 25 Mar 2024 17:58:38 +0200")
Message-ID: <87cyri1b1d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Sparse warns:
>
> drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:526:9: warning: dubious: x | !y
>
> Workaround it by using the '?' operator. Compile tested only.
>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
> v2:
>
> * use parenthesis

Felix&Lorenzo, if this looks ok to you I would like to take this
directly to wireless-next. I'm aiming that the next wireless-next pull
request is sparse warning free :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

