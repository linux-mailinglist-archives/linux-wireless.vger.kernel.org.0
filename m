Return-Path: <linux-wireless+bounces-27602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00BB94D27
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1029A171210
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E436548EE;
	Tue, 23 Sep 2025 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="m7RDs5F6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868531159E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613285; cv=none; b=uYUkWbXc/6CEKzyCovjRUnMcTcEvLsxC9wJxhk24Skt+GzigrU7RRDijyKAXVZJ5sGDKFzTLYjs64Ok64vCKc/DJsxKoP9qli51nbXH0KEmNIj7cTnRcDr6ZaIB8anBevjaTWQxVBU402gBuKiO+4kSioyHhNY2wNUu7FvJVJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613285; c=relaxed/simple;
	bh=BP9JzmwudB/CtDqju/hzjZw5mNRljPLnc0jiuH3WhE4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHOo7ql7xysBr6nmGj9zU+jg8u6FEZErRapWfNdfDhc+giOe8x/vaBijMGl1ZPvzREUQXRLzwGL2G9PMJZEj8dgROrmsEahST0F5P0/tZCtynI+YSCxQkzhSuLZZSNWPH5Ndicl5WEykOJsWriTAW06+fByHU0B6aoObDFWjTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=m7RDs5F6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JrGnKI+Rdd1uXW+cAhGqhKE7wAuIuOqWgEOkKtPEv44=;
	t=1758613283; x=1759822883; b=m7RDs5F6FtKaomVvEJiHWrYo/qoR+F3Q/YfIlpI0IbuTQtN
	mfS34fx1CwTFKHanqT157CeUwlt4QSfJj8iImxzMzu+EFotyVYPQaoyf8zkhRQwWJR2eZRelKb6R7
	vuAGYNJXEHK6Uwy8ovhJuIhN085mxLGbMy9Bg1igMpe+BlRK50Tnjn5U9i92uIcwHCZ8aKu1iOaLL
	iVsIwWA81/EWo0OwqQ4geQ34IlgAZyb+ElTV9nHObYu7gGfilvhmeqIWxGYhaMfUucMpJp5U3IPQ2
	CHa82ypbaeJaA58fksn0CnjFEAYWir9CUa0W0v84sNQMjMJloAal/8cOE4w1GsAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0xeI-000000069iD-3SOO;
	Tue, 23 Sep 2025 09:41:19 +0200
Message-ID: <849ce1aa154232a5a12c7778689c778fa3936908.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>,  Aditya Kumar Singh
 <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 09:41:18 +0200
In-Reply-To: <20250923073554.3438429-3-quic_amitajit@quicinc.com>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
	 <20250923073554.3438429-3-quic_amitajit@quicinc.com>
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

On Tue, 2025-09-23 at 13:05 +0530, Amith A wrote:
>=20
> +++ b/include/net/mac80211.h
> @@ -257,6 +257,8 @@ struct ieee80211_chan_req {
>   *	after RTS/CTS handshake to receive SMPS MIMO transmissions;
>   *	this will always be >=3D @rx_chains_static.
>   * @radar_enabled: whether radar detection is enabled on this channel.
> + * @incumbt_sig_intf_bmap: Bitmap indicating the sub-channels where an
> + *	incumbent signal's interference was detected.
>   * @drv_priv: data area for driver use, will always be aligned to
>   *	sizeof(void *), size is determined in hw information.
>   */
> @@ -270,6 +272,8 @@ struct ieee80211_chanctx_conf {
> =20
>  	bool radar_enabled;
> =20
> +	u32 incumbt_sig_intf_bmap;

This is obviously unnecessary now.

johannes

