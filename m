Return-Path: <linux-wireless+bounces-15542-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE59D4894
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 09:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DCC2828CE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14861C9B8C;
	Thu, 21 Nov 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqkRj3xp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B8146A6B;
	Thu, 21 Nov 2024 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176801; cv=none; b=qhTkHMrZ8iWVGyGIbIdjA4hrYtCk2dX7hRQGGk+SewAwCFGYHfXmX9lQ3EXmtSGl6ol3TuSk4SxHxdnh+qVgWp+1FAlbepqXKr+14NPeZMYzz8Do+t+Axjg/WnRVh4QnARHw1sg8XkT17vK3yF5st5LvUHEebPjEZBKepnxfD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176801; c=relaxed/simple;
	bh=yYU77W5hMPwN/8MGum399jtWX0B3yXjlv1mt4BYMu/Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XNTQVhF6JyQh70LfM8cIzrls/CdPxIN8YlMuJ908EFKHV6Zjl/XLvOiatorGBJHn1AC2EFC28b2s3hE4HSaHBxLtgDwtGMCLyoKH/fGdT+vDtE/q11uZu4nLhmluWv6Vc79zdKlTuMUKjTyv3BTEFi1tgTMg4/HtlVC4GOHBy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqkRj3xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D27C4CECC;
	Thu, 21 Nov 2024 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732176799;
	bh=yYU77W5hMPwN/8MGum399jtWX0B3yXjlv1mt4BYMu/Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QqkRj3xpp/DAV81o0ivaN6X048i7YtJgQF0oHhyNyuTg9bCcdzE+JlHpgZr4IY4OY
	 6Kpq3aqgSQyLPtxiwINyf5fpEWaay0MTw+cQ0jYm0cnPFuvCyQU9ACtFzDm0wdxrkc
	 KL0FUu04qAK6+8Y4js0MJ2xt6JwZU0zJEicmZlC/4i38lJgIVdRvRrPeNX6JicNqBR
	 7n/N0mnAbSWvoCGFrnpbtQkbqSY5Psi36uAtMVKO4bU1ISHV4VcD+aQsHqa4Bu2DhP
	 ajuAbE7HPkqks+PYo82Xsh3uNR5kbkBrHTlseJ7iuxMyAXdyEIFY+mIyRf4GeJpSz/
	 NHFBJr36h2CPw==
From: Kalle Valo <kvalo@kernel.org>
To: Renjaya Raga Zenta <ragazenta@gmail.com>
Cc: Arend van Spriel <aspriel@gmail.com>,  Franky Lin
 <franky.lin@broadcom.com>,  Hante Meuleman <hante.meuleman@broadcom.com>,
  linux-wireless@vger.kernel.org,  brcm80211-dev-list.pdl@broadcom.com,
  SHA-cyfmac-dev-list@infineon.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: fix brcmf_vif_clear_mgmt_ies when stopping AP
References: <20241121-brcmfmac-v1-1-02fc3fb427c2@gmail.com>
Date: Thu, 21 Nov 2024 10:13:15 +0200
In-Reply-To: <20241121-brcmfmac-v1-1-02fc3fb427c2@gmail.com> (Renjaya Raga
	Zenta's message of "Thu, 21 Nov 2024 14:09:27 +0700")
Message-ID: <8734jlypgk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Renjaya Raga Zenta <ragazenta@gmail.com> writes:

> This removes the following error log when stopping AP:
>
> ieee80211 phy0: brcmf_vif_set_mgmt_ie: vndr ie set error : -52
>
> It happened if
> 1) previously wlan interface was in station mode (wpa_supplicant) and
>    connected to a hotspot
> 2) then started AP mode (hostapd)
> 3) and then stopped AP mode.
>
> The error happened when it tried to clear BRCMF_VNDR_IE_PRBREQ_FLAG.
> This flag is not set in `brcmf_config_ap_mgmt_ie`, but
> BRCMF_VNDR_IE_ASSOCRSP_FLAG is set instead.
>
> Signed-off-by: Renjaya Raga Zenta <ragazenta@gmail.com>

'wifi:' missing but I can fix that, no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

