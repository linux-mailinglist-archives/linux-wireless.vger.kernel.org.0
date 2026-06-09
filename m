Return-Path: <linux-wireless+bounces-37579-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZFmSMiXyJ2pL6AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37579-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:59:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E69765F358
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:59:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phiality.com header.s=mail header.b=q7poJfGQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37579-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37579-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=phiality.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8383009F59
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 10:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF263F9278;
	Tue,  9 Jun 2026 10:57:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx-832558f3.phiality.com (mx-832558f3.phiality.com [45.146.253.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A928372662
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 10:57:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002638; cv=none; b=NfdEMObuomXIVzNbGEFtGSt48Z4d1qL/p+OPUViHVzByTVP4ormnS51321dD2byrWnU6wx6VpfK9u7QuiowlApYPLvHcobk/SeBkOKh8FjGLJEnEQ6c0gSnpq32Mbut5apM5U44CrrOeCQlkBPdzDdmypuoL+lAiwKU8g477No8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002638; c=relaxed/simple;
	bh=5GGOsStKNuUwhHyumdt4xOGiL7yAZGtpcI+rDluTEcg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=EUU1gXEbs2KYuQk2O9bzjpjqx0w0O3W06N0lmDIxokyDV3YqX5tLwk/n+yk2iIwQfRcwyUdAnsZlw+LqBT5aZOi4rK685xy2eQ2ulGO+5yL5JskAmx37UHovI17etbEF9T8+7atlpemFC8QPNCw8wRbHBMO9bf3UckuOSDglRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=phiality.com; spf=pass smtp.mailfrom=phiality.com; dkim=pass (2048-bit key) header.d=phiality.com header.i=@phiality.com header.b=q7poJfGQ; arc=none smtp.client-ip=45.146.253.46
Received: from webmail.phiality.com (snappymail.mailserver_default [172.18.0.5])
	by mx-832558f3.phiality.com (Postfix) with ESMTP id 0ECCE1601C1;
	Tue,  9 Jun 2026 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phiality.com;
	s=mail; t=1781002635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GGOsStKNuUwhHyumdt4xOGiL7yAZGtpcI+rDluTEcg=;
	b=q7poJfGQDNl8jODEAbkJVweYmE/g1prm7pNCAPUF1H1ZsI+HwWRyiUZ8HesE+QUruuc2BL
	gsp/CoApJYBBaXupDuC/ysJytrfqNnTJ9pwVCYdkNxw7fMbMqLreizHxES6kEOlB1VIWP+
	6k6y9Kd9N+IZAyBzMlC/fyDmQQ4NCRZqRPHJMFkUlYV0kw2OAg1kGizKZDIGYoYVSvrxG3
	q+68CwIBXRtxBYn94DrVh65OI/3coDl/9g4zLTHWw8bToIk9DvRABoXQT/mvrU3OnsBvuN
	maZotwkF54GBmQnTPAVKYeMocCy1tnxdWYy797ahAOMbtVhhnDZwZiwFPvQSuw==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jun 2026 10:57:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Phiality" <phial@phiality.com>
Message-ID: <72ccc65de49d2321abc25fcf7ba9b2071300f0bf@phiality.com>
TLS-Required: No
Subject: Re: [PATCH v2] wifi: mt76: mt76u: use a threaded NAPI for the RX
 path
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, linux-wireless@vger.kernel.org
In-Reply-To: <aifg0WOxWD6x7no4@lore-desk>
References: <20260609003224.132191-1-phial@phiality.com>
 <aifg0WOxWD6x7no4@lore-desk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phiality.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[phiality.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[phial@phiality.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37579-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phial@phiality.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[phiality.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,phiality.com:dkim,phiality.com:mid,phiality.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E69765F358

> I guess the patch is fine, just a couple of nits inline.

Patch updated in v3 to address the nits,
https://lore.kernel.org/linux-wireless/20260609105301.196302-1-phial@phia=
lity.com/

Cheers,
Filip

