Return-Path: <linux-wireless+bounces-36735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHUoNcJHDmoM9gUAu9opvQ
	(envelope-from <linux-wireless+bounces-36735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 01:46:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E02159CE3F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 01:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2680130A5A1C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 23:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31C3C343D;
	Wed, 20 May 2026 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="kf8IpvR4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAA3C4557
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779319009; cv=none; b=CERbbvwVxHcp39bZvbkI6n/GTE52bfnFhgYgTGYewZW0IMaMQF/hEkhdSGdi4zV+ua+ECiyl2jMiYhGLsLhC5inH2JOnUFohzu34u30y0l/M47e1yyjnja/RpccijbjIa2igkbQRodueM3Gmeas3BLkDzBy8Rp2S/J/eLV0wfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779319009; c=relaxed/simple;
	bh=0vJrEaa3imiV3Dddin5O2cIGKFId1ZKr0iu11mwoN2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqm2FVf7vJZ7t/MkqRsHglcNJrA4I55w51uWQIyjRSG6FOBLoUwEMD1/rQJrS1vV+CoF389JJ3sfTvU1YXNDKTjhCxotTs+bLatwpI7wEmFNwwOV+GmQj5TkWTe6ofZR7eqCTFZ0ynGPJ7yPTlao0MHjUhYwOx5aA23cRBtzV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=kf8IpvR4; arc=none smtp.client-ip=62.149.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from fedora ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Pq9VwYaHKEZ9tPq9Vw3nDO; Thu, 21 May 2026 01:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779318997; bh=0vJrEaa3imiV3Dddin5O2cIGKFId1ZKr0iu11mwoN2o=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=kf8IpvR4GAyMqKd+P4bPgyCYH4llRqDkTBWuvXRGA2Ag/vE5cLNqZXrhtS2+P20hN
	 wBEfgChkmJh87QDawESJae9ek+jnqjREVyNU1Fv0sAEUaJ+RpQ0CZJzUYXasIrCGSg
	 tsLJo2B+wmzw62IQvIGvWh3pzXgNA+rty0qTV+Y89EyS2aACTzGNN8+rjhspjIZouN
	 iZiZFCYG6o+7curEyx34ACWIRXdQYDAIYrWIQtUMcQoHjQd4JIL2UuViR01NuOnnDe
	 w+wjkXzlQiuNw167qsJLNvxW+0vS8QGvvu20LqFYkpWjcNYMfNAjEAqdixUI4uks0c
	 73VlCky2aKEZA==
Date: Thu, 21 May 2026 01:16:37 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Michael =?UTF-8?B?QsO8c2No?=  <m@bues.ch>,
 linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 kvalo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] b43: complete N-PHY rev 8 + radio 2057 rev 8
 support
Message-ID: <20260521011637.4e01ae65@fedora>
In-Reply-To: <a052e02c8039b06348119a1ec0b18bf1986a999e.camel@sipsolutions.net>
References: <8c0a07d2-9ec9-43d6-bdf7-f625bbb4a38a@mythread.it>
	<20260519175812.7ce97ba1@barney>
	<20260519230241.49489a8f@DELL-MOBILE03.ad.smart.it>
	<a052e02c8039b06348119a1ec0b18bf1986a999e.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNH/v5k6rjQQnXwKrhZw+4q8JxYNYy/lJUxo7N1WyRBL08tuDXlmygWVYGXWSl+/8uGR05pF08921KOqmku/UPqIIte0ZAP4OMebxNc7SZS7j7Zmm1ud
 vzFV17PpliBA6AZQH2dngeNogqayn3cWrnd3Rwla+k5Sl52rGA3RBkh0UIWls6bIThh3DDSSjAKDumevd3+SFv8KBFKhMHCjBPF/KJ6ED2eClcvDTCoJXDjZ
 oBz7PbyK31Nke3UtgJv9bkusGHCfB1u4Lb222l5QKG7kUeNCEL8hnHv5GmDl7mln8q5xyrtha9cniaFTOSSPvSkoqCY5UPElq8H7A2L41lAiSyqJaw52n37z
 mi36fMyQ
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36735-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[mythread.it:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:email,mythread.it:dkim]
X-Rspamd-Queue-Id: 3E02159CE3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il giorno Wed, 20 May 2026 13:06:05 +0200
Johannes Berg <johannes@sipsolutions.net> ha scritto:

> On Tue, 2026-05-19 at 23:02 +0200, Alessio Ferri wrote:
> > 
> > The patchset is tested on my own DLink DSL 3580L router and
> > generated by claude from our shared notes, i then reviewed it for
> > sanity and verified it by navigating from the router with modified
> > b43 driver with my phone.  
> 
> I would ask you to disclose this in the commits per
> 
> https://docs.kernel.org/process/coding-assistants.html
> 
> johannes

I'm also realizing that i was off by one when i generated the series
and missed the first commit, the actual series is 7 patches, the "real"
first one fill the gaps in the firmware mappings, so i would had
to resend anyway

