Return-Path: <linux-wireless+bounces-9681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB491B939
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 10:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85945282244
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6EC13C69B;
	Fri, 28 Jun 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S1pDiPuj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E5147F59
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561720; cv=none; b=avNUDS7eV/l4AWBxoMdQORTPPbDyyBeiVBwZ1D7/gBIhE3AoWADXNmDPoAfHix0x43dzm6c51G3C1tXiq8rBAzYQGjW/b3pbU049c/DP6vfm/b6MafQeXtEedHfXRtmZShGBQjLMcHkz0W1m+AigjA8SR9BwZ8IPHFk8Q7WrbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561720; c=relaxed/simple;
	bh=SyKRUFaKQ1wKk9Id35SDc9dPFtVlQQ7yn9+G+4woI94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rv6oRyUh/8N6phLtHvD19ZlzCRxyVqiBf4m0OJyrmPDQfyMLb4e6nW+OUzUnQXHfEy+ZHQljDhM+HkTIMN68DDbTwVd8P4hELs392X/ZsONquulovnY6MIHY6rQncNDF+syXmp2MqJTGG/B8zSEB5/DWfNElSTDTk+xFlOg2thA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S1pDiPuj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uZyxT8ItNiF9TeT/7R/54tZccSvg3dFdAq5unyzBKrk=;
	t=1719561708; x=1720771308; b=S1pDiPujirVoZRYyDDdUZcrMFSNNSgveHNwc1C2mymlBo18
	IFesCIDVqwfSOEAmrS7fD3ZkPyC5GFplo7PtZeh6ptY7ymQ96Hjxy1UJiNd5mEdiQMaDVpxq03QO5
	pKw/Y2NyaxihCfkWscviOAp/PIS8/5QA5KbndpUnz81NwD6gr6I9QiW9mdgiSezJlRfVITRCxWMon
	hiGkShYM+9knTMyxgiTLtDUZu3XgT9X2csFOZnUzCcDgGRngCD6d+14cbGFiVkhJYKF71Cu8Q8Ef6
	ZCZXuNIB8//k5TxiUgCiRXf1U8HCwbzHnbCAtl/nY5Mc/IxzYP5qOw6WqUhYvC1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN6Y8-00000009TIJ-2QJ8;
	Fri, 28 Jun 2024 10:01:40 +0200
Message-ID: <59d364472721ab469da0a794baa8c33d78716434.camel@sipsolutions.net>
Subject: Re: [PATCH 01/10] wifi: nl80211: split helper function from
 nl80211_put_iface_combinations
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Fri, 28 Jun 2024 10:01:39 +0200
In-Reply-To: <2160a27fc614e2a9a3cba9902e14d305db15530e.1718881762.git-series.nbd@nbd.name>
References: 
	<cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
	 <2160a27fc614e2a9a3cba9902e14d305db15530e.1718881762.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-20 at 13:11 +0200, Felix Fietkau wrote:
>=20
> +static int nl80211_put_ifcomb_data(struct sk_buff *msg, bool large, int =
idx,
> +				   const struct ieee80211_iface_combination *c)
>  {
> -	struct nlattr *nl_combis;
> -	int i, j;
> +	struct nlattr *nl_combi, *nl_limits;
> +	int i;
> =20
> -	nl_combis =3D nla_nest_start_noflag(msg,
> -					  NL80211_ATTR_INTERFACE_COMBINATIONS);
> -	if (!nl_combis)
> +	nl_combi =3D nla_nest_start_noflag(msg, idx);
> +	if (!nl_combi)
>  		goto nla_put_failure;

Not sure why the diff looks so much different here between my git and
yours, but anyway ...

Even if it's ugly here, I do think you should add an argument to the
function

	..., u16 nested

pass 0 for the existing user, and NLA_F_NESTED for the later new users,
and use

	nla_nest_start_noflag(msg, idx | nested);

etc. for all the nla_nest_start_noflag() calls in this function. I
really don't want to propagate the _noflag() API further.

(The above was the simplest I could come up with, maybe you can find a
better solution, but callikng nla_nest_start() conditionally seemed
worse)

johannes

