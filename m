Return-Path: <linux-wireless+bounces-38760-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xOR8A6kFTWqRtgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38760-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 15:56:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDE71C313
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 15:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sigvoid.com header.s=default header.b=fJmYMUTh;
	dmarc=pass (policy=quarantine) header.from=sigvoid.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38760-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38760-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F4D5309CE65
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22CA3F4123;
	Tue,  7 Jul 2026 13:49:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30141DEF4;
	Tue,  7 Jul 2026 13:49:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432155; cv=none; b=BUSY9kfzsyq8nGRlt8YLFZGD6wXt7opmGrMwX2AS2MtsWMkhfaldzq97sQqCNCigpTxeeG7cTH25jUad78Cm9dl3rNhflY+CqoaVT7nrSZVY1/C7i9NJWb/t8B9QEridaI1XfQqkBqiSQLeTx0UIKvt0RBAihmNGB5fkDM3Or/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432155; c=relaxed/simple;
	bh=YnlyOtnw3PgpfSljpllY6ScClDIFiZB9tlpFCSxjMyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBQ0V0hWb5UI2XOMqUktawxe6yen6tSIdLpT25xnMLrX6cvAu3WKDbYVDQMGtrZSRv/u1kA0j9oljnkD74PLrNaGeaPMkV3nqAzfXoHYPbmi2xBBI5Kg0IyVW2bxmQS9ukHvtCU3rWaq/d/3k/5z6FW6lCOZ1X2wuhya+YN2Svg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sigvoid.com; spf=pass smtp.mailfrom=sigvoid.com; dkim=pass (2048-bit key) header.d=sigvoid.com header.i=@sigvoid.com header.b=fJmYMUTh; arc=none smtp.client-ip=115.124.28.149
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sigvoid.com; s=default;
	t=1783432143; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YnlyOtnw3PgpfSljpllY6ScClDIFiZB9tlpFCSxjMyU=;
	b=fJmYMUThO/EEsRW6kmBrN57ejNUoTnYcAxK8IiK2A9dc1v6/lJfZDS3+ugEpg5JYuqMK3q1FEBdIFmNNp+Yy7wcgLqHj0rmafZpXuifMJ9dgpH0rXcN0rW556icvmKp/eStD64b2gJeMTfJlzEU5EX7mGnmOYqWNeYb5ErsATWWSCFJRUTE+BX3pXz4Le+Tfpr/Hx2qNhgg0HHgdxejhkRZ0wVPgxVxXDAsoPVinK4I+CukMBtqfrBBS2zyRC8Pv9k5S6KBm1Ton0R8kNO7WjqxZFtSB/hW/B1kmi1FFP+wH9Mn4zFoTH0KQEmXIIjGUEvzmUOUfgZwC1cKD772Z+g==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1065582|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0106749-0.00619437-0.983131;FP=8386079198753556468|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=yingjcao@sigvoid.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.iFXH90z_1783431804;
Received: from localhost.localdomain(mailfrom:yingjcao@sigvoid.com fp:SMTPD_---.iFXH90z_1783431804 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 21:43:37 +0800
From: Yingjie Cao <yingjcao@sigvoid.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nathan Howard <kernel@nhoward.dev>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: only accept IBSS channel switch from our own BSSID
Date: Tue,  7 Jul 2026 21:43:22 +0800
Message-Id: <20260707134322.70942-1-yingjcao@sigvoid.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>
References: <20260623090437.13198-1-yingjcao@sigvoid.com> <c3fd8617849368e579a56c4397b7ee8624ef27ad.camel@sipsolutions.net> <9201d828365fa2b11fb6a83d1ff66365435a9072.camel@sipsolutions.net> <ajrfKAmdZnPPkGKE@gpu1> <b7dab24792025a5a95b719ef7d508fb109859ec1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sigvoid.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sigvoid.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38760-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:kernel@nhoward.dev,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yingjcao@sigvoid.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yingjcao@sigvoid.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sigvoid.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sigvoid.com:from_mime,sigvoid.com:dkim,sigvoid.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38FDE71C313

Hi Johannes,

Thank you for the feedback, and sorry for the delayed follow-up.

I did use AI assistance while preparing this patch, and I should have
been more careful and responsible before submitting it. In particular, I
agree that the commit message overstated the security impact, and that
adding Cc: stable was not appropriate for this submission.

I am currently learning the kernel patch submission process and the IBSS
code paths involved here. Going forward, I will make sure any future
submissions are reviewed and verified by me personally before sending,
and I will include the proper Assisted-by tag when AI tools materially
contribute to the work.

For this patch, I will drop it until I have a fuller understanding of
the code involved.

Thanks,
Yingjie

