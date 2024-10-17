Return-Path: <linux-wireless+bounces-14159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E8C9A298E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14E0B2CB0C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF61DF74E;
	Thu, 17 Oct 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWKAXmnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176E1DF742
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183643; cv=none; b=M7Bh/VebspS1Af5dajLF2k8bITRwxdcwUOjNvcbeyISYXc30/hXHBQi+wCIvLPvwWhHY32quHdLv70xjKGXpevri38d6XRuyv5pg5L69bAnX8fhhPmpaCobjObXXvkJ2GLEE19ZEF6Z9XAnNJIWW37dzwPgONviqOsmrSgmKJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183643; c=relaxed/simple;
	bh=eBS/nkpl5OjhXd5/RKCyJym9ZjZ6BmsHfrVAXeTZ7Ac=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ffBozud2MOblckpQZDAwWaZ+8G4D/85pe5yi/0GJgoAqpbVxEGaYVdlifd+ILfzl9NbyU5VmMh8f5+BvWgnq0vKbmjbwT2H7oLuqNfQBd/ROurcmkoDa1FgBKswXh+Lfb7wB+5hGr6kGYXFtwCQusHTJksj78EDVwyS6Qi0p6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWKAXmnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0262C4CEC3;
	Thu, 17 Oct 2024 16:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183643;
	bh=eBS/nkpl5OjhXd5/RKCyJym9ZjZ6BmsHfrVAXeTZ7Ac=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=QWKAXmnqHJ6/iUEDc7huTEThYUhaPsMS/9uq+01K7McstCCZVsE4ELqvRUK5+eD4n
	 GcsSvo05wwR8mU8Gt6Y5AdgDC8qpMqYaOzEv2eFxwaBiVN3vOLH+l5f8S7vHLM4S/a
	 uZCwt4C3nihnu16KXdUM8jGMru1oh08VzB/HD32mIF1Bz+NaL1aPPgMR0JRHt8gjP+
	 0sZZu9lZFcojyWv5Pb1VPY56hXCJ9tHOErEuxl8UiMkosjdGXInbMvGLVGpb1wS7+a
	 i3W0iRQnttjWbIvH3L6E4bfgdhJMhhOPjfb0CFW28HFvJnkZZOg5jk4/FAwB8wdEmj
	 N7uH7X1dsDA4g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240926195113.2823392-1-marex@denx.de>
References: <20240926195113.2823392-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Ajay Singh <ajay.kathat@microchip.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172918363989.970100.14147823876508252072.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 16:47:21 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

> The WILC3000 can suspend and enter low power state. According to local
> measurements, the WILC3000 consumes the same amount of power if the slot
> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
> off. Use the former option, keep the WILC3000 powered up as that allows
> for things like WoWlan to work.
> 
> Note that this is tested on WILC3000 only, not on WILC1000 .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

98ca3178ad79 wifi: wilc1000: Keep slot powered on during suspend/resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240926195113.2823392-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


