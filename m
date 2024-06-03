Return-Path: <linux-wireless+bounces-8407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDE8D7C89
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CB1F22EC6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B29E47F6A;
	Mon,  3 Jun 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mXlKkL1w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20534EB30
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400218; cv=none; b=r4OBH8DaZHgg5tt6VgcBI++Hmb4kwfRBWHozDBlduwvuES9v2QkcYv7TUEi8Q8ZkCuSv+i6N8QmMo0cyIMkxLyKpnsNT8W5md8OI+keynHEMLmR+GNMvNN34XV06iUEwNztHDi0y1kP5gVyHWS3sF8EkYAsbz+686kIg/8gBA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400218; c=relaxed/simple;
	bh=cgMA6U1cgKdEMWmGo9/hZK5VltUsQ/BuccUbUkv0N+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paAevYEeF9ABUVViB2BKrp5ScSFKMrxSyt/eLlyfP8YhjKHabsT2JOPddjmfuJAf6nCj/X3fropZdfvF/212JnUE4xaLHfss9O9bGoP3LcvV0kGyUGLpMqOqKQV1UBUvALPCgoJdbvVyOaLy2J/kosRMTUzZk17sJhZDcN6i0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mXlKkL1w; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MOU4Cshkszd003EzQOCHeVJfUVoNCzZo0doSzm/lJys=;
	t=1717400206; x=1718609806; b=mXlKkL1w+u6VQ/7V34yKDKpn0S/D6/aynBKcefmL58vhQ6J
	1mgxGpo/tjCAZxzQt05xRISTYo7XDgFwreBLavb71u4Tm6xFdivApu+srYwdWx3tP6GVdSAOdIXiO
	tRas2UgCFHkw/ENFgRnwwJa7HfcOCBHaUZj14suhIluOqM4NTMfGIXeuz6TPo9aKCNnojrE7hld9b
	NLaeg2Ale4A58/jyKx2kDg5FVqkLWy4XWAAA/sfaviRkD1AOU4SeluKHxDhpcTQJIJoT1wKAyc8qS
	JjkftP9co1mPBZqcvm4TCwS4gu6xzmSWS/wl+HhcKtwJQC47i6WNoXCspQdRrIoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sE2FD-00000009KjJ-3DFA;
	Mon, 03 Jun 2024 09:36:40 +0200
Message-ID: <43680bd3c444da4c1b4e55b4ee4c7043c1186ccd.camel@sipsolutions.net>
Subject: Re: [PATCH v3 6/8] wifi: ath12k: support ARP and NS offload
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Mon, 03 Jun 2024 09:36:38 +0200
In-Reply-To: <af326e49-df6e-4574-9562-44b6aee10abd@quicinc.com>
References: <20240530072714.25671-1-quic_bqiang@quicinc.com>
	 <20240530072714.25671-7-quic_bqiang@quicinc.com>
	 <ccf9791b-e050-4844-8c37-35873fb3fcaf@quicinc.com>
	 <17721436-19fb-4337-9058-b20f4df2792c@quicinc.com>
	 <af326e49-df6e-4574-9562-44b6aee10abd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-05-31 at 13:11 +0800, Baochen Qiang wrote:
>=20
> On 5/31/2024 11:42 AM, Baochen Qiang wrote:
> > > > +static void ath12k_wow_prepare_ns_offload(struct ath12k_vif *arvif=
,
> > > > +					  struct wmi_arp_ns_offload_arg *offload)
> > > > +{
> > > > +	struct inet6_dev *idev =3D arvif->idev;
> > > as noted above does it make more sense to get the netdev associated w=
ith the
> > > arvif and then use in6_dev_get(net_device) to get the inet6_dev rathe=
r than
> > > caching the pointer from the ipv6_addr_changed() callback?
> > Ah.. I didn't note that we can get inet6_dev in such a way, just though=
t the only way is to cache it in ipv6_changed() callback.
> >=20
> > will get it using the following in next version:
> > 	struct ieee80211_vif *vif =3D container_of(arvif)
> > 	struct ieee80211_sub_if_data *sub_if_data =3D container_of(vif)
> > 	struct net_dev *ndev =3D sub_if_data->dev
> > 	struct inet6_dev *idev =3D in6_dev_get(ndev)
> Just found that ieee80211_sub_if_data is internal to mac80211, so not pos=
sible to get netdev in this way.
>=20
> any other ideas on how to get netdev?

You can go via the wdev.

johannes

