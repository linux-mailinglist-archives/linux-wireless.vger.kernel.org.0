Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCC25213F6
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 13:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiEJLmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbiEJLmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 07:42:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E169024EA05
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 04:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=2NUwKdWxlXikya1VHYEeFxyXnb6Hr+Uk5K2abp+wGkM=; t=1652182685; x=1653392285; 
        b=qdTXkEw5a6AYX4EOKOrr1nBr2NRa3ZBiQSW27uJOZ19zyTnVtJOKeCAVu0zZTTE/+zbaxi4z9PK
        vKjyj7zSpmaFpm7rcrnHnPXAxQe+5+yrleenaVcP2/U4salP0D/7bH3/nPYaktZ3+fyKjWiGWejoZ
        x9TKpTvezJuUrv40A/FcUatkUo6QkFy6tsfyB/EBJwHj3+iI0O9dJBs69X97KMKMLBifoixuGS39s
        Su/+l4oeP/CCmaVvcI5C1TKH00bEkg2w+IuzDff/f9ONuwBcqX4yvvYlsFYssxunKXWnAf8Cg2EJJ
        srAiVoA0am49jWbDHf/hKgJIbXCcMg7H/+xA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1noOBl-007mQA-HM;
        Tue, 10 May 2022 13:38:01 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix typo in documentation
Date:   Tue, 10 May 2022 13:37:59 +0200
Message-Id: <20220510133758.835716aa58d5.Ifddc266006a49d6cbb1eee183634ab295356ff94@changeid>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is called offload_flags, remove the extra 'a'.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 75880fc70700..7b74c695a83a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1701,7 +1701,7 @@ enum ieee80211_offload_flags {
  *	these need to be set (or cleared) when the interface is added
  *	or, if supported by the driver, the interface type is changed
  *	at runtime, mac80211 will never touch this field
- * @offloaad_flags: hardware offload capabilities/flags for this interface.
+ * @offload_flags: hardware offload capabilities/flags for this interface.
  *	These are initialized by mac80211 before calling .add_interface,
  *	.change_interface or .update_vif_offload and updated by the driver
  *	within these ops, based on supported features or runtime change
-- 
2.35.3

