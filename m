Return-Path: <linux-wireless+bounces-38846-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /e0wONiiUGrS2gIAu9opvQ
	(envelope-from <linux-wireless+bounces-38846-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 09:44:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896C73820E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 09:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=nlPXApL6;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38846-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38846-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4F3300CC3C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C43C5DD4;
	Fri, 10 Jul 2026 07:41:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBB83955FF;
	Fri, 10 Jul 2026 07:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669299; cv=none; b=LPqOVMOu596jxrQ4OBJYqhs620+5Qe56/vnVy3sRpGN1leX4Y13Y/QEFlWjY0IlTaBnk0NsswvkQxF8XiLf1hnKnaMa3/ELcwWjEtnaLH0Gdr0LksMj5GWilmS1fimL+XzlL/vW2TiJ14Pn3oYrEa3Cqb3dJ6SnJB/lmNkok8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669299; c=relaxed/simple;
	bh=H9E+vsON3Wn/y6sOQ+KBXeGGBuShMK2/+uOQXtxMSTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEI1qN0rehBTkwNl+gTguO2rCQ1ecSd9FGEKdnVNh7tDYHR8SLQZHwK/wiJTh/BoUneSiiP7PwPaae+t4ndtRNUZ93CJCuBoLBZZ7EXZ6zedwNf14eHSJpkH4lJIK64ZSH37HBJPXFT2HnHgGLsOAT/+dvUNHvbS6qZ6GCUFyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nlPXApL6; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=H9E+vsON3Wn/y6sOQ+KBXeGGBuShMK2/+uOQXtxMSTI=;
	t=1783669297; x=1784878897; b=nlPXApL6jJxtueiht+whEGMss7CDE4DayEbqYr+3zlBxT/V
	dB+9tc/Sm0RuXWoTtyKpCQsc8R5/+APXCq6yjLiLb7/U8BiCNmE3ReTi7k37xHxadWJKM/kw5VQmH
	/rinnu5bfOCc2+/bBH1xwL4NOO9ovtErBDvtrpNeRloyKYzF8/3mpxPKFQSO7TGixeHpr9CUd6ibP
	Wxba5VhxJEyzdTvz24S3Xsf94S9AwyuF/8bDRg1ms/quT66sUpiL09zpAzBEjjm0UPqwylCKZGkfS
	fm1a0RqwThP8Urx8B9dHOJdTQ0zRiHJ3U47JS4rq4F3IoWTjYmm9rOFkOAWJCZIQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wi5rT-0000000CHG3-2091;
	Fri, 10 Jul 2026 09:41:27 +0200
Message-ID: <1462bcdb0944bfd3ae7ac9618cc59ab6cf75dfc6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mwifiex: bound uAP association event IEs to the
 event buffer
From: Johannes Berg <johannes@sipsolutions.net>
To: Francesco Dolcini <francesco@dolcini.it>, HE WEI
 =?UTF-8?Q?=28=E3=82=AE=E3=82=AB=E3=82=AF=29?=
	 <skyexpoc@gmail.com>, Brian Norris <briannorris@chromium.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo	
 <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-wireless@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 10 Jul 2026 09:41:26 +0200
In-Reply-To: <20260710072140.GA17790@francesco-nb>
References: <20260629120333.94222-1-skyexpoc@gmail.com>
	 <20260710072140.GA17790@francesco-nb>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:francesco@dolcini.it,m:skyexpoc@gmail.com,m:briannorris@chromium.org,m:miriam.rachel.korenblit@intel.com,m:kvalo@kernel.org,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[dolcini.it,gmail.com,chromium.org];
	TAGGED_FROM(0.00)[bounces-38846-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2896C73820E

On Fri, 2026-07-10 at 09:21 +0200, Francesco Dolcini wrote:
> I think we received a few patches that are validating the data received
> from the firmware (including this one).
>=20
> I did not review any of them yet, what is your opinion on those?
>=20
> Should we consider the firmware trust-worth or should we validate
> everything we receive from it? Is there some agreement on this topic in
> general?

I don't really know fully "in general", but I/we generally treat these
as issues. I'm not going to worry too much about them, but I think we
should fix them.

johannes

