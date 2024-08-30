Return-Path: <linux-wireless+bounces-12263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79096612B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 13:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BA51F28F2D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED2199953;
	Fri, 30 Aug 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A99KWBxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A54199927;
	Fri, 30 Aug 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019107; cv=none; b=fZz5WgA6BPLZXfOobCNctMpts1pUyIMualXCdjE4Ls5MnAx9lO0tYOrIhCQnEj3eGyiUPCA2EhsFU5felkrxxqyiGrPUpV4LX/60C0Cj5BsDPYTWRIGNcRW6fuz6g23+Moh7LHvBnh831Vj8RMuDMQC0nWJyn24rXnvWXU6zvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019107; c=relaxed/simple;
	bh=E7pEDWEStrAaG2FKZhDY2UHnf6lFd/Hl1n8C0FnGH3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXE8s+UM/StZaSXLskE01EiTIPPbpY/Bjf83IK06VEOqSsZiGjEt2EUNhmw310bBQbJDQxTcm4d2R1JAF1xo3Rvgwj7EZ3FF+f4H223TO6knZP5kJaEAQSbgU8QhOnv2eZUUwxb/pyOLpQnpyI8hr6iRmdePVgLSr1M62bS2ZBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A99KWBxM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zewzSXQ3UbL9TPbGHpoYN2Ss1C7MaZ+YxfmHenSYXnM=;
	t=1725019106; x=1726228706; b=A99KWBxM8HLBm34VEZ/RxppB38aZL+DwFRR5GYgEyltwztl
	bLkVkH5onjHKf092sFTuQg/bTMdnh01DlkaaOUOdB2PIOddE93JDTqKVBkj82nUmFdQE3yEsmw59k
	jbGF1cFeNrZ9eUEp6f6TAznaUUIZSm4AQJYZu64ln6qlSiS2yonqPkO5a1Y85BJ0LEscCbZK80mwP
	ajOfFe5/7SmPcgOhCZ+7Ou75ZmjD4GxIs+VTrZr1yTEMKxH+raEw5mKZs1Wt6Q8KCk2kgaW9xswqO
	8EAXPdhHMEiEK1x7JWQuNAGr+9SZI97vl5VA53/Ok+SH7bztQKdfGPJdhQX9eNWQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sk0Gj-0000000BMZP-22gU;
	Fri, 30 Aug 2024 13:58:21 +0200
Message-ID: <192a1df2754eade22b68da5d8652dc996f2330e9.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mwifiex: Ensure all STA and AP use the same
 channel
From: Johannes Berg <johannes@sipsolutions.net>
To: Sascha Hauer <s.hauer@pengutronix.de>, Kalle Valo <kvalo@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	 <francesco@dolcini.it>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 30 Aug 2024 13:58:20 +0200
In-Reply-To: <ZtGnWC7SPHt7Vbbp@pengutronix.de>
References: 
	<20240830-mwifiex-check-channel-v1-1-b04e075c9184@pengutronix.de>
	 <8734mmuyq9.fsf@kernel.org> <ZtGnWC7SPHt7Vbbp@pengutronix.de>
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

On Fri, 2024-08-30 at 13:04 +0200, Sascha Hauer wrote:
>=20
> Related: num_different_channels is exposed to userspace, but outside the
> MAC80211 layer there is nothing in the kernel that enforces this
> restriction.  Am I missing something or is this just an open patch
> opportunity?
>=20

It is, or was least was, non-trivial to do in cfg80211 since it
isn't/wasn't always fully aware of what's going on. mac80211 does this
by calling into some helper functions with an appropriate description of
what's happening, any other driver could do that too.

johannes

