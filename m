Return-Path: <linux-wireless+bounces-837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FBC814972
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 14:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2931F25E3E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787672DB88;
	Fri, 15 Dec 2023 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWzyso3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC3018C2F
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 13:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659BCC433C7;
	Fri, 15 Dec 2023 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702647528;
	bh=UH7DXyj/Fie1+ZHHc3BLU8UNPHRN2ZZZbc6D4VItEss=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=tWzyso3gBr3wKZlsO6NsZBkrtB7oiayLv9fTwA0ykjfcwRXzZSK1+9FKP6zyf/qkH
	 TwOSC7PElap7/f2Zz3+l5oWeTPh9VbKI4xBskcCpvhjHFYtGtk27eyNVcQVRWBt4uU
	 xN4cEHr4Ahl3S6GUfVZZZUIIsJ0RQgslU3h6g2XbHdcNQCG7h9hywG01oxEJSVKEYb
	 uPdG8KS4MdVx4EshCPOO7KRjk7lUM4vHtobznGuQx4fw0Mi8ZbPrD3dj6P99AF2tBi
	 zeUDcKByS1w4n7lAteGHHeKSlTQ6AOAYfwL+0gDr6E5ARNfNKqt4EZ0Mjc1Jrt3GGL
	 aJkSN6cny8S0A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw89: fw: load TX power track tables from
 fw_element
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231213005054.10568-2-pkshih@realtek.com>
References: <20231213005054.10568-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170264752522.1759617.2696355217062597647.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 13:38:47 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The TX power track tables are used to define compensation power reflected
> to thermal value. Currently, we have 16 (2 * 4 * 2) tables made by
> combinations of
>   {negative/positive thermal value, 2GHz/2GHz-CCK/5GHz/6GHz, path A/B}
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

d60e73e5dd70 wifi: rtw89: fw: load TX power track tables from fw_element
344c066f2f5a wifi: rtw89: fw: add version field to BB MCU firmware element
7a9192eecf27 wifi: rtw89: load RFK log format string from firmware file
178b8e7d8a59 wifi: rtw89: add C2H event handlers of RFK log and report
edd77bb091d1 wifi: rtw89: parse and print out RFK log from C2H events
f0536b0d5fa8 wifi: rtw89: phy: print out RFK log with formatted string

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231213005054.10568-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


