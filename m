Return-Path: <linux-wireless+bounces-1830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667182C462
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2011F218F0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1368617BDD;
	Fri, 12 Jan 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfMy35Lb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC201175BC
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 17:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8481C433F1;
	Fri, 12 Jan 2024 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079483;
	bh=jTHPezWsvd5YczcFUz5lRcQn409JLR1qeW8m4oOhLdk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DfMy35LbdXkOV5GpIOfUH188TmYcG1gM8xx0r0H30Ri8B73rK4YK+TwAg+UEC4GDh
	 xRA+TA4sQhWgHt1XW8nU7w5VS0pvBluWa/zBeooYbR3cvUkn7kr3G+M61UukfHfRiR
	 eiajfGWr0nDoi7mKBT5En4UgsV1oQy1TibUMycYV3qxlFeH53PbIQ2ErKgaGQQOxUZ
	 +T6+qYUCan5n1SrTHGVexSb2vpNEG5hPAOrxMV0RNVoTp4ij6Bi8Ki7H8m1q60q/cM
	 VwF8QF5lvnoCYDAO30YYPAKRy87FGmJsRoZufCAO6PuDbVTG5WK7v3pw87YvuKYQK2
	 qypXUhqZJi1SQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] wifi: rtw89: add firmware H2C command of BA CAM V1
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240108091134.67007-2-pkshih@realtek.com>
References: <20240108091134.67007-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170507948076.1153005.6133817032056344868.kvalo@kernel.org>
Date: Fri, 12 Jan 2024 17:11:22 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> BA CAM is used to generate BA frame for received AMPDU packets. To support
> WiFi 7, change format from V0 to have more fields and enlarge entry number
> for new need.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patches applied to wireless-next.git, thanks.

6f066439f9dc wifi: rtw89: add firmware H2C command of BA CAM V1
3b96833a5727 wifi: rtw89: mac: add feature_init to initialize BA CAM V1
5d461dba16fa wifi: rtw89: add chip_ops::h2c_ba_cam() to configure BA CAM
2d623151bf26 wifi: rtw89: 8922a: update BA CAM number to 24
cdd368ce1ca4 wifi: rtw89: fw: use struct to fill BA CAM H2C commands
e3552b37dace wifi: rtw89: refine H2C command that pause transmitting by MAC ID
c313c31ff40d wifi: rtw89: add new H2C command to pause/sleep transmitting by MAC ID
69466b979a72 wifi: rtw89: use struct to fill H2C command to download beacon frame
a880b9283009 wifi: rtw89: add H2C command to download beacon frame for WiFi 7 chips
bcd1ae78448e wifi: rtw89: add chip_ops::update_beacon to abstract update beacon operation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240108091134.67007-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


