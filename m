Return-Path: <linux-wireless+bounces-8841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CAF904E07
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052C9B265D8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241F16D31D;
	Wed, 12 Jun 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jxjhla1M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EB16D317;
	Wed, 12 Jun 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180449; cv=none; b=daFw8K3fdAEK9QMq/B8tkSnJSaXJHnB1eQwf1+ewJS9RDSjs8JTwzjy0IrbC3+K81qiQgHyTTEvMQOBXPpm/QcGDSk0pLdrDUyKoTBuFPJahlHvtQ+KlhV27YKQ2zXQoIaoZ/Gnv/KPDlQAWdGWCmd2W2B2MW34c9ZiPhcdazw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180449; c=relaxed/simple;
	bh=9HuacNRP3bo0WNhOPRunBvvDTsGS0ET2vmHYVWCg33s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFqzZ6REd5Xtp7EfrY9uqKThy40jh9dWLDa6CcaJLYoK6nsN68dVp8OUaij44WcejirLCRo4fuJKYOPdXi7Df5FdA7WXwOsk1kqVMhBchfCKEq9z61+cw0ZTZCE19Hu7o/z52pZzeMeZWmn+NhCqdmt8YdIoZzz97owXuEGOt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jxjhla1M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9HuacNRP3bo0WNhOPRunBvvDTsGS0ET2vmHYVWCg33s=;
	t=1718180448; x=1719390048; b=jxjhla1MKXiLqtXRY3k4qiAm6ka9EkTvxrv4kXerzPKTPng
	Y2QYCwb0DrzYr4dN1vDVGrtA5qAJUvRKJbdL75s9LlmWnHnHnZoqIribS1L+bfVUH+GsJanQcM3Ki
	XJ9gcswPhmIL+r2/F5RUf+zZ6y1XQYyTIzu6h8ErBgVambHhYSHOLDKXhVS6VATxc2hCylQZ4rvno
	ZO9Bjo9jHZ9txIskRkMEWN8Ndd1JvPGB1pyMTBE8MNpvq7wU+rmmKQIU7GgOPeMSZSeGaOK0IBv9q
	LTe0evpESN6nANGzFjRApb+B1VvbHDxEQHzvgHg+LpGn6xp9k77WnJQl3W9DnaHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHJDm-0000000A3IA-0RlL;
	Wed, 12 Jun 2024 10:20:42 +0200
Message-ID: <fd1acc0f69ef9573ff0dced35863949c80c6d5e7.camel@sipsolutions.net>
Subject: Re: [PATCH v3] wifi: mac80211: Avoid address calculations via out
 of bounds array indexing
From: Johannes Berg <johannes@sipsolutions.net>
To: Kenton Groombridge <concord@gentoo.org>, Kees Cook
 <keescook@chromium.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 12 Jun 2024 10:20:41 +0200
In-Reply-To: <20240605152218.236061-1-concord@gentoo.org>
References: <20240605152218.236061-1-concord@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-05 at 11:22 -0400, Kenton Groombridge wrote:


> Co-authored-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kenton Groombridge <concord@gentoo.org>
>=20

Wait ... I don't know what Kees did here, but seems then he should sign-
off too.

Kees?

johannes

