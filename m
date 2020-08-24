Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E22506E7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHXRvZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgHXRvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 13:51:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A5C061574;
        Mon, 24 Aug 2020 10:51:22 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kAGcp-00A1ue-72; Mon, 24 Aug 2020 19:51:19 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>
Subject: [PATCH 3/3] genl: ctrl: support dumping netlink policy
Date:   Mon, 24 Aug 2020 19:51:08 +0200
Message-Id: <20200824175108.53101-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824175108.53101-1-johannes@sipsolutions.net>
References: <20200824175108.53101-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Support dumping the netlink policy of a given generic netlink
family, the policy (with any sub-policies if appropriate) is
exported by the kernel in a general fashion.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 genl/ctrl.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/genl/ctrl.c b/genl/ctrl.c
index 0fb464b01cfb..68099fe97f1a 100644
--- a/genl/ctrl.c
+++ b/genl/ctrl.c
@@ -28,13 +28,15 @@
 static int usage(void)
 {
 	fprintf(stderr,"Usage: ctrl <CMD>\n" \
-		       "CMD   := get <PARMS> | list | monitor\n" \
+		       "CMD   := get <PARMS> | list | monitor | policy <PARMS>\n" \
 		       "PARMS := name <name> | id <id>\n" \
 		       "Examples:\n" \
 		       "\tctrl ls\n" \
 		       "\tctrl monitor\n" \
 		       "\tctrl get name foobar\n" \
-		       "\tctrl get id 0xF\n");
+		       "\tctrl get id 0xF\n"
+		       "\tctrl policy name foobar\n"
+		       "\tctrl policy id 0xF\n");
 	return -1;
 }
 
@@ -123,7 +125,8 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 	    ghdr->cmd != CTRL_CMD_DELFAMILY &&
 	    ghdr->cmd != CTRL_CMD_NEWFAMILY &&
 	    ghdr->cmd != CTRL_CMD_NEWMCAST_GRP &&
-	    ghdr->cmd != CTRL_CMD_DELMCAST_GRP) {
+	    ghdr->cmd != CTRL_CMD_DELMCAST_GRP &&
+	    ghdr->cmd != CTRL_CMD_GETPOLICY) {
 		fprintf(stderr, "Unknown controller command %d\n", ghdr->cmd);
 		return 0;
 	}
@@ -136,7 +139,7 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 	}
 
 	attrs = (struct rtattr *) ((char *) ghdr + GENL_HDRLEN);
-	parse_rtattr(tb, CTRL_ATTR_MAX, attrs, len);
+	parse_rtattr_flags(tb, CTRL_ATTR_MAX, attrs, len, NLA_F_NESTED);
 
 	if (tb[CTRL_ATTR_FAMILY_NAME]) {
 		char *name = RTA_DATA(tb[CTRL_ATTR_FAMILY_NAME]);
@@ -159,6 +162,9 @@ static int print_ctrl(struct rtnl_ctrl_data *ctrl,
 		__u32 *ma = RTA_DATA(tb[CTRL_ATTR_MAXATTR]);
 		fprintf(fp, " max attribs: %d ",*ma);
 	}
+	if (tb[CTRL_ATTR_POLICY])
+		nl_print_policy(tb[CTRL_ATTR_POLICY], fp);
+
 	/* end of family definitions .. */
 	fprintf(fp,"\n");
 	if (tb[CTRL_ATTR_OPS]) {
@@ -235,7 +241,9 @@ static int ctrl_list(int cmd, int argc, char **argv)
 		exit(1);
 	}
 
-	if (cmd == CTRL_CMD_GETFAMILY) {
+	if (cmd == CTRL_CMD_GETFAMILY || cmd == CTRL_CMD_GETPOLICY) {
+		req.g.cmd = cmd;
+
 		if (argc != 2) {
 			fprintf(stderr, "Wrong number of params\n");
 			return -1;
@@ -260,7 +268,9 @@ static int ctrl_list(int cmd, int argc, char **argv)
 			fprintf(stderr, "Wrong params\n");
 			goto ctrl_done;
 		}
+	}
 
+	if (cmd == CTRL_CMD_GETFAMILY) {
 		if (rtnl_talk(&rth, nlh, &answer) < 0) {
 			fprintf(stderr, "Error talking to the kernel\n");
 			goto ctrl_done;
@@ -273,7 +283,7 @@ static int ctrl_list(int cmd, int argc, char **argv)
 
 	}
 
-	if (cmd == CTRL_CMD_UNSPEC) {
+	if (cmd == CTRL_CMD_UNSPEC || cmd == CTRL_CMD_GETPOLICY) {
 		nlh->nlmsg_flags = NLM_F_ROOT|NLM_F_MATCH|NLM_F_REQUEST;
 		nlh->nlmsg_seq = rth.dump = ++rth.seq;
 
@@ -324,6 +334,8 @@ static int parse_ctrl(struct genl_util *a, int argc, char **argv)
 	    matches(*argv, "show") == 0 ||
 	    matches(*argv, "lst") == 0)
 		return ctrl_list(CTRL_CMD_UNSPEC, argc-1, argv+1);
+	if (matches(*argv, "policy") == 0)
+		return ctrl_list(CTRL_CMD_GETPOLICY, argc-1, argv+1);
 	if (matches(*argv, "help") == 0)
 		return usage();
 
-- 
2.26.2

