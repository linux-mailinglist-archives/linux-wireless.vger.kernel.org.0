Return-Path: <linux-wireless+bounces-34900-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BmqD1wt4WmQqAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34900-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 20:41:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D819413D41
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 20:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00D33092E47
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FB433CEBB;
	Thu, 16 Apr 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ieBMJ7Ag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273F1DE4FB
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364783; cv=none; b=pkk+uZYYXXUPR9HWJTKhuJ934JKIad0ju9VPNuBp4IVveLeOgeuQghcmXYz1jnQcbiivwctnFTLwoX3aK+GfoEL5vaDHOGR2rWsO40l9QLkPH9Ygoci1a7SAvwP5V+drLiNCKutvIcQevHj+hHzhNEtPKOnTnVSDPuWOM7NqjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364783; c=relaxed/simple;
	bh=a6qt4DaAZX3X+0+XAsUbK4ntUamCn34KkA045ovbaKA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qvtenxqtl1P0jTjG8IppFNxSZpTl1/xFkaAqss9//LLTgoZ0ynHfaqAeDb7ATiTPX7OYVIAYfGGP0EywJspwPUqQk8VVhaKAkVkStSgl936DYCEcxQCEqcD6fp0b/A/O+s9mQlv6MbQxF/CWl+ceJtJ7ajAb/BGpnZCjnzXGYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ieBMJ7Ag; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=a6qt4DaAZX3X+0+XAsUbK4ntUamCn34KkA045ovbaKA=;
	t=1776364782; x=1777574382; b=ieBMJ7Ag7RSWy6iXno6toK08C6ZSPFkfbh4gv6PoK8UB7YO
	o/Jk3Gq9hgrxNhenqNVUmAjDInJN1kI3xPZEqxa/qRmCkwel64/gdrJ/pnBIfapgQKfzmCZczR58A
	Zj8hmFEnreR/okVY3yAHoHDZBJlkoXe2xgRMvkjyaCTY6+3/E+n8RV5nz+kb5P7qqdGjx9uCbLXCy
	tBfNUPZqsQnqlhShINiJJoEaaTAUlYb8Z4CLUlTkaHKmTX+HQaFrs7CKXvsnme9TR8BR91ouxELBX
	oTXQz48FdHwEDqE2IXALGrNG8ldNOkE3nGBoBQc/yE6NFjsCJjvViXoCn1KoegwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDRcm-00000007bVw-38DL;
	Thu, 16 Apr 2026 20:39:36 +0200
Message-ID: <c29bf32b7f1195a69d86b4f728ab02523675b41b.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/3] wifi: wcn36xx: fix OOB reads and heap overflow
 from firmware responses
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Tristan Madani
	 <tristmd@gmail.com>, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Thu, 16 Apr 2026 20:39:36 +0200
In-Reply-To: <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
References: <20260415223710.1616925-1-tristmd@gmail.com>
	 <9fa651dd-6004-42c6-8c03-95247d5807fd@oss.qualcomm.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34900-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid,talencesecurity.com:email]
X-Rspamd-Queue-Id: 3D819413D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-16 at 09:25 -0700, Jeff Johnson wrote:
> On 4/15/2026 3:37 PM, Tristan Madani wrote:
> > From: Tristan Madani <tristan@talencesecurity.com>
> >=20
> > Hi Loic,
> >=20
> > Note: this is a v2 resubmission. The original was sent via Gmail which
> > caused HTML rendering issues. This version uses git send-email for
> > proper plain-text formatting.
> >=20
> > Three issues in wcn36xx HAL firmware response handling, including a hea=
p
> > overflow in the main response dispatcher:
> >=20
> > Proposed fixes in the following patches.
> >=20
> > Thanks,
> > Tristan
>=20
> Are you able to cause these issues to occur?
> My expectation is that this is testing things that firmware will never do=
, and
> hence this adds code and processing with no actual benefit.

We're not really supposed to completely trust firmware though, right? :)

johannes

