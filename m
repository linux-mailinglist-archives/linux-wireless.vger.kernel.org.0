Return-Path: <linux-wireless+bounces-31229-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBitMwHGeGmltAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31229-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 15:04:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39910954E7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C474D3084912
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917D35B139;
	Tue, 27 Jan 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CcWJsaWk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010D33B6FC
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522256; cv=none; b=ABHPr7OEox32c57XwN8+NarOnKRQRR7FVkn6xhhOm6bGvm6HfFSnXoPfEZ2DspdawHQe4d5DQsKs2Vl+Ew4NgXhn0KIsMtPKaGDLxm19d85Bh6tExGsjQRMpcD2LM7VWv3s6sP/oPc/fKhZm1Umo2ZG9T40FKqsLtexLYaFiqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522256; c=relaxed/simple;
	bh=aVtcWUcwsPJ2e6fDQcV0HjIMSTCFLqhjU6lVjT1R/oM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbUdwu87DgAeE6E+Qw+qnXN0b19GBRyrOBxIC5O+4s2f//Vx5rpsgJdEilIlR+WVrq98vIw81Jb/xfg35L99qKZyBSVSzkxbb1Pvr9TnaBPXVxWATlhJ3IA5i1pSz/d+cWDwnLDBItgmSnJt2JxrJkX8T+TrBGzMJbkdFji6ySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CcWJsaWk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aVtcWUcwsPJ2e6fDQcV0HjIMSTCFLqhjU6lVjT1R/oM=;
	t=1769522255; x=1770731855; b=CcWJsaWkaCXsIFgDo92/aNa6SeUJZQUa0+5SHbpOszRZyYy
	W5A3m8uIevl6LlrZqgbRGNVInvQYjlf0nePDpNmhT6jJAujUl3BcpKsCRWPGmVGOKrIF/3VawQJ8P
	KlkkmI/sJhZc4hqnRhUERGLxcBEJXI062RRwfYs1wonbDHcqaWDcKojK+iueauRrlm+SwxfQekCHX
	QJsWrc8mh9hMRw03Qc9fVvyjD/k7yXphTOhQ79o+QlEjJgbRlAK7TTKxv+QTNxQtRb7eBFi2F7Qg+
	io5V4dB/JzvDzKatvr/HDsezfyR9+9c/7YpChV7irWXiq293aRT8GcA/ryccs2Aw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vkjZT-0000000514I-2Id1;
	Tue, 27 Jan 2026 14:57:31 +0100
Message-ID: <9ea4b65c3fa5750ef57e93dd04b70cc4ec5df445.camel@sipsolutions.net>
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP
 Coordination (MAPC)
From: Johannes Berg <johannes@sipsolutions.net>
To: Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, ath12k@lists.infradead.org,
 hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 27 Jan 2026 14:57:30 +0100
In-Reply-To: <88f05d03-2742-4b61-964f-54beafdd2e70@oss.qualcomm.com> (sfid-20260122_094252_172709_97D85042)
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
	 <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
	 <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
	 <63ff0362-4ee4-4f13-a212-dc1351eefe08@oss.qualcomm.com>
	 <52356be3d21920d84579d1a8fd803540c6f9644d.camel@sipsolutions.net>
	 <88f05d03-2742-4b61-964f-54beafdd2e70@oss.qualcomm.com>
	 (sfid-20260122_094252_172709_97D85042)
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31229-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39910954E7
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 00:42 -0800, Abhishek Rajkapur Suryawanshi wrote:
> > Taking this specific example, it basically says "FW sends a request to
> > hostapd, hostapd does the handshake and installs the MAPC station. This
> > is how we think we should handle the MAPC stations."
>=20
> hostapd controls and manages all MAPC related discovery and MAPC peer=20
> creation part. No trigger from firmware for MAPC Discovery Phase.

Seems to me you're splitting hairs. Clearly you have the *negotiation*
trigger (NL80211_CMD_MAPC_NEGOTIATION_TRIGGER) prominently featured in
the diagrams etc. Sure, it maybe that doesn't explicitly trigger
*discovery*, but if hostapd doesn't already know about the station that
the FW/driver is requesting a negotiation with, it probably also has to
do discovery...

Anyway. I went to write a long email replying to some of your individual
points but deleted it again, I feel it's not worth your and my time.


Clearly, you have already decided on the architecture, and aren't
sharing all of it, based on reasons you aren't really sharing either.
Which is fine, I can't claim that we always share the full reasoning
behind architecture decisions.

We should all still make it transparent _how_ it's intended to work, but
that could also be just part of the documentation added to the kernel
when adding the necessary APIs.


Which then means that really in all the hundreds of lines of text you
just wanted to ask whether or not "Option-A" or "Option-B" for handling
the MAPC peers should be used, and I'd agree that duplicating APIs isn't
good, i.e. taking "Option-A". Note we did something similar for NAN
stations, even if they have different sets of attributes than regular AP
client stations or mesh peers etc.

johannes

