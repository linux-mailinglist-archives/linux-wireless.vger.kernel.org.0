Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1413674E1B2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 01:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGJXDX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjGJXDV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 19:03:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99F21B2;
        Mon, 10 Jul 2023 16:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oMzYfni/SqAXGE8TOxN7w+2uYv8fFjCLm4K0/twX6OM=; b=K7VvjRLJQTC/xFqwV3RHdTwTYS
        m2bhtQ3xb0qZJOrdb6B+iJ5AhfM+iWWkMgm16p+Ewi4TTLEI52/VjurgAlFfs3MMnLBn9DBOyCMMi
        hs2mgQblUvUhaOv09xqWizRERYP0QDLDCu0HFtc3zorNIUFlyp1Z2bNuRLgArFaVCh8+dYGpgdfh6
        lTpYTHuUqxeuWbVm8vFgrUnTTa+CrhwwmY7sOy7qF90CBPYUF7/pGq9tqO/RBSjn1UFig64bS/A8W
        +E+zqp8PsEr3MfNtpb7IXmL5M4YQyy9RycNKU2NHVyLbWbVm/qP2Xwr/bG6GIsFcCzpCLgzorc3KB
        5w7qV1PA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzuY-00CuO1-0T;
        Mon, 10 Jul 2023 23:03:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     netdev@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Berg <benjamin.berg@intel.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH net 09/12] wifi: mac80211: fix kernel-doc notation warning
Date:   Mon, 10 Jul 2023 16:03:09 -0700
Message-ID: <20230710230312.31197-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710230312.31197-1-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add description for struct member 'agg' to prevent a kernel-doc
warning.

mac80211.h:2289: warning: Function parameter or member 'agg' not described in 'ieee80211_link_sta'

Fixes: 4c51541ddb78 ("wifi: mac80211: keep A-MSDU data in sta and per-link")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
---
 include/net/mac80211.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/include/net/mac80211.h b/include/net/mac80211.h
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2259,6 +2259,7 @@ struct ieee80211_sta_aggregates {
  * @he_cap: HE capabilities of this STA
  * @he_6ghz_capa: on 6 GHz, holds the HE 6 GHz band capabilities
  * @eht_cap: EHT capabilities of this STA
+ * @agg: station's active links data
  * @bandwidth: current bandwidth the station can receive with
  * @rx_nss: in HT/VHT, the maximum number of spatial streams the
  *	station can receive at the moment, changed by operating mode
