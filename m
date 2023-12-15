Return-Path: <linux-wireless+bounces-838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CAB814977
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883FB1F25FC8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D22DB99;
	Fri, 15 Dec 2023 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaCvj5HM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C02DB8E
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 13:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C1C433C7;
	Fri, 15 Dec 2023 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702647601;
	bh=6zAsxtKLo9TFKVV78gbq4pM9N06VRBefzOecpUoeJk4=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=PaCvj5HMMrKXDOm9fgS36GiamRF+ilrxnr2+5GnMzgrxJzqqGW3CQMMElFmTno65V
	 qRy731TWeMfnScVD0NtfAOCwhRILvbUY1VHTwN9w+iw0yuWtn/Ecy5EfIFJJyajqcZ
	 0Qe6tlnrQ6bF2+fDxwGzC3roIKLCSf41LHXW01J2zDsgyG6juX+KQS3wu8c3OoPqaU
	 OA8hHnSAZDs2JafIjWsUtwMOS6CKNSEI1D+rXcWbGxj3nDrPqsveoPchp5VVUTSl7Q
	 a47wMYw7R+k59j0PPUPMISRAD3Lk+HXN/EoT/MC325s7//NQDPM9kvpn1AcrCNeQqH
	 szeSPApAz2CEw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: add XTAL SI for WiFi 7 chips
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231211083341.118047-2-pkshih@realtek.com>
References: <20231211083341.118047-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170264759877.1759617.5120070310736521059.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 13:40:00 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The XTAL SI is a serial interface to indirectly access registers of
> analog hardware circuit. Since WiFi 7 chips use different registers, add
> a ops to access them via common functions. This patch doesn't change logic
> for existing chips.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

efde4f6dd13a wifi: rtw89: add XTAL SI for WiFi 7 chips
f20b2b7d3f1b wifi: rtw89: 8922a: add power on/off functions
cfb99433662c wifi: rtw89: mac: add flags to check if CMAC and DMAC are enabled
fc663fa02532 wifi: rtw89: mac: add suffix _ax to MAC functions
293f7bdca269 wifi: rtw89: add DBCC H2C to notify firmware the status
48fa9b61ae16 wifi: rtw89: only reset BB/RF for existing WiFi 6 chips while starting up

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231211083341.118047-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


