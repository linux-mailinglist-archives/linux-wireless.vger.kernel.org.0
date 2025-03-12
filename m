Return-Path: <linux-wireless+bounces-20222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0479A5D8B2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803453B5752
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F97F235C16;
	Wed, 12 Mar 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g47B97lG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F921B6CF1
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769751; cv=none; b=fZcneV4qljgOV9Btd4ZBNY1UDNGvBPaP7fDaZ1BLqBb5LH5Tf19gTZwLf8VtWE3LP49nBaGkZ3/UhAmES3A6V+xybWM6/hktrqVF2Ayf/twJnj/6L1AEj2vqD/DzB44XrrXkfJZqvXzOj1CnZu2kb67QfyegcgW1Mo3RSelTvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769751; c=relaxed/simple;
	bh=g335ojpDUfo/UkoeZpSW+lOmGFMt8shtJloGM7+WDEc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rn6yQ9ry437dJIbdny+YL8g+fa8doLd7Y5inr16WPv2fNFEqaeCvYJHFAnwEE109fQToDrhNF08xPSXBj27HmBwbkaNtCGQP+RwyS9TR1poxOMvQOU2rPIeFyeslT+zhLX3wCDWSKzdSegk4JTqebUI7ibEHpTkvOxJ36uiTvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g47B97lG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=T+PilNQZoDFiaeryP0xd6L+XbRHr4cTqiRxLDV+1U+E=;
	t=1741769750; x=1742979350; b=g47B97lGR/Y05JxrSzRxXGqIUgoAJNiyKj8eVboAjziIOaZ
	AWe6VIZt9YuJgk5W5S18xHgJlUYGoGA4jSlouvHvtzHA/RaXLOwcxtoA6tKt5NDerzoRzjPBtyzme
	Vz6aVi/LUClsBNVRTyiox6pTMLgVLgj3YmrUJDSp1erSwH3c01Wr16lkpTsusWI9mHcfsUMBcbBdR
	r3nUus2qgP1dQ3Hd8fLYsOSSKRWTttIU3wbqApobKtjbLfttak2xN2AMuHhZxqk66mMo1UX6amzds
	s78N3iyOUpTY++E5YVklrUXoBiFv4uH/+b8yxgMKNKq4czhQZalhDHEqCzcN92Ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tsHsQ-00000008oaV-0mYh;
	Wed, 12 Mar 2025 09:55:46 +0100
Message-ID: <52beaa2c05c91590797cc1f53b779fca085c8850.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/3] wifi: nl80211: add link id of transmitted
 profile for MLO MBSSID
From: Johannes Berg <johannes@sipsolutions.net>
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	ath11k@lists.infradead.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>, Muna
 Sinada	 <muna.sinada@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 09:55:44 +0100
In-Reply-To: <20250310200237.652950-2-aloka.dixit@oss.qualcomm.com>
References: <20250310200237.652950-1-aloka.dixit@oss.qualcomm.com>
	 <20250310200237.652950-2-aloka.dixit@oss.qualcomm.com>
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

Hi Aloka, all,

> + * @NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID: Link ID of the transmitted pr=
ofile.
> + *	This parameter is mandatory if the transmitted profile is part of an =
MLD
> + *	and the interface getting configured is a non-transmitted profile. Fo=
r all
> + *	other cases it will be ignored.

So I guess it's a question of what "the interface getting configured"
means, but I guess you could set up the transmitting interface?

> @@ -5561,6 +5563,18 @@ static int nl80211_parse_mbssid_config(struct wiph=
y *wiphy,
>  			}
> =20
>  			config->tx_wdev =3D tx_netdev->ieee80211_ptr;
> +
> +			if (config->tx_wdev->valid_links) {
> +				if (!tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID])
> +					return -ENOLINK;
> +
> +				config->tx_link_id =3D
> +					nla_get_u8(tb[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID]);
> +
> +				if (!(config->tx_wdev->valid_links &
> +				      BIT(config->tx_link_id)))
> +					return -ENOLINK;
> +			}
>  		} else {
>  			config->tx_wdev =3D dev->ieee80211_ptr;
>  		}

So shouldn't that be one layer out, so the link ID can also apply if no
interface index was given, i.e. we took the else branch? Seems like that
should be applicable, or is there a specific reason not to apply in that
case?

johannes

