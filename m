Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0E43F7DD
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Oct 2021 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhJ2HcM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Oct 2021 03:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJ2HcL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Oct 2021 03:32:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D625BC061570
        for <linux-wireless@vger.kernel.org>; Fri, 29 Oct 2021 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ARxIJzW356E9l6hj64UJy7UfiqSqNpS18R/Is3uU7wk=; t=1635492583; x=1636702183; 
        b=uFnN/h3QAaTVh6hHrs/WZLilU6FJu7ZSNZPkVgEGEkrNqtg/xJWyNf8NswxqEV358F6CRv1YiZ5
        2ycVRuf17zUeIS1LT1mgt+G/ho5Mc6cprib6oWvQUzR2fCx19YSUj9+t23l4sXn2UacVwuBNnE1Ki
        /nvi6ZQmjceisfpDlDL8e9i/NjtDr+GmkVUfScbWEmsTFDWheNfPrKYU4chCX5JFS6gc5YrYQO5k2
        t2pBM3qkoD5eTHyRYf+45mkGeiX8E+eNJp+sHvqLXHONC5rwqKmOWoIcysfdoJUg74qWTh4+9wTsI
        HlXq1Q2hPq/J9iit/wziZdh1rQ5Mm05Hpx7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mgMKb-008Euf-MX;
        Fri, 29 Oct 2021 09:29:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Jan Fuchs <jf@simonwunderlich.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] iw: survey: add support for radio stats
Date:   Fri, 29 Oct 2021 09:29:39 +0200
Message-Id: <20211029072939.15767-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a --radio argument to "survey dump" to support the global
radio statistics.

Change-Id: I16e615434607d982e9cf690f03148738eca25cde
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 survey.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/survey.c b/survey.c
index 9325353e4ba1..7f5385e30ba5 100644
--- a/survey.c
+++ b/survey.c
@@ -71,10 +71,20 @@ static int handle_survey_dump(struct nl80211_state *state,
 			      int argc, char **argv,
 			      enum id_input id)
 {
+	if (argc > 1)
+		return HANDLER_RET_USAGE;
+
+	if (argc) {
+		if (!strcmp(argv[0], "--radio"))
+			nla_put_flag(msg, NL80211_ATTR_SURVEY_RADIO_STATS);
+		else
+			return HANDLER_RET_USAGE;
+	}
+
 	register_handler(print_survey_handler, NULL);
 	return 0;
 }
-COMMAND(survey, dump, NULL,
+COMMAND(survey, dump, "[--radio]",
 	NL80211_CMD_GET_SURVEY, NLM_F_DUMP, CIB_NETDEV, handle_survey_dump,
 	"List all gathered channel survey data");
 
-- 
2.31.1

