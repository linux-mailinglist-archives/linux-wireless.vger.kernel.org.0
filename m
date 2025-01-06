Return-Path: <linux-wireless+bounces-17112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07452A02EA4
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422057A135F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 17:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719E1514F6;
	Mon,  6 Jan 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cdtEk/Lw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3687978F2B
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183415; cv=none; b=d74XGtuU4lHYVGLsWl+5HEXkM3YMxbl8Q37aBKQ2Ef0OMYnUdrNicDj1sbd5lJ2dA3Y0yfndwIiycyjQRd+KctCWYLsthtgg6EsGjebzmE1PIHuyDwuDT+iZte8ZEAKVq5gck07oAuhoCjJ3ps059RnZF6FCzuV9UoBcz4EzU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183415; c=relaxed/simple;
	bh=2Rz+mh7Isoh3FLsG9NIfpNa4HHMrfqwERf08jXPafAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbxlJMJh1gFUSW3/pa6wi+1fg4jl2ZbjWErxgNs2NTEXJFtuFMlNEBo1o+2b34rxyj0mGtouDa03gGyIEMDiVCSCwlEJ/cICCcwKy72SVuLb13Njsw908KzBp0u68iaLvzyem2Nue6ycHG9SBZnqvjs464SRa+lOMgZVgwF0yIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=cdtEk/Lw; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XP00aZqYOdF0jBkfRD4YWoeOLKZJ7/4lHiwGMilOEzQ=; b=cdtEk/LwN+cb65Dro8B0NkwiUV
	rTC36MLPZqd5RT6vh//JxaL7ycRFQtjamgeM1PotADfaNmtuPiMXHuUFJKzN2A+2/BpHXLvB1W+kU
	/idZcgljO8WZ3HxegWhp3TXd5tMB+wfFBnuZTrTih4UZm/D8LaL2/RtbnQCvRbT8UG+YNqZI6kTaw
	tPcXOOnyUK51/EzLWztVxPeSvio8hwvmPT1zgiMEaBlto4PB2r7zpJ0VKmX7gAVwFTsTAwrVMLbEY
	VOdOBZlNTGWARXd1gnOBsjeSuZps43aZcKiMXQj9iRb4Be9CcvU2qBHEBG5Ix8AfZGw0PchzH8S6E
	2j92TO3g==;
Received: from cw141ip135.vpn.codeweavers.com ([10.69.141.135] helo=grey.doe.home)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <stefan@codeweavers.com>)
	id 1tUqcF-004Y2Q-1i;
	Mon, 06 Jan 2025 11:10:12 -0600
From: =?UTF-8?q?Stefan=20D=C3=B6singer?= <stefan@codeweavers.com>
To: linux-wireless@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v2] wifi: brcmfmac: Check the return value of of_property_read_string_index
Date: Mon,  6 Jan 2025 20:09:58 +0300
Message-ID: <20250106170958.3595-1-stefan@codeweavers.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Somewhen between 6.10 and 6.11 the driver started to crash on my
MacBookPro14,3. The property doesn't exist and 'tmp' remains
uninitialized, so we pass a random pointer to devm_kstrdup().

Signed-off-by: Stefan Dösinger <stefan@codeweavers.com>

---

v2: Don't assign err, inline of_property_read_string_index into the if
statement.

The crash I am getting looks like this:

BUG: unable to handle page fault for address: 00007f033c669379
PF: supervisor read access in kernel mode
PF: error_code(0x0001) - permissions violation
PGD 8000000101341067 P4D 8000000101341067 PUD 101340067 PMD 1013bb067 PTE 800000010aee9025
Oops: Oops: 0001 [#1] SMP PTI
CPU: 4 UID: 0 PID: 827 Comm: (udev-worker) Not tainted 6.11.8-gentoo #1
Hardware name: Apple Inc. MacBookPro14,3/Mac-551B86E5744E2388, BIOS 529.140.2.0.0 06/23/2024
RIP: 0010:strlen+0x4/0x30
Code: f7 75 ec 31 c0 c3 cc cc cc cc 48 89 f8 c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <80> 3f 00 74 14 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 cc
RSP: 0018:ffffb4aac0683ad8 EFLAGS: 00010202
RAX: 00000000ffffffea RBX: 00007f033c669379 RCX: 0000000000000001
RDX: 0000000000000cc0 RSI: 00007f033c669379 RDI: 00007f033c669379
RBP: 00000000ffffffea R08: 0000000000000000 R09: 00000000c0ba916a
R10: ffffffffffffffff R11: ffffffffb61ea260 R12: ffff91f7815b50c8
R13: 0000000000000cc0 R14: ffff91fafefffe30 R15: ffffb4aac0683b30
FS:  00007f033ccbe8c0(0000) GS:ffff91faeed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f033c669379 CR3: 0000000107b1e004 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die+0x23/0x70
 ? page_fault_oops+0x149/0x4c0
 ? raw_spin_rq_lock_nested+0xe/0x20
 ? sched_balance_newidle+0x22b/0x3c0
 ? update_load_avg+0x78/0x770
 ? exc_page_fault+0x6f/0x150
 ? asm_exc_page_fault+0x26/0x30
 ? __pfx_pci_conf1_write+0x10/0x10
 ? strlen+0x4/0x30
 devm_kstrdup+0x25/0x70
 brcmf_of_probe+0x273/0x350 [brcmfmac]
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index c1f18e2fe540..1681ad00f82e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -99,13 +99,13 @@ int brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	/* Set board-type to the first string of the machine compatible prop */
 	root = of_find_node_by_path("/");
 	if (root && err) {
-		char *board_type;
+		char *board_type = NULL;
 		const char *tmp;
 
-		of_property_read_string_index(root, "compatible", 0, &tmp);
-
 		/* get rid of '/' in the compatible string to be able to find the FW */
-		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+		if (!of_property_read_string_index(root, "compatible", 0, &tmp))
+			board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+
 		if (!board_type) {
 			of_node_put(root);
 			return 0;
-- 
2.45.2


