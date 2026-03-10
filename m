Return-Path: <linux-wireless+bounces-32833-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPRcGGcIsGkUewIAu9opvQ
	(envelope-from <linux-wireless+bounces-32833-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 13:02:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4DE24C30A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 13:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D133209235
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5644D695;
	Tue, 10 Mar 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="JnSrJk99"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADED41C30A;
	Tue, 10 Mar 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143736; cv=none; b=OYEs/pvjKmBeVuWJXZ76bYRQO+zhzJr+zkWuNBOeJ/jmjqFhqcd2BSE0u/nvTjiLrMS9munyN94/I3hK04957ehxglwpJ/kyVLKJJEFQwevvct0+PGisoYgEPQXWQJN6jiLV4QDLrtTM2yp3wm2TYSxxpY26YrOuYcFTV0FOZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143736; c=relaxed/simple;
	bh=OPqqHdKZkEBOTA9s0xCv07joTtAqSJfXU2nXlSYlnvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfxQVWJG8fWy4eWEiBQ6mIaQFi0SsqycstI+btCcnHT2RK+fNYhQN/NuRElyfyUjasUSavNhiJzd5nRV5quQgoMB/y7PsIu9mhNTjCVKijk8ZJ2Mf2xjRZiMv2KmN3jpTpqoXV4uDbDVB4tJ+LqG/MXmiRGODJTTCDlxEYrp8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=JnSrJk99; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143724; bh=OPqqHdKZkEBOTA9s0xCv07joTtAqSJfXU2nXlSYlnvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JnSrJk99cMmEll/e0Ny6kdP6d7z5e2adRmc4BQNm0IfEWQA0v8Ia2/4OtczT7zTv0
	 zuDRp3CXS4OlS3cviAJlMazOv5W3776khhgj6gPjV1UTcdP1jjerFNUOvMmQEoWhNK
	 cVnCK+DSv1tu32bgvLbIqQqVG4gy8NgWLzdZkaqE=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-2367-7f0000032729-7f0000019d12-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:36 +0100
Subject: [PATCH 10/61] gfs2: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-10-bd63b656022d@avm.de>
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
Cc: Andreas Gruenbacher <agruenba@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=OPqqHdKZkEBOTA9s0xCv07joTtAqSJfXU2nXlSYlnvo=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAX4/dv49K4j89zI86N9JpAw6t8eU0kmPVDxm
 PT/7+a10hGJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF+AAKCRA0LQZT0ays
 2zIKB/999m4RLBdXe9kckM0CjKr4GcE3BeYjqHOf9Mb/fXRspIYiRhfK/0d76B0wUZ9vMlV+kHN
 aPugbL3mxS3VAKy9S9eV+9mHhq2ovSgAXuPOSy8/qOTGHUqDaNzk/2uQki9ZfnbI3N1QVu0zj5x
 8blYFqhhVL5JzTcz+RG+KziT6t1xXKbIKoya+t7T6UrNg4H5H2bWy4EaQ7+S0qT/OwwuCndJ5uT
 z17dIMTDIfQoeXt9rkvrr2Ft1Brl0Ry1Iiv5kD+CcJTipZJNdlQgICgttnzL/8iG0G6ksTSjehE
 819EPypp6/ZxNz8oLOAo07gCKojS6jLLwc/BvUWqoKOgacEb
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-9BCBFE1F-865D3B73/0/0
X-purgate-type: clean
X-purgate-size: 895
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: BD4DE24C30A
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
	TAGGED_FROM(0.00)[bounces-32833-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/gfs2/glock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2acbabccc8adf957e02845041193502a96370a6d..8ed6b4535a728e217e5cec7b64488583b5737c58 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2013,7 +2013,7 @@ static void glock_hash_walk(glock_examiner examiner, const struct gfs2_sbd *sdp)
 	do {
 		rhashtable_walk_start(&iter);
 
-		while ((gl = rhashtable_walk_next(&iter)) && !IS_ERR(gl)) {
+		while (!IS_ERR_OR_NULL((gl = rhashtable_walk_next(&iter)))) {
 			if (glock_sbd(gl) == sdp)
 				examiner(gl);
 		}

-- 
2.43.0


