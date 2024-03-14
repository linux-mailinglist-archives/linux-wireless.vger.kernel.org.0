Return-Path: <linux-wireless+bounces-4726-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A487B90B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312B31C20EDC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4403209;
	Thu, 14 Mar 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Z+rIx6C5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67846A2
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403433; cv=none; b=sJQfmxKvtIPvmSODxuSdOjQtiENs0OEekk1YJF9Xgnf5i5NOKFf+2NsgOIXKQ2qbB10D6mx2wVSFLhsbP4DYXyRLEsZSvYICX8V7ajNUP2I78wRPAigZ51vhEqZmssJW9NRHPH/vMCbRwGunqvj+VJ0j5sIbhMNq5Jt1fCQ7q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403433; c=relaxed/simple;
	bh=37XdsY1X1f+aS6JptCY/qd3SYUiAnJzvSx4grkQjdVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MrunMLZpSAFfk3MLAKzC08YpEwojlVRq4slf7eIAke03jrMOKFW9NYNl9Dk18kUhw1RMLWPvTPhUUvBI6yTJJyvKNbf+19qRDO2sWjvEd3Yt8Z3Q8hIm1W891t0+CX4IsLaIOtwxX7QDz/CzqDXT8d4MYO8+SLXIIqg8q4sAdLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Z+rIx6C5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=37XdsY1X1f+aS6JptCY/qd3SYUiAnJzvSx4grkQjdVk=;
	t=1710403430; x=1711613030; b=Z+rIx6C5kAqBl+mL5IpOSx42Ov6TJQBgNm716KqhmsaLonq
	gV3ATHr6btpB14nT9Du5EshvfPK6JyWAZuOsEHA+8a8lPl5cxgzwTKC+55L9VPVdhnrhz2MzD6LAr
	9r/HV+IQ4IiDC+N85207XohGsd891KBNh0FXL4Ytky/lFSUa5QmDlzKzzh8vFFmoK1nH/i8fpxKGk
	PhSEJvgWQ5H7PBLLIlXWoUsdxv0gJ+h/hagCyB73/plpLxe/IXkGBWPvOekQczuYCt0EJvID4bcD6
	GJHJCxlNNx/+QGs/1O8K+0rh6es9sr9asTuelh+ULgjFPEc4fPNX0oZqTYMEMezQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rkg42-0000000GQd6-07OU;
	Thu, 14 Mar 2024 09:03:46 +0100
Message-ID: <24017bc8d01a92df6a21acb244644c5d975407d5.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: supplement parsing of puncturing
 bitmap
From: Johannes Berg <johannes@sipsolutions.net>
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Thu, 14 Mar 2024 09:03:44 +0100
In-Reply-To: <4f79391f-cd81-4a3d-a236-447cb4c1f4d2@quicinc.com>
References: <20240312045947.576231-1-quic_kangyang@quicinc.com>
	 <20240312045947.576231-2-quic_kangyang@quicinc.com>
	 <8cc7e7f7b2914385b481ecfdd7bc3f67fc4546b3.camel@sipsolutions.net>
	 <4f79391f-cd81-4a3d-a236-447cb4c1f4d2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-14 at 11:21 +0800, Kang Yang wrote:
>=20
> On 3/12/2024 4:16 PM, Johannes Berg wrote:
> > On Tue, 2024-03-12 at 12:59 +0800, Kang Yang wrote:
> > > Current mac80211 won't parsing puncturing bitmap when process EHT
> > > Operation element in 6 GHz band or Bandwidth Indication element. This
> > > leads to puncturing bitmap cannot be updated in related situations, s=
uch
> > > as connecting to an EHT AP in 6 GHz band.
> > >=20
> > > So supplement parsing of puncturing bitmap for these elements.
> >=20
> > Hah, yes, I just noticed that too and fixed the second part yesterday,
> > and was still thinking about how I could test the first part :-)
> >=20
>=20
>=20
> So what are you planning to do with this patch?
>=20
> Any suggestions or you want to add puncutring bitmap parsing by your patc=
h?
>=20

No no, all good. I was just commenting :)

Once the trees settle and all (we're in the middle of the merge window)
I'll apply this.

johannes

