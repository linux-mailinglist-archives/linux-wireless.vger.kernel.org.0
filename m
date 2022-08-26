Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722705A2CFB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiHZRAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHZRAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 13:00:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1ABC13B
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id v4so1879190pgi.10
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=W7mnok4RvNOWYbCi5sXwUUbrj5VSaOxalCv+IO3V8bs=;
        b=Hz6QAD/7xgldqgy3mPaIe0vDXwGQjiuuja3SLMINYU/xvz0ii5PmCN25MvPD/O+C/e
         yuqTdvlL6hY/gptDzYsdUwFgge5SyH5X/Xe6PB/CXcZCLzYbfcZYEvDp5YKlqJHNAj/J
         fu43UT+vRAKJP+8kZgAORv5k7Wd7Y3c2bXi+XIsrL+JXum8PDNb5bDbhhABbC7ro2oeq
         V69WHzrldK2mxiAU5tYOmShV5LO6AXtijWyjQjz3BmpTE6ah6fb66N29B7oX36iNDYhA
         F3/uEEYW6ZTsmuN+Vek4cibebEGSgf/OJUuzSk++c0QMwMIa4fIiaWYWjG/ChZ6Qwz9n
         5GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=W7mnok4RvNOWYbCi5sXwUUbrj5VSaOxalCv+IO3V8bs=;
        b=xUxgCpVBqW/Ypfv4oe19DtxXw46FdEtaZ21fqyR2qclwA9Usqutxzw/PczC/uuuTc7
         cfA70wFytv7smBnp6PVt1W8+vZf8JUlk0dJmwgUfPg0uoQEtpmG23BIXyUY207D7S7u4
         WXNzjoVN80l1b0bSIBxZr8Pxmj56IBWoFtZMCINlJHfieDpEwk4Q6u+ER5qrRBx35KHL
         /O1GgqqTNgzULrnjufW1EH6BzPwJNZA1a8VD2suXffEaNh39zrRBlL6JXtexGQkdnX0m
         dZsLa958JnKWBjH1tGtBl37h9DnXR9v+r801IAgf3lLmIDIFQzsGbz14ZGdqLBs4cvCM
         lKIw==
X-Gm-Message-State: ACgBeo3zk4ixjnBF2weuEvayYAreOPYfH5HbkFzeRS1YZbVykRmGuCsK
        b4U7pz9uODYR/yLCtfqAVPDvZCMwDJU=
X-Google-Smtp-Source: AA6agR5l099HXxFo7VobgXFumY5Jacm6OVdKPOIDUfd8VqbD6OK9yfZgaupOZGfD3KNv9n86o5hOnA==
X-Received: by 2002:a63:f843:0:b0:42a:9ba9:27fd with SMTP id v3-20020a63f843000000b0042a9ba927fdmr3851975pgj.440.1661533241500;
        Fri, 26 Aug 2022 10:00:41 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id y9-20020a634949000000b0041d322b3bf6sm1685034pgk.77.2022.08.26.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:00:41 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 0/2] Support for changing address while powered
Date:   Fri, 26 Aug 2022 10:00:30 -0700
Message-Id: <20220826170032.2860883-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v1 -> v2:
 - Renamed the flag from 'LIVE' to 'POWERED'. Live can be interpreted
   differently i.e if it means just IFF_UP/powered or if it means
   connected. POWERED is more accurate to what this feature does.

 - Reworked the logic to check if individual interfaces are busy
   rather than globally. Simply checking local->scanning/roc_list
   was a large hammer, and puts limitations in that aren't needed.
   Now roc_list is traversed and only returns -EBUSY if the actual
   interface has ROC work. Similarly the scanning sdata is checked
   and -EBUSY is returned if it matches the sdata for which the
   address is being changed.

 - Only P2P_CLIENT/STATION iftypes are allowed to do a powered address
   change. I personally see no reason this is needed for other iftypes
   but if we want others to be supported I'm fine adding more.

 - Check return of drv_add_interface

v2 -> v3:
 - Moved address memcpy directly after eth_mac_addr (only if success)

 - Added WARN_ON for drv_add_interface return rather than overwriting
   eth_mac_addr's return.

James Prestwood (2):
  include: nl80211: Add POWERED_ADDR_CHANGE feature
  mac80211: Support POWERED_ADDR_CHANGE feature

 include/uapi/linux/nl80211.h |  9 +++++
 net/mac80211/iface.c         | 71 +++++++++++++++++++++++++++++++++++-
 net/mac80211/main.c          |  2 +
 3 files changed, 80 insertions(+), 2 deletions(-)

-- 
2.34.3

