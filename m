Return-Path: <linux-wireless+bounces-37646-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WqWKCUoWKmopigMAu9opvQ
	(envelope-from <linux-wireless+bounces-37646-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 03:58:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE666DB93
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 03:58:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=N35qJdAQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37646-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37646-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B5C83023E08
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 01:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965024A06A;
	Thu, 11 Jun 2026 01:58:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF940D565;
	Thu, 11 Jun 2026 01:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143108; cv=none; b=bcN+rbfpq7I8AX0boRfN4iQQqAVsVt1fMN0G0QgPeTi9glWss59Q6rVIbFibkPrcGLCTDAvkp3bDkADFwlULrDDuTNO7SpKY1nQlM5+o7g+2GpYhARv6pKiqYrcO0dvDmuH7IWnXQxaT9gvvJT9XSG3bsA8BR5fxqMu5XHVnvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143108; c=relaxed/simple;
	bh=iszKkz3JgLlRe0sP3qPT2UGfqGVBejQNnEjJt/kZepY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G04FBOlIqtoyVefV4Hb8C9YzAKLX2YIWlOaAN+i3Lkv2iI1HistdLhtopXEMXHGoegca2uKCYd7yHEf9247+ekgL0fQM0noG57Q0qIFyIaFqBPsY56O+N571/eMVH28/jbPYp1tvBrQGnVWjqmzPKk/RXHtGi9CEIPBCYxxwCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=N35qJdAQ; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781142970;
	bh=QJoWXZpcV5a9/t2+tGRRv6L7y8JgmT2jrErNwbztDW8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=N35qJdAQFOCMRDXi2zfD6DRURedvfWscZ/nnyneokCjNw70axYlh7i1kCYSqFrECV
	 rH59G5Hd1jJ24bRg0kqMGZsCdqcSOPzLRQS6vXuVRZEZ51qDw85L1M5svjvSJepoLR
	 XS7VYNSroFIZmOg2b0GoBE6MPQYs3UDT6jWf9Rg8=
X-QQ-mid: zesmtpsz8t1781142951t022be485
X-QQ-Originating-IP: dtgcXLHrh7uYinHQvqJ4j0g25H+VW+HzZRG97NzK1xg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Jun 2026 09:55:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 263188192785953540
EX-QQ-RecipientCnt: 10
From: wuyankun <wuyankun@uniontech.com>
To: penguin-kernel@i-love.sakura.ne.jp
Cc: jeff.johnson@oss.qualcomm.com,
	johan@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	sumanth.gavini@yahoo.com,
	syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	wuyankun@uniontech.com
Subject: [PATCH v2] wifi: ath6kl: fix invalid workqueue flags in ath6kl_usb_create()
Date: Thu, 11 Jun 2026 09:55:45 +0800
Message-Id: <20260611015545.111157-1-wuyankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <075511fc-1136-4208-84d0-9214e761f8ba@I-love.SAKURA.ne.jp>
References: <075511fc-1136-4208-84d0-9214e761f8ba@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Obfty5iaetlmC1NFajMFI1oj9T4UQ0rWBTMhiJTc1PyoiIn2Ug9Gwsxo
	8DXikI4OEDIx2XIsRLlfOlibdMFNSizg09+V13kR4tX/N1MDRGkucV48n1xjcZznRWujVAD
	yb//ywC20QHQ/a6t2UTe+V8xSEwbiV2TR5qvaPdNRgArGdyhZ/eFmmy7kNT76uE16HbA/r5
	s5D8e5cJjOxj/BrnI7/iJ6v0jZuTcPIXfDqWyySOQd/8gOVrj7VEYskH/h0S/CgPv+++e8z
	ATbGqhk17xALoPTlWv9uE27EUCmLy3NEDSHn3wCCHQNjoVUV/1XELaRir8pDDylx4q1psvI
	CvKQLvq6I5vLRMBfwUzGicHKv9B+3LJ9FVWtCDYxuovsgn7WPrXl6dStrAXo1DWc/IlUHLe
	SYj/KFv9InIiHoOp8sPjBhjdMKRDPtHPaN5PBZfVRmzk5BcQwfgT6xpr3wCXm/CZRFDHPpx
	pBwxEOtGDHqF9F8nBUAtejbcdzXkOoHFh9pW0PkRWkAqMIaEevQ5f1DsthaTEUpKenx16By
	rhtA3gV9EyKYiUI1LcbX/x2BMAnmH2POPHs7BjJb+IZrJABsvYbMjeYIfBQAK4ftV2omHGk
	lmQEK3BAd6GLGWt0DkuJcAunwmrnHA07OiaQb5YsGA8odq7DT00kF7PfTmBqtbsblIYFjPe
	y0pqrvCA+ViCMo6E57yCzOw0YNWXzaKX0ST31BjU0SAwoEJDXch2hB3vkwQrXaLLz1jYY0P
	RmV/tFEdfVgoeaMg/duuh0ltaNc9kXauzCQ1tu7hA85mc+RKIp0nPrr6kr/cy3WxflTvIbr
	bTGzFQw9gqhLu5nzLETR44ygqQG/G2jK62vY0yOFIMYlHzoQ9htXYGFtYHyD2ctd/zL7BOk
	ABnF+LiWCkHeoKxlQ2v6nsrkKt4OwxkiWDZpVdnDJznDv61bxKrEettaxTwxI1yE04/KyW3
	jupfeXhZG1TWw/RaEGusnRp63HmFbPNU2MChbliCRP1sd4kguM613pYpnX0/u29X4nw32DO
	oWdaphr1WxRrkSsaTLHt6Ctm5soQWEMnlFzq81DujawqZ/iRtluyWirUOBrD0=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,vger.kernel.org,yahoo.com,syzkaller.appspotmail.com,googlegroups.com,uniontech.com];
	FORGED_SENDER(0.00)[wuyankun@uniontech.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:penguin-kernel@i-love.sakura.ne.jp,m:jeff.johnson@oss.qualcomm.com,m:johan@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:sumanth.gavini@yahoo.com,m:syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:wuyankun@uniontech.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37646-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wuyankun@uniontech.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,f80c62f371ba6a1e7d79];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABAE666DB93

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


