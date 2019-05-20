Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFAD23321
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfETMAy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 08:00:54 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35346 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730727AbfETMAy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 08:00:54 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 69F8C30C088;
        Mon, 20 May 2019 05:00:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 69F8C30C088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558353652;
        bh=bGicLqcp1/dHgg4bDICFA/Z0PBvU7+StOn1XcGfHNdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihc0POf/ohgnzjOxmUXHxI43sclldB50DGoMHIqAqQyxNkgehrDYopTa03wC0gHu0
         NT89gvymCNr1BGQxKl10QA2mRKY35sFyuGX57dwa56PTqc4VFElaXfxWAr3SHYGjTN
         clazXTZUsESh6m7lqhehg/ac0poX6FHni7MraAYc=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id BB99560D77;
        Mon, 20 May 2019 05:00:52 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id EE58FB00F37; Mon, 20 May 2019 14:00:50 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 2/8] cfg80211: add 6GHz UNII band definitions
Date:   Mon, 20 May 2019 14:00:39 +0200
Message-Id: <1558353645-18119-3-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the new 6GHz there are new UNII band definitions as listed
in the FCC notice [1].

[1] https://docs.fcc.gov/public/attachments/FCC-18-147A1_Rcd.pdf

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/reg.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4831ad74..646107a 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3806,8 +3806,9 @@ void wiphy_regulatory_deregister(struct wiphy *wiphy)
 }
 
 /*
- * See http://www.fcc.gov/document/5-ghz-unlicensed-spectrum-unii, for
- * UNII band definitions
+ * See FCC notices for UNII band definitions
+ *  5GHz: https://www.fcc.gov/document/5-ghz-unlicensed-spectrum-unii
+ *  6GHz: https://www.fcc.gov/document/fcc-proposes-more-spectrum-unlicensed-use-0
  */
 int cfg80211_get_unii(int freq)
 {
@@ -3831,6 +3832,22 @@ int cfg80211_get_unii(int freq)
 	if (freq > 5725 && freq <= 5825)
 		return 4;
 
+	/* UNII-5 */
+	if (freq > 5925 && freq <= 6425)
+		return 5;
+
+	/* UNII-6 */
+	if (freq > 6425 && freq <= 6525)
+		return 6;
+
+	/* UNII-7 */
+	if (freq > 6525 && freq <= 6875)
+		return 7;
+
+	/* UNII-8 */
+	if (freq > 6875 && freq <= 7125)
+		return 8;
+
 	return -EINVAL;
 }
 
-- 
1.9.1

