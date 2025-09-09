Return-Path: <linux-wireless+bounces-27182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7226AB4B0AA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 14:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E68C3AD7C8
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE792E11DC;
	Tue,  9 Sep 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KCKJEBmU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846423D28B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419567; cv=none; b=o4a5Z/bWI+6rhcCym41UN3RZCi5vVfEGgTBaMonslS90YdfowUM9H3mTxndTBa+z6kp577qlSHbw47LUc01J2KarwKRnsKp0IB6ElRV0HqL6VN3SAtirTfKZLXA8/TMJXVXGGNFpdIfi7yMagrK6N4KWO+IqNplUYbfoVlG37Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419567; c=relaxed/simple;
	bh=JNhKuQSFoju1Durn/c1IgAPE5zwIi5gdNjqjB442Zeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlAki6xCyiC2qCe2C0eUl5eSKzggcQFxcKMhxxm1dVNby+pc6SkVZ1tQ4NsyxOL4uom4tlLjFn1q0IlGyeTbBnJJ568FsJBiy1tLm10dwjmsEwsdfa3EP7JbutFik/R8bK9DJ7ezvEbTvCE7IKFzcwB2MJUUdG7D8L3FsUSCn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KCKJEBmU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JNhKuQSFoju1Durn/c1IgAPE5zwIi5gdNjqjB442Zeo=;
	t=1757419563; x=1758629163; b=KCKJEBmUIukpMhqg//jjtLfANz91/uOG5UsKCC92fBBhioh
	EynO1h3mJKeiwFSFJnSdfE3Ki/maRLq8p3lRQqOg2no/nj/vWKE2UrbKaBQXGrd63FcV4oJnSPaiE
	ajeSrse+iEFFXPegZsuEB1eotL65/H1P7e58Knr0553nBCnaQySUNrqQhh5Yvj9MPtJj+romcxCLo
	qHWeJ+QhR52Aa3XYKHqy99+G8PClpfAefaovsSPFBWcmcKSa1mts9zbKl/8g2DfydDnfFuP+coqXj
	OY+C/qzk5dnKcEIXlhrj8PAMR2dFojCtWRayJ2xt5LlOPFrIo806EeC3IqCluTpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uvx6l-0000000AF19-2ybI;
	Tue, 09 Sep 2025 14:05:59 +0200
Message-ID: <2f368979a682e47f1d40d7ac7357c70e9e87f66d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/3] wifi: cfg80211: add support to handle
 incumbent signal detected event from mac80211/driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>
Date: Tue, 09 Sep 2025 14:05:59 +0200
In-Reply-To: <f59d7f7d-6b57-4ffa-9679-de1c32b0c1bd@quicinc.com>
References: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
	 <20250818101947.2464612-2-quic_amitajit@quicinc.com>
	 <83b5c2e55c7ad55851b9877c5c085a57b6414ad9.camel@sipsolutions.net>
	 <f59d7f7d-6b57-4ffa-9679-de1c32b0c1bd@quicinc.com>
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

On Tue, 2025-09-09 at 10:39 +0530, Amith A wrote:
>=20
> Punctured sub-channels are excluded from interference detection logic=20
> and are
> typically not represented in the interference bitmap. Their=20
> corresponding bits
> remain unset (zero).

So I find "not represented" and "corresponding bits remain unset (zero)"
to be somewhat conflicting ... if you don't represent something it
doesn't even _have_ a bit to set to zero?

Anyway ... you can decide either way "not represented" (as in "there are
no bits") or "those bits must be set to zero", but please just document
it accordingly. It's obviously easy to convert from one to the other if
needed. Setting the bits to zero is probably easier in most cases.

johannes

