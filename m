Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615AA44EB98
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 17:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhKLQxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 11:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234342AbhKLQxf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 11:53:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3D6060F70;
        Fri, 12 Nov 2021 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636735844;
        bh=VACVVKnGxgphTCRixT/BnWjzWhrJ8Z5s45QMTTcmOqc=;
        h=From:To:Cc:Subject:Date:From;
        b=D7n9KlgQY5GGccmQv/CEJ9+NY0t5Gz/y5Qu2rPbwGSd+hi9M74rohvqd7EqGC5qPM
         QJpMoG8dG5U2QNm433ksPkVEKFx5dMF1kP+45sqqjkDPhLRBaYPh4Uw77G+3j7xckx
         p/9atF7lJ+/IFuzzENzqipOmAYkIIxXI+ZEbS4kN91ijCEZwHMQEtqz01aLEufJwZk
         86msvJrO/Yjh/Azy9odjAyKsohcykovOYYr77pymXG3OTYv5YVhDEQX+SUFegOaDlW
         DXbl41o1PAy+UR87nACPNTFPJi8MJPUVDnhJ9tsTiijvIQy5I2h476+rI75u/3Aubj
         mBSyJzD5eTKzg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com
Subject: [PATCH] iw: event: report missing radar events
Date:   Fri, 12 Nov 2021 17:50:34 +0100
Message-Id: <6a7cd7bd2179578335cc95b158faf21ba3f7876a.1636730634.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly report the two following radar events:
- NL80211_RADAR_PRE_CAC_EXPIRED
- NL80211_RADAR_CAC_STARTED

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/event.c b/event.c
index e0908dd..ad29189 100644
--- a/event.c
+++ b/event.c
@@ -1233,6 +1233,12 @@ static int print_event(struct nl_msg *msg, void *arg)
 		case NL80211_RADAR_NOP_FINISHED:
 			printf("%d MHz: NOP finished\n", freq);
 			break;
+		case NL80211_RADAR_PRE_CAC_EXPIRED:
+			printf("%d MHz: PRE-CAC expired\n", freq);
+			break;
+		case NL80211_RADAR_CAC_STARTED:
+			printf("%d MHz: CAC started\n", freq);
+			break;
 		default:
 			printf("%d MHz: unknown radar event\n", freq);
 		}
-- 
2.31.1

