Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD78406D7C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Sep 2021 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhIJOTd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Sep 2021 10:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhIJOTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Sep 2021 10:19:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F8C061574
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id h3so1944135pgb.7
        for <linux-wireless@vger.kernel.org>; Fri, 10 Sep 2021 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SWC64Hw9RdRZUBb/5tZCGO0pnW6c4GkHo018gfxVZbA=;
        b=ppej98ouCoXFsE8KgeNwGHQYYLAlviMcgxkqTDR7jHFNz8EdVtN2zQ9Ntv3C8t+yFS
         QvcWcmHHBq/C86lZMc/5G3WdIpqyP2TfqoZZxnZaSdSZZMtEK6K96D5uPvSDVFsrx8nd
         sMU0XOOh4HjUpwfWrxlZaRtZ8pw1H58hF1bymItjlm2d8CNT1D6vUSbfh5BwRsiX9oPZ
         VQdH5BpykqOPS/ZSBpRdRPDiVXfOAA0E4F9dfs2WTNeAV/cSc0sSejhmDaJZHdwoacfN
         rmcbzJXZHhR4W50ifZcj4FzlzvSivQ3LCFAoV9B4mvzZKaKiikDEof1Zr9F0PgK8FEfY
         gR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SWC64Hw9RdRZUBb/5tZCGO0pnW6c4GkHo018gfxVZbA=;
        b=eBfvZqiSiUzWcAKNbtbw/lfUP9DSQSmes2vaVRzac4VZV9t1P20NZEY67xNoKfclXn
         Lyq6xbi0hIaM6TpQ0XpCNG3/bfzAMup+BimpCha4w1jPnTqxF1HawRv339BrhQPY4HqB
         F3PSfC3QrXiUZoabIsAOJvNeMrsoIdSEOLIRPGatRatfVchyHZWCrbJPccsn0ndN0OKG
         wuECcKZb001u7xdyho8IVgeBjtLRdcAIAulmmFMVOn545o6oAp9pCG2T/ZQUppdP65BI
         snlN+0YNlE2OhI8R+wD+8ocY5PbDXvI+cnwrJN7oDg1hqFwpAZWNN3iGTXf8pYLn6U/z
         Y0hQ==
X-Gm-Message-State: AOAM533lp1Py/VUAJzNYrQZ8hq/q4pUQQ/yDvqwORyV4Z1O6wnb0XYRo
        fOnh3D9nXOucJ/hfl9aTVIyzZgpKnHc=
X-Google-Smtp-Source: ABdhPJwzyGwvMUpCDvj8tH/olZRW9EaO5NQfbvQzS5It/KeJP3uG+fsfeUZWNt/shNghHXvmQo8OAA==
X-Received: by 2002:a63:e14f:: with SMTP id h15mr7625145pgk.49.1631283494424;
        Fri, 10 Sep 2021 07:18:14 -0700 (PDT)
Received: from localhost.localdomain ([49.206.113.222])
        by smtp.googlemail.com with ESMTPSA id q9sm5079519pfs.40.2021.09.10.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 07:18:14 -0700 (PDT)
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gokul Sivakumar <gokulkumar792@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH iw 4/4] iw: mesh: add comments in the mesh confguration parameter printing sections
Date:   Fri, 10 Sep 2021 19:46:18 +0530
Message-Id: <20210910141618.1594617-4-gokulkumar792@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910141618.1594617-1-gokulkumar792@gmail.com>
References: <20210910141618.1594617-1-gokulkumar792@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Gokul Sivakumar <gokulkumar792@gmail.com>
---
 mesh.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh.c b/mesh.c
index 943edf5..0fb98a3 100644
--- a/mesh.c
+++ b/mesh.c
@@ -400,6 +400,7 @@ static int print_mesh_param_handler(struct nl_msg *msg, void *arg)
 	if (!mdescr) {
 		unsigned int i;
 
+		/* print out all the supported mesh parameters */
 		for (i = 0; i < ARRAY_SIZE(_mesh_param_descrs); i++) {
 			mdescr = &_mesh_param_descrs[i];
 			if (mesh_params[mdescr->mesh_param_num]) {
@@ -411,7 +412,7 @@ static int print_mesh_param_handler(struct nl_msg *msg, void *arg)
 		return NL_SKIP;
 	}
 
-	/* print out the mesh parameter */
+	/* print out the requested mesh parameter */
 	if (mesh_params[mdescr->mesh_param_num]) {
 		mdescr->nla_print_fn(mesh_params[mdescr->mesh_param_num]);
 		printf("\n");
-- 
2.25.1

