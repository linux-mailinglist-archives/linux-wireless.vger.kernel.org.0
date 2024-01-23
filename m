Return-Path: <linux-wireless+bounces-2374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF5838D8A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F226C1C20F1B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344155EE78;
	Tue, 23 Jan 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5B/Tg7Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FCB5EE7A
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009717; cv=none; b=Wm2SOPMKr36lW/lSuBVv665eTVX4oNG9ReXBqajwl9M7rwPyl0KXQLlJ22MW/DnAGyOGPk2VRTrRA+j74dL/7EZdgT/VHnWkfCcZFZ/c5LLVTj8qUu4WEtey75l1YmGyKW/nj6fnYwiuGxjZaQxJ3MupTWTv/DxdNFVAHFJRxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009717; c=relaxed/simple;
	bh=PhVTS/dzd6AM1QWS4bHfdnPpmGfOkcMoGnK/wPXJ6AU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=FUaZcgKn5y/dz060luaz2niy/JoSOuq+/KUgZipgFOIHBqDSD57xwAawu+lhqaCu16QprnYtDsz0oc8T3gZX4mA7xGXVZbdeJb7vlx2e8Xj/HxZRKz57Eqy3AazsbO25SahqFN7FcOma+PLRA3VphfVpj2CU+r/NaNc8HdNHLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5B/Tg7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFACCC433C7;
	Tue, 23 Jan 2024 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706009716;
	bh=PhVTS/dzd6AM1QWS4bHfdnPpmGfOkcMoGnK/wPXJ6AU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=I5B/Tg7Y69JeH8ok2d7DymqtNBIk1F3R4RcqGJV+Vsp7+3RPXOdUMvRIWv0KNGpfA
	 XYtE++aV3dBgVt/mtCs36HSf7biJgXtV8c82Qol3OTGTZkHW5IF+oGTf//rbnZNXHK
	 8VUtx0FsZLbACM7GCml2BVxj0Kwr1GEx+n9yfKq/yf8lKy+k0V1o9xp/6qjJziT6DL
	 zVuhZEdjDhLLffTuLn+w7h3vsGHCySiwyhUWfPWQ8NlpDJTch+SD9+KVj4UGWGVlsW
	 94d745BuREVqP5LMgnm6ZvlVgOYrIehp70osIpWdUYaurQ1B7zsOxL/hqeNy0yNwrL
	 1ZEmjyY6KhKhA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240120003831.7014-2-pkshih@realtek.com>
References: <20240120003831.7014-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170600971361.3962299.12990604657841234148.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 11:35:15 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> WiFi 7 chips can operate in various MLO applications, such as 1 link (2SS)
> and 2 links (1SS + 1SS), and we should configure different PHY mode for
> each of them.
> 
> For example,
>  - MLO_2_PLUS_0_1RF is 1 link with 2SS rate, and enable one RF component.
>  - MLO_1_PLUS_1_1RF is 2 links with 1SS rate for each, and enable one RF
>    component that can support two paths.
> 
> By default, we set the mode to legacy MLO_DBCC_NOT_SUPPORT (don't support
> MLO and DBCC yet), and later we will introduce logic to change the mode.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

aacb84adf1a2 wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
5c682bcb2ced wifi: rtw89: 8922a: add chip_ops::{enable,disable}_bb_rf
10af16279a9a wifi: rtw89: 8922a: add chip_ops related to BB init
d2ff221579e5 wifi: rtw89: 8922a: add register definitions of H2C, C2H, page, RRSR and EDCCA
295304040d9f wifi: rtw89: 8922a: add TX power related ops
a4374cbd6b2e wifi: rtw89: 8922a: add BTG functions to assist BT coexistence to control TX/RX

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240120003831.7014-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


