Return-Path: <linux-wireless+bounces-12461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E72E96B34D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEB9280A78
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DF14D71A;
	Wed,  4 Sep 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LjoguZXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A714F10E
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436140; cv=none; b=KHzHDBN5/HJ/IT+J+86FPash66lpgX8H8Fp1FYKwFKLqPs2toGSniFzP2uNTtDM5OrxIAmEo2fK0oR4FYDTtV7hmtcfh9E8UQmtvSfoxV5R/r6iZh0w2k+YSCKoYoM56eGt1unZPsEBvaX3zNupY1xY93ejyx3ztMXV/2+V+/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436140; c=relaxed/simple;
	bh=R6/++X+GSSiNHTgyGTSu3nt8Ly/Xb2EI3e1zjO1WYv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k6khnUlA8WAPIjR1woQRALFUWklzkoHZBVWm9FeZ6WrdYuyVwoV9CWPjfuzaGyCJXLoBJuse95a2tISUJC3Qhl7t7YW9k8b0GYaTxxzlJsPtKkBSuaLCWuQ1t3aQ/SAyAAT/Mx44Ly+1HouE/fkzoyjEmnNo/0B+3GpTw/pj/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LjoguZXa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jOmx2M6dJ/bY1Mg2M9O93tawK7pZcZvHoIGKV2eixzw=;
	t=1725436139; x=1726645739; b=LjoguZXa/BapmOD/SJhHVLPPksjBAOby8XYzvmcOk5eLBTY
	SPXjUK86gNf8Hi5Zb7kXSdeViw6sV9p9CtRqHgabRNyuLzsF11idOMhgQaUmgtCZ8ZsEqbCesm5OB
	No2+GSPWkhMlUjaRxbGtU6090cbMluTvd8SgQvn0arhEMi5EzjDRKmHutkv4u+veqzNtvHYBXdH2+
	WLs1Ig7BTpZV246J2POHlSrUXcVoREovv/b1LhvW8svi/UCy/4uJo/cplw/3ix2Ofu+GWW0Cy80Jk
	/IQPay0Q43X4eP7xo9PxNWC5qh5Q2CEj6f+9+xUX5bMF2gMqu3cdNKWITbgiKvwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slkl5-00000004QcQ-29cT;
	Wed, 04 Sep 2024 09:48:55 +0200
Message-ID: <a9e1c8ce6c4826e019ac96b832ee72e257225ca3.camel@sipsolutions.net>
Subject: Re: [PATCH v5 8/8] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 04 Sep 2024 09:48:54 +0200
In-Reply-To: <6446af26-4605-4f76-9c09-2d40e3919e5b@quicinc.com>
References: <20240902064847.2506090-1-quic_adisi@quicinc.com>
	 <20240902064847.2506090-9-quic_adisi@quicinc.com>
	 <807fe0b60e727ea927cb12a75f874698a1798723.camel@sipsolutions.net>
	 <6446af26-4605-4f76-9c09-2d40e3919e5b@quicinc.com>
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

On Wed, 2024-09-04 at 09:03 +0530, Aditya Kumar Singh wrote:
>=20
> > > +			if (!chanctx_conf)
> > > +				continue;
> >=20
> > This changes the previous behaviour, is that OK?
>=20
> As in? The only behavior change is previously, cac_cancel() will cancel=
=20
> all CACs going on all sdata's. However, with MLO, if let's say link X on=
=20
> MLD A detects radar, why link B on MLD Y should also cancel the radar?

I was just going by the fact that this didn't even care about the
chanctx conf before. It was just using the link_conf->chanreq.oper.
That's with patch 6, but before patch 6 it was just using
deflink.chanreq.oper and assuming you had a chanctx I think?

So I guess it's fine?

> > The cast isn't needed. But you don't even really need the "itr_data"
> > variable since you never dereference it.
>=20
> That's true but we are using it to compare it. If we don't type cast=20
> then pointer comparison later would be problematic right?

No, why? It's void * so it's compatible with anything anyway. You don't
even need the cast for the assignment, why should you need one for a
comparison then?

johannes

