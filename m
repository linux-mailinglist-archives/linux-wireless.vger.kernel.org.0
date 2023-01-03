Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7176D65C154
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 14:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbjACN41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 08:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbjACN40 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 08:56:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104FD2EF
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 05:56:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CD8361290
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 13:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78961C433D2;
        Tue,  3 Jan 2023 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672754184;
        bh=fEOl+OM0Xl1eH2Ye987QUe5q8B/8P/xX5wh5r/X92so=;
        h=From:To:Cc:Subject:Date:From;
        b=dn4nk++GlWRlQXQd+LyKkw5qTG2dvqUXfwIflCNMCxgo7Z1EuIsC5vJcWtr46ZFbE
         PtWHKY0rJaAxCzWtT7CAWolWADxT0DCPcM8ainoLQD6Nq6M7lolZF7jOzprkul62h7
         hcbmpVbcZttorxftWj2pLpBbPjtl+ZK9Pcba3UmQNev8v6dg88WmaQNOqFXyRdVGoX
         3wSgmkt2jJZ5/Tq1XNqLlMv1x8o27sCfBjZBuKgtrZnE1Anyaiu9xqanmuBPOEn4H0
         38Q744vuY87U815lzi7gNHK2kigNlHFstYIjS+ljt+R2KEQUAvYDLMO1q66KzqjtFr
         9Vd5Xl/53cqBQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: fix switch default case in mt7996_reverse_frag0_hdr_trans
Date:   Tue,  3 Jan 2023 14:56:19 +0100
Message-Id: <6b0edfcb0d34a233a243f3817fbf98550ffb73df.1672754107.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The switch default case for frame_contorl is invalid. Return -EINVAL
error for it.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0b3e28748e76..e198ab006c46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -469,7 +469,7 @@ static int mt7996_reverse_frag0_hdr_trans(struct sk_buff *skb, u16 hdr_gap)
 		ether_addr_copy(hdr.addr4, eth_hdr->h_source);
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	skb_pull(skb, hdr_gap + sizeof(struct ethhdr) - 2);
-- 
2.39.0

