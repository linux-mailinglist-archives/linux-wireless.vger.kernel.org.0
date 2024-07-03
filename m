Return-Path: <linux-wireless+bounces-9898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3830D9254F4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BB61F257D2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6736137911;
	Wed,  3 Jul 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jPDMoWRN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6A944E
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993390; cv=none; b=GjJ88zonBJ3//I+ec9zbd7UzARAd4jxCLi+9vkZcU4QjFyRa6CTo7spay81OmHK8y2AIlNh9G/ejUnzjU46eu1d84a1JNtk/Q4ezgpl+VUp1M6pchrzogchLV4EsSnlu7zihvSNGiGCRxGLrtBk3EY7MKPtnMvp7GklNpn5oFGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993390; c=relaxed/simple;
	bh=04gn69zeQgAjW+tRUaQleQ/3L/zkOnf0oyvcuBwlrEc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKld7O4p/Lo8rzwTKAeC+ORd6ogHA1HLni+bol+cO7LUNgwN7XUpuGiQzc1hiQetFNdqYMIXVfQ4Pg1+z7dUOUjKvnR3/BZQAXXyqzQ+a/GY4FYfITVJ2bWVbRz1J5V29GA955QquNEaEWKMaqLNb4D3pAFU6Ms8TnWxY4JXcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jPDMoWRN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=50o4FK2NuR6uCQCYW2rWTp4vev5DmA/fzwlb9xDLSNQ=;
	t=1719993379; x=1721202979; b=jPDMoWRNmrC9veSnVHWCQf5rfjUi+Z93ZbjoUPUr9TjAPBA
	W/C5K30UGn+YF0NPgTjw0CfPw2AyZKfRtxyeoZ/WIOTR+YnHx4lfypCX49Qhs2Vb1YapFTdtL33FA
	aLZ5lMGQlLYlF6YnkyUMdOFap1Qd8NRTkpmgAElACdvY9b1QGsH1zHfIiJyYPXh/8075O70IT6jNL
	IJznBVcty1rvr4wTdFqrwsGsengbC7jYnUQ/iCApzKZxBEEbdc02dMM1fNOvCSjsAdy2BozUq28Yo
	mWWMwpPol5sPIQ9c8y7LcamPpELxpXuQmk7dlcjwmKh0pnr6nrBT+04eoWQw0anQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOuqZ-00000008IGV-2hmt;
	Wed, 03 Jul 2024 09:56:11 +0200
Message-ID: <983953af2a1e68031435c18dc12fedb0c2d82c9b.camel@sipsolutions.net>
Subject: Re: Adding EPCS Support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Youzwak, Jason A (PERATON LABS)" <jyouzwak@peratonlabs.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Wed, 03 Jul 2024 09:56:10 +0200
In-Reply-To: <BN0P110MB12102BF7BDD2D28E95373DD9D4D3A@BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM>
References: 
	<BN0P110MB12102BF7BDD2D28E95373DD9D4D3A@BN0P110MB1210.NAMP110.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-07-02 at 12:45 +0000, Youzwak, Jason A (PERATON LABS)
wrote:
>=20
> We are implementing a Wi-Fi 7 feature called Emergency Preparedness Commu=
nication Services (EPCS)

good luck :)

> - Define new nl80211 commands: NL80211_CMD_EPCS_ENABLE and NL80211_CMD_EP=
CS_TEARDOWN=C2=A0

seems reasonable so far

> - Define new STA flag: WLAN_STA_EPCS_ENABLED

That may be necessary at some level, but it might not be possible for
drivers to handle it at the STA level - EDCA parameters are usually set
per *link*, not per *station*. Also, a STA now represents a whole peer
MLD, so affects potentially multiple links.

> - In net/mac80211/mlme.c, in ieee80211_mgd_set_link_qos_params(), if the =
WLAN_STA_EPCS_ENABLED flag is set, ignore the EDCA parameters from the Beac=
on and apply Priority EDCA parameters.

Except you never even call ieee80211_mgd_set_link_qos_params() so this
cannot work.

> 1. Sending EPCS Enable/Teardown commands to the kernel (mac80211) from us=
erspace (hostapd) via netlink.=C2=A0 The response was "Operation not suppor=
ted on transport endpoint (-EOPNOTSUPP) (-95)".

This is so basic I don't even know what it could be. There are tools to
debug netlink, even "iw --debug", or you can print in the kernel what
happens ... Or even run an ARCH=3Dum kernel and attach gdb.

> 2. Receiving, parsing and propagating the message via nl80211 and cfg8021=
1.=C2=A0 Specifically, we would like guidance on storing parameters receive=
d in the NL80211_CMD_EPCS_ENABLE message and retrieving them in the net/mac=
80211/mlme.c module.=C2=A0

There's a whole 20kLOC file called net/wireless/nl80211.c that's full of
such guidance, please read it.

