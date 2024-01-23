Return-Path: <linux-wireless+bounces-2375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD0838D91
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF4628957B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCD5D912;
	Tue, 23 Jan 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z67O9392"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507305D73B
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009922; cv=none; b=T1DHbbq7uIQjXoqybrzApp2wGmq4Vtf8VtwHXNzggEROe1jMXZBWJgpzq9/7Ugwtg40AZdn6czulFgU27Z0MT9VayKtYKVx0+ftKq3WtAupbincp0oYhpo4OMozT4TQlPLXCove2FhR9IvJElZBrUy47lcrpORu9g2BwbMWQb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009922; c=relaxed/simple;
	bh=b6zRFT7I2858fC6OAebz6jCTsOP9hC0azLiMCBBnFuo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=HF/35n4FwckEWKVUFNFD+LmJNvMbyDXhLaJqhVv7DDij+ursxng/AHDayOSfU9Zkvov94UscG69XbOsbdSekJpbS95hjgxsI0fUD7iDxZ2M0XG8Dqn8L57N48V3K1k+pGduhPlgewbomOk3uGmd+W4X7zI3fVZ57/J7063oLFBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z67O9392; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02F1C433C7;
	Tue, 23 Jan 2024 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706009921;
	bh=b6zRFT7I2858fC6OAebz6jCTsOP9hC0azLiMCBBnFuo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Z67O9392Y8nd+FpMOy7sFRLRk2uX5OZwta1jhz5XsLKmWWLG49kEZgptqoYSHd0pV
	 9unFZk4oZZIsbxfodQVUzbBH9NWsO8HtHG+c2Ud+R2vPbWqmjKaO/HdhnUI/3bireI
	 N1cA9TDaemC6iSw1McdzRBVVYCsUg1vVKqds9p47dhE/sLT8oAAlC04Hcb2eTtJSpO
	 XWQqHP8raV3GoxB+dcY4vVC1+dKQ2aOfb4VZAcj5FLhN+UGWxCfXiU4MutY/ezbRZb
	 Qf657BhUkAlF7ba5R5ZuEqxN9oAyOW4XpjkT7fukjathgvCjaQyVFbxoVecqkpfBDp
	 TT2HyzrVdgLdw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: refine add_chan H2C command to
 encode_bits
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240119081501.25223-2-pkshih@realtek.com>
References: <20240119081501.25223-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <gary.chang@realtek.com>, <phhuang@realtek.com>,
 <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170600991867.3962299.2944204672985698565.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 11:38:40 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Use struct filling style instead of pointer casting.
> This does not change the original behavior.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

49d158557474 wifi: rtw89: refine add_chan H2C command to encode_bits
b9979843febf wifi: rtw89: refine hardware scan C2H events
7cf6b6764b2f wifi: rtw89: Set default CQM config if not present
dab2b8c41db2 wifi: rtw89: disable RTS when broadcast/multicast
7e11a2966f51 wifi: rtw89: fix null pointer access when abort scan
bcbefbd032df wifi: rtw89: add wait/completion for abort scan
f59a98c82534 wifi: rtw89: fix HW scan timeout due to TSF sync issue
5ba45ba77616 wifi: rtw89: fix disabling concurrent mode TX hang issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240119081501.25223-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


