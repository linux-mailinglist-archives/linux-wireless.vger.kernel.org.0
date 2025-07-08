Return-Path: <linux-wireless+bounces-24914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1163AFC596
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81559562C18
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBE21B9CF;
	Tue,  8 Jul 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JH1e0vdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E28298999
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963215; cv=none; b=ixeE5iSGmQ24Ld0Llz6ggg3wLW3Z9BWGR55wC2UGl5Q8o2TV/Xlr/v4rVPX71XhA6oM1W5Aq0Tz0GQGlPJAgAPoJ3wb2MWtqhrGhpvlJItcrMdzweO2kmiUcc/i/SJxmoU+Naz0PVJl2btlgEAQEY5nrwFkCkr0G+diPrCf1OSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963215; c=relaxed/simple;
	bh=ycMmNgQPXhFJ5HotlVvrLJRC+zPoFvW58HF/P10WpC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ps7PZeZw9EOlRrDZu7EluXzHX+J5EnN6A8xw+B64R6aMTaOQt2Og0t7of2s+rQ63Xgt8QDOzBr2l4hTRE0YWDpyUSYhm+VMPqRbtOH99NAe199K1P9IxOAQQGa9/G5awWOFofyu7edq1zB+WnuvJbKgOwiHTJlRq0BIsBn72/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JH1e0vdp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=21hQW5N5nZA/JerVYq7h605l0Ii0PUeCaKPMFrRer5c=;
	t=1751963213; x=1753172813; b=JH1e0vdpdBru+7NoZ/gaop/9gG1oZ7zZ6/7Ooy6Zxn6fZA5
	euEI6GQX/f5pXexhQ+dADE3ADi5KKtt1D2GJzCB4bxcHh56SfnBQjQooa0pFK1MiEZLSswhlMTdXB
	D5amVuavJfcb+6g5PQnYPG2zuQk/pfEJRCdC6Y/eSYE9NVV5DsKdENuQXO/eAavLwjGfgVUiP0hXm
	6kx4V8hTmGRtguQT8zXgv7mIMELopQNOuDpoPXM7CQ/dXVLA4d6uwbGh/cf+zHwO2Q1ojgf/PXIFZ
	IphRgDan89m0Y9BqRPb8BATPcYICC7BsPrdgdWG19WcrUxjLDlOG6xsgrOlW1hzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uZ3f2-0000000Bjtz-2SO1;
	Tue, 08 Jul 2025 10:26:44 +0200
Message-ID: <e4200088d9a56fa4ec6bf25c13375df7b9d13b42.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: disallow AP interface from getting
 BIGTK in RX path
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-CY Lee <michael-cy.lee@mediatek.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>, Money Wang
 <money.wang@mediatek.com>, linux-mediatek	
 <linux-mediatek@lists.infradead.org>
Date: Tue, 08 Jul 2025 10:26:43 +0200
In-Reply-To: <20250702104516.2738962-1-michael-cy.lee@mediatek.com>
References: <20250702104516.2738962-1-michael-cy.lee@mediatek.com>
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

On Wed, 2025-07-02 at 18:45 +0800, Michael-CY Lee wrote:
> The problem was that when the AP interface with BIGTK set received
> beacons with MMIE from other BSSes, it tried to verify the MIC using its
> BIGTK, which must fail and be notified to the upper layer by
> cfg80211_rx_unprot_mlme_mgmt().
>=20
> The solution is to prevent the AP interface from getting BIGTK in
> the RX path, as the AP should only use the BIGTK to calculate the
> beacon's MIC value.
>=20
> Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
> Reviewed-by: Money Wang <money.wang@mediatek.com>
> ---
>  net/mac80211/rx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 7671fd39a60e..f2d63a7cc642 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -1888,6 +1888,10 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *r=
x, int idx)
>  	 * index (i.e., a key that we do not have).
>  	 */
> =20
> +	/* AP interface sould not use BIGTK to decrypt */
> +	if (rx->sdata->vif.type =3D=3D NL80211_IFTYPE_AP)
> +		return NULL;

Could this apply to other interface types (AP_VLAN? mesh?) as well?
Maybe this validation should instead be restricted to where it matters?
Or maybe it should only limit the rx->link->gtk[] lookups, not the per-
STA ones?

(Also, what about wireless/wireless-next? please add a tag)

johannes

