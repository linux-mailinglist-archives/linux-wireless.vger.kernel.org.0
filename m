Return-Path: <linux-wireless+bounces-839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAED814978
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 14:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518661C2324A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64092DB8B;
	Fri, 15 Dec 2023 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGGCUMWw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3972D7B7
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 13:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B684C433C8;
	Fri, 15 Dec 2023 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702647642;
	bh=rGXhACWnvWZKELA2A2+uXVV/y/a4lDqndImovMajIqA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IGGCUMWw0MiteM/Qd4XVfmdoWtFM+Ez1qXnkI4w7oXx4QqTIrN2bsTxYzHwU5T8r4
	 oR98S8bvZOLhc3ZISvZvEyjCcenIO5XXZD1p2NlgrfgV2SfzD/tjcOO7ECL2Ogxvv3
	 B02+m34IHw+jeWXOE7YeF5iWs2KfiBKLxdeT+scUJKCUgBOU4QGvLXnfFTbHmBEyGj
	 vkBzjQKgcVJzD5lzn3Zsxt7zzC3bI8eey7ZfHgOmKaDIjsadedlDIf4xHIBppXuTVj
	 q4wUc+zSFRBxOm29Qmvd1I2HRj+K4G7TrQEvTtLczbOD3UF8RS6lEUO2MvqSdI4vuu
	 0jZYjWUvsPBTQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: rt2x00: remove useless code in
 rt2x00queue_create_tx_descriptor()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231213051449.126963-1-dmantipov@yandex.ru>
References: <20231213051449.126963-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, lvc-project@linuxtesting.org,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170264763943.1759617.7972468780385237703.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 13:40:40 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'rt2x00queue_create_tx_descriptor()', there is no need to call
> 'ieee80211_get_rts_cts_rate()' while checking for RTS/CTS frame
> since this function returns NULL or pointer to internal bitrate
> table entry, and the return value is not actually used. Compile
> tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

5a1745807580 wifi: rt2x00: remove useless code in rt2x00queue_create_tx_descriptor()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231213051449.126963-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


