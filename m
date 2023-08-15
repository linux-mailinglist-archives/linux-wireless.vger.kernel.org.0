Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E298377CF9B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238319AbjHOPvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Aug 2023 11:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbjHOPvU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Aug 2023 11:51:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F010DC
        for <linux-wireless@vger.kernel.org>; Tue, 15 Aug 2023 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=5n2NHR6OPt3ArsLyQmX3wvQj2kEy7i+y0qn1a74P3/w=; t=1692114680; x=1693324280; 
        b=J6rfayJFZmH1QeAVan8OZCOkLGE9f4i3D0BPYc836qd5PdfiuOKj4g5TlAflyje9tiB232LyeAa
        B0/qpZGMY5HZudZ8nohSk5rcErNi+dVIdFx0CyfaMZC8IpsYLMuX3axqneTCdKoWNsO0NSxsW7t6u
        qdSjTk0oAhWj1AFyGS2bgUoaZEr44v9XRWxuDv92bazE0QtBwGoTTD6+STxM5fTMsceHbIF2lUpiV
        chFdibU7EBptZ8bLkUDVwbs+vhlFk7oeh6S81n9exKrxtdqBb7Zczs7EFwimEYEYbFgg9HN0VsDbR
        8OnSFQbhvFA7Em9PryA313Rb4hxl0W76hJJA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVwKD-0090Fa-1e;
        Tue, 15 Aug 2023 17:51:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: check S1G action frame size
Date:   Tue, 15 Aug 2023 17:51:05 +0200
Message-ID: <20230815175103.aaed17e98e4b.Iac98e14c90b454f910fd2807dad8b87f6eb169d4@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Before checking the action code, check that it even
exists in the frame.

Reported-by: syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 4f707d2a160f..33f9764b94de 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3732,6 +3732,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		goto queue;
 	case WLAN_CATEGORY_S1G:
+		if (len < offsetofend(typeof(*mgmt),
+				      u.action.u.s1g.action_code))
+			break;
+
 		switch (mgmt->u.action.u.s1g.action_code) {
 		case WLAN_S1G_TWT_SETUP:
 		case WLAN_S1G_TWT_TEARDOWN:
-- 
2.41.0

