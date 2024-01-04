Return-Path: <linux-wireless+bounces-1479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4F823ED6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58981C23772
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3420B02;
	Thu,  4 Jan 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BKV10HtT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E41208B9
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eqFUtFVL0U7tdRFhaeYDMZRzFaaJJ9J0Tp73uqe4ZXQ=;
	t=1704361355; x=1705570955; b=BKV10HtTom20aIAMT7cwOKgg5X20WiHU+IHroCJ0adUNEze
	o/DzqyMUG6LUdv02TZmRuk65NOXW8HMofcqXmn17RxuBY28vkLtt1lHtyi/Yb6GYFbP59UmVOdj2B
	7BEO6OFyKkG2TRBxoSbI1HSKT68jy3BEDiDNQQIG+M7XudA27LIXQ1cCXHwynbGEfAnriK9QlOic5
	o+wLIupYKzr3gPw+bSuL/S71fVV2DkbtqKXdHbgNxRXRLt3SfZJtNpAR2jzpAM5XouMpTdQoQIGEN
	s7Xaw/Ixh6qmGrPVd1uEswuraehLVza2CjNo0HIn9Ito0LfwRHuvsY//nnVDRYzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLKFD-00000004THE-43RE;
	Thu, 04 Jan 2024 10:42:32 +0100
Message-ID: <a5123274d5a8d80d554ffb786e25bef72d45f69b.camel@sipsolutions.net>
Subject: Re: WiF Transmit Power Control (TPC) Regulatory Requirements?
From: Johannes Berg <johannes@sipsolutions.net>
To: b.K.il.h.u+tigbuh@gmail.com, wens@kernel.org
Cc: Seth Forshee <sforshee@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, 
 wireless-regdb <wireless-regdb@lists.infradead.org>, linux-wireless
 <linux-wireless@vger.kernel.org>
Date: Thu, 04 Jan 2024 10:42:30 +0100
In-Reply-To: <CAPuHQ=GSuKW5=T0GXXCq7Pf9jw=zcEnms-fEJey68QUWH1ishQ@mail.gmail.com>
References: 
	<CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
	 <CAPuHQ=GSuKW5=T0GXXCq7Pf9jw=zcEnms-fEJey68QUWH1ishQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-01-04 at 10:07 +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> You can find a wording in most such regulations that if TPC is not
> supported, the maximal TX power must be reduced by 3 dBmW. Hence in
> all such cases, the entries in db.txt contain 3 less than the maximum.
>=20
> If, on the other hand, you know of a country that specifies that
> devices lacking TPC may not use the band at all, all such band entries
> must be omitted (commented out along with a URL).

Yeah, that's how we (currently) handle things.

I'm not even sure what the requirements would be for "TPC" to be
implemented, tbh.

> > As far as I know the kernel doesn't have facilities to support TPC or
> > transmit power control,=C2=A0

Right. I have, however, heard the interpretation that the fact that we
have - even if nobody uses it - the "iw set txpower" command means that
we *do* have TPC ... Not really sure what to make of that though.

> > nor does the wireless-regdb database.

Correct. With the new regdb format we could add something that would
enable these ranges in the kernel only with some additional
requirements, but
  (a) we don't implement that now, and
  (b) I don't know what the requirements would actually be, e.g. would
      it be enough that the driver promises it implements "TPC" in some
      way? Or even the manual setting?

> > And so
> > in the database we would either omit rules that require TPC, or include
> > alternative rules (as specified by local regulations) not requiring TPC=
.
> > Am I right?

Right.

johannes

