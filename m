Return-Path: <linux-wireless+bounces-5157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7288703D
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8291E1C21FC6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7EA56754;
	Fri, 22 Mar 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FxGlo/I3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6966524C4
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123379; cv=none; b=IgWWqirDvKE4LtFg54IpFfcN0AoB4MZoW5ccyXkC98rGh61vo+IIbjzq/j7cZX/+KmTNUn4FqkSDy2IzPvBPuEUxMFjBX1xAw15ZG5pWV63CDot7O5BELqvu8zawgV6ej9PTbHiI+5tEl4qHD5avblWJEm6pWYcMVhw7XWff2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123379; c=relaxed/simple;
	bh=jpggPkgGn7mU7dQBusB5nl2gUCyYuXWflkDWw8wlbs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJm5NwCt9ty7tcYW6Pz2DtYt5aAhX3BQqZqQbXXxCc/8hknSNO/hSUMvkZfwOLnWVKqUIMvu+A55e+NL4s9pTNatwIyRY4U4Iq+mVEwr4S5d6aeIF1CLMXiwIrksoUFG7vzY2Y022t+fZ35v8vnXiK5nO7/xFOziENyzWPD9QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FxGlo/I3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zfycjR4G0Z7gGgay6hupFqtRwNZvv/E+4EUNN49G/Sw=;
	t=1711123376; x=1712332976; b=FxGlo/I3iXG7kaZ9FwxvmWNeOslFBzZGBt1Si23eWAd6q65
	yKTdat9XU5WfCgqT6/uNty55rQ7eeSXfGbM+f7vMnPpz40s6Kz5yneZyR2+bRWLwEdNAGTQ7RCR0Z
	2PEuE0e2Eh6pMsa/6i4dN2G+OOIyp1XaVYotSqtMxvNb3WbO8X9EW6iVaPtdTHCTxRKtJbTYcy5xX
	PmLVbtMCmtbQz3xINkdHgjwB3rZdrq+pdP+DNvt7PuCkeHHTCR7eTC4nEcu82HkZ0NUVgSGP4tTSV
	BEErbX5vubOzsUme2HSEK3AA2JunKvdjdX/McutEBBhC5Rs8WPZwxf7OiqJDxNBg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rnhLz-00000009v4N-26Xf;
	Fri, 22 Mar 2024 17:02:47 +0100
Message-ID: <bec0c3f9220c5084f163a39355499bcc7a32da36.camel@sipsolutions.net>
Subject: Re: [PATCH v2]wifi: ath12k: Add firmware coredump collection support
From: Johannes Berg <johannes@sipsolutions.net>
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Fri, 22 Mar 2024 17:02:46 +0100
In-Reply-To: <20240322054231.467152-1-quic_ssreeela@quicinc.com>
References: <20240322054231.467152-1-quic_ssreeela@quicinc.com>
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

On Fri, 2024-03-22 at 11:12 +0530, Sowmiya Sree Elavalagan wrote:
>=20
> +config ATH12K_COREDUMP
> +	bool "ath12k coredump"
> +	depends on ATH12K
> +	select WANT_DEV_COREDUMP
> +	help
> +	  Enable ath12k coredump collection
> +
> +	  If unsure, say Y to make it easier to debug problems. But if
> +	  you want optimal performance choose N.

Why would having the hooks to dump affect performance? Surely you don't
expect to be doing it much?

Also I'm impressed - 55MB seems like a lot :)

johannes


