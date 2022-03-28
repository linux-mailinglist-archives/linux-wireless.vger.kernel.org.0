Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE254E9196
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 11:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiC1JmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbiC1JmP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 05:42:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B15140F0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=+zXzGF046wp9JjSQlaZ5f5o/UnUaSCWPOX6JCReI31Q=; t=1648460435; x=1649670035; 
        b=A7ChRzG1fir7SEHjuSC1Yxo3tB9/Csh0qkH/v1dokNlhqISh89ony90O7gRGhskK1u3MHWMS0sM
        d1hzcMlnICpdZJjHNPH/zzPhX0cMjBB4vpa08XBo6po4+QQReWbQrmkk0WgfLRvh/LI+iVbFa2f7Y
        vl6friUA9FhnJdW2xmVfcBOkDt4lGaqw4/46RPKclzi3hcytgD8/MRtWupXW00BaYa3m75kjQSqHP
        0/71rvoNer3FolyfbJ4n1f2dxlzFdNVKgLsTgRkdX55JZwbX7NR6ahNPjFpkuqk8S1V1XJig5kvv3
        L015CKYdoHEsVj7J0pXaV5X3g9XlrMKhUuEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nYlrV-001Wgh-0s;
        Mon, 28 Mar 2022 11:40:33 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] MAINTAINERS: claim include/uapi/linux/wireless.h
Date:   Mon, 28 Mar 2022 11:40:30 +0200
Message-Id: <20220328114029.526fbb42784d.If7c79b4ca827dfe82a545689f2d31fcedabd8387@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As much as I don't really want to maintain this legacy
cruft that we started replacing 15+ years ago, for now
it still falls on me to take care of it. Add a missing
file to the list.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 949d0b49a0bd..9c906044c5b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -201,6 +201,7 @@ F:	include/net/ieee80211_radiotap.h
 F:	include/net/iw_handler.h
 F:	include/net/wext.h
 F:	include/uapi/linux/nl80211.h
+F:	include/uapi/linux/wireless.h
 F:	net/wireless/
 
 8169 10/100/1000 GIGABIT ETHERNET DRIVER
-- 
2.35.1

