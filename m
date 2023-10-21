Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3317C7D1DF8
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Oct 2023 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjJUPsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Oct 2023 11:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPsj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Oct 2023 11:48:39 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8D135
        for <linux-wireless@vger.kernel.org>; Sat, 21 Oct 2023 08:48:35 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A5E4BC4005D
        for <linux-wireless@vger.kernel.org>; Sat, 21 Oct 2023 15:48:33 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 135B013C2B0;
        Sat, 21 Oct 2023 08:48:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 135B013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1697903313;
        bh=bQSguloIhJ24I1AK7EnMYfTF5biL+kIyn8Rmpab0mkc=;
        h=From:To:Cc:Subject:Date:From;
        b=mDXQk+zjiXiWDe1PTe9BXWNmVTQ1zpXXCLWS8jIyqEeiUsdd+R6KRVYe4pwJzZCe8
         s2AtmCnC61mWF5b60RckehD3mlhPyK/Ma8BEhOfGTs/uXgz7jgD+81ngGqZpKDfpxZ
         kI4QYv57Xd/2nyD7GhbKJXRG7p++LAR40PHupriM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: wireless:  Fix bad memory passed in inform_single_bss_data.
Date:   Sat, 21 Oct 2023 08:48:27 -0700
Message-Id: <20231021154827.1142734-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1697903314-YN1PqJ5r4uRI
X-MDID-O: us5;ut7;1697903314;YN1PqJ5r4uRI;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The sins of similar variable names and passing void pointers
are seen again in wireless-next tree.

Wrong data was passed into the rdev_inform_bss method causing
crashes.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 7f8e831ef1dc..52b048675cc7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2155,7 +2155,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	if (!res)
 		goto drop;
 
-	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
+	rdev_inform_bss(rdev, &res->pub, ies, drv_data->drv_data);
 
 	if (data->bss_source == BSS_SOURCE_MBSSID) {
 		/* this is a nontransmitting bss, we need to add it to
-- 
2.40.0

