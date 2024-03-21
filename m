Return-Path: <linux-wireless+bounces-5111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63548860BD
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 19:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0F61F226C8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FE374C2;
	Thu, 21 Mar 2024 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="WJCYT0iq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A913173C
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046800; cv=none; b=KDEO1V4Us8LN5lLh28fFpmFTnCA84Gs59LBl2CE9n8KTT55CY+szyJO95gnHD7D9605X+LK/ND4Wm2MZD2Us7hWaOhjrNaNMpR5nPbeair6OTCYdZkNFxPyHuppE0/gyCj13h/uzbuNzKgcI6Q/iBEXlvsg7/vAg+zPmWpHKZtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046800; c=relaxed/simple;
	bh=ULnLCRbQtIWv76zCYb/iIUCYNlLzGdjDZpiGF0D9kFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLTvj0zSJDWpZCmWRwOU/fhpAhyg08d45Q0DNLtR6Nf28pTgGDrelW9R0QiBSl3RvYe7g3jyfDSOQHaE4DIDePVAGIRwOVQdXDK2CQG5XlF10J02NPU/8GnuSiNUEx8dlDA0XBA3JAfQ1HWQTa5lPt24T2XPp+wTw22fJ0gpGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=WJCYT0iq; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1711046257; bh=ULnLCRbQtIWv76zCYb/iIUCYNlLzGdjDZpiGF0D9kFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WJCYT0iqAF0IBlCvQ+D8RjfLeITAOW3NGliRVE/gTGfS0TA5B55P4yuSfyrqzd9Qu
	 of5b3r9utHd8p9CTl0DdpjIN2dYtFEs0kAwf/iqihq7qJPAq2sQK/OK/QSubEYbdKf
	 xwqT5X/uNuEEi96dgOhkwjouzf42N+JkHdTeUK64Cy9mhW4RT/+f8LgEZa82zPaiow
	 WrZIFCjQPhQy0+PVUkMISThGmE+Pe29MOCS0w6bTEUH/OteFwUJh/LlJeDVO1JV/gH
	 KDWgzvyAx/Gzt8U5gZePXI6qYkJFvecbE2Lsnq2JTUkGX76KEWwlPM5pYa+yBMkrHY
	 JFcnJ8qr7PiBw==
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
In-Reply-To: <20240320170656.3534265-2-kvalo@kernel.org>
References: <20240320170656.3534265-1-kvalo@kernel.org>
 <20240320170656.3534265-2-kvalo@kernel.org>
Date: Thu, 21 Mar 2024 19:37:37 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <875xxfh1n2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Sparse warns:
>
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20: warning: incorrect type in=
 initializer (different base types)
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    expected unsigned short=
 [usertype] mask
> drivers/net/wireless/ath/ath9k/xmit.c:1677:20:    got restricted __le16 [=
usertype]
> drivers/net/wireless/ath/ath9k/xmit.c:1681:17: warning: restricted __le16=
 degrades to integer
> drivers/net/wireless/ath/ath9k/xmit.c:1682:42: warning: restricted __le16=
 degrades to integer
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36: warning: incorrect type in=
 assignment (different base types)
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    expected restricted __l=
e16 [usertype] frame_control
> drivers/net/wireless/ath/ath9k/xmit.c:1682:36:    got int
>
> Fix ath9k_set_moredata() to use __le16 with masks and use if statement in=
stead
> of multiply operator.
>
> Compile tested only.
>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

