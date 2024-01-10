Return-Path: <linux-wireless+bounces-1668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04927829CD0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 15:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703B0B20AF6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jan 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761E4BA81;
	Wed, 10 Jan 2024 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlYae4A2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6884BA80
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jan 2024 14:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1698C433F1;
	Wed, 10 Jan 2024 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898296;
	bh=c9mkOWCt/Hj83TVeDB7H4YM4f83VjNHrqkFg1n4H3Ow=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DlYae4A2xA0XlGIp6r6sHAF2aoD81yLVvV6ldRHnW0BaE2+AQkQQXYS8v5iKek/Ym
	 MW6xXaQfN5ONnGI5XcmpJLo6QNq7dDzFdRUvHeDHi9noPfNhM5YzK70qlt9V2kmaiv
	 juqpMSBUjk2f2MohaF4wqxq6bo4H8wiatFs6GAHOFS6O9EbYdUWsJdp3M/IZ7ZAU1K
	 AQUv0MMzhu/JVQJ53S4uqRerF0bV1BpxZtQu9suY18m6SkAdVIlzf3Nf31PttyKf+b
	 t1aY1GNSobW+tih+SN1BVDRXElvJ6Knog8wpS1TPu5zKEXHq91eFCRYshMYnfkHs8Z
	 TTOBsBkMVd12w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: phy: move bb_gain_info used by WiFi 6
 chips
 to union
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240105064228.36580-2-pkshih@realtek.com>
References: <20240105064228.36580-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170489829397.471554.4724688437975475710.kvalo@kernel.org>
Date: Wed, 10 Jan 2024 14:51:35 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> WiFi 7 chips use different bb_gain_info struct, so move existing struct to
> a union in advance. This doesn't change logic at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

9225b9734670 wifi: rtw89: phy: move bb_gain_info used by WiFi 6 chips to union
0edcdd82337a wifi: rtw89: phy: add parser to support RX gain dynamic setting flow
cac432a08537 wifi: rtw89: 8922a: set RX gain along with set_channel operation
d16f34b084d9 wifi: rtw89: 8922a: update the register used in DIG and the DIG flow
0377e2a77201 wifi: rtw89: phy: ignore special data from BB parameter file
c207e14d9328 wifi: rtw89: 8922a: add NCTL pre-settings for WiFi 7 chips
ce84ecbdc168 wifi: rtw89: phy: add BB wrapper of TX power for WiFi 7 chips
6bd232192261 wifi: rtw89: phy: set channel_info for WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240105064228.36580-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


