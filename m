Return-Path: <linux-wireless+bounces-32885-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM/MB1wasGlAfwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32885-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:19:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809E24FEAD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B2B30B9F9B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9A4963CF;
	Tue, 10 Mar 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="xkT1xwtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66991477987;
	Tue, 10 Mar 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143750; cv=none; b=okdiQaCRQ6f4+hnI+Xf0ZIiNY+MkSIMs+SnyXykXO2Z/qjYp0870M9xso1uXjV9IKM69NaG8S86Rk+oMvgbvYTRfJGexb8+g1CgYi5M20k4NHmY76S8bzDv2D229el6xZrRep8v10wih8zl6otF/KQAvF+U8im2zAH97/YWhNqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143750; c=relaxed/simple;
	bh=7QEjQvc53kHdYvJikGIe0XIqNo63J0gbffxhQyvvDmc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yf30Lg18oDEK+3q7MT/AhxVyPPHV127dtliULxpXWH4CTqUWCEqhppP8jAFod6FNbSXC7+U93u2mSKUpJMhveOEmud0Vv7Xg5nuJibpLO0ABxzVjoLJ4LUoA/Il9duUUfXhgUr+b1DNRlbNctyhbt8osbeTA7hNT/9Cq0Yb3VOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=xkT1xwtn; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143727; bh=7QEjQvc53kHdYvJikGIe0XIqNo63J0gbffxhQyvvDmc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=xkT1xwtnaKnF5zwky80U90tVBtgjXUcX+GeykmrAvdmpppC5+8VK/cr2uIrG8dU1M
	 7wm2m1OyU4JV6u1islMHTFtIiUXXXY5n/w/md+c+5C+f1bhtmzGNVLxiuCLq3+FykP
	 yZ+BZpZfQ6y4Yx2gZPgoiPOharwFnkzMOEjjrW34=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-e21d-7f0000032729-7f000001da52-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:07 +0100
Subject: [PATCH 41/61] pinctrl: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-41-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Linus Walleij <linusw@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=7QEjQvc53kHdYvJikGIe0XIqNo63J0gbffxhQyvvDmc=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZht0v/gzetsO7BqEut/SimpAgjLSUxejqDN
 jYPITjd+qeJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGYQAKCRA0LQZT0ays
 2w/2B/4pX609pdZXvqHfb+Vqmmi/TuKtxSLe3zgXgKoCJW/gh17vsp/T22wIBqf6SXS4OIznDwc
 CqIbsgeOEAAlNDyBRYAY6KPNdElI/rv3fa2ORfx9RdjhIHa4x5wKb3P01gEbIVxJDT7L+eaQBY5
 W5yNdsizunhdj+FuJcUWkiWweG/sakXiGLIkqX5NlLESVIppvEGGOaxwjbsMisZ9PSaDKihHXQV
 LTJsTcuZgnx6Ly3LMJ0SQkiMEfMsx1Sbu6dG9rRM3ckN2uFTC5HrsnBNmmT4sZqY9FpULICBCkq
 q7sHGVDOpWpuw1oJ3VO2Y9YZsG2cD9KHQpB9olXNSESNKBcu
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-8E664F2F-77ABA0D5/0/0
X-purgate-type: clean
X-purgate-size: 976
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 7809E24FEAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32885-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index b5e97689589fbf1b6750620fc193bc820012be2b..97a80989601abbe969d4b64cb0f3926fd4f291f5 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1991,7 +1991,7 @@ static void pinctrl_init_device_debugfs(struct pinctrl_dev *pctldev)
 	device_root = debugfs_create_dir(debugfs_name, debugfs_root);
 	pctldev->device_root = device_root;
 
-	if (IS_ERR(device_root) || !device_root) {
+	if (IS_ERR_OR_NULL(device_root)) {
 		pr_warn("failed to create debugfs directory for %s\n",
 			dev_name(pctldev->dev));
 		return;

-- 
2.43.0


