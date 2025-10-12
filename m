Return-Path: <linux-wireless+bounces-27945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F8BD02E7
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97ED11890C52
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Oct 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE171898F2;
	Sun, 12 Oct 2025 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D03yKgot"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB4CA31
	for <linux-wireless@vger.kernel.org>; Sun, 12 Oct 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760277100; cv=none; b=iGLq8BmQumpRAZHAKcQy166hqBKIncYQfYeXTAv0ncBPFggwfTqtbNDnm/Hx1zH6+n74Tdr5ceRcHT7lggLF91r6SW29uoFi+Jr/7Bv9fESQDeG91N9UHmnYvIvmFWhsuivBoQdNdBHj/G1+n7XLLBu2nVnt0GQGsiZDFma1c7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760277100; c=relaxed/simple;
	bh=uQy5761+8ofXvJeFwq+1cu+yc7+3QSODYJG/7q2At8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWykV8QooR4oRst+nITVND+61doKjMnVRFxCXtBGYjS0HXmsbp/grl3ZsXW0POXEfRWNazhKCZzfmX897eJZJdwZoXuSgHlx1+NS0tQpBaLHlBxcpmfsz3m7lbD7SzP6YOm5oSRxCmAvqSpg94OFfrDg3NwCLK+PKBbN+gtqEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D03yKgot; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DaQt7x72t3yoC/DixjUylo5c1dLbXf7xBbx4j39w4wI=;
	t=1760277098; x=1761486698; b=D03yKgot/zpqL583J1sRAgOwwkczKl0lp1UsXapH4LKl6Qj
	VHjSGTpaWdFwHe33obHFBS5Ug45tUoiZuIolQjLuIDnMVUWo+mQ5OOhvyvMoWlsBhfee/P6cp8jTa
	q5cub7sqgMCcOScxz59mJvQbToBISPyF7pLO0016U9fZh7qskT2pHZAauxxqEC43k0M11Je3kzIeS
	oAQt/rUDREiwyd+8211aQ1myixs9mUJZyuk2Z4pegyEnNw+iKRVNd4J05toI880yep8si81IlcteV
	o6KJxB1PVplAHJbfRYNTpeRE/h+JCm5+9LvAtRNovCYTJE1o2vjMrXyPrLOf4uQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v7wTx-00000008EV2-3t5R;
	Sun, 12 Oct 2025 15:51:30 +0200
Message-ID: <c618e0e8fdee9f7aa2628aefdf2dc04c48e6e9b7.camel@sipsolutions.net>
Subject: Re: [RFC][v1][Design] AP Architecture for Roaming with Wi-Fi 8
 Seamless Mobility Domain (SMD)
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Sathish <quic_asathish@quicinc.com>, ath12k@lists.infradead.org, 
	hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Sun, 12 Oct 2025 15:51:29 +0200
In-Reply-To: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
References: <fbf4209c-4fd8-4047-96d7-7fa34d9ba44d@quicinc.com>
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

Hi,

Some quick feedback since I'm going on vacation for the next ~week ...

Would be nice btw to get feedback on the NPCA stuff I posted, now that
you can apparently talk about UHR ;-)

>         [2.3.2] Endpoints
>         -----------------
> 	To enable faster and more scalable SMD roaming, we propose placing the
> 	endpoint for Inter-AP (IAP) SMD messaging in kernel space, rather than
> 	relying on hostapd-managed messaging as used in FT roaming.

I _really_ think you should _not_ design it that way right now. To the
point where I think I'm going to just reject adding that to mac80211 at
this stage, unless a real need can be demonstrated.

> 	The motivation for this design is to reduce latency during ST Execution,
> 	especially under max client concurrency and high system load and avoidin=
g a
> 	direct impact on the data path transition.

That's not _really_ a good argument though - mac80211 will likely have
to process this in process context, likely acquire wiphy mutex, etc.

> 	DL/UL traffic transition latency to the target AP MLD depends on the IAP
> 	messages and the ST Execution Response arriving on time. Therefore, thes=
e
> 	actions should not have to wait for pending management frames to be hand=
led.

A good part of this argument - "pending management frames" - really goes
back to hostapd's architecture and single-threadedness, but really I
don't think "hostapd's current architecture implies more latency"
implies "we must put this into the kernel."

johannes

