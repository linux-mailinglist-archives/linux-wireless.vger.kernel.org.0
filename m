Return-Path: <linux-wireless+bounces-22998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F383AB84A7
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BFC1BC095A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE161C84A6;
	Thu, 15 May 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Gqj1+RWn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4FC2C9
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307992; cv=none; b=AGIapoTi1slcUdSR21oIDbfRQ6JwsxHtpLEdDNeDPl/7XiB9xQfp+/eVd76sKhvrjNMYAuY6zVNqSIIi4Z1VXG3B79RIJDX2CDjBe9fdXvOJLwKKNsWBKcl+kVZ1MVXkGN8V2tpnTtbQ18J9SawleT5dpclrKx2mp+Rm8Oj6mSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307992; c=relaxed/simple;
	bh=knEI8s7DcbCJckDkp2pU2ht+idg18FJ+mIvKxSldasc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0l6b6HC1lJdQcd+I2LmqsmcxRSTKs4nSbNRBxIgwcY2s17Z5b2twwKzQ731KDYiaupI1rqi6+4f+Iidv/p155ROijDI2VlBH6Yg6JhsjnRBD3ig1Vyf6VGq9R9KUaKkZXo4gwpjMOf2Q8uKmXNnGwZyybZ8BU6ZFsoOSjuE8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Gqj1+RWn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=knEI8s7DcbCJckDkp2pU2ht+idg18FJ+mIvKxSldasc=;
	t=1747307991; x=1748517591; b=Gqj1+RWnK97CGFQaqGKkuAZNoVyc7uireMvcP+ihac0VMCT
	2KCN9m3LmxpSr0TYirzz+KU0ChQUqQ9NVwWdhXRN9sRmGpLF5ULj1YXwFA/d3/kbN8H62wPVaJsVJ
	IpOmusnyt33MrAias6sOf0u/CgiwzegUwRwaqhSrajZ10+DknCb6EEpNFZLfceZ+OVA8JSKMtk2ZU
	v8h4Q9DaLMkZbC5EEUObeYwH/7803T/MIPsHLa2D6b5WcITzzHlZsgl3S/v+qzPNaWJNTTwPmCD8i
	AJ5B0IejsnSZ4oGOMx+WTOqQUKJicqnoKjmG7J24qo292/mv0RX996uFAqpo4xgQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWcn-0000000B5NY-0t7a;
	Thu, 15 May 2025 13:19:41 +0200
Message-ID: <e0c26227b8023ab046606597ecddffe1c3aea307.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 00/10] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>, Jeff Johnson
	 <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:19:40 +0200
In-Reply-To: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
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
> Current implementation of NL80211_CMD_GET_STATION does not work
> for multi-link operation(MLO) since in case of MLO only deflink
> (or one of the links) is considered and not all links.
>=20
> Hence, add the link_sinfo structure to provide infrastructure
> for link-level station statistics for multi-link operation(MLO).
>=20
> Additionally, accumulated stats for MLO are included in a concise
> manner to provide a comprehensive overview of the ML stations.
>=20

Uh. So I really wanted to apply this now, and also started making fixes
to it, but no, it's not really working for me at this stage.

I've pushed what I had to wireless-next link-sta-stats branch so you can
see what fixes I already made (and pick them up), but I have further
comments.

Jeff, I think you should probably get stuff that doesn't depend on this
out soon, from your pending branch, we'd have to have really quick
turnaround on all of this to get it all in place for 6.16 still.

johannes

