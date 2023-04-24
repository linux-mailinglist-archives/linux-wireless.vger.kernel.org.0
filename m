Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445586ED682
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 23:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjDXVFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 17:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXVFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 17:05:02 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC7C6185
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682370296; bh=6/qEhmkTB3ExhlHteL1N53eqDXq8emR8Pt3pE4jNiiU=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 mWUsaW4tHMl4jmIQC8hDGAjpkiHezVFk2bHCJhIdKezYOa3O/VoJJaO0GU8r5NZt/nzLnt9AgOOQGKmy614iBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682370296; bh=6/qEhmkTB3ExhlHteL1N53eqDXq8emR8Pt3pE4jNiiU=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 GpPTCcUrGJ4QLISGfyZr+Suk0YVrtM+SiT1b/IqbGuEA05OWnvZzFLv4XJcXOAnNTNJEBxKsMlcLqovwTkEPp8bJXhalw5/FVYY0NxO+qCVNqa3omROsQGimj7IpVTjjFlTubspqxUtF2w4SNK/7tdckfTEZQqpUWgelrytVUWk=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Mon, 24 Apr 2023 21:04:55 GMT
Received: from meshdev.amd.e-technik.uni-rostock.de (139.30.202.188) by
 mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Apr 2023 23:04:55 +0200
From:   Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To:     <johannes@sipsolutions.net>, <nbd@nbd.name>,
        <linux-wireless@vger.kernel.org>
CC:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Subject: [RFC PATCH v3] average: change non-init state and add check for added values
Date:   Mon, 24 Apr 2023 21:04:30 +0000
Message-ID: <20230424210430.390592-1-benjamin.beichler@uni-rostock.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.30.202.188]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 063766B8694C6732754F678963793827E42FE0BFE89C5565502F0218226F345B2000:8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The uninitialized state 0 involves the danger of reaching that state in
normal operation. Since the weight_rcp value needs to be bigger than one
(otherwise no averaging takes place), the final shifting in add ensures,
that the internal state never reach ULONG_MAX. Therefore use this value
to signal, that the ewma has no initial value.

The add function needs to check, that val is not to big, otherwise the new
value can overflow the internal state, which results in unexpected outputs.

Move the compile time checks into a separate macro, as they are used
multiple times and noise up the functions.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 include/linux/average.h | 82 ++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..4fb170ed0225 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -22,50 +22,58 @@
  * The third argument, the weight reciprocal, determines how the
  * new values will be weighed vs. the old state, new values will
  * get weight 1/weight_rcp and old values 1-1/weight_rcp. Note
- * that this parameter must be a power of two for efficiency.
+ * that this parameter must be a power of two for efficiency. A
+ * weight of 1 is not allowed, because of the internal init function,
+ * but nevertheless it makes no sense, since it means no averaging at all.
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
+		BUILD_BUG_ON(_weight_rcp <= 1);				\
+	} while (0)
+
+#define DECLARE_EWMA(name, _precision, _weight_rcp)				\
+	struct ewma_##name {							\
+		unsigned long internal;						\
+	};									\
+	static inline void ewma_##name##_init(struct ewma_##name *e)		\
+	{									\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp);		\
+		e->internal = ULONG_MAX;					\
+	}									\
+		static inline void ewma_##name##_init_val(struct ewma_##name *e	\
+							  unsigned long val)	\
+	{									\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp);		\
+		e->internal = val;						\
+	}									\
+	static inline unsigned long						\
+	ewma_##name##_read(struct ewma_##name *e)				\
+	{									\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp);		\
+		return unlikely(e->internal == ULONG_MAX) ?			\
+				0 : e->internal >> (_precision);		\
+	}									\
+	static inline void ewma_##name##_add(struct ewma_##name *e,		\
+					     unsigned long val)			\
+	{									\
+		unsigned long internal = READ_ONCE(e->internal);		\
+		unsigned long weight_rcp = ilog2(_weight_rcp);			\
+		unsigned long precision = _precision;				\
+		unsigned long max_val = ULONG_MAX >> (precision + weight_rcp);	\
+										\
+		EWMA_BUILD_TIME_CHECKS(_precision, _weight_rcp);		\
+		WARN_ONCE(val > max_val, "Value (%lu) is too large for ewma_##name##_add, this will result in unexpected values of the ewma filter. Max valid value is %lu",\
+			  val, max_val);					\
+		WRITE_ONCE(e->internal, unlikely(internal != ULONG_MAX) ?	\
+			(((internal << weight_rcp) - internal) +		\
+				(val << precision)) >> weight_rcp :		\
+			(val << precision));					\
 	}
 
 #endif /* _LINUX_AVERAGE_H */
-- 
2.25.1
