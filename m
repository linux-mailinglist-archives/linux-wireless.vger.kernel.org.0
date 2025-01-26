Return-Path: <linux-wireless+bounces-17963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6AAA1CB98
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 16:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5918C3A176C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB31F1534;
	Sun, 26 Jan 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVrmt1yh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141371F1520;
	Sun, 26 Jan 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903854; cv=none; b=tzI7t5ut07CJkILQQpy66J+1PqjHvVCgwTynX0tbb6zLghmAin7B7kpOM9bKWR4leQmf6lWhh/KbqBX9YaIN0W+CeDEHmg9HpeHlctFd6fbPwkYlUXuDB7jwFb3+MYIEWFVN1SuoHc4KtqglffzBoVeT/ZfLkkfReNrUn7+5Z9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903854; c=relaxed/simple;
	bh=54ewS7MXlW5cu7Xc8QyCMHafSN6OIUUti+mLK17lQT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwowdUCwogVoaBy9YG+dh+UVv4txykzU2CY+GqfwIKeA1nhCOt+ak4z3Lf0AdkrZuRYjA19irfsVa0QIt+FWqhFMBMpgCZ+j6t+AbNQJFzXbPf0IjrZWpzy5XRekN+2j5+AT/aVzp3nghwDrHa2cIXGJJOe4XqiZu0s+ExJ9b5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVrmt1yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C131C4CED3;
	Sun, 26 Jan 2025 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903854;
	bh=54ewS7MXlW5cu7Xc8QyCMHafSN6OIUUti+mLK17lQT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVrmt1yhlrrbWUeoiTnNtF7n3aXGyVHS9/tJnUYC5HSbDeCuKF3djNBitcNsS5A0x
	 hcF4s3zJPa0oXirgO2IC5krK9VOmCCCdNZvoArm8ZhscODE9N+RpvPtjE9fPLojLAM
	 KZjkFNNK6P8eu3nLLqyrNFizseUkgxnuqKFayYWE+9UgjPJvLuGKGQBblhrkBd+6H0
	 RP6zWjufERfmoVMTmV97wwcQvk3iJIVxy91zJIvwA63QjP/ett0S63D3WpCAHk4k2+
	 5ARRE+t54ZseWM2oXxKWkllkYgyAKYNKQxmPEiPPiZvXkXuwCjzu6m2oNrjGaK8av+
	 IHyLsX23e4A/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20D=C3=B6singer?= <stefan@codeweavers.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jacobe.zang@wesion.com,
	vassilisamir@gmail.com,
	knaerzche@gmail.com,
	bartosz.golaszewski@linaro.org,
	javier.carrasco.cruz@gmail.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 6.1 09/17] wifi: brcmfmac: Check the return value of of_property_read_string_index()
Date: Sun, 26 Jan 2025 10:03:45 -0500
Message-Id: <20250126150353.957794-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Stefan Dösinger <stefan@codeweavers.com>

[ Upstream commit 082d9e263af8de68f0c34f67b251818205160f6e ]

Somewhen between 6.10 and 6.11 the driver started to crash on my
MacBookPro14,3. The property doesn't exist and 'tmp' remains
uninitialized, so we pass a random pointer to devm_kstrdup().

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

Signed-off-by: Stefan Dösinger <stefan@codeweavers.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20250106170958.3595-1-stefan@codeweavers.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index 0eb852896322b..f117c90c53f59 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -89,13 +89,13 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
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
 			return;
-- 
2.39.5


