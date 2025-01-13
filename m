Return-Path: <linux-wireless+bounces-17410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25A9A0B395
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC687A0FB0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4081F235BEF;
	Mon, 13 Jan 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e3aGNerR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987B235BE8
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761906; cv=none; b=gMft1J9r4k89Crrq4ZNslNlib7ARKn5j4eTw2A2txvZb/XdRqrp8X5/SnzAkr0FP083U3rmnJ9+2pRk602f19cjXu8y0kfxZBw6cRNDlBSatStByZ737O/o1+5uAPI4FoIPnZwehkChTooT/lf/YdWJP5KzqZZOwUKkpkUKIupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761906; c=relaxed/simple;
	bh=xJLXSJ02Eou06iDPdey3UuJMgZcV2E7mvP5hBU3TRQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jL3P7ydvvZBc2daxn64Kg/eJe157SFZPdyuTymdte+PWeXPHX8zdAzTZZPqkcQZevY22obtTs1SOaN5M3jOI6XmpI6iJDLVIf32qJECFR7vFk6ABJFnP5tsqis5XKLPmbb18M72HqAaCIg+i1uHZLOJuRRCjaduwVDYQsWr6cXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e3aGNerR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xJLXSJ02Eou06iDPdey3UuJMgZcV2E7mvP5hBU3TRQA=;
	t=1736761904; x=1737971504; b=e3aGNerRGP7fhvcXzaR8tXf6bE6GBOKUijqWcPONZyaKWoK
	eUjdmjD7IJpTEWANd2jeAgfewX3SwfdEglIchxD92vdo78xCd0S7FZjgX5hHLsM0zwdfd+6hl/gx7
	bnUB7R/EdbODXlSlwm7V18CwXD6MELqDJ5rUOgcwyV222PE4t/nSiHnRmBwwo2buRkyHn+9ly0U11
	+ErcXCsGfXUtFKw4MXSeVP3EBhgcZfzVwNOHPZ0+G/OYx4BEdbju6YZfGBQRMMfu244VWF6rincf1
	nm8TntrI+HTTMpkucThS7FounD9VPVtPaqQIygSaLm8FEIMKlNpYFnFGyj1qU5/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tXH6d-0000000DUNt-40B3;
	Mon, 13 Jan 2025 10:51:36 +0100
Message-ID: <5ca82da506f0130c1cc895cac92e3b375e682496.camel@sipsolutions.net>
Subject: Re: [PATCH 12/19] wifi: mac80211: add HT and VHT basic set
 verification
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Date: Mon, 13 Jan 2025 10:51:35 +0100
In-Reply-To: <20250101070249.6d5444ee6255.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
	 <20250101070249.6d5444ee6255.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid>
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

On Wed, 2025-01-01 at 07:05 +0200, Miri Korenblit wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> So far we did not verify the HT and VHT basic MCS set. However, in
> P802.11REVme/D7.0 (6.5.4.2.4) says that the MLME-JOIN.request shall
> return an error if the VHT and HT basic set requirements are not met.
>=20
> Also extend the tests a bit, and for that change the test sdata
> registration to only have four spatial streams.
>=20

While theoretically correct, this is still broken with many APs, so I'm
dropping it.

johannes

