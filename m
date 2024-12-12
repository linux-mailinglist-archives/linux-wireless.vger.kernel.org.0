Return-Path: <linux-wireless+bounces-16305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ABC9EE44C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 11:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77E22834A0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A920E705;
	Thu, 12 Dec 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOtY5clY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2641E89C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999909; cv=none; b=Epx/l8FbY8BWf1YrYD6JJubD15n2u2LzmHuOutS8VibgKBuG4g4T1uzmcSlte7WjtiC09V4pk/WevBrYvCkpQX9hewkKFfpVPtFaKWEgjyBdeW8eWpuoIYBov8u5XNcOPRicEt5kj/ejlA3flB7RAb7QnQfGU4g4vjyzJ97D6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999909; c=relaxed/simple;
	bh=YQdkV5DZUnSTyg0vuItxQ0IsIWr/wnH96fWHGfU1Xro=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=faRQymFuulp2gega0FndPeMIuBxI4t9E2YLLOdaQrzeBV8RkdjTR4SPMCfvO5E3l121o9uugn7oPH++2IKdO5LZStMK/Edp698rnkbiCeiy4KbQiKW5k7gtDDdKTV4ZQNJlKEfxFmREKkQh02TtEyVtdHJUQFcfWYyIIqbTHtbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOtY5clY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41ACC4CECE;
	Thu, 12 Dec 2024 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733999908;
	bh=YQdkV5DZUnSTyg0vuItxQ0IsIWr/wnH96fWHGfU1Xro=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VOtY5clYgf3AJKi0hgFxSv01LHVdKWYz6q97dxS3qGQJsJoqcY3BjKu0NPM6UjHBb
	 qh5ANo1+D5hAqJR+qFb3LHorzkQpTVDPwHN26r7R4pzPwDeDSn7pchBMWrIlrhmHdq
	 rJQ2lM1wuhYOFztd3mXMLWn9BqHowI8saHQ+Zuh5rypM3TFA+KlE4uGXrPD6Z4Smlq
	 lwmN9u+iH/KxGBxyg1SUYzeH4DRACBTlQRXlv0IYuxIUQfhH6rrhR5md0DKcAVjjrX
	 WdG+sRXI0OrZHtEH9g4+Dntjuzlfb/0bBYx1Oab3AMFNWmMULsUfgcxfpmQhEvFtKl
	 8m9WrgtKNEK9g==
From: Kalle Valo <kvalo@kernel.org>
To: sean.wang@kernel.org
Cc: nbd@nbd.name,  lorenzo.bianconi@redhat.com,  sean.wang@mediatek.com,
  deren.wu@mediatek.com,  mingyen.hsieh@mediatek.com,
  linux-wireless@vger.kernel.org,  linux-mediatek@lists.infradead.org,
  "allan.wang" <allan.wang@mediatek.com>
Subject: Re: [PATCH 05/17] wifi: mt76: mt7925: Fix incorrect WCID phy_idx
 assignment
References: <20241211011926.5002-1-sean.wang@kernel.org>
	<20241211011926.5002-5-sean.wang@kernel.org>
Date: Thu, 12 Dec 2024 12:38:24 +0200
In-Reply-To: <20241211011926.5002-5-sean.wang@kernel.org> (sean wang's message
	of "Tue, 10 Dec 2024 17:19:14 -0800")
Message-ID: <874j39tcdb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

sean.wang@kernel.org writes:

> From: "allan.wang" <allan.wang@mediatek.com>
>
> Fix incorrect WCID phy_idx assignment.
>
> Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
> Signed-off-by: allan.wang <allan.wang@mediatek.com>

Allan's name seems to be in wrong format both in from and s-o-b. This is
the preferred format:

> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

