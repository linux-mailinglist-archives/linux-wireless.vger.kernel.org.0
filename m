Return-Path: <linux-wireless+bounces-19582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C73A49A26
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 14:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EC4170F94
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C95261579;
	Fri, 28 Feb 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XMPmzQz6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780B2F41
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747827; cv=none; b=r3J1ZB31d4RG53DwmCBLBw6d0cJjbXvPbCb7rzviBGblzrJiNpG3E4B4MshqSl3RiKrVQGcHg9VpHY4NG9Zb3mI9b4ylaoZpK93LhOS/LBYWnPgKkxXp8LaxTpr8saz++awLWkKjL8XG4n7VqwEL+vKMPfxln9HHZVmqguX7pyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747827; c=relaxed/simple;
	bh=1Ik+odr3BnUZ/oZupVXShOQC857vCz26qea8m5c0ri8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hix8wknKtcCKc+GBZbpJUWbUJdQ918XENVV0qiqcHLW3wGKbE5n/8tP3CvbpZ1smqO8O6Vz0eECYrQF+g9Kmy/U55/DK7FSuiMOLOAj7R8oUtgIUIKC1+IDbyBcW22Mf8QZrymLmtqlfkkgsEVks+KQscFL+ZsJQhaXxyp6xv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XMPmzQz6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fPh7Z4MnZ5ra59QNuM/EUIH1aYDOWYc2qu/ettE3ydI=;
	t=1740747826; x=1741957426; b=XMPmzQz6GKGPs3i3tNecj+VxT5kfkaYdNqxxG4dXQ2z6kmv
	vxson0zGrbS7MCitAEp+Eg8ps4UL7u78c/mb1Gh5noiBDSj45rzuw4u3kBjztL+UTP2OZTMyq0tuo
	o8ynR+4xP32C//VCfhMI1MNR2/C8t26L1GibVChVbwGAH+SDnRqc7HAzRIy7/VzwdBIYTRm7+EAaA
	fdDJK7ssN0+y6yq4iknx5qSYuzVWd3cmqk9e7Z176wt32v9hbLS9+RxrW73t64kyejQh2Sc67k93h
	k74B1f9kw6wyyYRjx7U5CVhAGMNJL0TMGOXpKXADuQXNyrTgmRU0wrQvUq4/oc9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1to01m-0000000DkMR-2WN0;
	Fri, 28 Feb 2025 14:03:42 +0100
Message-ID: <7ff2d1dd2a83d9047c128035296db1651bcb6b91.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/5] wifi: cfg80211: Report per-radio RTS threshold
 to userspace
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Feb 2025 14:03:42 +0100
In-Reply-To: <20250129155246.155587-3-quic_rdevanat@quicinc.com>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
	 <20250129155246.155587-3-quic_rdevanat@quicinc.com>
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


> @@ -2449,6 +2450,9 @@ static int nl80211_put_radio(struct wiphy *wiphy, s=
truct sk_buff *msg, int idx)
>  	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
>  		goto nla_put_failure;
> =20
> +	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD, rcfg->rts_=
threshold))
> +		goto nla_put_failure;
>=20

There is, fwiw, still a preference for shorter lines.

johannes

