Return-Path: <linux-wireless+bounces-31452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA2OOoKHgGnO9wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:16:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 545AACB896
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E7F63002299
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E41B4F1F;
	Mon,  2 Feb 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oszJ3Qoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5523D7FC
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030780; cv=none; b=GbOUFe/j5C1JY9QMNqq60e+PYyCuoHkg+nfSMpZ59TM9uz3DNjmtRNp9wAc0zSS14lVacmZ2pkGGCccF6TRqnPitu4RYmAnP0FKqF3I9m814qjKh6rEBNWLyMaeyrgG662HcdISnpOctUbm4R3HT2SlDaqirIyvs+7P4mZ1odpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030780; c=relaxed/simple;
	bh=+AjKQZTARhym8PCDe+vVC55RiVIIAoOmYP28Lj3e9XM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYxP5zdOzzzXRZW47umfGG0si6LaNXfiOJfIdOu5HdO55up3WEPIuvCIhAZD+fDYKmEmnDsZdXk+ewixUYAmXcGWa8OoWC4CmIh6AzZA70vy57tCXBwu/8XJz+KganP4fnPUD8/VGinfntaJ7X2b61FdDszFx5kOy6D9pxg+AvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oszJ3Qoi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+AjKQZTARhym8PCDe+vVC55RiVIIAoOmYP28Lj3e9XM=;
	t=1770030779; x=1771240379; b=oszJ3Qoiwwz7eDDOwSMjozQPsEyWPFI5IWfsmNXbJLfJJv6
	5sHuaCcDrp9Gjj2bhgyd8CL0npV+vs8E5MKIpbMPChrgNDwrO2kJ2liF6qr/3I+Yu+KcNk9szhPMp
	TcJ7pRp+fIfaHXLYoJm806kg52LvrysOODWor25gcqqI8r8sDN1cnmGlaHlwNdHyUJAq1hyIsmMdo
	Rvx47O61B6zCAGWyfVQ3u8OQKofQudBDZ2C8FmuJGjAkj9AFPAXpMKXFpVYXI2yxbO9mPmZMN+4sI
	hAfzxHjWnn65t9KbU1/e3xzg/6UhtGSshU8lhX/z7aX4EC6CuPFhe/VZuNXbVXzQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vmrrT-0000000BVeT-3aE7;
	Mon, 02 Feb 2026 12:12:56 +0100
Message-ID: <e0090840157dcb9968e683dab437296871bbd4a5.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 0/3] wifi: initial UHR support
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org
Date: Mon, 02 Feb 2026 12:12:55 +0100
In-Reply-To: <98c47cd2-6e90-4a17-a8a3-ea2d2290a72e@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
	 <98c47cd2-6e90-4a17-a8a3-ea2d2290a72e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31452-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 545AACB896
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 16:20 +0530, Karthikeyan Kathirvel wrote:
>=20
> Would like to see your approach of NPCA for AP side, since we are=20
> working on Enhanced critical update for all UHR operation features(which=
=20
> includes NPCA as well).

So, FWIW, I went over this a few times in my head ... how do we support
it when one station has NPCA and another doesn't (need a per-STA flag?),
how do we update the NPCA operation when stations with different
parameters join/leave the BSS, etc.

Ultimately I decided that I'm going to leave these problems to you ;-)

For now literally all I've implemented for testing is an ability to
represent NPCA in the chandef (adding npca_chan and npca_punctured
bitmap to it), and two new nl80211 attributes to configure such a
chandef.

That won't even be an upstream hostapd patch, just some hack to set the
NPCA chandef in nl80211 and advertise it in the UHR operation element,
but it's already good enough to test a single client.

(Oh and nl80211 won't accept that unless the driver advertises NPCA
support in UHR for the AP interface, which our driver won't do outside
some testing mode.)

johannes

