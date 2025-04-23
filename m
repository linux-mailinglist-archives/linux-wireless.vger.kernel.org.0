Return-Path: <linux-wireless+bounces-21910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7FA98A29
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9331B65095
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19317C2FD;
	Wed, 23 Apr 2025 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dVO0Rj96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF379D2;
	Wed, 23 Apr 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745412845; cv=none; b=pMWpdbmFLc6Tg4St4bmaHJaX726fTaOWvW+MqKDrx/Yg1BAoRwxkz6WQ2TUV/QSLxPAozr7YGaA8ZddXHxebfTyWsuW01avQQ4bq9JOuhtr/1iqMxYFp8ovUhZrlt10JuhaXSs9ZwTQgSRmTbHxnuIlkSUMGPepSWaSrzJUBDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745412845; c=relaxed/simple;
	bh=ZKAVMogWXPx2pj2K5Hh9LlE9qAqI5Iu2j9uhvzT38OM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzlaK1uMP7tYow8zXg+FQ9brS+Y5OL9T+lE7yHkoRGe/RsSQxE+up7hakRIRyT4KAWZpU/dx0QrGAJalI1a71sf3JELBEtmM5aBmoCgnXMykF0DKzibdYJGMmxmo3kqya36jbMQT/lrT4bhBCaiCYffyILkUoTukJY5SJYmExSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dVO0Rj96; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b0qvYVi5EKKwE4d58vIOem1eVuvc6m9T7pA9hU6GFgM=;
	t=1745412843; x=1746622443; b=dVO0Rj96yMJJjFjxpy/QBleZZ5HxPWK28C/le7dpDSsps+L
	X2wYSC+N9iUguA3RTgwunXPmUx1apwxcAj/IFJYnXi4sbr2XzhM26/s9PfOsrAd7maVawqRVZwQuC
	HRBOhO3tJ8kCBQUE17nxwDbjrSnh+zsja76n+5LoGHTyw7/AAuwhMaBXB2RaLsuJbSbdSvVAuIrfQ
	2NZLxc4W0EHgMbVtWPm/e+x++HO+AmuN/OTpMSdKzF84rQJ4Q/jMAGmaCKUJWrFUDhQYyxAupjs0e
	3eN3M2eSQYNQqISRaz5mQccHHyXtmVJPq9zvAdAOWyFLjcnsMLoM4fpNd1upSnQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7Zbu-0000000EfWY-2Ois;
	Wed, 23 Apr 2025 14:53:54 +0200
Message-ID: <b30cc04676a031db8c36df243160992094b3848d.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: Prevent tsf from setting if
 beacon is disabled
From: Johannes Berg <johannes@sipsolutions.net>
To: Edward Adam Davis <eadavis@qq.com>, 
	syzbot+064815c6cd721082a52a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date: Wed, 23 Apr 2025 14:53:53 +0200
In-Reply-To: <tencent_096EDEEED78C81A7D006E812E4C66E898A06@qq.com>
References: <67fac9a6.050a0220.379d84.0016.GAE@google.com>
	 <tencent_096EDEEED78C81A7D006E812E4C66E898A06@qq.com>
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

On Sun, 2025-04-13 at 14:11 +0800, Edward Adam Davis wrote:
>=20
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -1226,6 +1226,11 @@ static void mac80211_hwsim_set_tsf(struct ieee8021=
1_hw *hw,
>  {
>  	struct mac80211_hwsim_data *data =3D hw->priv;
>  	u64 now =3D mac80211_hwsim_get_tsf(hw, vif);
> +	struct ieee80211_bss_conf *conf =3D link_conf_dereference_protected(vif=
,
> +			data->link_data[0].link_id);
> +
> +	if (conf && !conf->enable_beacon)
> +		return;
>  	/* MLD not supported here */
>  	u32 bcn_int =3D data->link_data[0].beacon_int;
>  	u64 delta =3D abs(tsf - now);

Please keep kernel coding style - the line break there is awful (but
with "conf =3D ..." on a line by itself it can be just one line), and you
shouldn't have code before variable declarations.

The comment should probably also move because it's relevant for your new
[0] as well.

johannes

