Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E381DAF28
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETJrb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 05:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETJrb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 05:47:31 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973F9207FB;
        Wed, 20 May 2020 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589968050;
        bh=DmOukLQtSNcLqnEhwI/0eK3pCZTEz+3wudy8LG/iqt8=;
        h=From:To:Cc:Subject:Date:From;
        b=Po68wnvt2gcS7Q1IlIloajYasVWF5CfBMukTz0d9J3fKCWi4iu7d2cSQVaxtjqQvG
         iLow79GqOBwtSlEx8FoDUL3WjUVdPArEUS3TGc1k+4R4z7tmvi1bqs0LZTLIhhddMi
         GrdxSnPCtsVclD1ofd5R53ydzPBgkngeNsF/a4XY=
Received: by pali.im (Postfix)
        id 4FB0165A; Wed, 20 May 2020 11:47:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH] iw: Print limit for maximum associated stations in AP mode
Date:   Wed, 20 May 2020 11:47:01 +0200
Message-Id: <20200520094701.10791-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/info.c b/info.c
index 9147b92..8062629 100644
--- a/info.c
+++ b/info.c
@@ -723,6 +723,10 @@ broken_combination:
 			pat->max_pattern_len, pat->max_pkt_offset, rule->max_delay);
 	}
 
+	if (tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA])
+		printf("\tMaximum associated stations in AP mode: %u\n",
+		       nla_get_u16(tb_msg[NL80211_ATTR_MAX_AP_ASSOC_STA]));
+
 	return NL_SKIP;
 }
 
-- 
2.20.1

