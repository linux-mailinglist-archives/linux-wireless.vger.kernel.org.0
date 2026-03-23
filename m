Return-Path: <linux-wireless+bounces-33741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OlgA+DNwWnhWwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:33:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DA2FEFDD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 00:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 727CB302B195
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F2370D48;
	Mon, 23 Mar 2026 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="SEeQ1hmt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D81DF248
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 23:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308826; cv=none; b=ooSNBM6AozJsj6ciUIO8KEnb/n31W1bN9PBXqboV73JQ+vU5YGo+IJrKJ1uuhGMgxZ6syvrTOxQeu4E8qzlbvSfOuiIlA9hWdMI61rbW85Y/wf7cjzuPs740AZnEEdYE3H3XCJwH16AhXkpYOuRjxqY8eklLRYZIXIQuV6YcLVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308826; c=relaxed/simple;
	bh=mD0aI2DC6Ci9Ew+PcONZiULA8QDyw1TXWELBFbCSJ4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2ZpEcrtHr1qZoo+brddc714yTRdbWwXZaJ3csOJUipX9A8qrggT0+dRW7SmAmfkbURtqPzGrZ1jDSCtUaN7LnDcnYPTJGzo/+doKoeCYEZXYEUFhNo1M2vwPaFy16RH+kHT3J662p1+cSTuSa5b23mK52Y5KJZqSKhgRv5Phdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=SEeQ1hmt; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774308822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azF3cTtkuinStvpRWIQNBNOnRFYSYk8ZehEiTsjh1pk=;
	b=SEeQ1hmt+gd3+NHTVI4HTorVmqPWWiZFArWkCd6bbN0Nb8BfTHLGWk3LEy8MevF85adSYS
	XNKo9z/0DAk9J9ykwoTqUV28rbsge5XribwbWC36MBe2is0Yvue+E0qAv5Ip2M3QTNkCUi
	aGAkKFxwx2wyauaHEzQA3xML14EqIbEpVZsGm696NNpsRtJe2e+yLQW2NkVBUe29zqiRZK
	Uh7t+MJrO61hbrpZOQlxofwsgZcdRR5EZoVqiVsPNlZ+c/TujcZzmCpbMZmKMnWXFIa/6n
	Y9CMQgMwftIMMkBZQU5c/NYj1BAtAyl+sP8E5mDftqbdOZtXcOHSoAfyUR6qpA==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2] wifi: rtw89: usb: fix TX flow control by tracking in-flight URBs
Date: Mon, 23 Mar 2026 16:33:34 -0700
Message-ID: <20260323233334.158678-1-lucid_duck@justthetip.ca>
In-Reply-To: <f2fca9db9deb445c91b1973c6b7ca72a@realtek.com>
References: <f2fca9db9deb445c91b1973c6b7ca72a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33741-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,justthetip.ca:dkim,justthetip.ca:mid]
X-Rspamd-Queue-Id: 7F4DA2FEFDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ping-Ke,

Thank you for the review. Answers to each point below.

Mailer: I use a direct SMTP script -- git send-email had a hang
issue on Fedora 43 that has since been resolved. v3 is sent via
git send-email. The patch applies cleanly with git am.

Uplink data (USB3 5GHz, 10 runs each, DWA-X1850 RTL8832AU,
kernel 6.19.8):

                     Unpatched    Patched-32    Patched-64
  UL avg:            844 Mbps     763 Mbps      840 Mbps
  UL retransmits:    3            0             0

32 URBs shows a ~10% upload regression on USB3 5GHz. 64 URBs
recovers to stock with zero retransmits.

> Can increasing 32 get better performance? The stress test with
> small packets might yield low throughput?

Yes. I tested 32, 64, and 128 URBs per channel. The difference
is most visible under parallel streams (USB3 5GHz upload):

                     Stock    32 URBs    64 URBs    128 URBs
  4-stream:          858      556        837        849
  8-stream:          872      565        830        833

32 URBs drops 35% under multi-stream load. 64 URBs recovers
fully. 128 URBs shows no further gain -- 64 is the sweet spot
for USB3.

On USB2, URB count does not matter -- the bus is the bottleneck:

                     Stock    32 URBs    64 URBs    128 URBs
  UL avg (USB2):     250      252        248        253

Small packets (USB3 5GHz upload, 3 runs each avg Mbps):

                     Stock    32 URBs    64 URBs
  64 bytes:          139      128        126
  256 bytes:         441      444        442
  1024 bytes:        845      786        846

Small packets are CPU/USB-framing limited, not URB-count limited.
No throughput difference at 64 or 256 bytes. At 1024 bytes, 32
URBs constrains throughput; 64 recovers.

> Out of curiosity. Is it possible inflight >
> RTW89_USB_MAX_TX_URBS_PER_CH?

No. check_and_reclaim is called before tx_kick_off, and each call
submits at most one URB. The >= is defensive only.

> I think the code self-explain this already.
> I'd not prefer this comment neither.

Both comments removed in v3.

v3 follows with MAX_TX_URBS_PER_CH increased from 32 to 64.

Additional validation at 64 URBs: UDP flood (0% loss across 4M
datagrams at 930 Mbps), bidirectional (zero retransmits), and
60-second soak (844 Mbps sustained, zero degradation).

Full test data:
https://github.com/Lucid-Duck/tx-resources-flow-control/blob/main/test-results/2026-03-23-ping-ke-v2-review.md

Thanks,
Lucid Duck

