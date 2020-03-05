Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2017A716
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEOEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:04:16 -0500
Received: from mailext.lri.fr ([129.175.15.10]:48382 "HELO mailext.lri.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726204AbgCEOEQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:04:16 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 09:04:15 EST
Received: from [129.175.15.10] (mailext.lri.fr [129.175.15.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailext.lri.fr (Postfix) with ESMTPSA id B41D7C0FAD;
        Thu,  5 Mar 2020 15:04:14 +0100 (CET)
From:   Nicolas Cavallari <cavallar@lri.fr>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
Subject: [PATCH] mac80211: Do not send mesh HWMP PREQ if HWMP is disabled
Date:   Thu,  5 Mar 2020 15:04:09 +0100
Message-Id: <20200305140409.12204-1-cavallar@lri.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>

When trying to transmit to an unknown destination, the mesh code would
unconditionally transmit a HWMP PREQ even if HWMP is not the current
path selection algorithm.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.=
fr>
---
 net/mac80211/mesh_hwmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index d69983370381..38a0383dfbcf 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1152,7 +1152,8 @@ int mesh_nexthop_resolve(struct ieee80211_sub_if_da=
ta *sdata,
 		}
 	}
=20
-	if (!(mpath->flags & MESH_PATH_RESOLVING))
+	if (!(mpath->flags & MESH_PATH_RESOLVING) &&
+	    mesh_path_sel_is_hwmp(sdata))
 		mesh_queue_preq(mpath, PREQ_Q_F_START);
=20
 	if (skb_queue_len(&mpath->frame_queue) >=3D MESH_FRAME_QUEUE_LEN)
--=20
2.25.1

