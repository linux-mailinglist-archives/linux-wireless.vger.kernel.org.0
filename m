Return-Path: <linux-wireless+bounces-37545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EL2iK7tfJ2q0vQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:35:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56D65B606
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phiality.com header.s=mail header.b=mk3buiaJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37545-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37545-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=phiality.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B3D53045AAA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 00:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953942222D0;
	Tue,  9 Jun 2026 00:35:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx-832558f3.phiality.com (mx-832558f3.phiality.com [45.146.253.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617F548EE
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 00:35:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965305; cv=none; b=dRdKQRUH37g9MZOsB9zJnoAW07hsruo3Wsks8IPzJRCabjMUPf56OcKXgcd4O71QpbxAipbDLFlxRnWABmAC1TTxYSD00QXMAxKwgB6KuPBsFYFIgY2WKqQ+7dOscAbtZlBpiKgEk9zqvLTqR/sS4C5b92AbNc47S0QPIYgBcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965305; c=relaxed/simple;
	bh=vt6kPWsfNbucRJ/idqE2zoIvNWu7NbZIDveYTBK4mlw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ZJXhQdxTAnHfvr9pifMVdCN9nWxyys+F4QYGKShOjms4AJxJ7ylWzer+BQtU+mkxjl0Qmm0n1UoyZtXJkgsGR09S+9aGDyJcAZn1rL3pPhgPjVKD9dWt2r7jXEmm5TyikNsdE26YSk7exdNRVUGZpHHEVFsFCYm3Sp9raiu3hC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=phiality.com; spf=pass smtp.mailfrom=phiality.com; dkim=pass (2048-bit key) header.d=phiality.com header.i=@phiality.com header.b=mk3buiaJ; arc=none smtp.client-ip=45.146.253.46
Received: from webmail.phiality.com (snappymail.mailserver_default [172.18.0.5])
	by mx-832558f3.phiality.com (Postfix) with ESMTP id F191816015F;
	Tue,  9 Jun 2026 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phiality.com;
	s=mail; t=1780965303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vt6kPWsfNbucRJ/idqE2zoIvNWu7NbZIDveYTBK4mlw=;
	b=mk3buiaJGwqajBqgb50psD2ryXf+m2JZZOTwPoqtnIF26ricjXx+/wpqU62j+SkNZwf2bm
	UvfYMw0MuplVSnJC0vAnrBmdRovRx7wZmumGHkbMn3+Kmr5ke597kzy9OolD4Z0QM4GUFE
	BACyY/W6gsP2dTnQMinb+p/euGifCZRY0kWTOCgqpkn3WonHDAvmvUG1xR3nqNc5kjwerG
	ts7xrH4kMaX1YZaT6rEQ/x8oEWOZE/B124BbnKPgrAc3Gt7BkTueJ6MmrbAKSsoRFhMTv5
	9AZ6cDMEFH5A0ABL6dXoQkeGM034QlD9B4YlmLBTRmJT9WQlbX7rN0MKveH6xg==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Jun 2026 00:35:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Filip Bakreski" <phial@phiality.com>
Message-ID: <ba8109de16240cfcc150b90ff6b5a20fbb629671@phiality.com>
TLS-Required: No
Subject: Re: [PATCH] wifi: mt76: mt76u: use GRO on the USB RX path
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: nbd@nbd.name, ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, linux-wireless@vger.kernel.org
In-Reply-To: <aib-n_sCzWOjXFE1@lore-desk>
References: <20260608044109.31730-1-phial@phiality.com>
 <aib-n_sCzWOjXFE1@lore-desk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phiality.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-37545-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D56D65B606

> I guess we do not need to add them, we can just reuse napi_dev pointer =
and
> napi[] array available in mt76_dev struct. Agree?

Agreed, I'll drop the new mt76_usb fields and reuse dev->napi_dev and dev=
->napi[MT_RXQ_MAIN] in v2

> I guess it would be interesting verifying if threaded-napi provides bet=
ter
> results.

It does, on mt7921u a threaded NAPI servicing the RX queue averaged ~588 =
Mbit/s vs ~424 Mbit/s for the manually-driven NAPI. Suspend/resume also t=
ested clean.

v2: https://lore.kernel.org/linux-wireless/20260609003224.132191-1-phial@=
phiality.com/

Thanks for the review,
Filip

