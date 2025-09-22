Return-Path: <linux-wireless+bounces-27567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F43BB8F360
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDCE1898D25
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03BF22D9EB;
	Mon, 22 Sep 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NNB1xHLm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD57522F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524460; cv=none; b=GKSuzDpZ0JWAC/J/uVgQp7H407t/35QD7Ju0wpsZqjLYaWiSfKi9nd1Mn9cK0vCUaZzIZZ+ldSATBxHFsqhquGfrX+pu+2l5Sq9zqjsfn+WkFhM+RIkDoF8HhFKHDgN++HKc0F+WnPZqAgm+7kq6Z1WFr1ypQE2x2UqABLTBlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524460; c=relaxed/simple;
	bh=yAj7LNN+0PZVNqOdRLCE9K3JmMLAdt/6fEPnlSXxbEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RfD5llZGFpP5mUZDBDRKwFTBelOwqJjC8rU08ty5sXqooPmk6wiVpcBf5Os1WLgGy3xmR5+8FSCkm2NeSC3nzt907+ZxLmjP8ChCjyRtJUvzV97n/6wxCp5a+L91nVBrccBLdf+lqT0ZKFa1FExjCQEIqNSkZGWRUkXMzFIm0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NNB1xHLm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Xvf0naiRoV3tuR2vhRV47rFlwtgA8hc8AO/5HIiDce0=;
	t=1758524459; x=1759734059; b=NNB1xHLmErYMRiTI38puzLO5k7VEK59gWzciG1BYb5FAiKI
	cd2wim9ytUH3tDwjlyHRwVklI0J2Fjp7MwQTJKvPOsVBZ06Am0t3xExYv0AlWIk9Rl+41qdGvmz57
	8/zYNmLSF01GGb34iW42wGospKvqdv1FqFzpI4nX+iJVg2ubmTKDx6dQ41oUd1UTrY7zNz19rQIey
	Y+6i+XD0plnqXBe/6Lp+9foDLi/0q9WjICGtfcZ5rnmaTAmJSJOoRWvL7LoCnawNvA1kto8sgpQVV
	qQtn/7HGzlMQf049DHCqG0SVE7UhfFPAbz1PWqmZ/Da2F2mgDGfNKY+fbN7u7aZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0aXg-00000004A9I-0q04;
	Mon, 22 Sep 2025 09:00:56 +0200
Message-ID: <35fe10f3adaaeaf667e9f95931319fb6d1954a0c.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: extend link support
 for stop iface handler
From: Johannes Berg <johannes@sipsolutions.net>
To: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 22 Sep 2025 09:00:55 +0200
In-Reply-To: <20250922-stop_iface-split-v1-1-087403cea9f7@qti.qualcomm.com>
References: <20250922-stop_iface-split-v1-0-087403cea9f7@qti.qualcomm.com>
	 <20250922-stop_iface-split-v1-1-087403cea9f7@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-09-22 at 10:54 +0530, Manish Dharanenthiran wrote:
>=20
> +++ b/include/net/cfg80211.h
> @@ -9559,15 +9559,19 @@ int cfg80211_get_radio_idx_by_chan(struct wiphy *=
wiphy,
>   *
>   * @wiphy: the wiphy
>   * @wdev: wireless device
> + * @link_id: valid link ID in case of MLO AP/P2P_GO Operation or else -1
>   * @gfp: context flags
>   *
>   * Trigger interface to be stopped as if AP was stopped, IBSS/mesh left,=
 STA
>   * disconnected.
> + * In case of AP/P2P_GO types, if link_id is passed, it would only stop =
that
> + * link on the iface alone. If need to stop the whole iface, -1 should b=
e
> + * passed.
>   *
>   * Note: This doesn't need any locks and is asynchronous.
>   */
>  void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
> -			 gfp_t gfp);
> +			 int link_id, gfp_t gfp);

I think the naming (and touching all drivers) here is awful. Much better
would be to make a new cfg80211_stop_link() or so, pass -1 there to mean
the whole interface, and have cfg80211_stop_iface() be an inline that
always passes -1? In one fell swoop you get better naming and not
touching all drivers.

johannes

