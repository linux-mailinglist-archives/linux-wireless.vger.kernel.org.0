Return-Path: <linux-wireless+bounces-31754-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMjTES8/jWmq0QAAu9opvQ
	(envelope-from <linux-wireless+bounces-31754-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 03:47:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF51294DF
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 03:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59BE73031CDD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 02:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9099191484;
	Thu, 12 Feb 2026 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="OP9LYsxu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail6.out.flockmail.com (mail6.out.flockmail.com [18.204.122.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4C8460
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.204.122.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770864428; cv=none; b=RyB+HhZcGf95Dp5e8+AMMihIWx2RCcpbA4YHx0f8+JrA5YxilBu9PEV/oRB5BWFLzyrP1cyTI7Ku7cDFV3ULYiv71AjO3EpU4E2uZptG+JLtDdcq/uIvtj9hRCph4DPhrfse/SbNV0aqyOIaJDzpBJSuQk+JPi662y96JEYHo6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770864428; c=relaxed/simple;
	bh=jCGQjHM0JEqrywJGkyXQi3ZZayGYkXsTN7oJuE2nDMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBd/VLG56rAZBzjYvE4Y55XsvY4VD6d734aSsVke/CMJT4D+mhNfE8yhE4ah+OF2g2SvE4k5meNnENa96bfUCMcWYsWVPLQxYFLHmOQVgajkiJP96QsOkM+IBuDWzSoMB97Tj9iGx4qDlg6jutBuGRKGiDnBNou3MdPSbDiItdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (1024-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=OP9LYsxu; arc=none smtp.client-ip=18.204.122.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4fBKT14BCjz2xBr;
	Thu, 12 Feb 2026 02:47:01 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=2AQST+rnTfIKKuta9N13NYh0E/11OWaYTe1btg40/lI=;
	c=relaxed/relaxed; d=justthetip.ca;
	h=from:to:cc:date:mime-version:subject:message-id:in-reply-to:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1770864421; v=1;
	b=OP9LYsxurAACH76KLLDbD/kGwM9yHveFkG8Fhqkbp6RBi4yD/Fikpkx38qs7qfEkBE7NomUz
	xmR9q2o/GlKpWIJoYUgdcVRrtG2r4oYof53GBGn0SbbyRLKmuoqMYthX2lXAfOdiZJ7Oh4A94u6
	B47otAMGXo0N+AjzP3EYDW3k=
Received: from SkinnyD (unknown [84.39.151.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4fBKT04hdsz2xBN;
	Thu, 12 Feb 2026 02:47:00 +0000 (UTC)
Feedback-ID: :lucid_duck@justthetip.ca:justthetip.ca:flockmailId
From: Lucid Duck <lucid_duck@justthetip.ca>
To: morrownr@gmail.com
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	linux-wireless@vger.kernel.org,
	Lucid Duck <lucid_duck@justthetip.ca>
Subject: Re: [PATCH v2] wifi: mt76: mt7921: fix txpower reporting
Date: Wed, 11 Feb 2026 18:46:55 -0800
Message-ID: <20260212024655.3855-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.50.0.windows.2
In-Reply-To: <CAFktD2dZwX9-Cq8Pv7NEHE5agDLqVau+4fHjre7Zh+2M_1u3Uw@mail.gmail.com>
References: <CAFktD2dZwX9-Cq8Pv7NEHE5agDLqVau+4fHjre7Zh+2M_1u3Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1770864421395978363.28339.5548500334887344190@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=aI4Kqa9m c=1 sm=1 tr=0 ts=698d3f25
	a=xDJMX+qT11/t3O8MDy5wZw==:117 a=xDJMX+qT11/t3O8MDy5wZw==:17
	a=CEWIc4RMnpUA:10 a=VpdFYmy5yc-VxlYkAwgA:9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=titan1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[justthetip.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31754-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,justthetip.ca:mid,justthetip.ca:dkim]
X-Rspamd-Queue-Id: 9EEF51294DF
X-Rspamd-Action: no action

On Mon, 9 Feb 2026, Nick wrote:=0D
> I just tested this patch with a fresh download of kernel 6.18.8. All I=0D
> see is 3 dBm when running "iw dev". My USB WiFi adapter also uses the=0D
> mt7921u driver.=0D
=0D
Hi Nick,=0D
=0D
Thanks for testing.=0D
=0D
First thing to check: were you associated to an AP when you ran the=0D
command?=0D
=0D
This v2 updates txpower_cur from mt7921_bss_info_changed() on=0D
BSS_CHANGED_TXPOWER, which only fires when there is an active BSS=0D
context. If the interface is not connected, that callback may never=0D
run and txpower_cur can remain at its default (which often shows up=0D
as 3 dBm via iw).=0D
=0D
Could you share the output of these while testing?=0D
=0D
  iw dev wlan0 link=0D
  iw dev wlan0 info=0D
  iw reg get=0D
=0D
If you can reproduce the 3 dBm while clearly associated (the=0D
iw ... link output shows a connected state), then we are looking at=0D
a different path not triggering the update on your setup, and I can=0D
adjust where the driver sets txpower_cur (likely earlier around=0D
channel context setup rather than only in BSS change handling).=0D
=0D
> Also, something just doesn't seem right with 33, 27 and 15 dBm. You=0D
> are in CA, right?=0D
=0D
I am in Canada (not California). Those numbers are not a measurement=0D
of actual RF output, they are derived from the regulatory information=0D
(the chan->max_reg_power fallback path) when bss_conf.txpower is not=0D
populated. They will vary based on regulatory domain and the=0D
channel/band selected. For reference:=0D
=0D
                Canada (ISED)    US (FCC)=0D
  2.4 GHz       30 dBm           30 dBm=0D
  5 GHz DFS     24 dBm           24 dBm=0D
  6 GHz LPI     12 dBm           30 dBm=0D
=0D
The 6 GHz band is where the difference is most visible =E2=80=94 ISED limit=
s=0D
low-power indoor to 12 dBm while FCC allows 30 dBm. The values you=0D
see will depend on what iw reg get reports for your system.=0D
=0D
Thanks again, your results are helpful for tightening up the next=0D
revision.=0D
=0D
Lucid Duck=0D

