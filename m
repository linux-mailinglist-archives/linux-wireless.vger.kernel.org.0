Return-Path: <linux-wireless+bounces-29849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B188CC97F7
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 21:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E90AB303EAB1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B4261B8F;
	Wed, 17 Dec 2025 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="YBnGihbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD214A60C
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003602; cv=none; b=Io9tS/L1tuDWBNEq1iVW/jBjqdtkuYzShLkfsH42V1ML6ObyDe4CqG9u/hnQlHXvwgqpQ9SiJs6fvXu5VN5Htncupx8N8vaqak92e4aN7Y30sorcYJ9IagRxusEw3bfJnwLZfxU6InCpiKBMdzI6AyVHz/R7ZnTdWRFRp/hPjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003602; c=relaxed/simple;
	bh=mEYJFBrWBpb5SuzKSGlpPmpjvM2iMIL67vivKSY0plU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpvfuULmo8Nx9LXiRIp3m3MyM2BPodEfEC6o+uRATGaZwsIQCsiStq7m6OWXD6+4nDSmmZowt4JmIwD1uTgBVPZ7e9/x1bpwFhkBMvwt9RQ7BaX19evk9pft+2dXpB8E7ivVfArU6Kxwpg9mt2upRWgLTAUvBEL7AaOLP/1IWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=YBnGihbK; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.13])
	by mail.ispras.ru (Postfix) with ESMTPSA id 19FBB4076175;
	Wed, 17 Dec 2025 20:33:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 19FBB4076175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1766003589;
	bh=+gXlc3ik+9pViDfTqJih96LwNW/RB3YqrEIi+4/s8Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBnGihbKdUuUiKOIsSKzBaiz/63m5V5lo6eBcqmKUA7EH7azK2Mi87+/oBakV5rZe
	 sFqLXTQaImY3k8WXLmFdh9atiGvlnYdFNpn+tQeu+90y1JAuEfHuZClT+hJdraMiDY
	 NmwObbsCoGQfOnIPrPa04BfhODlvAOb8efMOINiY=
Date: Wed, 17 Dec 2025 23:33:08 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH rtw-next] wifi: rtw89: correct use sequence of
 driver_data in skb->info
Message-ID: <20251217232842-5e0e4ec9dfa63527255c049c-pchelkin@ispras>
References: <20251217072646.43209-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251217072646.43209-1-pkshih@realtek.com>

On Wed, 17. Dec 15:26, Ping-Ke Shih wrote:
> As ieee80211_tx_info is used to assist filling TX descriptor, and layout of
> IEEE80211_SKB_CB(skb)->driver_data (accessing by RTW89_TX_SKB_CB()) is
> union, so driver_data must be used by/after rtw89_hci_tx_write() or just
> before calling rtw89_hci_tx_write(). Otherwise, ieee80211_tx_info::control
> data is overwritten.
> 
> Found this by using injected packets which uses ieee80211_tx_info::control,
> but always sending incorrect data rate.
> 
> Cc: Fedor Pchelkin <pchelkin@ispras.ru>
> Fixes: d5da3d9fb05f ("wifi: rtw89: process TX wait skbs for USB via C2H handler")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> I'd let this patch go via rtw-next tree, because this change is conflict
> with coming rtw-next patches, and actually this affects injected packets
> function only which I'd consider as a debug function.
> ---

Thanks!

For the skb-waiting part

Tested-by: Fedor Pchelkin <pchelkin@ispras.ru>