> 3. Applying the new EDCA parameters in mac80211 module.=C2=A0

Now you're just asking us to do your work ...

> - Is the kernel the right place to implement this or are there user-space=
 solutions that we can leverage?=C2=A0

On the AP side you can change EDCA parameters from userspace, but on the
client side I think you do need such new commands, at least to override
the automatic settings - looks like otherwise
NL80211_ATTR_WIPHY_TXQ_PARAMS _could_ even be used.

> - If kernel modifications are needed, does our proposed approach make sen=
se, or are there better alternatives we should consider?=C2=A0
> - Is there documented guidance on how to add such features to the kernel?=
=C2=A0
>=20
> Please see our initial work to provide basic support for EPCS messaging i=
n Linux kernel 6.9.5 on Arch Linux in the patch below.

Please check out
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
and more generally
https://wireless.wiki.kernel.org/en/developers/documentation

> +++ b/include/net/cfg80211.h=C2=A0
> @@ -4855,6 +4855,10 @@ struct cfg80211_ops {=C2=A0
> int	(*del_tx_ts)(struct wiphy *wiphy, struct net_device *dev,=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 u8 tsid, const u8 *peer);=C2=A0


this is for much later I suppose, but this patch is completely
whitespace damaged ...


> +=C2=A0=C2=A0=C2=A0 /* JY: PLABS ADDED */=C2=A0

???

> /* add new commands above here */=C2=A0
> +=C2=A0=C2=A0=C2=A0 /* JY: PLABS ADDED */=C2=A0


???
"above"?

> +static int ieee80211_epcs_enable(struct wiphy *wiphy, struct wireless_de=
v *wdev)=C2=A0
> +{=C2=A0
> +=C2=A0=C2=A0=C2=A0 struct ieee80211_sub_if_data *sdata =3D IEEE80211_WDE=
V_TO_SUB_IF(wdev);=C2=A0
> +=C2=A0=C2=A0=C2=A0 struct sta_info *sta;=C2=A0
> +=C2=A0
> +=C2=A0=C2=A0=C2=A0 sta =3D sta_info_get_bss(sdata, sdata->deflink.u.mgd.=
bssid);=C2=A0
> +=C2=A0=C2=A0=C2=A0 set_sta_flag(sta, WLAN_STA_EPCS_ENABLED);=C2=A0

sta could be NULL, then you crash. deflink is wrong for MLO and yet you
say you want to implement a WiFi7 feature. Setting a STA flag has no
immediate effect, so nothing will actually happen here.

> +/* JY: PLABS ADDED */=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
> +static int nl80211_epcs_enable(struct sk_buff *skb, struct genl_info *in=
fo)=C2=A0
> +{=C2=A0
> +=C2=A0=C2=A0=C2=A0 struct cfg80211_registered_device *rdev =3D info->use=
r_ptr[0];=C2=A0
> +=C2=A0=C2=A0=C2=A0 struct net_device *dev =3D info->user_ptr[1];=C2=A0
> +=C2=A0=C2=A0=C2=A0 struct wireless_dev *wdev =3D dev->ieee80211_ptr;=C2=
=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0 rdev_epcs_enable(rdev, wdev);=C2=A0=C2=A0=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0 return 1;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0

what's with all the whitespace?
Also, "return 1"??

> +=C2=A0=C2=A0=C2=A0 /* JY: PLABS ADDED */=C2=A0
> +=C2=A0=C2=A0=C2=A0 {=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cmd =3D NL80211_CMD_EPCS_ENA=
BLE,=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // PLABS: If we encounter iss=
ues, remove validate=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .validate =3D GENL_DONT_VALID=
ATE_STRICT | GENL_DONT_VALIDATE_DUMP,=C2=A0

Eh, no, always remove it.

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .doit =3D nl80211_epcs_enable=
,=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .flags =3D GENL_UNS_ADMIN_PER=
M,=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .internal_flags =3D IFLAGS(NL=
80211_FLAG_NEED_NETDEV_UP | NL80211_FLAG_MLO_UNSUPPORTED),=C2=A0

So ... a wifi7 feature that doesn't support MLO?

> .small_ops =3D nl80211_small_ops,=C2=A0
> .n_small_ops =3D ARRAY_SIZE(nl80211_small_ops),=C2=A0
> -	.resv_start_op =3D NL80211_CMD_REMOVE_LINK_STA + 1,=C2=A0
> +=C2=A0=C2=A0=C2=A0 // PLABS Changed=C2=A0
> +	//.resv_start_op =3D NL80211_CMD_REMOVE_LINK_STA + 1,=C2=A0
> +	.resv_start_op =3D NL80211_CMD_MAX + 1,=C2=A0

No.


I don't think that patch was helpful, but since I'm not going to
implement it for you, you're going to have to do a lot more homework in
understanding the code base, how this feature should work, how to submit
changes, etc.

Good luck!

johannes

