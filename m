Return-Path: <linux-wireless+bounces-34459-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJvyENfi1Gn0yQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34459-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:56:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A54193AD566
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 12:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1B483037162
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7071345741;
	Tue,  7 Apr 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vqPNiQGl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A2395D93;
	Tue,  7 Apr 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559029; cv=none; b=PNYC66qoJ6UNRNfdN9BHHmoN+RK3hb0owvP3sx7dRkS3L4dkELlTBrxQzIzCstY2a18Utn35DC2pxmAyemXiFYg8xmA6jpZ23H4gZRr215E/NkEfYj5uN2dwhJrw04axCpsDDvvMgO2ahbJZVXtoPCdzuG7ZlKYn4jZVz4QCEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559029; c=relaxed/simple;
	bh=JHIUX+CAVtJIrgteiln3H0UCEd3d3VbNZuyYU6ThT/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acvlj8S4dKB5HOSdJXl6XOWxNop4J9uF2EzYB6xDuQO5bq1+FplFGEdyhw51JUJOnEUw7atriEeAmHs1Bwtli+ieb+UDR9piHKZ76ZY/ffBA6bXRMQ6MZOcjYGe0kvGR8LoxzEhzacl9m6VdCQS4EgUh5fIiqWCUoiFtkG2Z77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vqPNiQGl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JHIUX+CAVtJIrgteiln3H0UCEd3d3VbNZuyYU6ThT/4=;
	t=1775559028; x=1776768628; b=vqPNiQGls0VvXGFp+VZpbgg/calqimQyxZhwpxR/umg9iWO
	f2yeSQrU1rTUoYM0tm50s7O/YEg3lodtgXCHj8cseSCxGowJfEckx5gn3s7KlLJOC4OA8IO/aYV1Z
	iblIBlfcRk356Kwgi+F4iJrS7pkwVKwWz83bS6kD4K3OYmxsubiyveWnW+khYuneUKcxImcMWmseh
	3Eu9b68IfCO8Uj/3S+rpFbPJOp5yixOn722C+jFemTEeXn9yR3f/fxGfB/BWPqZ8drstOjD5a54JY
	5gmkZN3v3qpTODbSS7oLc+GTajM532JssPYWZBkGdtBeA3V19/NCmA5q6jRpLFzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA40n-0000000CGY9-1Yu3;
	Tue, 07 Apr 2026 12:50:25 +0200
Message-ID: <d16f1525ebfd12b0a4cbbde89b4ce7a7f64c7f18.camel@sipsolutions.net>
Subject: Re: [PATCH v2] iwlwifi: dvm: add missing cleaup for on error path
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Haoxiang Li	
 <lihaoxiang@isrc.iscas.ac.cn>, linux-wireless@vger.kernel.org, Miri
 Korenblit	 <miriam.rachel.korenblit@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 07 Apr 2026 12:50:24 +0200
In-Reply-To: <604fd5a1-135b-4a47-b752-52cb21d8863e@web.de>
References: <20260401030555.541685-1-lihaoxiang@isrc.iscas.ac.cn>
	 <604fd5a1-135b-4a47-b752-52cb21d8863e@web.de>
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
	FREEMAIL_TO(0.00)[web.de,isrc.iscas.ac.cn,vger.kernel.org,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34459-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A54193AD566
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-02 at 08:10 +0200, Markus Elfring wrote:
>=20
>=20
> 3. Would you like to avoid a typo in the summary phrase?
>=20

See also

https://lore.kernel.org/linux-wireless/3a7022fcd18fdaf98044f8a3a21b09a2f7cb=
a914.camel@sipsolutions.net/

johannes

