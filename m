Return-Path: <linux-wireless+bounces-6446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463DD8A8341
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A8F284C4F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB984E0F;
	Wed, 17 Apr 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fqp1ncp5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A115A0E4
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357587; cv=none; b=Ey4wbvs6H0FY0OQ1J5lwk1oyXuXDsGnEb3vdvUcrjK1wLaxbJZrmrNbQ6rh9uWGOv63C2xSKYkA7kLVBGm4xWwhagweqeiNZV5VYoJQSp3WSMUvoBv6ZBGj8BJYsqNHLZa++dUjJhSnETbDEloK0x7yoh+b7Ggw08nOBfjNSHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357587; c=relaxed/simple;
	bh=cC1J7hdUzg+z+IoiyOESnA1UndoqpxLHI9iR0fMudWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CiM3PmrsBx8oUA41JjVPQNLlDWcj+AxCct0srTeiMRjvSFyFZnJv/8cABpmpOOtyR9olfCVeGlH5QcveRfqeGCQm6KHJDINc9coO4+zrC2bMlGMcSSk2rtzN8HhEf169CCllfV2im99xj93Kl+MBwKJ6JibTRFqsrFYDotDd7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fqp1ncp5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cC1J7hdUzg+z+IoiyOESnA1UndoqpxLHI9iR0fMudWg=;
	t=1713357584; x=1714567184; b=Fqp1ncp5T8wVRNpJbBIKhRSr9oWHfeWfuikcr5hk6ofNLZF
	HGMQErNevkOiU0uHDkGCQSNAXOTqb7N6PBmW4b0PSGw03p2+/byw2RS+AtCozUPyltXGwA8SfWBFY
	irlpVuCt6ejMei1c24yc2LXRwsHs4HAkmJdbO1945nZ6xbQqocFexrhJeEANV6NThIxwBz3BsuKEA
	OETZ5m5FH2znfTITe0r97ev3fMJtB8uaQjqVUYz6/n//ofalyr7/m7vL4cQp6h9K2FDt/J/STdvC1
	3W7vF0QKcJ11uedwtXk/2LV6yugCYaC2FA/RJdfGGsrK5+sEeloNQx34gROMc+/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx4Zg-0000000AwrM-3A9w;
	Wed, 17 Apr 2024 14:39:41 +0200
Message-ID: <f65765b29ea7503fbbaa5e047c95a82de6fc2083.camel@sipsolutions.net>
Subject: Re: putting future iwlwifi firmware into intel/ ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Mario Limonciello <superm1@gmail.com>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Date: Wed, 17 Apr 2024 14:39:39 +0200
In-Reply-To: <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
References: 
	<fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
	 <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
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

On Wed, 2024-04-17 at 07:31 -0500, Mario Limonciello wrote:
>=20
> On 4/17/24 06:18, Johannes Berg wrote:
> > Hi,
> >=20
> > Since I was just looking at some firmware related thing (files for the
> > hardware that might be shared between Intel BT and WiFi), I noticed tha=
t
> > just over 30% of the files/dirs in the top-level firmware tree are
> > iwlwifi-* files.
> >=20
> > While we can't move the files that older drivers might consume, we coul=
d
> > e.g. change the driver to look up future versions/future hardware under
> > intel/ instead? Would that be worth doing?
> >=20
> > johannes
> >=20
>=20
> How about moving them all now and then creating compat symlinks for=20
> older kernels at linux-firmware 'make install' time?
>=20

Didn't realize there even was a 'make install' time :-)

But then I guess it'd be simpler in the driver since we could just
unconditionally add the intel/ prefix to the request_firmware call.

johannes

