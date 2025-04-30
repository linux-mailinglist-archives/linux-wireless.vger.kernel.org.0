Return-Path: <linux-wireless+bounces-22259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21143AA4B1E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D011A1895B22
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78ED231A23;
	Wed, 30 Apr 2025 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YobAOuAI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011625A2D9
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015997; cv=none; b=Ht58c+mBYI3MD8BQ6kv6PlKovDrLiYrfwC54YFMu6UHS3GCtYDAkoWJVT60dlyRModv09h3j0D/O0pcCBhZ+vfe9eKje/18vCrTSb+wmc3IostMCrxbZnkGxegRqBgf7ky2r8sjavpo2t5YWwrlCKEm4oZtp5d5RmnaB622fPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015997; c=relaxed/simple;
	bh=8eqtb7OyEvvg+tuuH7irpTO/zFJKVvBOogWRuFQKpaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cHYqWaCwaEVuGH0uPzaXhsDYJng24yYH3X+CVSCVD9SEdPf5kiTZg1PEM6UpYRmAL1db5Zuf5iGCDC6egTSZM58rPHYEuTqzF/H6Eri5ipBhcBwj8z7VHm5gT4NfkcxegeKH7hQvvCbkkTgAP17SNJEOuKly3YU1Rsdfvr2E+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YobAOuAI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BmlTEsiUG/16B97wWuu7kNV9oHidqVQozwqicANmL5Y=;
	t=1746015996; x=1747225596; b=YobAOuAIRtCSnps7HjtfvH+TioOgsRhYWdlMnOAsRvkc0UD
	znEeJNpyaslCFz91hjyh0SNdjW9js1kY84IUc9nexKvwtnT/oRI/yXjldEU1PKlsJYdnULkSoTexD
	d4QzodoOLjJy7NL+h+gfGo93zu4QnCSiW2o3GorAOiWldZ2I7gNNAd6lsfnw2DjXfHyCqB0/2/lji
	PoSE1ld51MdKoL/7Ry5jaSOTivtpt7Zz6xsbFruXyJ7oFeBG66C4MiQjcPEHVwZdKeKCPBZQ8eDlg
	961tuGNnzlXUBFRTnXmO3aCg+C/R5tnj3cmlLqXpBNa4/UoUPoL2TBvNDgBAW1wQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uA6WE-0000000DluV-2TQd;
	Wed, 30 Apr 2025 14:26:30 +0200
Message-ID: <f447a8290d56eff5c28f22a4fed0458b5dbe8abc.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next RFC 2/2] wifi: mac80211: process group
 addressed Rx data and mgmt packets on intended interface
From: Johannes Berg <johannes@sipsolutions.net>
To: Maharaja Kennadyrajan <mkenna@qti.qualcomm.com>, Maharaja Kennadyrajan
	 <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date: Wed, 30 Apr 2025 14:26:29 +0200
In-Reply-To: <SA3PR02MB1008360AEAF6B0DF92E264C49F0832@SA3PR02MB10083.namprd02.prod.outlook.com>
References: 
	<20250430071435.2201777-1-maharaja.kennadyrajan@oss.qualcomm.com>
		 <20250430071435.2201777-3-maharaja.kennadyrajan@oss.qualcomm.com>
	 <940db15452d6dc9c7f4dd074360bacd2c6f315f8.camel@sipsolutions.net>
	 <SA3PR02MB1008360AEAF6B0DF92E264C49F0832@SA3PR02MB10083.namprd02.prod.outlook.com>
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

On Wed, 2025-04-30 at 12:25 +0000, Maharaja Kennadyrajan wrote:
> >=20
> > > +     if (valid_links) {
> > > +             for_each_set_bit(link_id, &valid_links,
> > > + IEEE80211_MLD_MAX_NUM_LINKS) {
> >=20
> > We just added some for_each_sdata_link() macro or so, so you don't need=
 the
> > distinction between MLO and non-MLO. I really don't like seeing that, i=
f we do
> > that all the time we have far too many places that would do it.
> >=20
>=20
> We have to loop over the links of sdata here. So shall we use this API fo=
r_each_link_data() instead of for_each_sdata_link?
>=20

Yeah you can use for_each_sdata_link()? But you didn't.

johannes

