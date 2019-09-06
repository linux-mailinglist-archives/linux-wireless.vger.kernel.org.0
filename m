Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAFAB0E0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 05:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390383AbfIFDQA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 23:16:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731938AbfIFDQA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 23:16:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A5026118E; Fri,  6 Sep 2019 03:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567739759;
        bh=fbZ6GfxpdsYubTQ+S4gE+qpQBlzZ06Oz5GzqpfkMQ0k=;
        h=From:To:Cc:Subject:Date:From;
        b=l+VIo1ifWU1nHTh4py/NapCexPEF2SGuGVax3x8R38WfyKRYQ7+dO1XU/jI369zSu
         rY5U6KAWnOghZe9gGSC11ogKjKpnVWfGJktenwQYJScKSaaDBu+WVjlnFMZVKZGvxR
         nwh2gk61Yt6bJJ2yQ00KKPKQO/yb+C8NVp9nhNIo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A38D60E75;
        Fri,  6 Sep 2019 03:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567739758;
        bh=fbZ6GfxpdsYubTQ+S4gE+qpQBlzZ06Oz5GzqpfkMQ0k=;
        h=From:To:Cc:Subject:Date:From;
        b=VHuQ6T3PWdKiSM9xIxhhvUPIK4l5BR+lkM5jZqCFvuSyHLqUlYIfSMgxO3jthgT6w
         vYtsfHo5q3xGLPLidd85O0DKNWW94S0jdmmpGdAYR+rJ076ekEAdTJtKHb2JGVDef0
         0PJJAtYWshc9AsLXdDlNmOudQd9p4Fyi78qq3a3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A38D60E75
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>
Subject: [RFC] cfg80211: Allow self managed devices to update global regulatory
Date:   Fri,  6 Sep 2019 08:45:33 +0530
Message-Id: <1567739733-18852-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, self managed drivers cannot update the global regulatory
using a regulatory hint from driver if the wiphy regd is already set
from other sources.
Due to this, when a regulatory hint is provided to cfg80211 from
self managed devices, the request gets ignored and global reg is
always at default, i.e World reg, DFS-UNSET.
Hence in such systems, the result of 'iw reg get' does not indicate a
valid global regd.

Hence, Allow setting the cfg80211 global regulatory when it is unset
and the requestor is a self managed device. At the same time, do not
propagate these hints to other devices in the system.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
 net/wireless/reg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 646107a..86c4460 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3550,6 +3550,20 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
 	if (!request_wiphy)
 		return -ENODEV;
 
+	/* Update cfg80211 regdomain only if it's unset, in case a hint
+	 * is received from self managed wiphy. Ignore all other
+	 * processing from self managed wiphy's. Return EALREADY to avoid
+	 * updating other drivers.
+	 */
+	if (request_wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) {
+		regd = get_cfg80211_regdom();
+
+		if (regd == cfg80211_world_regdom) {
+			reset_regdomains(false, rd);
+		}
+		return -EALREADY;
+	}
+
 	if (!driver_request->intersect) {
 		if (request_wiphy->regd)
 			return -EALREADY;
-- 
2.7.4

