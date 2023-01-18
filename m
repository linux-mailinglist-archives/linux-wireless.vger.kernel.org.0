Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF6671E98
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjARN4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 08:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjARN4V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 08:56:21 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC428A0E5
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 05:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=p88w6JdWixDyXYvlXtLNFZyDrA1Y7UXK4Bm2ZWR7EOo=; t=1674048423; x=1675258023; 
        b=souN5W8nHFG1FBXhZck+0tQzcuPpLdDX4+A2WxWAVH5skFPjT/wzHFfrqVLwwi20KIiKeS6p1SA
        A34p/7u/qVl5YGgeVk65L4qw3Cvd4gwZxT7Z9WV3XV6HUEt5X4yrNH0Y7T1tE4Dbq0I34QlbovSxT
        tY/VFxO4t9P4oQBLyJfRr8tBYRbPA5BniluwizbPWA+JApIBn1M1V8JAzE2v862qReg6/h/0KTlGq
        C4dW+YPO8xpmnyPL557QYDywmSjpdrSpZgTL3Y5VGqUv7QOiBJGCCYVLDMD19e51cEohNRKVhohDd
        kjqxPOCAHRB4jMASYwMmUgnbxRcJq6TvfYVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pI8Sw-005c2r-2C;
        Wed, 18 Jan 2023 14:26:59 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] bitfield: add FIELD_PREP_CONST()
Date:   Wed, 18 Jan 2023 14:26:53 +0100
Message-Id: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Neither FIELD_PREP() nor *_encode_bits() can be used
in constant contexts (such as initializers), but we
don't want to define shift constants for all masks
just for use in initializers, and having checks that
the values fit is also useful.

Therefore, add FIELD_PREP_CONST() which is a smaller
version of FIELD_PREP() that can only take constant
arguments and has less friendly (but not less strict)
error checks, and expands to a constant value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/bitfield.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index c9be1657f03d..ebfa12f69501 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -115,6 +115,32 @@
 		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
 	})
 
+#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
+
+/**
+ * FIELD_PREP_CONST() - prepare a constant bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_CONST() masks and shifts up the value.  The result should
+ * be combined with other fields of the bitfield using logical OR.
+ *
+ * Unlike FIELD_PREP() this is a constant expression and can therefore
+ * be used in initializers. Error checking is less comfortable for this
+ * version, and non-constant masks cannot be used.
+ */
+#define FIELD_PREP_CONST(_mask, _val)					\
+	(								\
+		/* mask must be non-zero */				\
+		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		/* check if value fits */				\
+		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		/* check if mask is contiguous */			\
+		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
+		/* and create the value */				\
+		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+	)
+
 /**
  * FIELD_GET() - extract a bitfield element
  * @_mask: shifted mask defining the field's length and position
-- 
2.39.0

