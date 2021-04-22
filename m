Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB436868C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhDVS0Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Apr 2021 14:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbhDVS0Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Apr 2021 14:26:25 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B3DC061756
        for <linux-wireless@vger.kernel.org>; Thu, 22 Apr 2021 11:25:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a15-20020a05622a02cfb02901b5e54ac2e5so12817684qtx.4
        for <linux-wireless@vger.kernel.org>; Thu, 22 Apr 2021 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cdFFfBwj6y+ldLJWT4RH/UCRgZud/iyFWxuR5ipQoVI=;
        b=kPtqx4n7It6L+YNDdsYxD+Agp+bgfqLUbKTTCN5iRtHehOYyZij9HjCUfBDwHkYrfV
         Ewm4+4uKAQl7/7POfPGXqztoHtuKSLgyBiOl8yYtveYKRoXBoX462R7bgYU9g63iaYmz
         ZBJPzyhqbxNqrBg98+elt4eQDtJ1anUEuieGz2CH5sa53K3vAfTL+9nCDquPIsv9fBr7
         cRM26SgqxG/c+pwkRUb2l3NDeXp+hwGi4vZzm2RQ/5CMKsCr1k/BBI7w20bg/7FGSzFs
         0xRjA5OosaIy3YABLGlVhyd0CQqowaNKhHb+L1HDPBKI/LXq0zabapLS5JSiqRlsDsKU
         FQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cdFFfBwj6y+ldLJWT4RH/UCRgZud/iyFWxuR5ipQoVI=;
        b=jXHbd7BsH3NSd63nsdFNPs4E/bAYMez8jxNogWixiYZU7+51jKpbh1LUUavciMT1FP
         iyLEZhpyLYoAMT4VNl4BVMRWd/Bz0Un+IdawDdRzofWfc6+AmAgw7H6OslVuHd+vkIio
         qhZMLzBJr+9rzZF+YlnVnfoCmetBS4Djt1uPia8uzK/sjFfCChg2cPQ60qcIjpdv39O6
         yJ6+5AE/jNDb9u1j54xb+Em+V0hZyAHYDRoZJ2QCb1aS3M54IuKos8eM+ZTyt+fP2Cej
         1OY1PgBFgvWboASy6uo7qNljqK9qQyjd7t9gg4QjflUyMEiy+t5WAfT0vuyNumwjdv91
         f7cw==
X-Gm-Message-State: AOAM5328Vux3gdgp7Of4lzpS1Gy3bGxm7+6097hH8lyNQaqS0J6Xo7G5
        mbuxdNpBTc64QQ3U3mwVfCtG7XUG9hRb03Hc
X-Google-Smtp-Source: ABdhPJxHDiOKvw7MbVPkxJtBsTTRLWxDYith8HTo++LxCspdOO5u1CM0L1TAxMlZXcj0DObKKM0ej9QNERvGplzw
X-Received: from manoj.svl.corp.google.com ([2620:15c:2ce:0:f9bc:2c5f:7aa9:b2])
 (user=manojgupta job=sendgmr) by 2002:a05:6214:13c2:: with SMTP id
 cg2mr228706qvb.4.1619115949274; Thu, 22 Apr 2021 11:25:49 -0700 (PDT)
Date:   Thu, 22 Apr 2021 11:25:45 -0700
Message-Id: <20210422182545.726897-1-manojgupta@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] iw: set retain atrribute on sections
From:   Manoj Gupta <manojgupta@google.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     stable@vger.kernel.org, maskray@google.com, llozano@google.com,
        manojgupta@google.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

LLD 13 and GNU ld 2.37 support -z start-stop-gc which allows garbage
collection of C identifier name sections despite the __start_/__stop_
references.  Simply set the retain attribute so that GCC 11 (if
configure-time binutils is 2.36 or newer)/Clang 13 will set the
SHF_GNU_RETAIN section attribute to prevent garbage collection.

Without the patch, there are linker errors like the following with -z
start-stop-gc:
ld.lld: error: undefined symbol: __stop___cmd
>>> referenced by iw.c:418
>>>               iw.o:(__handle_cmd)

Suggested-by: Fangrui Song <maskray@google.com>

Signed-off-by: Manoj Gupta <manojgupta@google.com>
---
 iw.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/iw.h b/iw.h
index 7f7f4fc..67aa00c 100644
--- a/iw.h
+++ b/iw.h
@@ -118,8 +118,9 @@ struct chandef {
 		.parent = _section,					\
 		.selector = (_sel),					\
 	};								\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"") 		\
 	static struct cmd *__cmd ## _ ## _symname ## _ ## _handler ## _ ## _nlcmd ## _ ## _idby ## _ ## _hidden ## _p \
-	__attribute__((used,section("__cmd"))) =			\
+	__attribute__((used,retain,section("__cmd"))) =			\
 	&__cmd ## _ ## _symname ## _ ## _handler ## _ ## _nlcmd ## _ ## _idby ## _ ## _hidden
 #define __ACMD(_section, _symname, _name, _args, _nlcmd, _flags, _hidden, _idby, _handler, _help, _sel, _alias)\
 	__COMMAND(_section, _symname, _name, _args, _nlcmd, _flags, _hidden, _idby, _handler, _help, _sel);\
-- 
2.31.1.498.g6c1eba8ee3d-goog

