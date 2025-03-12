Return-Path: <linux-wireless+bounces-20220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C8DA5D88A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E820189D35A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5A2376F2;
	Wed, 12 Mar 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ieoK+GnH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F92376FE
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769103; cv=none; b=Bd5LwHHXfqp2NxJLRal/xwpKt00z9YeZEHoktHH3QJatICET9ZeMFxVmGNlZUU8UMAZ0eBvIQ1YUtUeFBg6zu8D9ZcE4PFPdrBe1U87qo5Nb7SfmUrYbRGs1s9m1KH8coHAftGmRBtZ5hFftC8oD7Bm0YTaHGFHLIj0shTFCgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769103; c=relaxed/simple;
	bh=vP8EXNmrrvqitRTuGVT/HRTAq2FbgcGNQWKvqGpzB0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmIcwiKnHbIEk4x6RTXDOlGARzkJmqq5dXBPSe83pmqgD2yNpbDIZPFI9Kssen24lwgw7CN934VPYmEIXHEBDwRhBf7TH6az96JazXHY2Bq4kYaiAK/Bf9kfzsRhHPdowbT3FKtXsspoqb1yNt7/BC1iCvVD0vWRvPQEiJXND3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ieoK+GnH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SdRNDbD9QNhaqwJnKINMO/VhNx+JV02lMJktUq7SPiE=;
	t=1741769102; x=1742978702; b=ieoK+GnHTo/u7euHQDIVK9n8aKykOznEyHktFnC0+YmgXW3
	CqkkMgeOZQGI52q+JY0j583h93TaD3JZxx2S84LrVwENCT7rh6nIX9C/kBxaYJI3/LyY1EuYhOS/A
	5mj42a6+1EB9miicbk4mgtzFwk5+MF2H8RpwFlOj+VKqpA/gspWC9kQB1tBKVkIl7oQwK82I9C7v7
	3+DpxwPnD+BZ5y4rt5WvdYroRyWk3D0aQUitihUV9d5RWFHtZSkzykfDFVenw/dcVAuY0jpIKSc49
	8WIwyHnKqndGuwjJvP0HSokedwhn1xNQOmiXh9HGL7oXnKyP6x3zE8ny5pLRaD6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tsHhy-00000008oEC-3hjT;
	Wed, 12 Mar 2025 09:44:59 +0100
Message-ID: <56274f96c44f476e9ac0fabe75e89a43e79c9a58.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v5 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 12 Mar 2025 09:44:57 +0100
In-Reply-To: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
References: <20250312065132.3397726-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> V5:
>  - Rebased the patches.
>=20

It's getting _really_ annoying that you keep sending patches that either
don't apply or don't build cleanly ... Please be more careful in the
future.

johannes

