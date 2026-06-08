Return-Path: <linux-wireless+bounces-37489-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zO9xBlBtJmpoWQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37489-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:20:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1AD6537B0
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:20:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=ZzYVqWXp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37489-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37489-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6F7300AB04
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7E2E718F;
	Mon,  8 Jun 2026 07:20:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C124352024;
	Mon,  8 Jun 2026 07:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903245; cv=none; b=UmDPI2s2Jh9Kjc33x3JpL2loJmus4bsawUlagAQZfUx2yrRN89S3n2Ty/MdD8QteveT8mgfHrMdFqmPLxnlhpyIbWqmVsHsOOfW6m8vsTNnrY+Z5xeYrwjTocNVI0HO1UTxddPIkZfMHZyjOcojFaE3vkEAX1oE5ySGoLxFNcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903245; c=relaxed/simple;
	bh=WRo1b8x+9Umo8d4AnQyV/6BmXNvO+ucEjytL5SJTDl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksVJejICTGhEWFf0PpaTsK6MpAsTFDhJn3oGhVfjmhMMw6dtZU3rg7Idg7578G9MQW8CLJXiwQIoTUA04ykSqp++RJtEI9iywDV1rthX2sc72ch8areLtZm21H5hVeqv9KuWKR6dO9ur4o+YNbUgN57g+rffCEXsEwZhZsQfKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZzYVqWXp; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WRo1b8x+9Umo8d4AnQyV/6BmXNvO+ucEjytL5SJTDl8=;
	t=1780903243; x=1782112843; b=ZzYVqWXp0jm7qV9V/yVgqir1J2fZuFhaqnM1nTOVYNcokBH
	VRTnoDaeQ2HbS1CoVqNY0NhKg/GAQnN+k1s85DlcR3TJlhurmBSip5TQoCXv7RtuUuR/zznIfzjTz
	V9QJ90Pt8Rw3dXkLV2oARcM6nuAzz14Gf6EzlnSgE/X1LPL4CXtwEKkY6oCQG5ZYibLjTcbwi8NEw
	7iXWZy4Ob7pAHwuwqSNbt8/tHTO641fHR3efDPiiZHXQRlPvITzIU+nh1F90pQL7uEPUAhXryDZsP
	XhSBw1dk5w3x5ZXSGZgwRkpKV6e9Kith1WLgkcjmHPpc04d/mmIO9q3qDgmRJMPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wWUHo-00000005Z61-2W6Z;
	Mon, 08 Jun 2026 09:20:40 +0200
Message-ID: <0bd0a95fc89b0eb9a289ecce15555b8de76639a7.camel@sipsolutions.net>
Subject: Re: [PATCH v12 00/22] wifi: nxpwifi: create nxpwifi to support
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	briannorris@chromium.org, francesco@dolcini.it, wyatt.hsu@nxp.com, 
	s.hauer@pengutronix.de, ulf.hansson@linaro.org
Date: Mon, 08 Jun 2026 09:20:39 +0200
In-Reply-To: <aiZs9CCl3tBv9ZrJ@nxpwireless-Inspiron-14-Plus-7440>
References: <20260605161335.2415583-1-jeff.chen_1@nxp.com>
	 <dea3dc8bee50dd5eaa1327fb8ea83658f73d323d.camel@sipsolutions.net>
	 <aiZs9CCl3tBv9ZrJ@nxpwireless-Inspiron-14-Plus-7440>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jeff.chen_1@nxp.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:briannorris@chromium.org,m:francesco@dolcini.it,m:wyatt.hsu@nxp.com,m:s.hauer@pengutronix.de,m:ulf.hansson@linaro.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37489-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1AD6537B0

On Mon, 2026-06-08 at 15:19 +0800, Jeff Chen wrote:
> On Mon, Jun 08, 2026 at 08:39:24 AM +0200, Johannes Berg wrote:
> > On Sat, 2026-06-06 at 00:13 +0800, Jeff Chen wrote:
> > >=20
> > > Firmware binaries can be obtained from:
> > > https://github.com/nxp-imx/imx-firmware/tree/lf-6.12.34_2.1.0/nxp/FwI=
mage_IW612_SD/
> >=20
> > Are you going to send this for inclusion in linux-firmware with an
> > appropriate (redistributable) license? I'm not entirely convinced that
> > the license (that appears to be attached to) the repository is really
> > one that could be used there?
> >=20
> > johannes
> >=20
>=20
> Yes, we are preparing a submission of the firmware to the linux-firmware
> repository with an appropriate redistributable license.
>=20

Sounds good.

Since we haven't really had any takers on reviews, and I've probably
done as much review as I really want to, please just send me a pull
request with basically the mmc quirk and then a single commit to add
this driver.

johannes

