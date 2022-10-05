Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9603F5F54E7
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJENB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJENA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A39A1D0E3
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2TAa8j0qrDw6tMJ6oZmo+IquULME6WO2a+91Cw6lz54=;
        t=1664974857; x=1666184457; b=bAtjrd6ByCfFMXLd2NOpf3cIuoiatGZhEmq2QYlbjopK6cx
        S3Pl2Kcs9OHrTJryxwSi2GmDzBJdcC2kIEFuSZw0uzIYSJ+npfJXRXLJFuOApfy90DI4WH9CaS5lH
        aqqNwnPtNeiMLeZkFn9abdeLwB9GTSWUR4KRjljoedxNVTjcKXisCVvoo/dd8Trvz1oPx2h+fgK6O
        Yih/Z2kRkomWfFB378lvGXSE2+UuE1IF/nb0Fc4MElbaX9+czBWpvbssXp3OXVVC5uZ2R6hYrpTR8
        66IGa4qDJimLxrXz40KvjRc3/INEGqT5uDqPKFyPIXNP3ov6W6NEbTH9pvxUpszg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og419-00G2RL-17;
        Wed, 05 Oct 2022 15:00:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/28] wifi: fix multi-link element subelement iteration
Date:   Wed,  5 Oct 2022 15:00:39 +0200
Message-Id: <20221005145226.1c962d927d1b.I0e8ed4861b89687a8d35c093a40e1df2a3436d59@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The subelements obviously start after the common data, including
the common multi-link element structure definition itself. This
bug was possibly just hidden by the higher bits of the control
being set to 0, so the iteration just found one bogus element
and most of the code could continue anyway.

Fixes: 0f48b8b88aa9 ("wifi: ieee80211: add definitions for multi-link element")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index f51e939f28f2..6252f02f38b7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4593,7 +4593,7 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
 		return 0;
 	}
 
-	return common + mle->variable[0];
+	return sizeof(*mle) + common + mle->variable[0];
 }
 
 /**
-- 
2.37.3

