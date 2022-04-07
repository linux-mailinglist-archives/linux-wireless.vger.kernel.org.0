Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4FB4F8B0B
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiDHAAj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiDHAAg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 20:00:36 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6AA15D395
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 16:58:35 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 63FE32005E
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 23:58:33 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3A6243C006D
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 23:58:33 +0000 (UTC)
Received: from v-f30-64.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6707213C2B0;
        Thu,  7 Apr 2022 16:58:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6707213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1649375912;
        bh=8MLdQagpbw4WzvDiPv2GGJpvCs3gfxgDUB0YKiCRPzU=;
        h=From:To:Cc:Subject:Date:From;
        b=Gma7nb3lMDpjMju/Oo3KPDkKGhPMFCQS8Xi7dKeypS28giJU/Zlodg9b4wOQo4L83
         GKYw3SpICr0KADmkAzbmE+v+bWCjfRQZQwIOwsSsa/jpRJlRO+43pKppVBSVWDjp9E
         yDU60lKFV4Zs+2gORheRyOVMzCMxDhV+iYGpblZY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] iw:  print out assoc comeback event.
Date:   Thu,  7 Apr 2022 16:58:26 -0700
Message-Id: <20220407235826.2690-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1649375913-OkeH9kG5buQy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Looks like this was added in 5.17 kernel.  We see this event
when trying (and failing) to do .11r roaming).

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 event.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/event.c b/event.c
index 1d201a8..ee73a57 100644
--- a/event.c
+++ b/event.c
@@ -893,6 +893,23 @@ static void parse_ch_switch_notify(struct nlattr **attrs, int command)
 	printf("\n");
 }
 
+static void parse_assoc_comeback(struct nlattr **attrs, int command)
+{
+	__u32 timeout = 0;
+	char macbuf[6*3];
+
+	macbuf[0] = 0;
+
+	if (attrs[NL80211_ATTR_MAC])
+		mac_addr_n2a(macbuf, nla_data(attrs[NL80211_ATTR_MAC]));
+
+	if (attrs[NL80211_ATTR_TIMEOUT])
+		timeout = nla_get_u32(attrs[NL80211_ATTR_TIMEOUT]);
+
+	printf("assoc comeback bssid %s timeout %d\n",
+	       macbuf, timeout);
+}
+
 static int print_event(struct nl_msg *msg, void *arg)
 {
 	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
@@ -1285,6 +1302,9 @@ static int print_event(struct nl_msg *msg, void *arg)
 	case NL80211_CMD_CH_SWITCH_NOTIFY:
 		parse_ch_switch_notify(tb, gnlh->cmd);
 		break;
+	case NL80211_CMD_ASSOC_COMEBACK: /* 147 */
+		parse_assoc_comeback(tb, gnlh->cmd);
+		break;
 	default:
 		printf("unknown event %d (%s)\n",
 		       gnlh->cmd, command_name(gnlh->cmd));
-- 
2.21.3

