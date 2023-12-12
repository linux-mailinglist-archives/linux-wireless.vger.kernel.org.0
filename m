Return-Path: <linux-wireless+bounces-704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E029F80F128
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6381DB20D60
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64B76DAD;
	Tue, 12 Dec 2023 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRTNP8W3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFD3399E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 15:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9778AC433C8;
	Tue, 12 Dec 2023 15:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702395338;
	bh=Uze0pxeBdkOUy3U6m/Mh1/d2tI9SnM/+x1V/99wkX3E=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=sRTNP8W3M8DChOJFfMhLF2+Q9C/ce8wSirbdPGEhroZatcWxA5Z1ofqtZdZykIpQH
	 xjzACOHrkmAAnFZoIWpRaqma0iie7zLY/8l0shx6ONOJqCbS2gVmu1qaNeY8Mf1lkX
	 s+NmZjqH8IE9MA3f3wnN8rc1HN0cKxyYQfZcHO7IO4Zw1UM4c2mQTxynxMGxlPwirj
	 hNCo2UJG6gHqvu1Z071xtKoZzteruv24oYWu67XCIeLSYG7YkE4VswbtCAHDxrr82+
	 M5mqBriHhDSVoui49dOd2qgNnwkyPlWCzmyIbFJ0poClwQzzKjS2WUPBquq00YontM
	 P50AdTZuPgg3w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: iwlegacy: Add null pointer check to il_leds_init()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231211033019.238149-1-chentao@kylinos.cn>
References: <20231211033019.238149-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: stf_xl@wp.pl, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>,
 Kunwu Chan <kunwu.chan@hotmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239533573.306086.10663897206558625486.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 15:35:37 +0000 (UTC)

Kunwu Chan <chentao@kylinos.cn> wrote:

> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

afd549903ea9 wifi: iwlegacy: Add null pointer check to il_leds_init()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231211033019.238149-1-chentao@kylinos.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


