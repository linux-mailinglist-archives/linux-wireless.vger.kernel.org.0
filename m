Return-Path: <linux-wireless+bounces-31224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN/BEJ6yeGkksQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:42:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C044946D7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 13:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A037E300371B
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F234CFCA;
	Tue, 27 Jan 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vU94pbU7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40D34CFC7
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517720; cv=none; b=Ke+wTtkMpBgCcFxrpsKa0urkvN56HM1RR0OcvPZaZlRTRRElHBK2mqu3ndjlewjxz6tfw4PVpCE1WjHafi9xEuvL9eGZjAEaaSA0rn9vLrkR2eA8IiGPfbGVA2F9+mTAVQut8zcwLelvSv1fT0Zh7vqr69LmgDYsGpTTSRrfjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517720; c=relaxed/simple;
	bh=MfbzAJU8CG1RcGAh/0ELndGBS75i4StAK8TMv++NjDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gh04snO4vCBvJHiVWqLFbpbfghBuBrNqt+6UP1gLMcgEmpUzJvwga90KAtzQHmtbCj3KfwIejFibsLs00jk1HlugzzxfO4yBOHRMC01sUngHfG+p/Pt1cQi70dr6cb3e+PQzpxqdMm+Ud8csfmNE9FmfaqGV3jrz3vrlVdba3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vU94pbU7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MfbzAJU8CG1RcGAh/0ELndGBS75i4StAK8TMv++NjDw=;
	t=1769517719; x=1770727319; b=vU94pbU7xrwN8DVWcPHMwsOdFRkRHZm4IizqRqXMWjr3BjC
	KZH+bta3+svXBwsTQwB/lGJfnPEdqGpt3Ad9v4tbyDo7/GHFqENWcBWxGZqkzWEoKqbHLQhXL40GR
	MnVXleHDBiqjwwR0SYOWYMyDvVaMJ2aB7U3GtMHOR/NNqAE/0q020UI2Ue8cdWEWmu2Irg1PSpaPd
	wzy3mecACJe0lVS0KbFoFJp4YGcYOAkXhPL+2VgfP6qHk8QpGwojPb79XCd9yJL97BYlEpd0IVkvE
	p1wh7aYVj4Y/MBmbMLc/pOf+rhFNaQrMaGoRLVzny1/SwwxyZlEQDhom5hNyaH9g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vkiOJ-00000004zS1-2ecH;
	Tue, 27 Jan 2026 13:41:56 +0100
Message-ID: <b2effd37d943394d415ba314222f399ad1579a9d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 1/4] wifi: nl80211/cfg80211: add new FTM
 capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Date: Tue, 27 Jan 2026 13:41:54 +0100
In-Reply-To: <20260111190221.bf43785c18f6.Ic98cf9790ddee84bf88e5720b93c46c23af3c96c@changeid> (sfid-20260111_180413_591356_7AA889E1)
References: <20260111170351.2093318-1-miriam.rachel.korenblit@intel.com>
	 <20260111190221.bf43785c18f6.Ic98cf9790ddee84bf88e5720b93c46c23af3c96c@changeid>
	 (sfid-20260111_180413_591356_7AA889E1)
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31224-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 4C044946D7
X-Rspamd-Action: no action

On Sun, 2026-01-11 at 19:03 +0200, Miri Korenblit wrote:
> From: Avraham Stern <avraham.stern@intel.com>
>=20
> Add new capabilities to the PMSR FTM capabilities list. The new
> capabilities include 6 GHz support, supported number of spatial streams
> and supported number of LTF repetitions.
>=20
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>

"tested:" is not a customary tag, I've edited that out.

johannes

