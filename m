Return-Path: <linux-wireless+bounces-37622-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+AgNUIvKWpkSAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37622-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 11:32:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5996E667DFE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 11:32:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=Gs7Fho2s;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37622-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37622-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E0230160DD
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC553B47C9;
	Wed, 10 Jun 2026 09:23:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12853AD50F;
	Wed, 10 Jun 2026 09:23:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083427; cv=none; b=KySCsdz3COOvX6VOv14QgC2PX5ffQLU3rccSWn0IVq86Y6aLfPTDa/A+r/PEHXOeSo5T6qc7o0iKTp1Ei8ETz42fvAhAhV8CfVkBow/PapV2LM00fMp7G8g2UiWNwFgzocG7SHb2b/ZIyakT/Y5yv5MrtdQHdMwvDLk5I8CiKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083427; c=relaxed/simple;
	bh=fbksk0r+l9gUbaGDi2ftc2FYLTOsSKnUCY5rdrXJtvc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qao2v+8SfdmgdihBk7m34eEr5XW4cLbXXKvf/Iak/F45q1eC/K0I7iRttN5rlTb6Sd5Mr/QYWxD87unCZ6D0wuk9kAAORwwlO9+K6qWAo5u+YiwAzgns0CftRDYmCah4llrTqj0Oxjz7kNR7jF1fTUwS8GRsKSpn32VUs1QUXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Gs7Fho2s; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781083385;
	bh=4/9GXdd9QofpntZUP+2Yz31YkZfX5I5OmChfTdC5E9c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Gs7Fho2sf4pthFTCs9Gl7EZjBYiIwi1p3HhVZgOg9uYSdhxmlYGtfFzs97OeoU+P7
	 NBNx0Tt8jP3bfzIEAAkX5Xecz3UA7DgBydd6vkGy44pYBxmeqU4ZfAPNbI07pVfNJZ
	 zJ0Cj+F/wkfsPd+DPQpAoCWXpcu0HdFVSeGKozQQ=
X-QQ-mid: zesmtpsz3t1781083367t60c1950c
X-QQ-Originating-IP: uUJTKHLDiyboehVIb+VaTl5+nJDih1sIucCSx6/mUPs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Jun 2026 17:22:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15373450884566247854
EX-QQ-RecipientCnt: 10
From: wuyankun <wuyankun@uniontech.com>
To: linux-wireless@vger.kernel.org
Cc: jeff.johnson@oss.qualcomm.com,
	johan@kernel.org,
	kees@kernel.org,
	wuyankun@uniontech.com,
	sumanth.gavini@yahoo.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: fix invalid workqueue flags in ath6kl_usb_create()
Date: Wed, 10 Jun 2026 17:22:36 +0800
Message-Id: <20260610092236.40026-1-wuyankun@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MjqaYNLY8QZGud07TBn/4w7nutsls2aMgVqYMXa6nKkxJNcOotmaBjKz
	D24n+zZ9B1w0VQ6tGXCjUrEJpy+nV08eOSMqzkP8XUVkhOKYeh6qBmkV/Q4w7SfDP+hc8h7
	cm87y3ipjxfQoFnSiViTj1Ad3IHqFCeloAn4irfGit9N0exjZH9avFghyHNqODpQWKutrqv
	a+bSWlVnOAj5MvJTJuckqaQ61WmUwPa1ZjzK6UnwbTxpSKO2Txy6Rn6YycOUZk7HCVbxBqE
	JmE/BO/KP5kvJlOpV97WgrnpzsWScNQbHFI1n5bNkNblk8hJT++3/Tty2/lY/lAeYpsIJA3
	HYdA4KEzrquB4WWqZvpBjPOsrp70c4NNBwOBK7bQseK/zk6EFMp6ZOYtYlNSyVwnqh9T+8m
	FctzZnUAy0Exhxmf07toxw6vYqyNkGEfMmiindsoph6BXw7wo+X2mJlNr5vfYKzeH80eg8f
	2decbQAklQziHhxEf0oBk/YH2DKDYnE/YVVPx98Uerc5GC9vv/r6tXiwe2VvMPPdpiCEB0j
	LtSzswlxeMbTyOWY17YKx2x8lt3gEbgR6ez/ERhjvUame3ZruBpapH1HTHKok8RgLQyXT8u
	NynYxsXB5FnDj0hbBt5Nhr9/V0Rhe1j3hi7kVUHZGTuEW0X0dyFsc/VZ3hpohfq38RFR1QW
	Os75Y275YGJjybFlP32VIEBI1yHpPGYhncZ3qKCd9BkxbGyKngjqgtlXQMVMrL4Xa/xL1WI
	YNI6NeUncGsmypeGQUyxh8DkWlrAcptQVBrY9aySb++jZQq/z8sPFRckZz9pcywZ6BNwsFR
	RtU+Sejr6qy/dLf7U0sC+vh8bIf8+wVVOO70hE+BE2AF+eAwzcCjcZKSvdNP9kMn3heM/1R
	gzA9zJoWhaE1/xVvklhZZYRWotL6cOIlQOr+/oWimIgUEGsqS0dPvp40hFehHfxCBUVwkhy
	U0V3kJKmeITGErv5IS2ny5Iripak9mzvC7eqjO3LxgkIym7uCi7dL1tL9oJDkTPb/JJLqEf
	NYQ5XQuVWPqn3MckbTxZLHwbWZg45bSwTs/tI1UP4YyyFFmmQmSPjT+gpHpnc=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,uniontech.com,yahoo.com,vger.kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37622-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,m:johan@kernel.org,m:kees@kernel.org,m:wuyankun@uniontech.com,m:sumanth.gavini@yahoo.com,m:linux-kernel@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,m:syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com,m:stable@vger.kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wuyankun@uniontech.com,linux-wireless@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5996E667DFE

ath6kl_usb_create() currently creates ath6kl_wq with flags set to 0:

  alloc_workqueue("ath6kl_wq", 0, 0)

This triggers a runtime warning in __alloc_workqueue() because the queue is
created with neither WQ_PERCPU nor WQ_UNBOUND set:

  workqueue: ath6kl_wq is using neither WQ_PERCPU or WQ_UNBOUND.
  Setting WQ_PERCPU.

Set WQ_PERCPU explicitly to match the actual execution model and remove the
warning during device probe. No functional change intended.

Fixes: 62ebaf2f9261 ("ath6kl: avoid flush_scheduled_work() usage")
Reported-by: syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a289c01.39669fcc.33b062.00aa.GAE@google.com/T/
Cc: stable@vger.kernel.org
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


