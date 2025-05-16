Return-Path: <linux-wireless+bounces-23068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683EAAB985D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F4AA00D4F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D722F76B;
	Fri, 16 May 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OQCKGxKi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943DF22FDE7
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386525; cv=none; b=CXb60tgEFvpRQojTLerbHr9DjDRmQWu/Ed8jF7p432OfLuKJJtiaZx+27NmftiDGd0//TF+AbXh55ODSo6RelzVwk89WHdwEBoRirjv9BWBrxuU7tHftmq1RyjKQIEvsFp1CQShtS7Yx8p7pwc9X4LrjPnOElSc2RFsOmu92/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386525; c=relaxed/simple;
	bh=1hc+Pg6BdBspacF7uC7eeGCXOZZ7VNa/r4YFcvfOVBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAY4nR9Ds4haiB2OteXadP9VX9Y4Y+OmOHtaNd6AFwcdioh51YZSoGnl9HH8j+rS4BQgByXLpwHupLyQ/o9q94pNidwH0i767uVpJ+wgVpKlYsQr3PZaBEWrv6JVPtpxdEkiPWMyvfLF80SkUR3H/8tvFiv0MOVosqRAXTWNpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OQCKGxKi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZqtSMkyWgK5O9yoxSo2YjhzoYKwwO2tY8zxxGFJlFqc=;
	t=1747386523; x=1748596123; b=OQCKGxKi/hshIEz79mQz5QEN12U6W9LZaB2TTBcIZzEBUr6
	0eGo8hTVKyTFttJxrL57rIsfesPTGa1S2GKFbxZDku0cQXicYmEj2O2p2xeVx7XqotblS4mB1pm65
	IieeTfilREhkRMb/2fIq3oDnSPE5oHQ8GipU8O51qxThNg3nRCxg88KJBoJzetBj+SWdAMeNE+cbn
	sTrFfZ+zB+fb2wcU6a9xDTUrdwU0rVXRUiRh4aCPom4N5SBiwBt+PMLoCZ3bDiwD9NuTkhCYgIk+e
	8dv1Augvub3grK3mxQTfhve8+0zL47Rfn4EqIJACqIeFWbbDapbtWIgTPrERxYZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFr3Y-0000000EBix-3pHC;
	Fri, 16 May 2025 11:08:41 +0200
Message-ID: <19cbc5ca0dc485c39c61ce713f2b4f4faabad684.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Vietnam
 (VN) for 2025
From: Johannes Berg <johannes@sipsolutions.net>
To: Duy Hoang <duy@etylix.me>, linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Date: Fri, 16 May 2025 11:08:40 +0200
In-Reply-To: <12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
References: 
	<12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
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

On Fri, 2025-05-16 at 16:02 +0700, Duy Hoang wrote:
>=20
> * 5470 - 5725 MHz
>   - 500 mW (27 dBm)

So as we found in the ETSI thread, this (500 mW =3D=3D 27 dBm) isn't
actually what happens, but rather you get 26 dBm.

However, the Vietnam regulations, although seemingly the same as ETSI,
explicitly state 500 mW rather than the 3 dB reduction from 1 W that's
stated in Germany!

I'd still probably argue that the difference between 500 and 501.187 is
small enough that you can state 27 dB here in the db, rather than
stating 500mW.

I'm not sure we should make the processing scripts do rounding in this
case, perhaps we should, if we decide that we want to ignore the
difference of 0.237%?

johannes

