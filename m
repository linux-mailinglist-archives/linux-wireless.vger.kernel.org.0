Return-Path: <linux-wireless+bounces-27562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D49B8F198
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436DC7AF132
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B09F9C1;
	Mon, 22 Sep 2025 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sDqKkPd1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6386342
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 06:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521875; cv=none; b=dDSmH9vtf7DovLC0Cbo/kwETTaqHy/5l62Edm5M++hOi1rR8CFC04i8LXaokBxwSiDBHJ8M0+3rKoS/WJYwip6pJ/pTvlkQ3GY0pUWbmyzJkBPO3YI2xJRzLHDnwnUXj6+fVpRd0rms0CXP/L6IBsg12r9qnifJSxxXV5bNrRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521875; c=relaxed/simple;
	bh=sNSlBBWuwCHQIZb5+Y0b+odyIzirb1x+3BpzgY0x61k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZJmXQtG4OSe4k7v5Vh2wsJbVw8ZjltsiNQmdk3qnLrJiW/C+amkuaxVoMdf0H+qy22bKAj7WIyUa8oQFo+PV6SrHXz7U83n/N17sdLuyomPKLuOoZv1LEZFxU4t7uGnAct2kHY8QEPN3UsrySBFariw1YW2f1x2ZT/pmLwbVTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sDqKkPd1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sNSlBBWuwCHQIZb5+Y0b+odyIzirb1x+3BpzgY0x61k=;
	t=1758521873; x=1759731473; b=sDqKkPd1yzPed1Bq1Hu5BLdK0J6IPNLcdpB5w3fk3I4Wter
	jzuyKqfdZdzSJ0ZKwyud5DwaYoWVNcE/wVzlUG3sNTIoaNUW1+EmqxOTqDYDqcRyhOVmE8mtLgPGM
	914uwYTZZ0ajTYtkWq6eIvJQSleHyj4wqVydzHKFbSE2gd4pJIaags70HL8zFgGFzvtTjxTvjUJAP
	ttDaaacl9CSLs4INfPsc/noumVkuJ6Uzg3RsIFczZMcwhYXxsjEtPL6vh7/LPAmAXGgt/RhWYh4YE
	DIzYwIumWIsweyiFcEgJ7+wXB+mZYkHxoDjzUiQdcofrn/WXmbPHJxMDPUnOpExA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0Zry-000000047AJ-0I92;
	Mon, 22 Sep 2025 08:17:50 +0200
Message-ID: <6f1f2a41ff0af4c6bff8199250397fd93ae983f2.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 2/3] wifi: mac80211: add support to
 handle incumbent signal detected event from driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Hari Chandrakanthan
 <quic_haric@quicinc.com>,  Aditya Kumar Singh
 <aditya.kumar.singh@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 08:17:49 +0200
In-Reply-To: <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
	 <20250912032105.714949-3-quic_amitajit@quicinc.com>
	 <42b9db0313d7b5448ca6103099b17e63c01300d3.camel@sipsolutions.net>
	 <5115aba0-6a43-4122-a8ca-6fd993f21177@quicinc.com>
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

On Mon, 2025-09-22 at 11:10 +0530, Amith A wrote:
>=20
> The workqueue mechanism here can be removed as
> ieee80211_incumbent_signal_detected() will be called from process context=
.

That's fair, but somewhat besides the point - it should be OK to call
the cfg80211 function from pretty much any context, so even if this
weren't the case for your particular driver, there'd be no need?

johannes

