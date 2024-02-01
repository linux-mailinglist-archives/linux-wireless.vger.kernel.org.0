Return-Path: <linux-wireless+bounces-2974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E8846002
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 19:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA931F258C8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 18:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744F3A1DA;
	Thu,  1 Feb 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HueK001x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE81102
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812421; cv=none; b=bpHxb19qZasJpr6+tnHR7rO/3Aw+uqiHr6erWlpfpL+pfLvQzIGs7e3R8290RXKopR0Fk0jneLQp9IO/ssRH0HrR2WHTj9rA8N99C5fvCNgKM5dixpl9bQUMjHHLo71uNVS7hfcu3XRjvX/Bvi0tsvrN8ufR1gGU6sAcbqYACkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812421; c=relaxed/simple;
	bh=XzG4LsmTT6EL4ut2QsbLlhxgu9cBcYgceSJVzkpWMXs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6G4rhZH1gw0Sh8YVUahZi+pyOjDEYAHfxWkgDn9wQvm8T5lbrvlq3ndsDfMaLGnDNNvmh6TfMBL0svNNvH2Q408pnYGRIupyzAFdPsErdXHFtbydT85ieBn77u4gJURblIiL5SYh6B5SQ4q4H4v72PfqKm4wiuBK6aZAUtUt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HueK001x; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/7WUZWnJEsbHI0x7VonwF7Tb68wi1m1eNByQw8FFSGk=;
	t=1706812417; x=1708022017; b=HueK001xaNaoly7OWoi7Iho9PNpnmrexQPBIWJS6tU0re0w
	Ps+l9in0N+FizTImaxVD7+Hf7V2D/1L5nMs3e5io9f5Yo5+Qwoc6JaCgORAS7fEjxxf1VWmGi/8ru
	MwFNYUjJ6y6frUbuo16GEAR+EuWj7hTUJymRnCGvXufRZegTKCIni8BMKbstQAW3Pxg391eL1XIAl
	RK1hs4RXTu6oM06r/VGj9ZYaYf5ic5HAmyNk2bSjwsf/slCEG+79CDEZdFBDH+gcV3gQFOcAV+MY/
	hipqPzBq+ggO3KZfbTFObgmnW7m7pyaWbH0+BMfPT5nBwlQniLd2hdDXZg0dHAuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rVbsN-00000008ZGb-0T6n;
	Thu, 01 Feb 2024 19:33:27 +0100
Message-ID: <34028bfa3550f36f9c03c507caf1570f12ae5674.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: trace SMPS requests from driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org
Date: Thu, 01 Feb 2024 19:33:26 +0100
In-Reply-To: <acffd9a8-062a-4deb-a996-03fd71d3e357@quicinc.com>
References: 
	<20240129195435.b20d2ead2013.I8213e65c274451d523a3397519ac578c3ed2df4d@changeid>
	 <acffd9a8-062a-4deb-a996-03fd71d3e357@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-02-01 at 10:21 -0800, Jeff Johnson wrote:
>=20
> > +
> > +	TP_fast_assign(
> > +		LOCAL_ASSIGN;
> > +		VIF_ASSIGN;
> > +		__entry->link_id =3D
> > +			ieee80211_vif_is_mld(&sdata->vif) ? link->link_id : -1;
>=20
> why go to this trouble?
> why not just print the link_id that was passed into
> ieee80211_request_smps()? just so non-MLD will give -1 instead of 0?
> seems all of the other existing trace functions just print the link_id
> that was provided

Yeah, good point, we should anyway know from the context whether it's
MLO or not.

Didn't really think about it, tbh.

johannes

