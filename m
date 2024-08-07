Return-Path: <linux-wireless+bounces-11066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F03194A262
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5531C20EFC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2CC19A28F;
	Wed,  7 Aug 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpQT6cWT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BDF2868D
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018130; cv=none; b=bN6f7deOhmw0b/xU0LI3FxMcX2KKVZpMJ5PWQZD6grYA9t+SdV/umXWX1onEFJ4hdMYSZ2U1NbC1Cxkkd/5I0rP/pg11PD0cyyj8T3AD2Ft/XEhMsh/Ol9Ebs5FYf7of7ZULLiAIvNZ8cRFcM5B1SSfvybOOy/P5dQTcu5secEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018130; c=relaxed/simple;
	bh=MG++xbZ1EffhJ72mLXwLW+vBcTjL9OZABWqO8WfSBTs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RgcAShrVYS7Jw+4MErnRNxQ616xIN4Doiy0CVwC+DMhw58iJ2DnLGDdrSXAyeCPWCQZBhDG8J9f/pVdrFFJ6NYKKL37VUsBj29KiqiZLRuk7wV1rLlfyQTDSDOMju27qFP56UnMlh/zhH2r5Y749OKbu5mZzs+QJwf+CCzcxXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpQT6cWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EE8C4AF0D;
	Wed,  7 Aug 2024 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018129;
	bh=MG++xbZ1EffhJ72mLXwLW+vBcTjL9OZABWqO8WfSBTs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CpQT6cWTp3D6HfHYCJ34Bh+2nU9sZSFs3ww7wTv57JlpeMYRptCBD4IJk+JmkC8Zl
	 00qVydjCbGkLywzZZ80wBZkyMRLUm5pVlJU231qPk9rUQeXMRKOunO3lZSNmmaoshx
	 wsJjm7YV4ETpfB9SwycyzZ3vdSSKnY5sZ+x/T0lY/joep9lWOxgYL0A3+Dcp9REwf3
	 UKI7vMsYQ3jbjpN97tPsxgvfwxKREFRbegonR9zolZxvLCeC8D9eh6dOqUVBswXM+0
	 IiGVg7m8Lsn/vWSrabs1jdDKT4v4Da+qlV4HO+Kqh/HjjvpINS7oWfEwJgz+Iol6iS
	 iHVvlJ5CubR5A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ath9k: use devm for gpio_request_one
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240731210312.7622-1-rosenp@gmail.com>
References: <20240731210312.7622-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172301812742.3837211.3362774091383282718.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 08:08:49 +0000 (UTC)

Rosen Penev <rosenp@gmail.com> wrote:

> Using devm_gpio_request_one() is simpler as then we don't need to call
> gpio_free().
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8aabc03c7d22 wifi: ath9k: use devm for gpio_request_one()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240731210312.7622-1-rosenp@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


