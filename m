Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC836B6D4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhDZQbK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhDZQbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 12:31:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6A3C061574
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 09:30:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t2-20020a6344420000b02901fc26d75405so18071553pgk.20
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qwJB76TBNHkWENBY8Fsauk6AZ+kOn0Ka4OvKB1fagVk=;
        b=Ub/EN49mU2BOHY5wVySpTczmneT9YBqKLpTak1v8liVsYTdbnVI40kYVFsCSGRpaZ8
         Jm3BKSRr6fk/gdivQqOyBtcoFuiXkx2paYyEidOmh92hfj7m6d/CnhG5TFen9UcUpgJY
         53HCFWpDlDzCXzcFqSI01u3eOPGFYsUMaYnePqxSsGet2cEH8OO1urZg4CRXa3CN+YaA
         XaHkFDKqHCQGSB5APQtszArOouhiDTEnjeSW1rO6IlIg2KeNxKLI2jeEfMFLyQzMhODS
         vc1u1IMdEb9OgoTFMavIEX4sQl1SreaXnWAWzXm2VUcC70ATe5Q8CFIEp2RpPsc2hQO0
         x9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qwJB76TBNHkWENBY8Fsauk6AZ+kOn0Ka4OvKB1fagVk=;
        b=no/vRZDcnwmoIv6lOlaHwh336aslLNiDooVblIKAht75zXV3xDJJQdkmltN7TIuoRS
         cft7AavE8ybLTSc4I/SA2OjhUyFrcjglyXs2PW4gspgPu+h6NyBf0Q54UIGwnsH3D1R5
         R2odIgXqzo5eTE6NjWZcRRkFCmNgLjAu59QzpbZEtApOu6SfYK5jZpG8xHBujCCKYIbf
         q5XFlsNGAvfAtJxiT8TLwwpheUMirkWHQnsV267NX05B9SsVPBXMIgYzc96Kl+uEENx8
         wZaUgioeaXAUucEkJom0hNbv1jSyhHaHr0+YKEG3wSrWS8B2zIwJoz2Zyx9shNpYU2kb
         KVeg==
X-Gm-Message-State: AOAM532wqCIIUo7CWig+94V0jxrQPGOhUrnzuTujplJ0SsWg6XyZaqPO
        69lAqJJXyi5PoG4Dz+xujwwmwIR+v/kPRrlM
X-Google-Smtp-Source: ABdhPJwCzwRBpTmH+3q3wHO4CPtXBQaJBa4UXv6Zxo++Y+b4ppDt6i+vzGaG71ssca7RUl8tXMrHBuFItfMlUTHS
X-Received: from manoj.svl.corp.google.com ([2620:15c:2ce:0:2b5d:c38b:f03d:9410])
 (user=manojgupta job=sendgmr) by 2002:a17:90a:730c:: with SMTP id
 m12mr23423979pjk.111.1619454627559; Mon, 26 Apr 2021 09:30:27 -0700 (PDT)
Date:   Mon, 26 Apr 2021 09:30:21 -0700
In-Reply-To: <20210422182545.726897-1-manojgupta@google.com>
Message-Id: <20210426163021.3594482-1-manojgupta@google.com>
Mime-Version: 1.0
References: <20210422182545.726897-1-manojgupta@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2] iw: set retain atrribute on sections
From:   Manoj Gupta <manojgupta@google.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     llozano@google.com, manojgupta@google.com,
        linux-wireless@vger.kernel.org, Fangrui Song <maskray@google.com>,
        stable@vger.kernel.org
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

Cc: stable@vger.kernel.org

Signed-off-by: Manoj Gupta <manojgupta@google.com>
---
Changes v1 -> v2:
Apply the retain attribute to all places with attribute used.

 iw.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/iw.h b/iw.h
index 7f7f4fc..8ca8e44 100644
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
@@ -141,16 +142,18 @@ struct chandef {
 		.handler = (_handler),					\
 		.help = (_help),					\
 	 };								\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"") 		\
 	static struct cmd *__section ## _ ## _name ## _p		\
-	__attribute__((used,section("__cmd"))) = &__section ## _ ## _name
+	__attribute__((used,retain,section("__cmd"))) = &__section ## _ ## _name
 
 #define SECTION(_name)							\
 	struct cmd __section ## _ ## _name = {				\
 		.name = (#_name),					\
 		.hidden = 1,						\
 	};								\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"") 		\
 	static struct cmd *__section ## _ ## _name ## _p		\
-	__attribute__((used,section("__cmd"))) = &__section ## _ ## _name
+	__attribute__((used,retain,section("__cmd"))) = &__section ## _ ## _name
 
 #define DECLARE_SECTION(_name)						\
 	extern struct cmd __section ## _ ## _name;
@@ -162,13 +165,14 @@ struct vendor_event {
 };
 
 #define VENDOR_EVENT(_id, _subcmd, _callback)				\
+	_Pragma("GCC diagnostic ignored \"-Wattributes\"") 		\
 	const struct vendor_event 					\
 	vendor_event_ ## _id ## _ ## _subcmd = {			\
 		.vendor_id = _id,					\
 		.subcmd = _subcmd,					\
 		.callback = _callback,					\
 	}, * const vendor_event_ ## _id ## _ ## _subcmd ## _p		\
-	__attribute__((used,section("vendor_event"))) =			\
+	__attribute__((used,retain,section("vendor_event"))) =			\
 		&vendor_event_ ## _id ## _ ## _subcmd
 
 extern const char iw_version[];
-- 
2.31.1.498.g6c1eba8ee3d-goog

