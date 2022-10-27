Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01560F9FA
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Oct 2022 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiJ0OC3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Oct 2022 10:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiJ0OC2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Oct 2022 10:02:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626718024D
        for <linux-wireless@vger.kernel.org>; Thu, 27 Oct 2022 07:02:25 -0700 (PDT)
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis)
 id 1M5wgF-1ohBZc1JO7-007Sk9; Thu, 27 Oct 2022 16:02:23 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Fix ack frame idr leak when mesh has no route
Date:   Thu, 27 Oct 2022 16:01:33 +0200
Message-Id: <20221027140133.1504-1-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XmCcPyxi5aQ56UzM7bH9cqRAAkX8eEZWiqC57yfu3xobouCQkkb
 z60/l8YcxCvuI1kTC98zMz/wcvADBodO1cO1ppVHKYL4jlRX8zTJDmW1xPXByjyGRQYAI1f
 owzUFjDD7rJjrQWjZHPzocmeZ81ByOcwqwC4KCBMd4TcDXcTPLbfQpctwHteMKpBWzcHMW2
 2DfDwMNlhG8UV1nCeEe1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kDay+5m5ejo=:o2HIzaU/xrhjR9uQVsAB19
 X5C9IU9DL1xYKDMHZDpT0AHSwGJgxnOTKE0kXLa3nOBHUngPeC4fNobWXonROnQmfO+i6zF6E
 6x/BJ0mFnAbxGButTTb52aMW7g4bz82Uy2ZAXQyKEYjOoziK+ZA6+3x6uVZoJVo5IPGZuAwt8
 rH7zL27Qw0U/G94WuHwJaOJJc8pN6Lkj7h9bPOdXfAmDnlFLFVdFkBXZEZ9P//kLp5KBL644i
 3/Wga/SN9jIFsRieCrH6vdIabgOT36DmkQgpmcJ9ZPpKWBHBiB1lQl3JR1UoJ14dkvXoOQYH9
 sFaJYOCfDuiOrcOJunpfi9MzCeMuzZCqyf+waOvl7wBlDF9RwopLVngbqOkSClhsyJNhKHxCT
 A2n6T9UtL8I5MK+y2Gezo8LcfPPtBRH76MLmrtl2ICxGrwiEiGaCeS0Q0eaIy36ty0vHpeENJ
 nLJ+kfRKWjXLilHt52y7o+8U9Rj+1zX+Zya/KsGdGTX5p5LAVvjdW7buVbgSpXJb+BJzDPorQ
 wjlNwHxVej4zgXS/dnWVSQ5N+VVrWZDoSSp7S9mdgYRnRrg7DizixGAh4aNPxKkJmUNrw7EAH
 B5FsIAIsIU9FggyXW5wwI5zFEPfGjoMJNQauXDQUylHR2tlOXB5W++42QPQd4AQzi+D1MvLF5
 j+VJv4Onls841Fs6UTynEofbNparPLM6Nmf/KHyaqyUZK5JTFQo6n3egVa83KdC6/bc7AE6ko
 Jq52iWlKSYC8qwHN860uf5UMU809520VmIj9+VBnes55Rccl8KWjePQr3FEEuxqLAUzEulcNU
 7Dkyx7KOVfeYuF6oiuMSQqRme9+rMg6MitQnLTUkmBwhFENo3A=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When trying to transmit an data frame with tx_status to a destination
that have no route in the mesh, then it is dropped without recrediting
the ack_status_frames idr.

Once it is exhausted, wpa_supplicant starts failing to do SAE with
NL80211_CMD_FRAME and logs "nl80211: Frame command failed".

Use ieee80211_free_txskb() instead of kfree_skb() to fix it.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 net/mac80211/mesh_pathtbl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index acc1c299f1ae..69d5e1ec6ede 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -710,7 +710,7 @@ int mesh_path_send_to_gates(struct mesh_path *mpath)
 void mesh_path_discard_frame(struct ieee80211_sub_if_data *sdata,
 			     struct sk_buff *skb)
 {
-	kfree_skb(skb);
+	ieee80211_free_txskb(&sdata->local->hw, skb);
 	sdata->u.mesh.mshstats.dropped_frames_no_route++;
 }
 
-- 
2.37.2

