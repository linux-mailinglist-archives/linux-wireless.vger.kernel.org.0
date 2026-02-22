Return-Path: <linux-wireless+bounces-32078-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6epRJ+0tm2nwugMAu9opvQ
	(envelope-from <linux-wireless+bounces-32078-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Feb 2026 17:25:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48316F9FC
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Feb 2026 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E926F300C93D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Feb 2026 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648622CBC6;
	Sun, 22 Feb 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="BJRF06IR";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="FgvpKB7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73C1FB1
	for <linux-wireless@vger.kernel.org>; Sun, 22 Feb 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777513; cv=none; b=Qp453onNs5enjzWLKcAUcuzcl/AFduty43ZZhmcYr33ldpQt7RJq9PjsnEICTNn8qhN9I3Hm6utJ7mA2v3d/47CAATxkLM2VcaBg9ODm9JSLeoHUbJ8ukKIEU/8xK+7FO1/+tC7Y1R3rZyo1C8eYrvPGGods7AePoxl6kEv6n4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777513; c=relaxed/simple;
	bh=SJsPiAbfWLW4wq9Idsd+YveXh/Utt3vKMFZBXvWIc8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLV6mhFNUofIy55g70WavZ8NvsCoTyDDlQFuytaV+n2PvqC4+x0vVqlVTxOeiVTWBKGQgR+7et0G2Qfv8L/bVzTdc9t4iZEB4Iy8FouVVrze5VuAMWJXbHO81vveTJBVqnHz09L4iTGa7+MJs7oX75/w6kIlgFI6RqT4iXa7PBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=BJRF06IR reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=FgvpKB7C; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1771778411; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=CG6CmaFogXrtFMNNsyT6tnwVb2ecRN3dNdKGuj+xzK8=; b=BJRF06IRm0gwtXWsbN1Gi2PBe+
	xlGDq0rarZc1omCqBsIN4TUEWp4iURBkfiMw3IIC0sx6CeWV4UmPWnPTbyUcoKJjw135H6XteBM63
	Bq/Rs7zgjdnRg0dLAXu0ytb48OVfODg29fRgXYd3mw4BZfybfvtLChGnsxo7cVhFQWpSo2b2FBfHI
	c950aoqiECGTJhJtjGpbMETblCCKt40fL1v4P0/p2ubOjFzDXq1OGYBw93aktKH50OR/q3sz+aU8p
	0uS7JfgRBcWRmktwPWLV47XuNd3c1xaHlDQh8FlhnVkScCTOTN/7VKPVpkdljPv8fcKZyRlBX/PLO
	pR4egyVQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1771777511; h=from : subject
 : to : message-id : date;
 bh=CG6CmaFogXrtFMNNsyT6tnwVb2ecRN3dNdKGuj+xzK8=;
 b=FgvpKB7CpFs+nsDERngaXuJDmAcMDGKAe84GumrgELE1eMT6oAF5FbXxLEri8t3Ln10cL
 QRT7nikbgyJnWEyoLLz6dqtyao0ecx9i5Fq2H4L53k47xvblsPkjmQFqhfPsxm1XkB0n3WO
 +auMzLT653gRR1pLid1fnegmBANKtDHMEhv1h6wAhxgbk1KL0U/I+D3jGiFYttxz56u80YO
 7nsqs7o4pmHZt5SgolrvTMja0aoklfcKcrD+gyPHMj68yi83EhAByjHMhduF1ktSNRBvsMB
 t47U8xcKGcSPLBzTztJd0sg9SdC8I+38Einigrac85K8QXCzTrEi3kfcHk2w==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vuCGX-TRk1ql-Cs; Sun, 22 Feb 2026 16:25:05 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1vuCGX-AIkwcC8ps6y-HJg9; Sun, 22 Feb 2026 16:25:05 +0000
Date: Sun, 22 Feb 2026 17:06:21 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
Message-ID: <aZsmk0lUpL0UBd6Q@pilgrim>
References: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
 <aZRnlPA_uY9uWuKr@pilgrim>
 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
 <aZR9eQlhy55iD6IN@pilgrim>
 <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
X-Smtpcorp-Track: UniXV439jpKe.lLom5BYraKaV.3gDdOgnLTet
Feedback-ID: 510616m:510616apGKSTK:510616sbru8S-D2W
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.74 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	URIBL_RED(0.50)[triplefau.lt:dkim];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_MIXED(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[triplefau.lt,quarantine];
	TAGGED_FROM(0.00)[bounces-32078-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[smtpservice.net:s=maxzs0.a1-4.dyn];
	DKIM_TRACE(0.00)[smtpservice.net:~,triplefau.lt:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF48316F9FC
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 05:00:56PM +0100, Johannes Berg wrote:
> On Tue, 2026-02-17 at 15:38 +0100, Remi Pommarel wrote:
> > On Tue, Feb 17, 2026 at 02:59:34PM +0100, Johannes Berg wrote:
> > > On Tue, 2026-02-17 at 14:05 +0100, Remi Pommarel wrote:
> > > > On Tue, Feb 17, 2026 at 12:30:08PM +0100, Johannes Berg wrote:
> > > > > On Tue, 2026-02-17 at 11:36 +0100, Remi Pommarel wrote:
> > > > > > Commit f89e07d4cf26 ("mac80211: agg-rx: refuse ADDBA Request with timeout
> > > > > > update") added a check to fail when ADDBA update would change the
> > > > > > timeout param.
> > > > > > 
> > > > > > This param is kept in tid_ampdu_rx context which is only allocated on HW
> > > > > > that do not set SUPPORTS_REORDERING_BUFFER. Because the timeout check
> > > > > > was done regardless of this param, ADDBA update always failed on those
> > > > > > HW.
> > > > > 
> > > > > Seems like a legit problem, but
> > > > > 
> > > > > > Fix this by only checking tid_ampdu_rx->timeout only when
> > > > > > SUPPORTS_REORDERING_BUFFER is not set.
> > > > > 
> > > > > that doesn't seem right? Especially the way you implemented it, it won't
> > > > > even respond at all when it's an update and SUPPORTS_REORDERING_BUFFER
> > > > > is set.
> > > > 
> > > > I could be wrong but I think the patch format here make it difficult to
> > > > read. If it's an update and SUPPORTS_REORDERING_BUFFER is set, the
> > > > following "if" in the code (not fully visible in the diff here) will end
> > > > calling drv_ampdu_action().
> > > 
> > > Yes, but it will be IEEE80211_AMPDU_RX_START which isn't really intended
> > > by the state machine/API between mac80211/driver. So that doesn't seem
> > > right.
> > > 
> > 
> > That does make sense. However, if I understand correctly, it means that
> > even if we end up storing the timeout for drivers that support
> > reordering, a new IEEE80211_AMPDU_RX_UPDATE should still be introduced,
> > right?
> 
> I guess in order to do a no-op update that doesn't change the timeout,
> we could? But not sure it's all worth it?

I was going to say it would not be a no-op for a buf_size update but,
if I understand correctly, even when SUPPORTS_REORDERING_BUFFER is not
set the buf_size update is ignored completely and the reorder_buf is
not resized yet a successful addba response is sent. Don't we need to
check for buf_size change as well as timeout also?

> Pablo seems to have looked up that it _is_ supported - which I didn't
> expect because it's not part of the API contract, so the drivers
> implemented something that can't actually ever get hit? Seems odd. And
> I'm pretty sure e.g. iwlwifi wouldn't support it.
> 
> But I basically also think it's not worth it in practice; why try to
> support something that's never going to happen?

Just to confirm, you mean that updating the timeout is not worth it, but
fixing this issue is still needed right?

-- 
Remi


