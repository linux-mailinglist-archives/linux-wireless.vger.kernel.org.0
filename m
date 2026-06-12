Return-Path: <linux-wireless+bounces-37696-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZCLULQ2iK2p4AwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37696-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 08:07:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDC676DD5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 08:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=hwYcQ8Zu;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37696-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37696-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95D731E4E36
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 06:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC933BB9F0;
	Fri, 12 Jun 2026 06:06:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A239FCCA;
	Fri, 12 Jun 2026 06:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244416; cv=none; b=pCZ0b1gYCSEXeUXqgXIrtJ7OgnXlIpnYXXxmdITxbJvXhNlVXT0dtr3eOgQg836ACjZvbjV8QNfeOskZ2PipkXzo3c9ZeR268MfE9ugaekU1T8QDoMN3fpgMaCb765xXRHGAj+NU9v01bWTVsYhPLIcQ4dc2au06lHAARQegqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244416; c=relaxed/simple;
	bh=iszKkz3JgLlRe0sP3qPT2UGfqGVBejQNnEjJt/kZepY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tIruZqsGpSM1pp74ZrYFUlFKs9Kq0tq9+DupbyTFnY3u5Tt+AtXFAgOafi7x9X+ei9z2P7Kqfc47z94s+FfE3tKJqwAiO+PkTcXmLn6MFaWtjsnS0uvtGtstvbxq3wx91i8jArsaqj0I9q78glNNXSbT6fR7D/zhxDbSJJu1Yuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hwYcQ8Zu; arc=none smtp.client-ip=18.169.211.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781244361;
	bh=QJoWXZpcV5a9/t2+tGRRv6L7y8JgmT2jrErNwbztDW8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=hwYcQ8ZuAi4YXqTWWeId+DPW/Ojum73QUhsHtKzLqn0YulKCKMqCc6uI+DuCxAa+s
	 n61FXrEk/pOhgm+ZB1ePlgIm/8q6jk+qWoxOrCOuSTmcd8dkzyGlL5BFBYkps9D0W8
	 XKo+1ItUuCjT3m1dN/I0Od+mDamEzR5cYjlrPuSM=
X-QQ-mid: zesmtpgz4t1781244342t5aa2ed07
X-QQ-Originating-IP: VNBj1aTnkDnzoT7DCa88i1WN7TVbLF5CR6W9vAx9ngI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Jun 2026 14:05:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9832015854964275207
EX-QQ-RecipientCnt: 10
From: wuyankun <wuyankun@uniontech.com>
To: linux-wireless@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp,
	jeff.johnson@oss.qualcomm.com,
	johan@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	sumanth.gavini@yahoo.com,
	syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wuyankun@uniontech.com
Subject: [PATCH v2] wifi: ath6kl: fix invalid workqueue flags in ath6kl_usb_create()
Date: Fri, 12 Jun 2026 14:05:36 +0800
Message-Id: <20260612060536.247232-1-wuyankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M0G3LjVjhyWpYh31Q8VJ1xHThYWbJUjgFi3/LsKmYVrfzOg4/0wcBpZ5
	Vb/0txqPsXovc4dRizwCp9nRwuA5bsHNUF83TMDiundH9DGd3QYSWNgJxEII/72QCMI/MgI
	grUi74bieuGk8kZ5noW2G14Ynrm2GvRBhXUYhy4RmHJlXiGQmGfqDQqv5Dg6IqavhTRYPq6
	VJMrSnrzJMLInbvXiPzwCtq+65lS443VK6eCxu2OcOFNVGbZMXSzqYqN7SFrtoZfU7fK0zB
	JuO/5mLF8kRgH/2e1kErhCs7bAU0ob9mTAhJnyySbv3Wcgu/dMnwgYyQ7LPaFATd1E1WNV3
	lTHclGJ5JvXtXIbsshV8/qg7xoPMTd9RqDzwRiQQUBmqLd0tHAQEIdgSIEacm4z7GuF1BqH
	UL18TteTpfdBg+lJosoZkDihqH8ItgOTQ+aVXOcX6uho+R6GZE9MqEBp771jH7ap5uKqfAG
	cQvzgaM0U2rddK/u0MVJVyZE7sU4L+WnPioyBqtJ+PjNKS7g2D80veVkWOzEmUb2LabX14+
	/JB+Ak8A3OhH+nO0vl9OBMxDy407n2NV4XddlVLvyiIJN6gtyQ/mlsgVifGwnU1hqcrVF7I
	vibVDyEpchkD0zCPUdD4ojWDhd+k95JmBnSCko5+bSlXnILOwLfO49nZF0XWBg4BA/CVHPw
	In0nfP4oahnxvyXssbalZJzK8RvmvDWxJa1QDyuUbPLBc+Ubiu+dLf3tjx5l5iGI+L8G2Pl
	AMF5KE7zHdNmI8JPXeP3rTyfZ9x/dvCTSio67fgYNnY/p/cHSfpkWKMeA8GNF67JNnSn3RW
	aYsXllyZM8elZ4EEAK6SA06yncGp4TX7Twvm06BV7d8UIvCbYBh4YGp2BV0P1TO+dl/KQsB
	hm+JznGnijvDMqPuhF11FmN28EHsghvtwyCClW3vLtvBlO1+jlVf/ojC00dEVgQSO0WwA2c
	GZ3aEdxWqx4lg7tqTaV531NueIOle+XYa+n8hyWVAutF4FyNU6Fl8ieIdWZqLBXtUPIxBkv
	GbDDnTLRs2/nf3/I+czmOV0RDVLj1DtfEWxvAFnShE10/FdDrt2ykhqyXCfGW2Tz17it9pc
	lN+8a7yugI1U0xd5wL6xDjqEbt4p0moLf04015VcdPY
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[i-love.sakura.ne.jp,oss.qualcomm.com,kernel.org,vger.kernel.org,yahoo.com,syzkaller.appspotmail.com,googlegroups.com,uniontech.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37696-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[wuyankun@uniontech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:penguin-kernel@i-love.sakura.ne.jp,m:jeff.johnson@oss.qualcomm.com,m:johan@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:sumanth.gavini@yahoo.com,m:syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wuyankun@uniontech.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wuyankun@uniontech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,f80c62f371ba6a1e7d79];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BEDC676DD5

ath6kl_usb_create() currently creates ath6kl_wq with flags set to 0:

  alloc_workqueue("ath6kl_wq", 0, 0)

This triggers a runtime warning in __alloc_workqueue() because the queue is
created with neither WQ_PERCPU nor WQ_UNBOUND set:

  workqueue: ath6kl_wq is using neither WQ_PERCPU or WQ_UNBOUND.
  Setting WQ_PERCPU.

Set WQ_PERCPU explicitly to match the actual execution model and remove the
warning during device probe. No functional change intended.

Fixes: 21c05ca88a54 ("workqueue: Add warnings and ensure one among WQ_PERCPU or WQ_UNBOUND is present")
Reported-by: syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a289c01.39669fcc.33b062.00aa.GAE@google.com/T/
Signed-off-by: wuyankun <wuyankun@uniontech.com>
---
 drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 79c18f5ee02b..945984c3dbe6 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -636,7 +636,7 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
 	ar_usb = kzalloc_obj(struct ath6kl_usb);
 	if (ar_usb == NULL)
 		return NULL;
-	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	ar_usb->wq = alloc_workqueue("ath6kl_wq", WQ_PERCPU, 0);
 	if (!ar_usb->wq) {
 		kfree(ar_usb);
 		return NULL;
-- 
2.20.1


