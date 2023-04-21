Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D86EAC00
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjDUNq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjDUNq0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 09:46:26 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D8133
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682084781; bh=cU3nyN3MSiPACnW65e9W8xUMZFhYriikjqiwDUOdb1A=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 6JYLKTOtYmPVgafkYpYJ/hbrSs6NezW31gsgI101N7vk76IwlrYRMes+5bOZZm/S13/NwVBSeFolBR5pI0pICw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682084781; bh=cU3nyN3MSiPACnW65e9W8xUMZFhYriikjqiwDUOdb1A=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 b3qoIgvKXETJobhQQAtgzr5hb6x0XvFYGOIE8OGvkSFPJ4/FzQWdcQ0qH1oEZCdqHD6ABmNQodvGGGSzHqkC2OX/BJbbktF68Cd+BoA4kNqGatu2+cIMce7qV8uXV/UJabU6SvaZm1GCvGqVwEBk5NBXxCsbGilB63J4eGTdjlE=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 21 Apr 2023 13:46:21 GMT
Received: from meshdev.amd.e-technik.uni-rostock.de (139.30.202.188) by
 mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Apr 2023 15:46:21 +0200
From:   Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To:     <nbd@nbd.name>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Subject: [RFC v2] average: rewrite for clearity
Date:   Fri, 21 Apr 2023 13:46:04 +0000
Message-ID: <20230421134604.211128-1-benjamin.beichler@uni-rostock.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.30.202.188]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 49532A7E5FF6BFFF311ED81FC50C0E0876439A2D11B5418B98365FC6D0F497DE2000:8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move the former *_add function with its implicit initialization into a
separate function, when the user explicitly wants to init with the first
added value, although this creates issues, when 0 is a expected value for
the internal value.

Add a separate init function with value parameter to allow init with
distinct value, which was formerly done by the implicit init of old
*_add function.

Move the compile time checks into a separate macro, as they are used
multiple times and noise up the functions.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 include/linux/average.h | 86 ++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..7149a9ee555a 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -25,47 +25,61 @@
  * that this parameter must be a power of two for efficiency.
  */
 
-#define DECLARE_EWMA(name, _precision, _weight_rcp)			\
-	struct ewma_##name {						\
-		unsigned long internal;					\
-	};								\
-	static inline void ewma_##name##_init(struct ewma_##name *e)	\
-	{								\
+#define EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp)			\
+	do {								\
 		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
 		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
-		/*							\
-		 * Even if you want to feed it just 0/1 you should have	\
-		 * some bits for the non-fractional part...		\
-		 */							\
-		BUILD_BUG_ON((_precision) > 30);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
-		e->internal = 0;					\
-	}								\
-	static inline unsigned long					\
-	ewma_##name##_read(struct ewma_##name *e)			\
-	{								\
-		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
-		BUILD_BUG_ON((_precision) > 30);			\
-		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
-		return e->internal >> (_precision);			\
-	}								\
-	static inline void ewma_##name##_add(struct ewma_##name *e,	\
-					     unsigned long val)		\
-	{								\
-		unsigned long internal = READ_ONCE(e->internal);	\
-		unsigned long weight_rcp = ilog2(_weight_rcp);		\
-		unsigned long precision = _precision;			\
 									\
-		BUILD_BUG_ON(!__builtin_constant_p(_precision));	\
-		BUILD_BUG_ON(!__builtin_constant_p(_weight_rcp));	\
 		BUILD_BUG_ON((_precision) > 30);			\
 		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
-									\
-		WRITE_ONCE(e->internal, internal ?			\
-			(((internal << weight_rcp) - internal) +	\
-				(val << precision)) >> weight_rcp :	\
-			(val << precision));				\
+	} while (0)
+
+#define DECLARE_EWMA(name, _precision, _weight_rcp)				\
+	struct ewma_##name {							\
+		unsigned long internal;						\
+	};									\
+	static inline void ewma_##name##_init_val(struct ewma_##name *e,	\
+						  unsigned long init)		\
+	{									\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp)			\
+		e->internal = init << _precision;				\
+	}									\
+	static inline void ewma_##name##_init(struct ewma_##name *e)		\
+	{									\
+			ewma_##name##_init_val(e, 0);				\
+	}									\
+	static inline unsigned long						\
+	ewma_##name##_read(struct ewma_##name *e)				\
+	{									\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp)			\
+		return e->internal >> (_precision);				\
+	}									\
+	static inline void ewma_##name##_add(struct ewma_##name *e,		\
+					     unsigned long val)			\
+	{									\
+		unsigned long internal = READ_ONCE(e->internal);		\
+		unsigned long weight_rcp = ilog2(_weight_rcp);			\
+		unsigned long precision = _precision;				\
+										\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp)			\
+										\
+		WRITE_ONCE(e->internal,						\
+			(((internal << weight_rcp) - internal) +		\
+				(val << precision)) >> weight_rcp);		\
+	}									\
+	static inline void ewma_##name##_add_or_init(struct ewma_##name *e,	\
+					     unsigned long val)			\
+	{									\
+		unsigned long internal = READ_ONCE(e->internal);		\
+		unsigned long weight_rcp = ilog2(_weight_rcp);			\
+		unsigned long precision = _precision;				\
+										\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp)			\
+										\
+		WRITE_ONCE(e->internal, internal ?				\
+			(((internal << weight_rcp) - internal) +		\
+				(val << precision)) >> weight_rcp :		\
+			(val << precision));					\
 	}
 
 #endif /* _LINUX_AVERAGE_H */
-- 
2.25.1
