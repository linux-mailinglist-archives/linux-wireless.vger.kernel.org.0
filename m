Return-Path: <linux-wireless+bounces-12004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21695F979
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 21:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E11421C21994
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 19:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49418192D64;
	Mon, 26 Aug 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bdVRIVP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2173194138
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699682; cv=none; b=NZjuGJGvEHRlhNmilwDP2C24BNLrtCPfMqVmEsISibSU54kgJhTGyflgYoyaLxJmaUR5GWtAPuWuOEXcyYdty4ELhbp5RrW0LWy1qxbyw8UDVS/mkmrYUGzON35Qcxp59y4n9zryqXf+t7QS+8xL7g5N+a3Y6JjB5NuK0y3dVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699682; c=relaxed/simple;
	bh=DyZ11z3jM70xw3XrEb2TSifH5iWS/8/RfIpA4pclKRQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTRakdYVx/2G3uRfYh7qN3siUjL5rOkn978MXG1xB4o6sJJNJSlPpB1fr0k6nxXicMNVvFmVKRdATplYaStMsDjWDumlyP+opwOQ2uHzqTdZsz3dEET+k2lTOabL8RUJCHo8w16XglGeVe92MurgITM7084dj3z09UZbahsACI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bdVRIVP4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DyZ11z3jM70xw3XrEb2TSifH5iWS/8/RfIpA4pclKRQ=;
	t=1724699680; x=1725909280; b=bdVRIVP4sT3lggJsZJKdlh5tBKkAz6SiThOoGZI9u87FQsp
	CMO7fNjQv2GMJN3Z7eDEyCgjHakjXmKYdGIh/VV17D9XUOD/qGn+Y0izGXCNO+QkI6dHTv398EIlm
	sQx9y8C+g3ycWgbUIGehK8u24mAZbtsqVq6zip4FydD0xeV/ffgB9/nFm9hB/RK2Cw1rL7rVnRzrW
	LFxyvIDlSJdR2iQNdb+KoBva+DYhWixTOkJ9pLJ1BNTT2yqtjHL5YWdw7t9fb39UDvWTfnKRQzDk9
	Py+2DxU0vKIcPQY2CLyhNaGpyltDXzyypGN7dc5+W1wGiuyrMxYLYIoVKRLOacdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sifAk-00000003P9k-1Bil;
	Mon, 26 Aug 2024 21:14:38 +0200
Message-ID: <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
Subject: Re: WiFi constantly changes association
From: Johannes Berg <johannes@sipsolutions.net>
To: Alan Stern <stern@rowland.harvard.edu>, linux-wireless@vger.kernel.org
Date: Mon, 26 Aug 2024 21:14:37 +0200
In-Reply-To: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-08-26 at 15:06 -0400, Alan Stern wrote:
>=20
> Is there any way to debug those INVALID_TE and PREV_AUTH_NOT_VALID errors=
?
>=20

The kernel doesn't use those codes for its own deauth, if that were to
happen, so you'll want to look at the wpa_supplicant log, perhaps
increasing the logging verbosity for it (I think how to do that probably
depends on the distro, and I don't know off the top of my head.)

joahnnes

