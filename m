Return-Path: <linux-wireless+bounces-38687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LmCuOUOnS2rZXwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:01:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3126A710F57
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:01:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=UdmNatmq;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38687-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38687-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1D45306E2E7
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E985436BF1;
	Mon,  6 Jul 2026 12:50:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2054314B7
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 12:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342223; cv=none; b=utEcQMHUylKfdZY6Mm+BPKjV1nPXBkeWrO2A2+li1bPTlN0iXWsTyDlBKoP2Qd+ISzx8iHaJX/O91o6Ejo41xTc+SB518vcBZ6A9uS5hiOVcVVefh5Ms/vl85xkpdX8dBfORUgbKR9AIsNh/xSwCvZLtC78NqR/60j/5MczeSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342223; c=relaxed/simple;
	bh=gVrRbAWnYanFrFc3qVnXGG+4FUsJdIGNvoADmlbOBCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YExUrUMCjQIPWxmHnqWDpQeBGI9t/HzGGq8wG43Xde48ejFvTxBpSG/LSOQK8xV2VeW/Q1XZu0NIovFmtIb7l6aDHIDkXg+/dICS20zlm9x6FvAsImWujv2fut/XQr3mNYfDBFGOlrrCo53K3ex70vRFRBO0l+gRNohZQWlVJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=UdmNatmq; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c88cc025f54so1932915a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1783342221; x=1783947021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+1bRU0RDhzdTJVcRJ7KZI/KaSUe/xvJJWVsgXYCS8Q=;
        b=UdmNatmqlybs+3xo3e3HfuGSN1Kx++srdIkPbZg8ZlVIMS9rcyHbSi4qRRteDVuWtB
         HW51HX0mN2NuSS8TVykWf3BUkKkcsupuSlKqTkCu2B92iR+NaftSwjVgQrmw+Do3ssF3
         nST9yleHIfFIChJKXh5N3T+ZDCpLN8q9DaHaic6oadRIvsiNnl1dk27eE6O2gBh0pjrl
         6YSQkGuNJws4GEfkGeZUtZRtHn3hpZF5MjbEuLSIJUCuJD/NXO3Gx2/RHyv3oU1l5pAP
         YiNL6nIWCMdi4q1rkPqXDxH2kixKGVZi2g7FTHY3ki8NMf+s9Ynbx3AJ7usT/ROVAEMz
         BNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342221; x=1783947021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+1bRU0RDhzdTJVcRJ7KZI/KaSUe/xvJJWVsgXYCS8Q=;
        b=ZINNxfv0EF4+gYnPAoeV5SB/LRCGqm+nFpfz7Shf15RdV0qbjfsE2H1n7lewjUiDqY
         JwwpGYgmzmOfByhqYyqkPND7NzDnD06WV4G7wirPSneUgHLId7/6VWENzCeIJR6J+pqk
         yUc2O3IyhC+W9dJPjprP+h/h0aWODt48ywAm6M3bBPqHfEOAXndwG0loOzltpC3ID5hB
         AmzFNc6PzL61ht5PwM1xrPtGwBtMLV4YwsOs2rEG1CasEsxzgj0e/WXKTjfGuHagNcgP
         Zgjd6CjwylvPaFOt9UPzVdbWA3ebVpFIPyDCA3wV5T4y1WEYLSPnwf+IkDHGO2OaUSry
         MhmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1/ssDZGkTjFF2/vX/RjCZQrNY3+uMhp7EjMttuvDhUSLRDVxUXtIJFOBGdmw/yhCRlZn3seV4uL91iRnt0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzErIDzSuSr3tyWItO0jQb6cdi+0vxGczHXQLRpZ5wRs1NAazCF
	UrI0Grzcv7Yj9Mmexsf7w/s28cTazLdfuAFacMeKOzqsKYO6FgzguOF2BUeUbOpeGU4=
X-Gm-Gg: AfdE7cmjfxB1Z/X/DNEh4x3A5Va9+LFw6Z7LZgzCNgpwjBzow8Xc2p2q9Vmz/m7BNAs
	ortm2IBeAj//hinmIDrd7OiBfKHtkzzNBE5TdqDyW9lP0UPQ683vZg4c+mvYZXEWjyflrBxAt0u
	8xkqmkbbeKZKUmtrN4eELfGz2L4CAp3IbI9Lm07ncP3W9wcZ1L+/6SdaVTZx308vNsQVSjTzvdM
	cyWH/cQvEtucApR5dLZklTiGRAu/XdnrWTcmTS3nLKLdSCyaYpAlgeAuziod3/5mTg3LUHVrBqv
	PraycX2R+0IPogZY9fTIKyrnGlkXHX1k3O7WZjloWNJFeKm1JKPbnCwNphDylCYCAD/KTyhudSP
	OBPLTLDnMmdsn/ZhwKx//Ey6bN9xOKxlPpfGUD5dKB1xYHJVcKwL20EToDTZgJE/peQ9g+tpWVd
	uHnrHIpKnNULplBbfRKPtiCOWDqlwUOzUSMxSXLrF2orkb9th4SzjMPA==
X-Received: by 2002:a05:6a21:4cc3:b0:3bf:a7d5:df38 with SMTP id adf61e73a8af0-3c08ed704d4mr533061637.9.1783342221252;
        Mon, 06 Jul 2026 05:50:21 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa566sm47760137c88.4.2026.07.06.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:50:20 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:50:15 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: arien.judge@morsemicro.com, dan.callaghan@morsemicro.com, 
	ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	Andrew Pope <andrew.pope@morsemicro.com>, Bassem Dawood <bassem@morsemicro.com>, 
	Chetan Mistry <chetan.mistry@morsemicro.com>, James Herbert <james.herbert@morsemicro.com>, 
	Sahand Maleki <sahand.maleki@morsemicro.com>, Simon Wadsworth <simon@morsemicro.com>
Subject: Re: [PATCH wireless-next v3 00/33] wifi: mm81x: add mm81x driver
Message-ID: <5nwjtflsihwo745k6cqi7lqsb5dblcb3fymw25y5hwcosxtfjj@y2szij6jmes2>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
 <c48d02d04101e50ece0feab60fb04f63aef37140.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48d02d04101e50ece0feab60fb04f63aef37140.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-38687-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:arien.judge@morsemicro.com,m:dan.callaghan@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:andrew.pope@morsemicro.com,m:bassem@morsemicro.com,m:chetan.mistry@morsemicro.com,m:james.herbert@morsemicro.com,m:sahand.maleki@morsemicro.com,m:simon@morsemicro.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,y2szij6jmes2:mid,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3126A710F57

On Mon, Jul 06, 2026 at 01:45:49PM +0200, Johannes Berg wrote:
> On Fri, 2026-06-26 at 16:28 +1000, Lachlan Hodges wrote:
> > This series adds the first Wi-Fi HaLow driver to support the Morse
> > Micro mm81x chip family via USB and SDIO.
> 
> I've applied the cfg80211 patches in this set, please send a pull
> request for the actual driver.

We were actually going to send a v4 this week sometime just to modify
the firmware path for linux-firmware... I can either just send that
as a PR or would it be best to send a v4 as patches again? Obviously
PR is easier but I didn't want to include further changes without
at least letting you know.

lachlan

