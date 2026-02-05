Return-Path: <linux-wireless+bounces-31576-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DWoLww+hGk71wMAu9opvQ
	(envelope-from <linux-wireless+bounces-31576-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 07:51:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDDEF1EB
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 07:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90CB4300492A
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68731A57C;
	Thu,  5 Feb 2026 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="G/KbFRk2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA81254841;
	Thu,  5 Feb 2026 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274295; cv=none; b=c+rbi7cfqpy9MlEyV3Hxzw5s+FgPEi+qRxUmLu2iftRGQBjO99SRZX7+vS10GEkZqASQ6ENCUo0nsC5J2SmOMxNsAPIY2t88ULlXfG1oeGRKuSdUqrnhPwcVTdMz+ME7j7SSbCTks5LUwdzKlIQjlJ+u2mQedovjaV0wk4vtxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274295; c=relaxed/simple;
	bh=JFHqCS/QE3dG9chs601h5qLL6L3aYBiTEhvSUt9PcEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VTT5giyHyVu0J2GXzpb5PKz33NZWMJwsZ82/e7j147YnLoIBMbjNwtlNk5ZQnjKdisnefJCHvRIjIaHYb66RqQIXfKLxicEGulaEYbhItha4o2n/+yJMovzDpIxB2mBgehobUYpEF6gFLwHqENNQ1JIM7bxP8c4eg0IMqPV4vY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=G/KbFRk2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JFHqCS/QE3dG9chs601h5qLL6L3aYBiTEhvSUt9PcEg=;
	t=1770274294; x=1771483894; b=G/KbFRk2hoI7KOBmNICMrTNJrZRMWJJbk40M12JMba+mkZG
	8/9jSfpB6lS0yw8jd7ri+svTcsz/rIXwVzSCGCHiVvQTvpgZsz9TpHlecs9YqY2gnTa8glRSTwfec
	pWBRS/UEOTiwi9M/Q/W4R5rBkF3TTPpNqEE9Jvi9aSd5gRxrxBQsiou2sprwNU84pjf7qC4RfPEql
	9061edXxtJ8+ATw4n4IIrMzt2qmJFazjKgDX/sR6o/s084sitlt/xORcHi7Y3Z6pmO/FweIt4jD1o
	FnzchNQdJW79oFtaSwZ9OELWSOAmJBNLJ8l8Ot7b4gJaLRdy1q2anQorILQt7oWw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vntDA-0000000FK18-0wMQ;
	Thu, 05 Feb 2026 07:51:32 +0100
Message-ID: <b7c2c89e50fa9b6fdfe9a52f9d3fbcd1518522f3.camel@sipsolutions.net>
Subject: Re: [PATCH v9 00/21] wifi: nxpwifi: create nxpwifi to support
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	briannorris@chromium.org, francesco@dolcini.it, s.hauer@pengutronix.de
Date: Thu, 05 Feb 2026 07:51:31 +0100
In-Reply-To: <aYQ8EbSbln3bN9n+@nxpwireless-Inspiron-14-Plus-7440>
References: <20260204180358.632281-1-jeff.chen_1@nxp.com>
	 <3eaf27a486a80012b0be116e847f2e93f162aa1e.camel@sipsolutions.net>
	 <aYQ8EbSbln3bN9n+@nxpwireless-Inspiron-14-Plus-7440>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31576-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 55BDDEF1EB
X-Rspamd-Action: no action

On Thu, 2026-02-05 at 14:48 +0800, Jeff Chen wrote:
>=20
> I dropped only the DT binding YAML from this wireless-only series because
> bindings are reviewed by the Devicetree subsystem.

Right, I get that.

> The driver keeps minimal
> and optional OF handling,

Yeah that part seems strange to me. Any OF handling in a driver should
be written per the binding spec (YAML file), I believe, how can you
write it in the driver without reviewing the binding first?

> but SDIO bring-up does not depend on any DT
> properties =E2=80=94 enumeration is via SDIO VID/PID and the driver works=
 without a
> binding.

Yes, I get that too, but still you have a driver code that (I believe)
ought to be written to the binding, but have deliberately excluded the
binding. So I don't think the code should be present either?

> The plan is to submit the binding YAML (and any DT properties we actually=
 need,
> e.g. OOB wake IRQ/regulators) as a separate patchset to the DT maintainer=
s so
> review happens in the right subsystem without blocking the wireless revie=
w.

Sure, understood, I just think there's a code dependency too, per above.

johannes

