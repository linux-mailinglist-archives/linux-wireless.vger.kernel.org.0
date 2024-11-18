Return-Path: <linux-wireless+bounces-15455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E829D110E
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C287281826
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA92192D97;
	Mon, 18 Nov 2024 12:56:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F2190468
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934609; cv=none; b=szGXPCBrCoesFuVBcZf0TD47heS+TFEhjen4r4MVZqHRKaHKnGzY/o7tjbgce1CxsLjBrJQ1CfwQ6otviiARw4I3AtNGOli4D36RHsd1zIkvwcBxVANCr5QQsiu6cjPdUOKNbdZ3s1XL58LH9RmsiJMiIp31jM+XXFAFQ9JFtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934609; c=relaxed/simple;
	bh=RPkYuwAuYmcUE2Sot64WGa+gZU3SnYD1gpVILDXJF+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIAR88fg2UizC9R8fl/HmoFHFb7DfqHg+ZawjzPMy5T3TKkS6u2I6Gd7gqDdW3WH3BYjjmSx6ORxGxPQj9Ze2zm0IhjVdN7OA8bE86zi6VMc5ePQ9R9Ms+t3wwd3xeKlIbnT29F+hJgFg8av0pDJUqP1rbb5uxLaQMx14LLKcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from localhost (p200300c597316B90000000000000032b.dip0.t-ipconnect.de [IPv6:2003:c5:9731:6b90::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BA5D9FA132;
	Mon, 18 Nov 2024 13:56:42 +0100 (CET)
From: Issam Hamdi <ih@simonwunderlich.de>
To: ih@simonwunderlich.de
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	mathias.kretschmer@fit.fraunhofer.de,
	sw@simonwunderlich.de
Subject: [PATCH v2] wifi: mac80211: fix mbss changed flags corruption on 32 bit systems
Date: Mon, 18 Nov 2024 13:56:40 +0100
Message-Id: <20241118125640.1110502-1-ih@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241104172415.3790038-1-ih@simonwunderlich.de>
References: <20241104172415.3790038-1-ih@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit systems, the size of an unsigned long is 4 bytes,
while a u64 is 8 bytes. Therefore, when using
or_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE),
the code is incorrectly searching for a bit in a 32-bit
variable that is expected to be 64 bits in size,
leading to incorrect bit finding.

Solution: Ensure that the size of the bits variable is correctly
adjusted for each architecture by use BITMAP_FROM_U64().

 Call Trace:
  ? show_regs+0x54/0x58
  ? __warn+0x6b/0xd4
  ? ieee80211_link_info_change_notify+0xcc/0xd4 [mac80211]
  ? report_bug+0x113/0x150
  ? exc_overflow+0x30/0x30
  ? handle_bug+0x27/0x44
  ? exc_invalid_op+0x18/0x50
  ? handle_exception+0xf6/0xf6
  ? exc_overflow+0x30/0x30
  ? ieee80211_link_info_change_notify+0xcc/0xd4 [mac80211]
  ? exc_overflow+0x30/0x30
  ? ieee80211_link_info_change_notify+0xcc/0xd4 [mac80211]
  ? ieee80211_mesh_work+0xff/0x260 [mac80211]
  ? cfg80211_wiphy_work+0x72/0x98 [cfg80211]
  ? process_one_work+0xf1/0x1fc
  ? worker_thread+0x2c0/0x3b4
  ? kthread+0xc7/0xf0
  ? mod_delayed_work_on+0x4c/0x4c
  ? kthread_complete_and_exit+0x14/0x14
  ? ret_from_fork+0x24/0x38
  ? kthread_complete_and_exit+0x14/0x14
  ? ret_from_fork_asm+0xf/0x14
  ? entry_INT80_32+0xf0/0xf0

Reported-by: Kretschmer Mathias <mathias.kretschmer@fit.fraunhofer.de>
Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
---
Changes in v2:
- Use BITMAP_FROM_U64() to map all the 64 bits.
- Update the commit description.
---
 net/mac80211/mesh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index cb5f16366b9c..e420eb4797a8 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1157,14 +1157,14 @@ void ieee80211_mbss_info_change_notify(struct ieee80211_sub_if_data *sdata,
 				       u64 changed)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
-	unsigned long bits = changed;
+	unsigned long bits[] = { BITMAP_FROM_U64(changed) };
 	u32 bit;
 
 	if (!bits)
 		return;
 
 	/* if we race with running work, worst case this work becomes a noop */
-	for_each_set_bit(bit, &bits, sizeof(changed) * BITS_PER_BYTE)
+	for_each_set_bit(bit, bits, sizeof(changed) * BITS_PER_BYTE)
 		set_bit(bit, ifmsh->mbss_changed);
 	set_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags);
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);

base-commit: dfc14664794a4706e0c2186a0c082386e6b14c4d
-- 
2.39.2


