Return-Path: <linux-wireless+bounces-12465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D196B47E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 10:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4A81F28DDD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230F1547EB;
	Wed,  4 Sep 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SCRAGIL8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D318593C
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438495; cv=none; b=UpRSriaQwwswihPhq8Fiulru3F3S6aRMMI4phlWjAAhtrHOj0dGNIvWhfUzHlBr26Ui5ouqsCMHolRVZgMUT/HdcfJLJUVlHnIzXjOdNZVCKN84qhBTwUiGbIDl6WLjs8jLS90DAZDrsEywkzZlIsHzePYoco9m3sksTRQyVUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438495; c=relaxed/simple;
	bh=t2m0IielNv4QGl/yXsfA8R5KEg8PIHudKMxDajOf+10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSfj0ogh/14iLwInZ3Y6Bf/oJob/vRczUaqKnL4RMg3ZoQxTu67fQFHDUk9H2VgrAwEMooZnZRWWsZ94h0BmoyQRUB9ss+s5CWnyMBNooX5W5Tal5SV2deMN6i2f3owZ6sezv1o42LhyQ1lCA/o7q0O8JX/r14n9hSRjW+l8gEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SCRAGIL8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JlhpKBvggfubOXVLA2lXK9ykIxGOcFqmwZMsH+zgmew=;
	t=1725438494; x=1726648094; b=SCRAGIL8g4z+BhwY+TVdqYc5iw74o7eGjl96LkfmdV9Kf2r
	fo/j2cz/v9jYtUxw+WKlmgFrkjOO473CILiTf9hM7jNqQqo74SrS5tUdp4KwlIg4VJkWaQ2AXNIyR
	ONPq9+xpKQBk4EPOPkaMoEpmZOXQE9sRQa5dPh+uz4fvX90UyBIbUUYmkRnYqD9BzBFm822R58RZ+
	U/Ug0kPrcevhylRpD4bCd8H66DSTzWrrHA77YSTVyMDjyPst+OKai+IGCL4cmQfIJIN9JUPi1jtFi
	LN2Xd8JtYrWiorr5CUPOjSs4n6CyRexTxjJYjPdEPrnNuecb5rZQiRyFqqO5Avag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sllN3-00000004TqR-3XWe;
	Wed, 04 Sep 2024 10:28:10 +0200
Message-ID: <be8d3a5a20a2c77490d78ca05e6ece7651c57caa.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: introduce EHT rate support in AQL
 airtime
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, jonas.gorski@gmail.com
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Soul.Huang@mediatek.com, 
 Leon.Yen@mediatek.com, Michael.Lo@mediatek.com, Eric-SY.Chang@mediatek.com,
  km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com, 
 posh.sun@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
 Shayne.Chen@mediatek.com, linux-wireless@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>
Date: Wed, 04 Sep 2024 10:28:08 +0200
In-Reply-To: <20240904082109.4339-1-mingyen.hsieh@mediatek.com>
References: <20240904082109.4339-1-mingyen.hsieh@mediatek.com>
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

On Wed, 2024-09-04 at 16:21 +0800, Mingyen Hsieh wrote:
>=20
> +#define IEEE80211_EHT_MAX_STREAMS	16

Still not sure why you think 16 streams are legal in EHT?

johannes


