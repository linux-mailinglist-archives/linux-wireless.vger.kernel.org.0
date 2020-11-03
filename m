Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98B2A5AD0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 00:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgKCX4k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 18:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKCX4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 18:56:40 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8253FC0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 15:56:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so15763526pfp.5
        for <linux-wireless@vger.kernel.org>; Tue, 03 Nov 2020 15:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fxr5iOV0siNTsG5oN0BNXHjzI/D8qC6t7dvQQ4DpYU=;
        b=WKIpz8l5muA2c+4wtK/e6gl4nowscZvkEeKSGRzafsoagntR+3srQqkSYcypKdpLct
         TgzEv1D4QKjeFwSbUFHcxBAB4OpCtmuThtWmBHUCMUeyBk+Jb2FuhGu/A0hrNdlBia7n
         HY8pLth0tAcYX1v9F3jbxWvycZUEjsGP2LNRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fxr5iOV0siNTsG5oN0BNXHjzI/D8qC6t7dvQQ4DpYU=;
        b=GJGzhLYXDqN3AKE/MrmYKG5MN0VvD+6dwMawPzC5YfRjQ/B8Q7qt5gcddLXERY2Zvt
         nM9jUMcP87R/copYe3QAAmZt1AEHacIUgykwoRzo8RHOqplHq9GdXRPetqZBnCZroD9p
         mf7akX8j8S/njY8QlKOELE5B/FDjoaDA7nJaSnZPW/AobPrxqkf6gCoZJgGQ7X82Fe7l
         PqIH/nX65n/s312e0YOS4jkbsE/QrZxYBfrzuGbzP8qURKrrxSAmQZ12TkNZmLu4H8ZO
         bqKHJCtn5QVXaNYynHUleHAkukz/MCdKs/Fj789TFW2hiLurVdvetj5MT0wSETV4lrf1
         yVtg==
X-Gm-Message-State: AOAM533vdvSUACr3OB79NtscZRAv0GOHcc89DcLjnFfAOvITX3dXNTi0
        agcs5YgwQ3VIDKmilYfr6Ny03g==
X-Google-Smtp-Source: ABdhPJws18euEvCbN6PUrf3c6Nk1M3mZFTKxy6ZxlaySqcAdffwipyqIqKDwuPotsyzyXinB1pkw1A==
X-Received: by 2002:a62:7e44:0:b029:163:f1c3:3b32 with SMTP id z65-20020a627e440000b0290163f1c33b32mr28859248pfc.62.1604447798104;
        Tue, 03 Nov 2020 15:56:38 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id w127sm218827pfc.172.2020.11.03.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 15:56:37 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] iw: handle positive error codes gracefully
Date:   Tue,  3 Nov 2020 15:56:31 -0800
Message-Id: <20201103235631.2936594-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

netlink(7) requires error codes to be negative, but since when does a
man page stop anyone? At a minimum, we shouldn't allow a non-conforming
vendor command to put us into an infinite loop in the below snippets
from __handle_cmd():

	err = 1;

	nl_cb_err(cb, NL_CB_CUSTOM, error_handler, &err);
...
	while (err > 0)
		nl_recvmsgs(state->nl_sock, cb);

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 iw.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/iw.c b/iw.c
index da71617921d8..35308ba3244a 100644
--- a/iw.c
+++ b/iw.c
@@ -287,7 +287,19 @@ static int error_handler(struct sockaddr_nl *nla, struct nlmsgerr *err,
 	int *ret = arg;
 	int ack_len = sizeof(*nlh) + sizeof(int) + sizeof(*nlh);
 
-	*ret = err->error;
+	if (err->error > 0) {
+		/*
+		 * This is illegal, per netlink(7), but not impossible (think
+		 * "vendor commands"). Callers really expect negative error
+		 * codes, so make that happen.
+		 */
+		fprintf(stderr,
+			"ERROR: received positive netlink error code %d\n",
+			err->error);
+		*ret = -EPROTO;
+	} else {
+		*ret = err->error;
+	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
 		return NL_STOP;
-- 
2.29.1.341.ge80a0c044ae-goog

