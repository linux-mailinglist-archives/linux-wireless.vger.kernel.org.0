Return-Path: <linux-wireless+bounces-614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8380BFE2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 04:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356931F20CCB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1615E8B;
	Mon, 11 Dec 2023 03:30:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B38FE9;
	Sun, 10 Dec 2023 19:30:47 -0800 (PST)
X-UUID: 8c610b21d4dd43e78e60a6bfbc3acfb6-20231211
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:11677d22-57f1-4fa4-b5f8-bee90eef913c,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:11677d22-57f1-4fa4-b5f8-bee90eef913c,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:b30405bd-2ac7-4da2-9f94-677a477649d9,B
	ulkID:231211113033ZT95PL27,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: 8c610b21d4dd43e78e60a6bfbc3acfb6-20231211
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 278654567; Mon, 11 Dec 2023 11:30:31 +0800
From: Kunwu Chan <chentao@kylinos.cn>
To: stf_xl@wp.pl,
	kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Kunwu Chan <kunwu.chan@hotmail.com>
Subject: [PATCH] iwlegacy: Add null pointer check to il_leds_init
Date: Mon, 11 Dec 2023 11:30:19 +0800
Message-Id: <20231211033019.238149-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 054fef680aba..17570d62c896 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -541,6 +541,9 @@ il_leds_init(struct il_priv *il)
 
 	il->led.name =
 	    kasprintf(GFP_KERNEL, "%s-led", wiphy_name(il->hw->wiphy));
+	if (!il->led.name)
+		return;
+
 	il->led.brightness_set = il_led_brightness_set;
 	il->led.blink_set = il_led_blink_set;
 	il->led.max_brightness = 1;
-- 
2.39.2


