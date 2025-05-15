Return-Path: <linux-wireless+bounces-22999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F9AB84AA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8884C282F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C578225414;
	Thu, 15 May 2025 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RyZdXWU2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029891C84A6
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308078; cv=none; b=uHnAqfLDlNcAQ+asyWvdttKdkfTtICxUgjeSz5R8tlvMAt/d1JwNLx1gaDHiV2+dgLTDAJaJPpdC/FwYAO/cikalc8V63456ETN2o7JlvRHesXzOUnkvcdh0xkmXfJmPGv3w/uBRvItUFmmJQ8UQk3V9nqWJ3EHchRRdgKO1VL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308078; c=relaxed/simple;
	bh=cAEyUmQ7Chvhe5fGnZeJrcloJQAogp0nl0NlJQKMCWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7Lf7MQxZ6uhMi+2bRd5cM1nuaonqlOUr864jQ29MlGEMNb1pXx//g4wAEIhtDV4vc1JW8jv4v2uvYdXO2Q8Y7i6BYCyUFGcYOYQSaMG6FiGTl2NbyaJEuf9DhWeu6ueKMyQUyZKzj1LdFSPnAGFhf2+QOK9c8TJKbha6O+kFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RyZdXWU2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cAEyUmQ7Chvhe5fGnZeJrcloJQAogp0nl0NlJQKMCWg=;
	t=1747308077; x=1748517677; b=RyZdXWU2A4kf7YJHv2Mstca93EhVc0zB4y+SdXHxpRMILFc
	YE7FHs1u9lnO5ZIB6Jo/eYsOnicczRlXKouhJwLY0NxjWo6RDkKCKuFzDyzD46rtuTH/xhYM8pO/o
	U2A98mKOelA1WsNw05/8h7prWOVsjNB8v+O8I1JCk22oTGhD7tMqCxBSZr9C1ayYDI9mGyATuCKhe
	vgf15PNerTNOsDiFtsJn4rg92yoxAz3Ra/uPMiy+CfePE0gNRRKeQ8ziUiXgcvVern/V7+dY7I9aM
	dOA7Sve7Lx/E3aY0aocJ5tzM0Pe95yOPnBmQmtZyIjW8OUENUc04jfUg/qjujHMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWeH-0000000B5aT-1P5G;
	Thu, 15 May 2025 13:21:13 +0200
Message-ID: <1683e3d5cd40dcc65ed7022083eefd6acf9764ac.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 02/10] wifi: cfg80211: add
 link_station_info structure to support MLO statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:21:12 +0200
In-Reply-To: <20250515054904.1214096-3-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-3-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>=20
> + * @addr: For MLO STA connection, filled with address of the link of sta=
tion.
> + **/
> +
> +struct link_station_info {

nit: neither ** nor the blank line should be there

johannes

