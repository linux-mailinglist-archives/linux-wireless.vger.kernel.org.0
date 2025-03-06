Return-Path: <linux-wireless+bounces-19847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590ECA54442
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB603A85DE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8519D1DF964;
	Thu,  6 Mar 2025 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FeynSXqr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059374315F;
	Thu,  6 Mar 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248611; cv=none; b=Aan4g20/LyP1CdQQY2FMVyBnRbnOxcY4cKJ2HH643E7xXwYSdgrikDrGAnacUyyUrlZ6wW2JDV7rN2ldVNeIDHXxS7Awa/L9yTKPumQ36+OdoRHCcHgtCHnpnkOlykoiac1zDwOJL+93pdQtAsTcC6/MI6g31XatprTEeymYs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248611; c=relaxed/simple;
	bh=rzJGmMInzv26KjEftdsPmyjLfgJnpq/MSN14afFB9xs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l7ALcsZf6Eu6FqMfqQHQyhRf2tkMUpx2X9kiIkFhAnA1v2OpHF3RzqV+zw/RRVZ353Ov5PUCksJzIcTJcUFFu5I3VRkcHO0+1hegt5mswpBLy3pq0h/ng5Us75cImokZAPuRuJvt5OQY+6O8ULbGA22xkQZQSutRLpa0Lxf8MUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FeynSXqr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rzJGmMInzv26KjEftdsPmyjLfgJnpq/MSN14afFB9xs=;
	t=1741248610; x=1742458210; b=FeynSXqrNWhsj9TLCxB91skzynh7hWSLy1EKUe3E8pp/DzD
	e/X3bi/zIg8ipbawH8K3y/6FrcMSXKeOABD1jqpDAiuAaRnMDHGW45851onL/wIczILdRaMZqKL2A
	6OYOsS7re+DO+Hv2cn7HP/TiqSMUpfO+LhQ1HG69kxmmEQG9+BAvXjuZ/TFw1xaqVZm1ko4CxeNIc
	dAqCDd1AZe1eAGVcp4WPOoCXuaAs3K6HMtyQVXOVqo1c3RRox4e1XG6DwfYPBwvNfu3Q1iqZYjQ1O
	49oC7BO0n7Z4/kl5HLlm+Gib8MKIuhw6WcIRyrpYmYd5fDXFlhDWviX5G7iKVQ0w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tq6Iw-00000002iIX-2gOJ;
	Thu, 06 Mar 2025 09:10:06 +0100
Message-ID: <98b872e270bf2d03700b39ec5b62f2746eb46e88.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/5] wfx: add support for WoWLAN on Silabs WF200
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>, 
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	linux-devel@silabs.com
Date: Thu, 06 Mar 2025 09:10:05 +0100
In-Reply-To: <23857370.6Emhk5qWAg@nb0018864>
References: <20250302144731.117409-1-jerome.pouiller@silabs.com>
	 <2018315.usQuhbGJ8B@nb0018864>
	 <98e39be3351190ec71ffb067c062c82883ebef24.camel@sipsolutions.net>
	 <23857370.6Emhk5qWAg@nb0018864>
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

On Wed, 2025-03-05 at 16:18 +0100, J=C3=A9r=C3=B4me Pouiller wrote:
>=20
> I will send a new version in a couple of days. Thus the various robots
> have time to test it.

Any particular reason? I don't think you need to break the lines in
these two minor cases, it's only a couple of characters wider.

IOW, I think I'd take these patches, but if you have something else to
change about them I guess let me know.

johannes

