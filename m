Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C40ECD90
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2019 07:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKBGPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Nov 2019 02:15:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBGPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Nov 2019 02:15:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ED3661491; Sat,  2 Nov 2019 06:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572675348;
        bh=VSiu+SKKR/LfB4YYkM/KMfac6Q2L11t3g5xh8LmBJhY=;
        h=From:To:Cc:Subject:Date:From;
        b=gxjxRxbg2quh2wsHiNFvsl0OdxXiSwqzKpL0WFHA7OMsPoKCaZKvIxAaRHTcOzzMC
         7Qn006NdcZMSJ9L0U5pRECM2TeM6nz6hKdV+PXFWuQZZAZuNkqiiyZ5MTPJBsYLIj4
         Utwz0yQUS+7A5qHvteYV7C/xDrUfDlBT59C/322c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from akolli-ThinkPad-L560.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F612612E6;
        Sat,  2 Nov 2019 06:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572675347;
        bh=VSiu+SKKR/LfB4YYkM/KMfac6Q2L11t3g5xh8LmBJhY=;
        h=From:To:Cc:Subject:Date:From;
        b=WfOWs2jOR6jzDGtNoJU3FsW9i02qTo9hU0yV6zUsVG5TTHYDshe5nd7NUo+FFrdCq
         +7Cf3awfoaNBlcZkrytZ+ELT7bq62QMkEBjBD3yjF0pHq+tjfTfXWuq+DrR5WA3P5f
         3LBkwZP7pUjGk7wCHM0KWr7S1el/G+VcpB7WBQ0U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F612612E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] nl80211: Add proper NL type for NL80211_ATTR_MPATH_NEXT_HOP
Date:   Sat,  2 Nov 2019 11:45:49 +0530
Message-Id: <1572675349-31733-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Assign NL type as NLA_EXACT_LEN_WARN and len as ETH_AELN
for NL80211_ATTR_MPATH_NEXT_HOP attribute to avoid
NL warning message like below during mpath set command.

"netlink: 'iw': attribute type 26 has an invalid length."

There is no functionality issue due to this warning message.

Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
---
 net/wireless/nl80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d1451e7..1b51b59 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -393,7 +393,7 @@ static int validate_ie_attr(const struct nlattr *attr,
 	[NL80211_ATTR_MNTR_FLAGS] = { /* NLA_NESTED can't be empty */ },
 	[NL80211_ATTR_MESH_ID] = { .type = NLA_BINARY,
 				   .len = IEEE80211_MAX_MESH_ID_LEN },
-	[NL80211_ATTR_MPATH_NEXT_HOP] = { .type = NLA_U32 },
+	[NL80211_ATTR_MPATH_NEXT_HOP] = NLA_POLICY_ETH_ADDR,
 
 	[NL80211_ATTR_REG_ALPHA2] = { .type = NLA_STRING, .len = 2 },
 	[NL80211_ATTR_REG_RULES] = { .type = NLA_NESTED },
-- 
1.7.9.5

