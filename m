Return-Path: <linux-wireless+bounces-20749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A91A6D9F7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0151889CD6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84D25E818;
	Mon, 24 Mar 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OcIFZEyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379225E45F;
	Mon, 24 Mar 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818655; cv=none; b=pQg6hAeRIMevnK7IHgA8odnpDnq4QSM/5Cme9Tw2eUE4P3iMg2o/HLFVlVQOmlN0wFq8aaTKLcARbDuMHetp0DVq2N08ig573gMCRWtwCDM4FnvNfjPxX+qeDTQbEiMgbxPtdMJtQtjZdLHbYS72MKHtcJF2UFGarvWrkbqDLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818655; c=relaxed/simple;
	bh=5tv7b5JgaGpZtGLiMparLaMo96WFhGtL4WXUaY6LNt0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uBScTqLLxF8mf2iq1xqcQGlLqzagT6cMKWUMNPazrYZh2p99jdEDcdCDkF1goDVfTUF+KGbXzrZCaYWnC3aqDmmzb8QOZ52gCpmPD2pDP7kpwKjikWC6Hq7sOK5hnJTbKUlJuHpN6e5atUIcNy/DYKizqGpocTfFeB8TALWRAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OcIFZEyR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GbrpKuzmhy+e/es5lhkkPp484KgTanEn83zSrGM4LxY=;
	t=1742818653; x=1744028253; b=OcIFZEyRZiSBxNj80FfTYndWr436QguANu47oOMY1Yfllk1
	I3To5F/ytfARXUfwcconRRX5oRZHXW1JFb7tj0uBWG5ja6yz1alEvGJkMX1embIY/SpoNjBTMUPAz
	33p64Zx0viNnoMNC9gJuseNHd5mfHQGgHxaagpRNdPUV6GYd45q7rqYX2zyajgjBisGdLAB2MaRXa
	fBnLuT2dyHHll4kJTH3Eh6pGa/sfqFqIVHv3/HaKbzi7+whl60+V+oepCnUhHo2mKZMIuIpMHh0F4
	nvhuBsQMf0K4c/fysDrG5KERq6C4JATB/yj0ncMbrf/prHlWBiTGJs4OcKyhTOIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twgkF-00000003zKb-0R7C;
	Mon, 24 Mar 2025 13:17:31 +0100
Message-ID: <6c0eb718965c01a2b3889ec54e0fbc73be25a568.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: mac80211: Purge vif txq in ieee80211_do_stop()
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2025 13:17:29 +0100
In-Reply-To: <54c3c83ea8f58af89d275d410682d73cc6289dc8.1741950009.git.repk@triplefau.lt>
References: <cover.1741950009.git.repk@triplefau.lt>
	 <54c3c83ea8f58af89d275d410682d73cc6289dc8.1741950009.git.repk@triplefau.lt>
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

On Fri, 2025-03-14 at 12:04 +0100, Remi Pommarel wrote:
> After ieee80211_do_stop() SKB from vif's txq could still be processed.
> Indeed another concurrent vif schedule_and_wake_txq call could cause
> those packets to be dequeued (see ieee80211_handle_wake_tx_queue())
> without checking the sdata current state.
>=20
> Because vif.drv_priv is now cleared in this function, this could lead to
> driver crash.
>=20
> For example in ath12k, ahvif is store in vif.drv_priv. Thus if
> ath12k_mac_op_tx() is called after ieee80211_do_stop(), ahvif->ah can be
> NULL, leading the ath12k_warn(ahvif->ah,...) call in this function to
> trigger the NULL deref below.
>=20
>   Unable to handle kernel paging request at virtual address dfffffc000000=
001
>=20

Also here, can you find a Fixes: tag?

johannes

