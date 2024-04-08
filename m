Return-Path: <linux-wireless+bounces-5978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6920589CBDB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 20:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C19D1C231DC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Apr 2024 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2866A8A4;
	Mon,  8 Apr 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lKNzHG/Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3C1272BF
	for <linux-wireless@vger.kernel.org>; Mon,  8 Apr 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601694; cv=none; b=GNPSzizK4yTySjNV8uvN5Ins91cCwyBjWyZIOP+ps1zP5jGSJnP2hTseulFKl9HPMAryBUmJEQHgr31UhPFcyrlBJa1rOJ/rIBxevoMaMnAENdre4mBNTsccGanPrtOENVS8PZkPX4LTc9ZxdxilzM55yPUAnB5+/LgVgYfNr+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601694; c=relaxed/simple;
	bh=5+w8V/rX9ddmjqFs5wIkaPQ9quXPXWJfuGZ6A0Ytl3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gWN1K4/tQVsHH7LkvUid+LirLBhggfbVH8DQlgO727iyOcY1S2YicSEgtbDqc4cUs2JFsbzGIBNkDDugbUpdKXOlB+mTbiM+s2nJimf1hi3RJG4rPx87KuvT6LhnUuShOfyCXlpKmBPZJsKQe/Vm9G9jJf2WJntCmU1KR606qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lKNzHG/Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PSGasXfZtO+c9IL1zinDoYDH1VVpFxRJQjka+adS58A=;
	t=1712601693; x=1713811293; b=lKNzHG/QlxtbmrCS1ncXLqmWVXtUtSD5ACL+HRm5s68DxFz
	0DKYbRnAkCmBLV8VTe1guTAbu45pxs+j5aL7geylOLtzYpe/vTUtmv4NI6QfLiK11lckHYeocWlCC
	YKbvBTiTXSC3JQLB6lhXvMh4h9GxEVWjVLrSKhalqqXOCaSCyqhd3GzXP/+Bn+gf4MLaiA0zlRTMS
	n+V/ps2Mlz1c8khP/cT+k75PCaDmqkS20nbPdTNCDfmeoyznnyGVeMgAySvU8jNci7goUa4lcYRtI
	SL1lEqz5LqiYWv0exmkpjq/mgjceClcFDeRHOx4hhzyVor+fQkDLjT+XVABRWtbQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rttvs-0000000GQlm-0K3H;
	Mon, 08 Apr 2024 20:41:28 +0200
Message-ID: <e599d1b1c7c6e32856eb5374cfaa20965b49b44c.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Clear mlo_links info when STA disconnect
From: Johannes Berg <johannes@sipsolutions.net>
To: Xin Deng <quic_deng@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 08 Apr 2024 20:41:27 +0200
In-Reply-To: <20240327032448.15098-1-quic_deng@quicinc.com>
References: <20240327032448.15098-1-quic_deng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-03-26 at 20:24 -0700, Xin Deng wrote:
> wdev->valid_links is not cleared when upper layer disconnect from a
> wdev->AP MLD. It has been observed that this would prevent offchannel
> operations like remain-on-channel which would be needed for user space
> operations with Public Action frame.

I agree that's a problem, we shouldn't leave the valid_links set.

> Signed-off-by: Xin Deng <quic_deng@quicinc.com>
> ---
>  net/wireless/sme.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/wireless/sme.c b/net/wireless/sme.c
> index 82e3ce42206c..86e837f37f8c 100644
> --- a/net/wireless/sme.c
> +++ b/net/wireless/sme.c
> @@ -492,6 +492,7 @@ void cfg80211_wdev_release_link_bsses(struct wireless=
_dev *wdev, u16 link_mask)
>  				 &wdev->links[link].client.current_bss->pub);
>  		wdev->links[link].client.current_bss =3D NULL;
>  	}
> +	wdev->valid_links =3D 0;
>=20

But this is (very obviously, even with only the limited context shown!)
in the completely wrong place.

johannes

