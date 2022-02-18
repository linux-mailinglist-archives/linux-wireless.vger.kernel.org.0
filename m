Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916984BBD88
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiBRQbO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Feb 2022 11:31:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiBRQbN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Feb 2022 11:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 172682B1A9E
        for <linux-wireless@vger.kernel.org>; Fri, 18 Feb 2022 08:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645201855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MlHUFHX+ZHcQFW+lyQMNcMO6c5EeDKK8SX4zE6inQZ8=;
        b=MS/QhgMLOo80EzVlFzryXt/Fhwtzx41Q//jk7cryhZaChcbvqhFiWiWZlYhWHhw6TSnYIi
        ameiv4QzcZ1BCmG3qdL5j5CrMXfwiXscWmBxmKoa+dfFGXoSKXIyP2ficeH1gKNSdrferb
        1hj5oBYTB/z2W8Cpe/Ik+/hjUJ4Nk0s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-1Y7RG2RCOoOhjwYmpH8-CQ-1; Fri, 18 Feb 2022 11:30:53 -0500
X-MC-Unique: 1Y7RG2RCOoOhjwYmpH8-CQ-1
Received: by mail-qk1-f200.google.com with SMTP id 199-20020a3703d0000000b005f17c5b0356so4495971qkd.16
        for <linux-wireless@vger.kernel.org>; Fri, 18 Feb 2022 08:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MlHUFHX+ZHcQFW+lyQMNcMO6c5EeDKK8SX4zE6inQZ8=;
        b=QnUYxF16Hg/uABZT5MrGmZGC5v3ar172QlMjd1Y//PClmWfVGykDslPQ35AUCBsFEm
         H4wxcpdAm0NkPAyGvayH6+zEBSRugwOw/rIcrprz9hsOVI1rE//tmbyL8wtbqGq89qPb
         3Ww5WWnDHDwlzjkO8e+02oZve2pcUacJZp7HxRDPoQwmbUObrlHq85MsaNMwDTaBzErp
         eOzGAAOHjdeqy4+3nFHvsfyw42BLYSUWhcER8jdqwPyBMRPGjr+8CaAwOUAt4TxVx2A8
         +nTgb1mG2+Dpt0xiQKXc7/ITfCG/NBEfA/jE+yonpiPjjNicGcd4KkehkOp5EodF94Or
         O9GA==
X-Gm-Message-State: AOAM532/ZUf9WTC1typN2ORv9nhoXfbuQNuMR4/ru2eGie4jPKuuCsJp
        0euE+3YDRbLuuwaN7dlGt5d7frb+TQvSdGK9M4tv+6l6yMlGnZjgB4pQoiXrXqcATWDaW2UDUSV
        K7QIrp0u6lsDM5IAQjWdqFTipJG8=
X-Received: by 2002:a05:6214:2269:b0:42c:37d8:a1aa with SMTP id gs9-20020a056214226900b0042c37d8a1aamr6473776qvb.92.1645201853411;
        Fri, 18 Feb 2022 08:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4vFhU7HKS9yRqHe0sY1K1K2BAfoqEYhz5pP7+ki2kTzk8Y/F1C67XvLcFUXAjFfYcBr/Uhw==
X-Received: by 2002:a05:6214:2269:b0:42c:37d8:a1aa with SMTP id gs9-20020a056214226900b0042c37d8a1aamr6473751qvb.92.1645201853164;
        Fri, 18 Feb 2022 08:30:53 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c2sm18024043qkp.0.2022.02.18.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:30:52 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, cjhuang@codeaurora.org,
        briannorris@chromium.org, kuabhs@chromium.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nl80211: check return of nla_parse_nested
Date:   Fri, 18 Feb 2022 08:30:45 -0800
Message-Id: <20220218163045.3370662-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative problem
nl80211.c:15426:6: warning: Branch condition evaluates
  to a garbage value
  if (!tb[NL80211_SAR_ATTR_TYPE] ||
       ^~~~~~~~~~~~~~~~~~~~~~~~~~

tb is set when nla_parse_nested() is successful.
So check.

Fixes: 6bdb68cef7bf ("nl80211: add common API to configure SAR power limitations")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/wireless/nl80211.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7543c73a3f1d..c1532c8eb657 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15419,9 +15419,11 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_SAR_SPEC])
 		return -EINVAL;
 
-	nla_parse_nested(tb, NL80211_SAR_ATTR_MAX,
-			 info->attrs[NL80211_ATTR_SAR_SPEC],
-			 NULL, NULL);
+	err = nla_parse_nested(tb, NL80211_SAR_ATTR_MAX,
+			       info->attrs[NL80211_ATTR_SAR_SPEC],
+			       NULL, NULL);
+	if (err)
+		return err;
 
 	if (!tb[NL80211_SAR_ATTR_TYPE] || !tb[NL80211_SAR_ATTR_SPECS])
 		return -EINVAL;
@@ -15444,8 +15446,10 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	sar_spec->type = type;
 	specs = 0;
 	nla_for_each_nested(spec_list, tb[NL80211_SAR_ATTR_SPECS], rem) {
-		nla_parse_nested(spec, NL80211_SAR_ATTR_SPECS_MAX,
-				 spec_list, NULL, NULL);
+		err = nla_parse_nested(spec, NL80211_SAR_ATTR_SPECS_MAX,
+				       spec_list, NULL, NULL);
+		if (err)
+			goto error;
 
 		switch (type) {
 		case NL80211_SAR_TYPE_POWER:
-- 
2.26.3

