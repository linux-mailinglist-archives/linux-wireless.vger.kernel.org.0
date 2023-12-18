Return-Path: <linux-wireless+bounces-944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A998179F5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC351C22F7A
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7251DDFC;
	Mon, 18 Dec 2023 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIry3h0G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8592904
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 18:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006BCC433C7;
	Mon, 18 Dec 2023 18:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702925199;
	bh=EptGzg58+cPDd7g/9aUY/r/Wd8WbVa8/AZav0tjNyM0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=MIry3h0Gsxssmek7lwBHVtR046CRJURNbNjUvX5PElaU3dQKE0aAHbKQTG761dXV4
	 DeWQzHjX+hUQXOQKjkUGr+pvEbo4EVo+sBh76TPJb19Qb1Rq+4ZQGVQeRpRiYrIi/T
	 9QJMmb3mgGJCiTMuVN0nD+nfsDFdAdwUb8wxGTn9bhFZb2gBN1rlSbG737xkiJeW23
	 vuOWFINkFxsC37fyV0ey65jIw9tN3lkXNU+lDR80sz5q6XfBjw4XKOccZKZcwGVj5Q
	 5h6+Thj++axj9aayjtaT2mtwugd6CWjvFlKgEmTt70qimDi4D2CYp1g9INghQdCtWM
	 2ba/9Dl535whw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: fix LNA selection in ath_ant_try_scan()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231211172502.25202-1-dmantipov@yandex.ru>
References: <20231211172502.25202-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen_?= <toke@toke.dk>,
 lvc-project@linuxtesting.org, linux-wireless@vger.kernel.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170292519633.424292.4014017811010090345.kvalo@kernel.org>
Date: Mon, 18 Dec 2023 18:46:37 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'ath_ant_try_scan()', (most likely) the 2nd LNA's signal
> strength should be used in comparison against RSSI when
> selecting first LNA as the main one. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d6b27eb997ef wifi: ath9k: fix LNA selection in ath_ant_try_scan()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231211172502.25202-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


