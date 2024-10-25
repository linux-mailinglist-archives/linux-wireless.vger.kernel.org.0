Return-Path: <linux-wireless+bounces-14512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6209AFD78
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF23C1F21554
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABBB1B6CF6;
	Fri, 25 Oct 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QGWEWjuo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA022B647
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846911; cv=none; b=bwQCz8w+kb58cgA6QpGYXjb2OQn2ZrPO7k1ZDMDlRxN9VrJA5KQXqUj7wdwu2tQmYUPzZhVHMSIE6WmnXgag/mx7Onwe6tfV/VoICsfpexOV5aWnmw23s1daG3N1w5z5331CTHEqMXQ+1pLK7u9qdALJJ58ZmWFnMc8NLEr1ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846911; c=relaxed/simple;
	bh=Yflc2U1VM4wi4NsDgyvwXWuk/LnmEMDDrlQ2HMeclv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOQeyQncOe3oRa5544k/vQn3SKos/9iAglmoizOFd6ulP2MLbPu+e8vKCaqSEN3wARjpCaoCPkgoQtdXLjpPys67TVD1T/ohYTATYLnKqqUdIfj9XuUyY+gwot1BAdcVeMPvASkZeMma+pULplO9o1fYvWK5GLtn4L8xwel913E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QGWEWjuo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=90w7dv2+GA5w25d9/IzOJTNJT84zn5UXEhwsvXK/+P0=;
	t=1729846909; x=1731056509; b=QGWEWjuo1T7yNcfuaLc+osLrC7iWKAGxCEL7B35ZBEk3eK0
	t+wHHuH+OO/HOrT8rDjw6qHytVzMOfi552LANEDXJKuY68iE//F9AIaqdrpLyegcmqJ28HLtaU+4F
	J324J60zxFiwlC6mIqRXBS661RlM5oYg94bWUML+4mDCbSXF1DUSxukjz/LgsaI7Huw+ThTy5HRmu
	2F7m9p8KgsT3acvUJeTVg9nIcSU4oCovDbSggZ8ck0hjRd0u03JwiUWpMKVy2LUyfMnRNhlZjRCFD
	H01M3C8ZAc5Fl6K3fwThSOgc2Z9kk7oYouCvNW0ZLBvWc5cQWfBSYXyWo8qxqPqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4GCX-00000004RxP-2IBL;
	Fri, 25 Oct 2024 11:01:45 +0200
Message-ID: <61e215796bde0de99c0ac9445af9abb8e026d23f.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] wifi: mac80211: restructure vif and link conf
 for mlo mbssid support
From: Johannes Berg <johannes@sipsolutions.net>
To: Muna Sinada <quic_msinada@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Rameshkumar Sundaram
	 <quic_ramess@quicinc.com>
Date: Fri, 25 Oct 2024 11:01:44 +0200
In-Reply-To: <d33d9883648df26d61bb801c515ee2a3a014515d.camel@sipsolutions.net>
References: <20241025013857.2793346-1-quic_msinada@quicinc.com>
	 <20241025013857.2793346-3-quic_msinada@quicinc.com>
	 <d33d9883648df26d61bb801c515ee2a3a014515d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-25 at 10:51 +0200, Johannes Berg wrote:
>=20
>=20
> > +				link_iter =3D
> > +				      rcu_dereference(iter->link[link_id_iter]);
> > +				if (!link_iter)
> > +					continue;
> > +				/* Check if any of link of iterator sdata
> > +				 * belongs to same mbssid group as the tx link
> > +				 */
> > +				if (link_iter->conf->mbssid_tx_bss !=3D
> > +				    vif->link_conf[link_id])
> > +					continue;
> > +
> > +				wiphy_work_queue(iter->local->hw.wiphy,
> > +						 &link_iter->csa.finalize_work);
>=20
> This really got indented a bit too far anyway though - hardly readable
> at all. Please refactor.

I feel like maybe I should say also: Remember that the _primary_ target
audience for your code should be the _human_ reading it (including
yourself a year from now).

johannes

