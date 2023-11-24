Return-Path: <linux-wireless+bounces-64-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FB7F8380
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C7288416
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669C37170;
	Fri, 24 Nov 2023 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L7lQGkLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32DE268F
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DEDBYl1c/XJDbk4iFcYtawgCZt7aMSZ++/KGczMT2f8=;
	t=1700853185; x=1702062785; b=L7lQGkLVrWYMj1i+aNCtdIaFB2t2qw0o43SJLUNq5FXc0Gi
	KRIFoidOSG7hRwtHEc2xR+AWvk8t3qUPVcAZKa5lga6nEblq3klAcKwqthWMI4Z2P25MZVA3UX5V8
	eqMIE3rce+HzE5ca6ibqNc4G4uTqMuqYgeD0BIcG6zqIX9uGx2PHfI+Nrh6GaCzVLb39isUs6WYf5
	DhY2/+uG26UylC7JgN1sNKpUHNBRUkG0GWsgNAeQ8HuFvwW1kuN5A/NeAuyrdnMg8Nwcr1+0u0qpz
	8BMR/QXXyecIOfTU/t6FovjbRuD8oyGcbjjkpScdWSCQSHXNcjStEqY3Nz+/XKJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6bbr-00000002jhM-2LVU;
	Fri, 24 Nov 2023 20:13:03 +0100
Message-ID: <782a4f7ac91dcb0e1c564e285051c63e2a95d71f.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS
 STA channel change
From: Johannes Berg <johannes@sipsolutions.net>
To: gregory.greenman@intel.com
Cc: linux-wireless@vger.kernel.org, Andrei Otcheretianski
	 <andrei.otcheretianski@intel.com>
Date: Fri, 24 Nov 2023 20:13:02 +0100
In-Reply-To: <20231113112844.15d7a0ee3fda.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
	 <20231113112844.15d7a0ee3fda.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-11-13 at 11:35 +0200, gregory.greenman@intel.com wrote:
>=20
> @@ -9302,6 +9302,17 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 =
*bitmap,
>   * case disconnect instead.
>   * Also note that the wdev mutex must be held.
>   */
> +
>  void cfg80211_links_removed(struct net_device *dev, u16 link_mask);

What happened there?
=20
> +/**
> + * cfg80211_schedule_channels_check - schedule regulatory check if neede=
d
> + * @netdev: the device to check
> + *
> + * In case the device supports NO_IR or DFS relaxations, schedule regula=
tory
> + * channels check, as previous concurrent operation conditions may not
> + * hold anymore.
> + */

...

> +void cfg80211_schedule_channels_check(struct net_device *netdev)
> +{
> +	struct wireless_dev *wdev =3D netdev->ieee80211_ptr;
> +	struct wiphy *wiphy =3D wdev->wiphy;
> +
> +	/* Schedule channels check if NO_IR or DFS relaxations are supported */
> +	if (wdev->iftype =3D=3D NL80211_IFTYPE_STATION &&
> +	    (wiphy_ext_feature_isset(wiphy,
> +				     NL80211_EXT_FEATURE_DFS_CONCURRENT) ||
> +	    (IS_ENABLED(CONFIG_CFG80211_REG_RELAX_NO_IR) &&
> +	     wiphy->regulatory_flags & REGULATORY_ENABLE_RELAX_NO_IR)))
> +		reg_check_channels();
> +}

That ... doesn't even use the netdev pointer, apart from going to the
wiphy? Why not have a wiphy argument instead?

johannes


