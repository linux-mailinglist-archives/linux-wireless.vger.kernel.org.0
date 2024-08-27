Return-Path: <linux-wireless+bounces-12031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C4096044F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFD1B22FB3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E519885D;
	Tue, 27 Aug 2024 08:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RoXziu4k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96A196D98;
	Tue, 27 Aug 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746931; cv=none; b=jw7UE337S5ZMLJwksoTlZtSh7S/dnnLEqdnPWpKb2YNafRCdzfpWiXRjf9EcrvHM26HasPV+SvdoRuiKLzrXGvVF9PvollVr8V38PQv8Z6OkztMtBuPrlK9RpkKwnlJ6kKfh0T7E5Ba4hgWSHCfYApZ6WUtWXZWRUoU/xrxNHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746931; c=relaxed/simple;
	bh=ZaVUIQYOGMqPMgtYVcZSPRipNAboG/rRveMP7/qIYhs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/JqYl3jZ4nfe4AWbbeE1LHccGBc/LxLb7hlxIGnOeY7IaegiUPZu4F8eygqbEcUhhkmHGWItutJBjXu5gCNyPaF093ChmG3iRiNbNRxi+RTJoc352RtoDWyzugLXRfiazvqcJ3kz1uneaOykUCbA7G5sc5kC8fiYXTwW0FQMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RoXziu4k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UoOaZ55QCCB7NxyBwlW4cuUdu7hHL3vFo6vF4P29qkw=;
	t=1724746930; x=1725956530; b=RoXziu4kOOQO8MO6rmmqgNqzkq+4jNg4goEA0oC0o+6dJQt
	GO4Tzhc26eDvId+mUKuLKAVaewlDy2hpMso0QBGwLeLC7BzK7i34C2KdjfM5AK9EeD8s4B48jz492
	WmlFF2U3WKp3IKQohPMDURrYjZu7UcZOa8eXKNHEDTrKeH7FO53QNUpOjI5RRgBPtr1W4u6zx9Qd7
	SHhIBjUc5wskqj99b+z2VblE9YoKnG/mqoUVg1GO4DM5wCOz5z/ZKyayhFPUWyASlxCRZeO2WAcOo
	NDBCpckbfFWIj4d8MxGjbCeXQrlu/rI/Di0d4kUnW00x1wCWae81nhS9jfLm4Lbg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sirSk-00000004T4g-0TpH;
	Tue, 27 Aug 2024 10:22:02 +0200
Message-ID: <6ae3908c182664496784b1f1a86dd5bfd72fbc62.camel@sipsolutions.net>
Subject: Re: [PATCH][next] wifi: radiotap: Avoid
 -Wflex-array-member-not-at-end warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo
 <kvalo@kernel.org>,  Stanislav Yakovlev <stas.yakovlev@gmail.com>, Ajay
 Singh <ajay.kathat@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	libertas-dev@lists.infradead.org, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Tue, 27 Aug 2024 10:22:00 +0200
In-Reply-To: <ZrJmjM4izqDqwIrc@cute>
References: <ZrJmjM4izqDqwIrc@cute>
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

On Tue, 2024-08-06 at 12:08 -0600, Gustavo A. R. Silva wrote:
>=20
> +++ b/include/net/ieee80211_radiotap.h
> @@ -24,31 +24,36 @@
>   * struct ieee80211_radiotap_header - base radiotap header
>   */
>  struct ieee80211_radiotap_header {
> -	/**
> -	 * @it_version: radiotap version, always 0
> -	 */
> -	uint8_t it_version;
> -
> -	/**
> -	 * @it_pad: padding (or alignment)
> -	 */
> -	uint8_t it_pad;
> -
> -	/**
> -	 * @it_len: overall radiotap header length
> -	 */
> -	__le16 it_len;
> -
> -	/**
> -	 * @it_present: (first) present word
> -	 */
> -	__le32 it_present;
> +	/* New members MUST be added within the __struct_group() macro below. *=
/

There cannot be new members without breaking interop with the radiotap
spec, that comment isn't really useful ;-)

> +	__struct_group(ieee80211_radiotap_header_hdr, hdr, __packed,

And also, "header header" sounds odd to me really. The header of the
header? What's what?

I think perhaps better to call this ieee80211_radiotap_hdr_fixed or so?

johannes

