Return-Path: <linux-wireless+bounces-32887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLsCBFkYsGknfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:10:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF324FA72
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 14:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 832F13133334
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4C3F7A89;
	Tue, 10 Mar 2026 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="lvv9rCLr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91647CC8F;
	Tue, 10 Mar 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143756; cv=none; b=H0ShOt2rbo1sLFhBVlM4to82WxraJE4dn+bfnxvUThTrI1Tx2UVq1LyjIiUHcxbI16z3W/uxphEVdhBmP+vwSRkX0teegoWNM8J3PCEBGSYytTX82tSzEdtpMhbr7/kbhEMiJQZ6+LDW4p+RQLXPg/QhZ/q0Rwq6C3tWToZyTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143756; c=relaxed/simple;
	bh=+XsCLvfG0yRq7Clc+S6vXeLkWzACx5pWWBTw1PU8u30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjtcqwiP9BJUfbrJ5UByRnTtMP6tFGSKyi870EKJeIMsdZdbnNXYSrsQMlTpI2Zp/TacEeG/Pc1oxkPPRMCPr0GJS5uKNvyhFal7Gj8AlG3itkKV9RRkBjrb2aqh8DtQJfnJoN9FSolQlIeSYZczQNgN6ctYhevfdwlylcXRI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=lvv9rCLr; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143728; bh=+XsCLvfG0yRq7Clc+S6vXeLkWzACx5pWWBTw1PU8u30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lvv9rCLrKWJ6Lu61m8H7Y+hQqk5FJD2drMy+ZUGbkYYYddiRBpNwylOwAbaMLr8TX
	 0ntk8LeS4o8QIJl/CLsQj4Y/a8rOjXwDbRopsLj0c8Blb8ycHGzponZ8V0ZgUbX2BB
	 PFE3teWoV/3Bfqs3MntIwu8IQkOTndj3UyxUs7UY=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006b0-e21d-7f0000032729-7f000001bac8-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:28 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:28 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:16 +0100
Subject: [PATCH 50/61] iommu: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-50-bd63b656022d@avm.de>
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
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=+XsCLvfG0yRq7Clc+S6vXeLkWzACx5pWWBTw1PU8u30=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAaAP0a4MkqsRJ5x7o2AECAXDJXUcNnvcP2jL
 Fnncqolc+mJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGgAAKCRA0LQZT0ays
 26BWCACZ2FsBOvK5vymJ4jNeheyMBLZmlutrR9jfimv19CKbp3wX0yqY0IgbC3+xiW+xz2CmiEu
 elpLzpFROPj+lHciOMtwniWl836Y8y3OBxdIzgp1Tcy3Ffv4iiDYZg6fn4s21C30sfDewBkZzM/
 oTShSXVQk2aaQji24A4tVvesTB1YCSJ0cdodFVu8ytRsCFbRhzUGEybOG9Bk1gp1pizhlUrevZe
 ky3pa8774nGDXRNTenO3QPi5eYmjmp3+jl22odQgRq4UYaTFuckuTj8ZjbSd3Db6Vvti4yjTzbj
 dPn6v3i40vUhGSdowNFCOZB8euyQhRspr8tJsS+hGDqM4vf7
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143728-A6654F2F-F8696DCD/0/0
X-purgate-type: clean
X-purgate-size: 936
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 1DBF324FA72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32887-lists,linux-wireless=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[57];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,linux.dev:email,8bytes.org:email,arm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a9202025643639a6b28e6faa84659..500a42b57a997696ff37c76f028a717ab71d01f9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -881,7 +881,7 @@ static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
  **/
 static void omap_iommu_detach(struct omap_iommu *obj)
 {
-	if (!obj || IS_ERR(obj))
+	if (IS_ERR_OR_NULL(obj))
 		return;
 
 	spin_lock(&obj->iommu_lock);

-- 
2.43.0


