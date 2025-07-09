Return-Path: <linux-wireless+bounces-25086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17FAFE47E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67BD7A420E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512C287279;
	Wed,  9 Jul 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BDhyF9J0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18D28726B;
	Wed,  9 Jul 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053924; cv=none; b=sznd8SWSESSPtlKJCrIxcW8oNCjI1nSMUuMLwhLShzReycSMzzc6C19Y6V3hpFzsco/Qh0yg+xjx5GMOGzCsUL+TsbtIbq7nWPE7vpBr9sw2QF120x+bLrMtZrfKrwHnP5EAR4KEitAb5d6bYchi0OxqPB6uD8lqJsy09PqY+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053924; c=relaxed/simple;
	bh=IfVARssC/e/6ICtO7cP3Zm7g0j4V52NkdfC2FG0xnqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FFyM3Nr+WjbPn4up5/WBU4eU4DD++mxeQXDn/U6vHfCUViB80+Tol+kxxms2gLJ3TBs8q1M8qRW7ZC/Wr/bqc8mgINAlNu6UI4VYipFBunKw7TrpQ160pxqWdDZclNhQVa4lEbzKXFU5IKQm9biuOpz4yP9+yKbO0Msn04/8Zvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BDhyF9J0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=G/enIP3LgpSjrZJnLI4Xugtqu1O8tS9WsIl68GWUahc=;
	t=1752053922; x=1753263522; b=BDhyF9J09rQIcvblc4RCis6Ca5g5JhdTjl10/dfJKbQPPRY
	AAXor59Tn/xPB1BgTmXaQ2Eccn05nQsalecR0lYUd/Znz0YJHLV4ed/+pUuttCoG1xPgHLJcJm/5u
	wnHb1oW/ILT5gDYAvAmc8t32SXPaWnOH1+RwENVmKk0e4ga0+xnlct0n2En/qkdYaohj0D6M5E9pz
	VElhkZ2VUD4NyMmlmGa1Hjc7yb+8T/UuKbeL2rk2l+hRYRD/23yWRpObpOMn3h6QqeNL7GP/IALM8
	mBtLw84NieJZccfqFOfuBZ8IN7K430eDOeZrYblqalSTSmcvzpwQevK+Jux1Z+GA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZRFy-0000000DCrI-1iFJ;
	Wed, 09 Jul 2025 11:38:27 +0200
Message-ID: <9dd32e266523cc7f5f5fdc3e676216f4a0057615.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: parse attribute to
 update unsolicited probe response template
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Yuvarani V
	 <quic_yuvarani@quicinc.com>
Date: Wed, 09 Jul 2025 11:38:24 +0200
In-Reply-To: <20250709-update_unsol_bcast_probe_resp-v1-1-d3323ce9a7b5@oss.qualcomm.com>
References: 
	<20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
	 <20250709-update_unsol_bcast_probe_resp-v1-1-d3323ce9a7b5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-07-09 at 08:05 +0530, Aditya Kumar Singh wrote:
>=20
> +	if (wdev->iftype =3D=3D NL80211_IFTYPE_AP &&
> +	    info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
> +		err =3D nl80211_parse_unsol_bcast_probe_resp(
> +			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
> +			&params.unsol_bcast_probe_resp);

I don't see why this should be only for AP, not e.g. P2P GO?

johannes

