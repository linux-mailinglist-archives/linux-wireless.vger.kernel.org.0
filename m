Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D2D10D1D5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 08:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfK2HeL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 02:34:11 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:56712
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfK2HeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 02:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575012850;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=rumz662KjdjNJ1SZfQvs+wG/DPl5sQDgKdfpuWgWoRM=;
        b=mnXBBjtzOn5u4uxukLzwgTezf9B0hG7UmSakxRhue0LX6PBuVW5TJz/pp0Q4NoLI
        5YAbRLZcHtS07he5WYDIga/lVXgRvxp9Ah8f5zSKyTD7fFPw01du9sq6T65aCOgOY6u
        xj8v4Fmk04TVsDZfKHvT/kd4Oj2j5pI4cJK0xuQ4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575012850;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=rumz662KjdjNJ1SZfQvs+wG/DPl5sQDgKdfpuWgWoRM=;
        b=PIRllKyrDVd9hJ/lg2tXJtuExmhgte93xQpMQeLSnMSnRIKiXPB8fWWDnIoyShJ0
        ywgRVbKrPqOz+VOq3YlI3a40Fy8kIhv06/uzkkJQ8JJMGXnls4fodwHgRP1PQ/4Z7SV
        QGHvF0jPAra8NMZkF3uDlhIjsao/PfDdGUNxxMMs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FED6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath: add support for special 0x0 regulatory domain
Date:   Fri, 29 Nov 2019 07:34:09 +0000
Message-ID: <0101016eb614d832-1f2459b1-1555-4ce7-8f90-5704d201bc10-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.29-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some sdio chips of rome QCA6174's regulatory domain code of EEPROM is
empty, then ath_is_world_regd will return false for this case, and
it will lead function __ath_reg_dyn_country not work, thus the regdomain
will not update for NL80211_REGDOM_SET_BY_COUNTRY_IE type, it result
ath10k set the same regdomain/reg_5ghz_ctl/reg_2ghz_ctl to firmware,
then the tx power will not changed with different regdomain's AP. The
regulatory domain code of EEPROM of some QCA6174 PCIE chip is 0x6c, it
means world wide regdomain, for this chip, it does not have the issue.

For empty reulatory domain code chip, set it to world regulatory domain
in functio ath_regd_sanitize, then it will fix the issue.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/regd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index 20f4f8ea9f89..bee9110b91f3 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -666,14 +666,14 @@ ath_regd_init_wiphy(struct ath_regulatory *reg,
 
 /*
  * Some users have reported their EEPROM programmed with
- * 0x8000 set, this is not a supported regulatory domain
- * but since we have more than one user with it we need
- * a solution for them. We default to 0x64, which is the
- * default Atheros world regulatory domain.
+ * 0x8000 or 0x0 set, this is not a supported regulatory
+ * domain but since we have more than one user with it we
+ * need a solution for them. We default to 0x64, which is
+ * the default Atheros world regulatory domain.
  */
 static void ath_regd_sanitize(struct ath_regulatory *reg)
 {
-	if (reg->current_rd != COUNTRY_ERD_FLAG)
+	if (reg->current_rd != COUNTRY_ERD_FLAG && reg->current_rd != 0)
 		return;
 	printk(KERN_DEBUG "ath: EEPROM regdomain sanitized\n");
 	reg->current_rd = 0x64;
-- 
2.23.0

