Return-Path: <linux-wireless+bounces-3467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C0851848
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDDE1F21CE1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFB3C495;
	Mon, 12 Feb 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krvLykxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A93C48F
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752384; cv=none; b=TA/RpTV6b2PyuCFKDoNmURljTqPXVSpkntitKPM+QxQI1Tr56KKQ0FCxEI4lmpUDJmR8oj1U47oHPyjQCQVueTQn6FKsvjz6EGlU65RZz9wsWfr8qFSsZ0vMcvNXsEqZqIkw7CdKBa09a6r1omIkH/e9CixnH3TwVeuFSShud5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752384; c=relaxed/simple;
	bh=3xDaI8eVWbf6Mm/cJilYTZK+rVq1ugJbETV3ziLol5I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=sZhlUWhgfPXxckkSt3q9LR1jvdcfWpBZ0RucVYVeR+Yrp85m1YLLKKm1nRX0yiv4RU7UMH+3di60svGtDUv0S2mmO9dMLjJREe/T6pEgU5cyJsfjRvQGxNUF79Qqow3Ccq4WriqL/ffIzC2YTMkHKrE9mz/UfuD2xPp1Kfn/D1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krvLykxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A43C433C7;
	Mon, 12 Feb 2024 15:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752383;
	bh=3xDaI8eVWbf6Mm/cJilYTZK+rVq1ugJbETV3ziLol5I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=krvLykxRuoZaEHoSqCN/2sfds9lGEaYYzbOpw22luTmi9EnaZISb93SSNcYOFgNqS
	 /qm2uGjG5rUNjy5A9fLugsgKYnjLEpWXZymVoWki9vNAssaf5A1Lni9ChPU9zyCFA7
	 tVvdyMyF4rNlMkUMTD8s946uZPMGhwgbJ3++j2Ef/mkh2lr3zW0g1JqhtIxrlQI2Go
	 RjlqlKF2xC78aeqCRVJMQv5/4P2bIox2Jk6hb0LHPRVOCS1la/CsPpXxZDkVFbto6H
	 Xq0R7KhalTHwKcIchAF+O+IqKstHx8qN1sDa44onZtLyUNlTXIMInW+BtC1i0g7Fp5
	 5ojfJgKefNvmw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/11] wifi: rtw89: correct PHY register offset for
 PHY-1
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240209065229.34515-2-pkshih@realtek.com>
References: <20240209065229.34515-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170775238041.2851594.4571225717771729904.kvalo@kernel.org>
Date: Mon, 12 Feb 2024 15:39:42 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> PHY-1 can be seen as a copy of PHY-0, and the difference is their base
> register address, so add a function to get offset to access PHY-1.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-next.git, thanks.

db84b758541f wifi: rtw89: correct PHY register offset for PHY-1
e10cd2ddd89e wifi: rtw89: load BB parameters to PHY-1
b6e65d18bc2e wifi: rtw89: mac: return held quota of DLE when changing MAC-1
b204d2475266 wifi: rtw89: mac: correct MUEDCA setting for MAC-1
fecf6b57fbc7 wifi: rtw89: mac: reset PHY-1 hardware when going to enable/disable
505b57d08f72 wifi: rtw89: use PLCP information to match BSS_COLOR and AID
49ea98235ada wifi: rtw89: differentiate narrow_bw_ru_dis setting according to chip gen
ef95df598622 wifi: rtw89: 8922a: correct register definition and merge IO for ctrl_nbtg_bt_tx()
598481c6eb20 wifi: rtw89: 8922a: implement AP mode related reg for BE generation
5f9c264f8e09 wifi: rtw89: reference quota mode when setting Tx power
4ae8ac201ddb wifi: rtw89: change qutoa to DBCC by default for WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240209065229.34515-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


