Return-Path: <linux-wireless+bounces-997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24851818AC7
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 16:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C00280E0B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848331C298;
	Tue, 19 Dec 2023 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZGo/8SP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6911C296
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 15:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444FFC433C8;
	Tue, 19 Dec 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702998402;
	bh=UvuD8ev46emlVayViBzbMUHKTbqeTGcHc5FEx7Dd9rE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=tZGo/8SPXwuC3ca6IVeWRnlc6+Hr+/m56Ex9NnNI7sWhDPhzkBrooO71IdfMi2uHR
	 +a85JPV9Ri+aw+Ivb2yb5xk6S9ILHcybVVlnCJ0TbkASFeICL1Qb42eb1QDANzloIv
	 euwZQ6Ki4HkLy2G/Hv4yYv2koDJTj8HLEsJ4VBuJGKthQ3hFxMLx339gSJeleGi+HZ
	 q68b2qwUtRacxf3uoqXyEnoU6xRujG7oPXcZ38J2rqyi7R8x+hNeNEnIynZzBhCVd3
	 AOd9eFAEVl9khVUeRXh3gnEzc9OcL1pW3kzL7wFXfXqUL8+ZAdeuM/B/rU2AQG8GtO
	 6jNrqRDrMSTpw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: mac: add sys_init and filter option for
 WiFi
 7 chips
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231216045739.10432-2-pkshih@realtek.com>
References: <20231216045739.10432-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170299839914.797699.4575976945360760862.kvalo@kernel.org>
Date: Tue, 19 Dec 2023 15:06:41 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The sys_init is to enable hardware function block of DMAC (data-path MAC),
> CMAC (control-path MAC) and others called 'chip_func'. To understand the
> functionality of this function, we keep some functions as empty.
> 
> The other is typ_fltr_opt that is to configure filter option to decide
> whether RX packets engine can forward packets to host or WiFi CPU.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

694c626bcfe2 wifi: rtw89: mac: add sys_init and filter option for WiFi 7 chips
bad7aaef3116 wifi: rtw89: mac: implement to configure TX/RX engines for WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231216045739.10432-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


