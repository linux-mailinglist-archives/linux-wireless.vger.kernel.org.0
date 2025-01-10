Return-Path: <linux-wireless+bounces-17305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B15A08BBE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505943AC189
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 09:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF021F0E40;
	Fri, 10 Jan 2025 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dmCDnKJR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D049209F50
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500840; cv=none; b=CVDPXyVa7Vri4O3WtIAYgEZ6LojR7BcuQTglcocqQA/MQ0CJFqZxu84NIAuruhRjRfbTWTEo6EqKl6O0ufQqNjPxoHYvLJUcTuKaSbPA+n2L3LsJhCJk3jboPP9DvI3qsHc1cF4QJ9bUBkQEDB2LD7v2eSpPM1xwvdRYBmAocic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500840; c=relaxed/simple;
	bh=gGemGW30GpgiOGt7Ej6RzKm8ozrwqLmGSmKNyOGMftU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7vyUzxCMNq3qt+QDXioLcgwaIQk8WPPrLj0gArHgA5op9y+ufAgVnmkOT+9xEXU5eVfty5hYsd6MWMJHubrKXO09AZY2LMNzvJVozAaszrQD/VxHz7AhFQeCbinDjSE4EYZC3bHKriw2wysl4jjjUmA86vT2TW5Vvfs8pByOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dmCDnKJR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gGemGW30GpgiOGt7Ej6RzKm8ozrwqLmGSmKNyOGMftU=;
	t=1736500838; x=1737710438; b=dmCDnKJRP+GrQqb46x5wlDB6tCfn/Hl7S4waa3Gr2ERdsLM
	+Q3j+RpGW9Zy49ptQpqWgEeifA+ItoDav+OR6i3GuzLXQRgzkAwXG5IC//0wrF82TJFbeTGD33foD
	JzV4x7RmhClEqrB4jW/I7VBmtp2mGlu7hMybA3HlNnlm4RNfZT9kmAg9iQlJ1VffPLEbF34ME/dT+
	0I/uSq0Df3tDspU9uswzB8W5w73EHA0dSPgUDMo8lT7komYi9clREa1QFqr/2y76NA86UNOQzMdPj
	LH64QqKLe3ln1fG6Puk3BwLip3IsLp2Xa244k3xvuLEeiGrze6fy/mc8PD+tBsqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWBBz-0000000ASg2-0HUz;
	Fri, 10 Jan 2025 10:20:35 +0100
Message-ID: <ac4560bbaa2d90f0c931bff6074642ea0df1cd71.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 3/7] wifi: cfg80211: extend statistics for link
 level in sinfo
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 10 Jan 2025 10:20:34 +0100
In-Reply-To: <20250110042449.1158789-4-quic_sarishar@quicinc.com>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
	 <20250110042449.1158789-4-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-01-10 at 09:54 +0530, Sarika Sharma wrote:
>=20
> -int ieee80211_ave_rssi(struct ieee80211_vif *vif);
> +int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id);
>=20

You really should get these kinds of things out of the way before the
real patches.

johannes

