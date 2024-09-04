Return-Path: <linux-wireless+bounces-12471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319EE96B6DF
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3E7B2BC01
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E321CF2BC;
	Wed,  4 Sep 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vrDsAfXg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103B1CCEF2
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442202; cv=none; b=Dak3dup7iUg16ULz2GYnmNv+MTgpWw2pR3kSdQX8XORRE1CFXIR6kqrboA4rvCKysJuCMzJ00JFqonZsrQwfKreX1pO7xVUuFjaFAzcdSeWFjpds8iHPUGFmNlZ9DnvlWd9pG73dGoadNZFo2lxyteEKhehmTTbEJirRneGjJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442202; c=relaxed/simple;
	bh=Rv7e/eoaMoQb4k7jiYJ9YlmB6O8BqlzXVXNWjf3vFzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tX0JNv40hgdwN6SyHGsCYuhYLKwMxnu9gvWWyJyc/5EUThVt9ag3IHQtouobvY6gLktNLw9fO06808HTPm4ms1JQrvoH4uxYbPB+GesUU4v6+bnNZKdtfYLIdFT2JubP3I7nlsk0U9zCv94kl0rA0Un9n7Z8npUReJpNupeb4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vrDsAfXg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QHwdImZwMaVc4O1Fs/2dN8M1RWteS+aWLr57hgj/EfU=;
	t=1725442200; x=1726651800; b=vrDsAfXgbZRCf2ZQrKaaHOGWiKNNTnla9WnWFKzaDA9BIWL
	+dxzjKQEJ4PzNEf6PeM+9YNdUVsLQQrwosIp2izUmg/o4Jgx7XCJEyn4hJpWQO7LH+nSS9Pp5Nlbn
	zcJDapLNDpveg+HONs+wSTD9bFFTGedt2jrZIB3vgeKWizrtHX86HPzs/6obXrHH5yNVIULONukHr
	Wka/zYsEzRN9bCgNHQT2hIjA2Hz+5hCeUc6rkMKFyy/Yhot9JWduo+P1PbhNVo5YaWl0c2WsplMT7
	lVUpYI/vAvptqk69L/TXv7jYzco7EK/P12j5eA2eChV/FJP2PShZRulPCtCTcOCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slmKq-00000004Z9a-39p8;
	Wed, 04 Sep 2024 11:29:56 +0200
Message-ID: <df96a65701b5c72d78805b7f7c518670ae794f2b.camel@sipsolutions.net>
Subject: Re: [PATCH v4] wifi: mac80211: introduce EHT rate support in AQL
 airtime
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, jonas.gorski@gmail.com
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, 
 Leon.Yen@mediatek.com, Michael.Lo@mediatek.com, Eric-SY.Chang@mediatek.com,
  km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com, 
 posh.sun@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
 Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>
Date: Wed, 04 Sep 2024 11:29:55 +0200
In-Reply-To: <20240904091749.7311-1-mingyen.hsieh@mediatek.com>
References: <20240904091749.7311-1-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-09-04 at 17:17 +0800, Mingyen Hsieh wrote:
>=20
> @@ -443,13 +549,18 @@ static u32 ieee80211_get_rate_duration(struct ieee8=
0211_hw *hw,
>  		idx =3D status->rate_idx;
>  		group =3D HE_GROUP_IDX(streams, status->he_gi, bw);
>  		break;
> +	case RX_ENC_EHT:
> +		streams =3D status->nss;
> +		idx =3D status->rate_idx;
> +		group =3D EHT_GROUP_IDX(streams, status->eht.gi, bw);
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;
>  	}
> =20
> -	if (WARN_ON_ONCE((status->encoding !=3D RX_ENC_HE && streams > 4) ||
> -			 (status->encoding =3D=3D RX_ENC_HE && streams > 8)))
> +	if (WARN_ON_ONCE((status->encoding > RX_ENC_HE && streams > 8) ||

That should've been >=3D, but I feel like it might be better to move the
warning as multiple warnings into the switch statement now? The > and <
here also makes it vulnerable to reordering, which is probably not going
to happen, but why put the trap here?

johannes

