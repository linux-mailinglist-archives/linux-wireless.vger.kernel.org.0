Return-Path: <linux-wireless+bounces-8204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DBC8D1E50
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7481F228BD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B3140E37;
	Tue, 28 May 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgHF2I4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DE6A8A3
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905870; cv=none; b=WuA6GQFKiZpqOekpMUSM2ixbR10LZNtybJnag+EADEyswMq3JhczmZv9KWRaymvVBOd12vDQtec+l3FHlfN3JQPhN3TI6nBjphmxkrEg4OkELw01/K2SjVOIeQYXMOsLFxrD7vWaDOYu6u1xlbZG39WTD83Dq3vX67jADV+XF8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905870; c=relaxed/simple;
	bh=qiGTasfTtQoFyYOa6BZUrQ9nsnyUCXKNBvTcXCaF7zU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P7HL+IghB7hTDkxtEyiU7KBppzWUJbOjydq34BCWHvvAWZUfXwVQ0KsAMP7mD3PDTQG1mocU2x3R2hgEJslBt+ZBLdidhsiLUJqjrMBmxIxD5yTbhn9NR3TTXzU3zOEFS2/+iAOK27lBTPmETkn5iSvn8+qXFueEo21CYIwtYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgHF2I4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503A9C3277B;
	Tue, 28 May 2024 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716905870;
	bh=qiGTasfTtQoFyYOa6BZUrQ9nsnyUCXKNBvTcXCaF7zU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SgHF2I4zAgLB9pePA/MsdGdjtA7A1NPCbZx6lfFShHrwRUuxRGiq0fA9T97NGAiFz
	 5h2UXKLM9XxvET7908LVgke5j52UkdTCkoYF5upNWmVaVSFWCgQbOHk7d+5+432Mh9
	 m6ekssAP98dXWQy+zuDHRoDvosVqULV5r3LajedSh38hkL4YH+oUXSgenLsM4r8iA8
	 B5LXkqPaMWbJBWjEPXIb2tTFVL47H+UUVDo+c7sAgGtM1R18uf3VajL9RWNOQvUJx3
	 lgMgNJbYt7wSRqrGAJqhrJJVaVaJ6hw4ezD7S6Jkhw47AEJ12/X2TbkELNmc14NFqL
	 8yeC7l/xGDOkQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id A93855FA42;
	Tue, 28 May 2024 22:17:47 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240522062835.69628-1-pkshih@realtek.com>
References: <20240522062835.69628-1-pkshih@realtek.com>
Subject: Re: (subset) [PATCH 1/4] wireless-regdb: Update regulatory rules
 for Mongolia (MN) on 6GHz
Message-Id: <171690586767.641246.5269610632344527661.b4-ty@kernel.org>
Date: Tue, 28 May 2024 22:17:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 22 May 2024 14:28:32 +0800, Ping-Ke Shih wrote:
> Communications Regulatory Commission- CRC released Amendment to Resolution
> No. 37 of 2020 [1] on 2022.01.31, which supports freqency range
> 5925-6425 MHz, output power limitation is 100mW, Indoor and and outdoor
> will be used.
> 
> [1] Amendment to Resolution No. 37 of 2020
>     https://www.crc.gov.mn/storage/PDF/2022/2022-togtool1.pdf
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/4] wireless-regdb: Update regulatory rules for Mongolia (MN) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/2a768c42cebf
[2/4] wireless-regdb: Update regulatory rules for Saudi Arabia (SA) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/04875d9b62c3
[3/4] wireless-regdb: Update regulatory rules for South Africa (ZA) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/b7bced837f6a

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


