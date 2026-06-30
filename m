Return-Path: <linux-wireless+bounces-38331-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qe8iFXdvQ2qQYQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38331-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:25:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453026E11D2
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 09:25:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=Yau9jqaR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38331-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38331-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EE0F3006D68
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4463939903B;
	Tue, 30 Jun 2026 07:25:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43241225;
	Tue, 30 Jun 2026 07:25:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804336; cv=none; b=rmadKHvz7IzpwOHxPac0hvY5Sx5JuwJldH2x82UZr6xlvqZiYDlwHT1A8Uw/zLhviBRFOESxS5bFWFhf7JLLQns2/y4dAFPudx1Fh2RVfcngMJruFhj43kdZ23qdu8+2tn/nX3UQYmrj7zrZbV1K/J+d9jr+yHVvyPp8wfd2kFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804336; c=relaxed/simple;
	bh=WvhxqOiusRfFAMqN0hegOJIEbSbrtZDw9h2KJZtuHV8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWPMTQyVGDjxW3Xl1pqjN5o8w+P+Rh5DcGqQafRbSFPTu8iE9A43Sss0YP5jvTGcem+c4oHIGtJzeqzw7FzgBN0+gUBlt98GSRqmtxhTebikDG0o6iapncjtrQHRwIQi4G83TB5wxUP8HnQA70dVVmtSBfKlTQys23jipLt2IK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Yau9jqaR; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WvhxqOiusRfFAMqN0hegOJIEbSbrtZDw9h2KJZtuHV8=;
	t=1782804334; x=1784013934; b=Yau9jqaR9nqamEnCozVwSPqSSQL5QpnPn+HDM89a3jnuElu
	VgDKB1M1Zx5tMykXF2MjlLdzCZ7T5uA/l3L1MfEod0BoOKwedzjRojyo+Xwi0lHyJOmACOsl2kV2s
	l8EvGVcpZJUnSyNp52x9VVhbNvR+vyMUBKhrZJyVgoOL7hAd0xqiOm1a5Le8qFNlAI6sHQ1u6o2kU
	5nWab6fHsMxDmAwEDB3x+NGVtWnrPGtT3a5Hyf4aDL+uRgcYe/LbjDuUTEOC0+s+iuJ+wKQ8jZNQK
	Eva4EH0Mb+Nr2pTf2JOVHJHsZEDe9bG6EpGzAqaZGlqBr5nfFMuYACkXNPtNRG5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1weSqZ-00000003OF2-1mo4;
	Tue, 30 Jun 2026 09:25:31 +0200
Message-ID: <a9578988af110a0966cd2bd236e6044ac5e7a70e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: iwlwifi: enable MFP_CAPABLE in FIPS mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: emmanuel.grumbach@intel.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Date: Tue, 30 Jun 2026 09:25:29 +0200
In-Reply-To: <20260630072046.201393-1-jtornosm@redhat.com>
References: 
	<588f665e6c1e8a24d6cee56762ae754f39ab9703.camel@sipsolutions.net>
	 <20260630072046.201393-1-jtornosm@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:emmanuel.grumbach@intel.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38331-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 453026E11D2

On Tue, 2026-06-30 at 09:20 +0200, Jose Ignacio Tornos Martinez wrote:
> Hi Johannes,
>=20
> > There's probably something to be said for the second patch anyway.
> Good to know, should I resend patch 2/2 separately, or would you like me
> to wait until I have the customer use case information?

I think we can just take it as-is.

johannes

