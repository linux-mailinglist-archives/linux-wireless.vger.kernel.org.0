Return-Path: <linux-wireless+bounces-17431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B2A0BEE6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 18:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614D71887D3D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26CA190692;
	Mon, 13 Jan 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8QyAD4v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F6190486
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736789484; cv=none; b=gUye6KzHh71r7wbMYsCHwWqiDrnACfAEKn+ite75ajV4Mw23HnOhXsAAeKWR6PCe8jXgI+nHegd/xamL28wV97RDZMnBjluGs5N/ci4XEgUYZhoFhewD0Jr5l8kPphPVkWojIBhrRcJNfv0cCob0bX7Q4ZK5N9AzXvND2Ywz4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736789484; c=relaxed/simple;
	bh=qyWIDNWTQj/Bx0oSWG+lklmOu/SSiD5UkalWji9JCyA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MHrOus4u0y8Wa8n0EMu1ze8RY0qr0ChFa+wsaZsW23XkPZ1XTZbmBW13ZlWsq7hCGrcGWn9ODIdBXJlFqktYTYKkYWJdK72jDmiUTjVOINm88QVBvFQrE5iN6uuPv9etCGL19rveBkVtwtaIYreQpD1d5YLf22KMJxP/WPrUIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8QyAD4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCCC4CED6;
	Mon, 13 Jan 2025 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736789484;
	bh=qyWIDNWTQj/Bx0oSWG+lklmOu/SSiD5UkalWji9JCyA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=H8QyAD4vrHrUqvTPqHhxLGyJ3WIQ2B+17MVWyIjFQVA2XH/4elZ+3ZDA9QDE2Boo5
	 BRFP/qBhXZ6yHImIEtWC3IS7xryTILpL8qHcRum/C+z17XlHreOdHf6doTxtyG41S4
	 gbXT+3MCMumQYpH3cSQL/CiBaLc2kLDPhcJw512GHbANzgDPY6wuiHt+fw9QM64X/+
	 lHvX+oKANTSjwAR1vOILDlOgL9O9f1nJWrsD1P82k25l08BdAn3v+ip/ZZJ3WENVJf
	 YuwzOfPj/CkTovkmdwiX1UNzGemxX3lBj8dJGXROYWktMTACgx2UfP+s1OYBbFThDk
	 h8n/xBMshjLUQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2025-01-13
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <6c05b939-5649-4a07-91b2-81791ae0ad80@nbd.name>
References: <6c05b939-5649-4a07-91b2-81791ae0ad80@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173678948177.270486.238279022780154930.kvalo@kernel.org>
Date: Mon, 13 Jan 2025 17:31:23 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> Here's my pull request for 6.14.
> 
> - Felix
> 
> The following changes since commit 8221712a174ad83e36489c414c26619010f4e348:
> 
>    wifi: brcmfmac: Add missing Return: to function documentation (2025-01-10 15:14:00 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2025-01-13
> 
> for you to fetch changes up to 4d915d0d5cf04c7e36127303fb74b325f47839c0:
> 
>    wifi: mt76: mt7921: avoid undesired changes of the preset regulatory domain (2025-01-13 11:22:01 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.14
> 
> - mlo fixes for mt792x
> - single wiphy multiband support for mt7996
> - mt7915 stability fixes
> 
> ----------------------------------------------------------------

I see new warnings with GCC 14.2 (and sparse):

drivers/net/wireless/mediatek/mt76/mt7996/init.c:205:55: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
drivers/net/wireless/mediatek/mt76/mt7996/init.c:205:9: note: 'snprintf' output between 16 and 18 bytes into a destination of size 17
drivers/net/wireless/mediatek/mt76/mt7996/init.c:220:57: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
drivers/net/wireless/mediatek/mt76/mt7996/init.c:220:9: note: 'snprintf' output between 16 and 18 bytes into a destination of size 17
drivers/net/wireless/mediatek/mt76/mt7925/main.c:2124:36: warning: variable 'pri_link_conf' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/mediatek/mt76/mt7996/main.c:659:33: warning: variable 'link' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/mediatek/mt76/mac80211.c:1046:20: warning: Using plain integer as NULL pointer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/6c05b939-5649-4a07-91b2-81791ae0ad80@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


