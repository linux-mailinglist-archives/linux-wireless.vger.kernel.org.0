Return-Path: <linux-wireless+bounces-29330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543FC843BA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 10:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A19514E3828
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B1254AFF;
	Tue, 25 Nov 2025 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F2vl1DiF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D4220698
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063042; cv=none; b=ZB4mkdv4D0NoprdRx8U2kkigAjhg+MI+rwavK5TYL+cJH8dRZYNKoDySwMf9gRQB+y3i+91H5YjrxCAaWBMro7JLQ8xOY5jlGjxZpl4MYx3AA1QvKim5eTXV4+GMIgo09OBJ8DPLfwBGDv9R0Q3NuOiNd1bIyNcWCVJzlFTlNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063042; c=relaxed/simple;
	bh=WduaUWmxj9xxZ1EbHkIsI2lIVx0DnRQHV4kX4ZPrE0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kY1XmTfOkRl4Zqbli405lH9x+g2U3ld5H9AurZwMfxa/bhdWNzKNqpQRdjx9Mb2XJ4WaBWhkkQgfaYXX8YUeNePniPLaG2K5/qrjh4TvR78N+gw2SL6mRvnnY6lKi71aFzCQBz8SBPy5jKPlFQf+N9zNd66Pr/yYqyQxiZU7zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F2vl1DiF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WduaUWmxj9xxZ1EbHkIsI2lIVx0DnRQHV4kX4ZPrE0I=;
	t=1764063041; x=1765272641; b=F2vl1DiFBlLbMUWyRuyVk/3yiqmoM/Mn7ds393IHGq9u9KG
	rfB14KjsiU4hWOGOUjMhRmtai5HfEnV4+llUvq28J8KZww/RWXOFI9bOSjMl9D6Dv3h2LQJlc31Ae
	kgUua/QVWbvLJOBIrDlzDf00sjTx7Tq7qDKZ/YryyinErfvLp3SD9TzMQQ1wJc6BcHbS1AKkLqbW6
	EDCNayq+sZyP0TKPJIAtnAp8GUmyXQNwQhu0g5NLM6oiHVx9iZPDBcc5zFt1NH7bjJK8J+P6mw+Rn
	t1mZqwjriaFH7ApB6g/whHcJMjUg7ARO4PxAAxdPjgs+fpa1OfMJS8XN9JpeN1SQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNpNd-0000000Be3N-43Lt;
	Tue, 25 Nov 2025 10:30:38 +0100
Message-ID: <41f2d55eb0921a95db6a3445800df67dfe99e7ee.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: correct FILS status codes
From: Johannes Berg <johannes@sipsolutions.net>
To: Ria Thomas <ria.thomas@morsemicro.com>, Jeff Johnson
	 <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com, 
	pradeep.reddy@morsemicro.com, simon@morsemicro.com
Date: Tue, 25 Nov 2025 10:30:37 +0100
In-Reply-To: <20251125033915.3m2uczkde2nqcoya@1207> (sfid-20251125_043925_657383_C69B50A9)
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
	 <20251124125637.3936154-1-ria.thomas@morsemicro.com>
	 <29ebeb55-1528-42b0-a692-11f20097fca8@oss.qualcomm.com>
	 <20251125033915.3m2uczkde2nqcoya@1207>
	 (sfid-20251125_043925_657383_C69B50A9)
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

On Tue, 2025-11-25 at 09:09 +0530, Ria Thomas wrote:
> On Mon, Nov 24, 2025 at 09:52:31AM -0800, Jeff Johnson wrote:
> > On 11/24/2025 4:56 AM, Ria Thomas wrote:
> > > The FILS status codes are set to 108/109, but the IEEE 802.11-2020
> >=20
> > Note that the current version is IEEE Std 802.11-2024, and it would be =
useful
> > to directly reference Table 9-80.
> Thanks, I've noted that the current revision is 802.11-2024.I cited
> 802.11-2020 because it=E2=80=99s the first revision that defines these st=
atus
> codes. I can switch to 802.11-2024 if that=E2=80=99s preferred.
>=20

Didn't really matter here, but generally I guess it would be better.

I did apply this now, but I do wonder if we're better off just removing
unused values? We don't (even pretend to) maintain a full definition of
everything 802.11 in the kernel, and don't need to either?

johannes

