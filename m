Return-Path: <linux-wireless+bounces-3334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788584E244
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 14:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95EAB21AC7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9176406;
	Thu,  8 Feb 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FRa358sY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0078763F4
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400098; cv=none; b=Z/GzX0eF2keBa1kd0gs69CECuLFSFxRDQGx0p2mXlX7zYahDe0AcSg2BnAH2nDdLhlEFL7CQwUdGzK9TaKiUfoCrzv5Pv4ilafjGk3tziZsiWPddtFV4IWe2lAvKr7utBc/hlhTjWXi6EoyeVh9MnVRw+OIzptwMUZnFD4q24tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400098; c=relaxed/simple;
	bh=i2rzAj1S0kRp2T4zYwhWU/jzY9MrDny5H1cJAnt9Eso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fO7XZV3Zmcn0xp6ReyQ0KUQRmZnItkDl7+0OAI5WHt2uUob0KKevK35VaOnz+N1zL8llZD1foCWSAabya8QeCX0JVDOJKOi1jta4qJqUsB/uiwIiWQrCes2M2UjYfhEaZsyO7fq11gDLK3OVV2jDMab6D7woFK5VCrL8zjbEurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FRa358sY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i2rzAj1S0kRp2T4zYwhWU/jzY9MrDny5H1cJAnt9Eso=;
	t=1707400095; x=1708609695; b=FRa358sYov7jlhM8q1s1/xPL+KOgmsJbt7aehztWKisN/LJ
	htcPlHuIL2ZGRasjGFfLNnUwnvUp/xzRusRl1+yhIZ9G7ybiVY0ugB3YfK0k3LMSi//ybHe7jaBGi
	RShLPHuOo2pQjrldHUc9gRVwvn8uKhtKs9GurLsRrmPZUdB1ZJgIu40NJacB+LN9O7qp8TNOMf8TU
	Krq5Bd5kJSeltJxUMuiMernxBqqrtBPrXgi13NwRq6gQp5yLTlqadpZjDfema/TphMEqajk3J+Aci
	gmdInS6ApmA2VKEZDd1TeubQzTZcl7ntpwYGa3QyQ4lpbYqlmzzusS8d+KF/Momg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rY4lA-0000000HUtJ-1IaK;
	Thu, 08 Feb 2024 14:48:12 +0100
Message-ID: <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel
 switch on link basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 08 Feb 2024 14:48:11 +0100
In-Reply-To: <20240130140918.1172387-5-quic_adisi@quicinc.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
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

On Tue, 2024-01-30 at 19:39 +0530, Aditya Kumar Singh wrote:
> Add changes to start a channel switch as well as finalize it on link basi=
s
> in order to support CSA with MLO as well.
>=20

FYI, this had a number of conflicts with my other work - please check
the tree now.

johannes

