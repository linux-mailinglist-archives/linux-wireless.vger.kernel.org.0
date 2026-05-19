Return-Path: <linux-wireless+bounces-36676-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD4EKW35DGpHqwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36676-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 01:59:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016415862EE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 01:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ABC630474EB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 23:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3F3AC0E4;
	Tue, 19 May 2026 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="cvyCDM5R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE0318BA7;
	Tue, 19 May 2026 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235042; cv=none; b=fwiBwxZI2f4Uk4JC06MRbSOLza1/Wh8EDMgxRj3mVoQRvwxA/U9oAYA5AdbqZ6/P2K+Do65443NREWHJ0tJ+/EW/RxcPeoC4wyz4lxgDTNtQQX/WqsDlZnjxFGHOcEVoFECiUsNSrYSxi7rNanKpU6IirwDmjn2+a8XIR45H1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235042; c=relaxed/simple;
	bh=2YKnQLvLTnXZy4wPB9Rd35JVzM/zZiTSGaUX4IkD1sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSkaqtQEJsTJdAjgZ3ygFekRjUgblYsDNuh7R0livNZEJBARRfRMROAYpjzoEMIvh3SG7z/BWBs1LSzETKIPYhlYfgaey1u2zyl45z1jAUwNollkGikr7Aat0+/kVnL/8Ym3tisqEszPIe/4L0O9ce5Iy/XOrpVnu4MZnQd6G/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=cvyCDM5R; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1779235039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REyrfv14Ul92Z0QoHqcUHp7zy5LrCfLs+D7Qmc6RaAI=;
	b=cvyCDM5RsqaQyQN8y+SheiY1yuQgiQhO8PR07RVtCu88UBwPPNH04dG3NenMwQRWG6PYHF
	C0RAhtid+9OVlJhqcigznQ1L8AX6PcHYy0rxnWTo3k7AetiGY4s6zj/x82hZwcpi0hqpLl
	UVk+BSks/xW8aBgm6lHXhMXp/u6KD1tgUccjOFrXSouX7JjFaN0eri1/yVKovPWYLLjtsE
	oqexurVOUM76w0IOEZjsl9Wgu+ZkfqLnQVb4z2Qx2YOJPFbLQ6/0LguYrbIbaeDDv7zSND
	G/yg2yyZy8jt5M3jHf9B80LIM72txSeRHnR5KelbaDLk+2Xzxbp4RieHYg3PYQ==
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Oscar Alfonso Diaz <oscar.alfonso.diaz@gmail.com>,
	fjhhz1997@gmail.com
Subject: [PATCH v4 0/1] wifi: mac80211: fix monitor mode frame capture for real chanctx drivers
Date: Tue, 19 May 2026 16:57:12 -0700
Message-ID: <20260519235713.49109-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260518170147.13885-1-lucid_duck@justthetip.ca>
References: <20260518170147.13885-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[sipsolutions.net,nbd.name,kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36676-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[justthetip.ca:mid,justthetip.ca:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 016415862EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3 [1] kept the existing local->emulate_chanctx branch alongside the
new single-chanctx fallback. Johannes pointed out [2] that emulation
always presents zero or one chanctxs in local->chanctx_list, so the
new fallback handles that path as well. v4 drops the branch.

The real-chanctx TX path is unchanged from v3, so my v3 Tested-by
carries: the airgeddon evil-twin flow on mt7921e PCIe + mt7921u USB
+ Kali VM with MT7921U passthrough still applies.

[1] https://lore.kernel.org/linux-wireless/20260518170147.13885-1-lucid_duck@justthetip.ca/
[2] https://lore.kernel.org/linux-wireless/58d6ee4054473af391eb5ae8b4382e6964dc3ab6.camel@sipsolutions.net/

傅继晗 (1):
  wifi: mac80211: fix monitor mode frame capture for real chanctx drivers

 net/mac80211/tx.c | 16 ++++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

