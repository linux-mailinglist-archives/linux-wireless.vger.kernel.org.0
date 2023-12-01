Return-Path: <linux-wireless+bounces-297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A237E800B3E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C78D2817D6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78C1C685;
	Fri,  1 Dec 2023 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwGAq+f5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF25954E
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 12:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACACC433C7;
	Fri,  1 Dec 2023 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701434611;
	bh=nSbNkpbRGEwX7lv4Och+jke3HjWo9mb+MhtexQmZ1sc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=jwGAq+f5LNTKGLtGKb+XO0AsSgzzjrIjn/BZB7i/pg3m31y4e08RbKOOgIT9KPPQV
	 8JT1/uYZ6r0q+U8kapkDa+mnOsDA5UfCrg6o+lzgrQoXJJNlEzT6steiJriDlfua5l
	 FyONzauvX++cXp4/TrcJICprr0HTvezfjSydRYUMzQpXKT1wq2Td7YPp6vk4uQZvWo
	 tVJ8iRfUA21d9DL+OUal9vMsd5ZyXACfkTcyakvE/Yw4QbBTH2+/hjC6Icaqqtzn47
	 5F4trhIM1z8WY/P219T8BTEAf8IGLlwhq3sOV0znHp46phRg8FBeaG1JNIX5w6f9UU
	 jK9xxXaj3iWow==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: fix not entering PS mode after AP stops
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231129070046.18443-2-pkshih@realtek.com>
References: <20231129070046.18443-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <gary.chang@realtek.com>, <phhuang@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143460861.2072551.13745611906714696058.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 12:43:30 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> The attempt to enter power save mode might fail if there are still
> beacons pending in the queue. This sometimes happens after stopping
> P2P GO or AP mode. Extend stop AP function and flush all beacons to
> resolve this.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

0052b3c401cd wifi: rtw89: fix not entering PS mode after AP stops
2f3eaccc6621 wifi: rtw89: Refine active scan behavior in 6 GHz
e46987ce819d wifi: rtw89: refine remain on channel flow to improve P2P connection
756b31203d48 wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231129070046.18443-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


