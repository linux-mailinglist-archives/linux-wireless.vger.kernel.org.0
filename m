Return-Path: <linux-wireless+bounces-35245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBwCFkxI6mkhxgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 18:26:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4D454DC9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E20473080AF8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D9377EBA;
	Thu, 23 Apr 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMteiUAA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbZY+vnr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C537D115;
	Thu, 23 Apr 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960890; cv=none; b=HFcEU0oHAp1ihd63uU/L6xkmiXzqnsbYwnThuPc7w/jMgPRICHLbKmsWwJysEzFYMFnYMi3QQLYauJtzc5lhfCih1UMqWCx9iahCcx9pHBsEHCwu1uOHJWEpPjYg25zLm2huZwSBmgSQ5BMgngPlDbEEBjNPdvHXdGsy9oTBfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960890; c=relaxed/simple;
	bh=2CTQ4RAv+u3NA76KBzNTfx7cj8+ZcpCfmAabBKswfn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z18Z2uzHQzcT82CfkMsutD5wNN4tki+1tup0pNWaj5JjpwyKohgV6WrnVSHzfSi2a3Sk/oJSRlvHI5AsNCSKoDJFW84fnxuiwburofFO92fjFgUmBmIgT8Dqji3OnUmJBISByyyNJZ4cV1pOFcTNVDlCYjAyB3/bjjQb1SgQUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMteiUAA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbZY+vnr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Apr 2026 18:14:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776960887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CTQ4RAv+u3NA76KBzNTfx7cj8+ZcpCfmAabBKswfn8=;
	b=DMteiUAAVXDXQ/cR2GcUwc3gsNlo5X3lAy4BWFbtBZ0DcE3Ek3lqs1mq3eqlDOo2HBqTKz
	QZKo7FCRmfLgCTX5wP/wrmbtcInMBAQhWB/1EusEEnnGifQTiAXGlv/YxLviXaHfMY0Vc+
	4KAd3pmbBiqmQ1VoMfiEjhsvraNWy46bSCpkcyJvFG7yoxHv+zLs1BI8Fa+h13BwN1yMgB
	vrlzI9kx7XSdxL/i+aFLNK/xGVpAELrjqeiM9xNMKZNkGtZcOTXxk2+JA02PsfuK6Xd6lf
	6dqz6wnY9o5ihpvj1wVXsl5Mmsqqie7AdGYXxwlRNSgIHAkGHW8EeqtJPSlxPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776960887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CTQ4RAv+u3NA76KBzNTfx7cj8+ZcpCfmAabBKswfn8=;
	b=tbZY+vnrzHQBW5hJE3HA/YoIDWKjQZ5ZIS5hkZL7iVKAR09XRbWOcVJrj2jCD+9Yo9ksZy
	ngalhiVcVdokGgDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Yu-Hsiang Tseng <asas1asas200@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Kalle Valo <kvalo@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock()
 for RCU assertions
Message-ID: <20260423161445.10FeXYSb@linutronix.de>
References: <20260422180814.1938317-1-asas1asas200@gmail.com>
 <20260423063020.NAero6Rz@linutronix.de>
 <caad3b9c-2c14-4e09-b8f8-840d2ec111be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <caad3b9c-2c14-4e09-b8f8-840d2ec111be@oss.qualcomm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35245-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.infradead.org,oss.qualcomm.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: B0E4D454DC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-23 08:24:46 [-0700], Jeff Johnson wrote:
> On 4/22/2026 11:30 PM, Sebastian Andrzej Siewior wrote:
> > On 2026-04-23 02:08:14 [+0800], Yu-Hsiang Tseng wrote:
> >> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.=
0_SILICONZ-1.115823.3
> >=20
> > This could written in plain english as in "Tested on =E2=80=A6". Not su=
re what
> > this "convention" is but anyway.
>=20
> FYI this is a long-standing convention for the ath family of wifi drivers,
> dating back to at least ath10k:

I see. Never mind then. The previous comment read like "don't use
non-standard tags" and the change was to use a blank line.
Anyway, not my department.

Sebastian

