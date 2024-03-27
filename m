Return-Path: <linux-wireless+bounces-5307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893888D31E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 01:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA2CB2212B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774F7FF;
	Wed, 27 Mar 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Hbr6mnwr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB547256A
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711498303; cv=none; b=Ex9+4AHl6trUWKINs6PHQwlfuBq7VTCFd0Do5HzXPURPaaUSDqaTAuSEZhq6a9aQu1vRaFVOYR0lXArQNehUyKBA76aBaMDy7NYoU13PiY/qe2nuXVhPRkFBbff17LqTHjmuHwl7jIRJ3415lhz8SJJaPP3LVVtEQsEwZf+JP2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711498303; c=relaxed/simple;
	bh=aHfUkbE1Nh8MIhvR0Whj/I7tck7oiDgznWXaL2pGFfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPQM47QxRjN+WDqlGPUqjkNiyPAzFxtseuMS7ycwwDH5LH+nn4aVqP8E6MbmyjQpbmuEpayYhjZXXy9QWVi24DY8rZnH39m+UY9vtPaq7ME3nVGejqADKWOzllLaW03gQrGJhF9ZPLxzs+6rWfDd30VdDm+cOmnxGFyTxrLtudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Hbr6mnwr; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 57ABA24006B
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 00:11:34 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 89B2613C2B0;
	Tue, 26 Mar 2024 17:11:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 89B2613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711498293;
	bh=aHfUkbE1Nh8MIhvR0Whj/I7tck7oiDgznWXaL2pGFfY=;
	h=From:To:Cc:Subject:Date:From;
	b=Hbr6mnwrAAF8SO4gRgCPR0y8XNSnb5wkzeSSXHvgwkCWRRk9JeqgQP2yabE1Ebfft
	 SdRo6QiUPaet0RswYb6H8tX4aUpSejUw0GrBoH8w2If/dlAmNDSw5QkYA3koud0amX
	 XVC9KYWtznlHTUyRR8gAs3c5C3EXaaynpyaJrdcQ=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mt76: mt7915:  Emulate chanctx methods.
Date: Tue, 26 Mar 2024 17:11:31 -0700
Message-ID: <20240327001131.4028431-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1711498295-64PO0GQOac79
X-MDID-O:
 us5;at1;1711498295;64PO0GQOac79;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Looks like this was missed in the initial patch that made
the conversion to the emulated chanctx drivers.

Fixes: commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a246d11d9811..fadb8e62092c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -2050,6 +2050,10 @@ mt7915_net_fill_forward_path(struct ieee80211_hw *hw,
 #endif
 
 const struct ieee80211_ops mt7915_ops = {
+	.add_chanctx = ieee80211_emulate_add_chanctx,
+	.remove_chanctx = ieee80211_emulate_remove_chanctx,
+	.change_chanctx = ieee80211_emulate_change_chanctx,
+	.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
 	.tx = mt7915_tx,
 	.start = mt7915_start,
 	.stop = mt7915_stop,
-- 
2.42.0


