Return-Path: <linux-wireless+bounces-31664-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mp9cNzrTiWk3CAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31664-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 13:29:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D010E9FD
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEB803014757
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EBB244665;
	Mon,  9 Feb 2026 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SDP1k1KV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AAA225408
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637836; cv=none; b=Gs0F7Fez8Q+Bbb+iJokvaef7Ejk2r5yIn5dFu0VoSGQ1zZv60YkaTFWXK55Fm0nNYiF1lbClNM1wVPQEAiGe0ApkJ2po40sWMT4duuXy8KJN0jbG4RCVOT0IIKHMFSH3wtcwhdVAay7M8dqvd3tTVnfjH80AopJKK4DejD7GHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637836; c=relaxed/simple;
	bh=L8TNF4kMUyDyvAMmaW1SwqaTDkrszCu9vjZOyn4KHR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sv+eck+fj/sfvb7N42pN2nCzo4zth8aGQkQRfUeVlM9hbnS3nIi75T4HyIPJMmBIkSzV716ERKRXvqCI630gP5EM6K0qM2L8OvwkcURVo0llDkXCmrYeD/7s3lOOTX/EM636NBtepMONhNtow4LjQ3PNWhY6eCNslTI8uCZ1ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SDP1k1KV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=L8TNF4kMUyDyvAMmaW1SwqaTDkrszCu9vjZOyn4KHR0=;
	t=1770637836; x=1771847436; b=SDP1k1KVz+sllpExx2wPulogrR4UjnD5+he99dXlZlMiQaQ
	+0unqV/jbKQbU2gNjGrE7eGTLWXkoSV8AzBgJpnjUH/STA7ZcwjhSf260NAgBe24sycYXBRbEI/ZJ
	UgWBzZ79mangDeyYvPX6Mn8O77MzXYzParr7q+/L36n+Kl9xCviMIJQcsYH3gQSx5ILSaDbU9VaQs
	77YJ59bEUcV6MqIppS2ciO86CMVt4+Iq2+wk5Hl/FzXOMJml6Mzucb6EATu45GokGWr3Qj5WiOTnI
	IFZQyjxamuRU7Kqr7XY/djuxGigZy4uZuMn0OwyyPY0weBaBYMGmTzznri02rPuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vpPmh-00000002rbj-0uMO;
	Mon, 09 Feb 2026 12:50:32 +0100
Message-ID: <dbb7fdea65d2c47504b7684376150e85669b47cb.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Fix AAD/Nonce
 computation for management frames with MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Mon, 09 Feb 2026 12:50:30 +0100
In-Reply-To: <ff9330f7e17da9c7c1ba87b9400051a9bec29aa4.camel@sipsolutions.net>
References: <20260208081854.1080048-1-sai.magam@oss.qualcomm.com>
	 <ff9330f7e17da9c7c1ba87b9400051a9bec29aa4.camel@sipsolutions.net>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31664-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.90.174.1:received,2600:3c04:e001:36c::12fc:5321:from,168.119.38.16:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	DWL_DNSWL_BLOCKED(0.00)[sipsolutions.net:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 686D010E9FD
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 12:27 +0100, Johannes Berg wrote:
>=20
> If I restrict hwsim [1] to only pairwise and CCMP/GCMP (clearly it
> doesn't handle TKIP due to Michael MIC, WEP is irrelevant, BIGTK isn't
> handled in hwsim), then it mostly works without all of that extra logic
> for me for the tests. Maybe need to think about IGTK here though, some
> tests are still failing.
>=20
> [1] https://p.sipsolutions.net/d101bc31582cadcf.txt

Oh I guess that should be 'return 1' and hwsim would have to call the
encrypt for data frames before address translation ... But the more we
can push into hwsim, the better IMHO.

johannes

