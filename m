Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430A5908FD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiHKXNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiHKXNq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 19:13:46 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CD4A0627
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 16:13:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 73so18353611pgb.9
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=P7tMDnEeGkYlF38PwhDl5wR3eFh08lAKI8j0M5pWmcc=;
        b=fG3M7022RS5BeuM4afs/gDnMuiHhLJ2vb/RF5k8NRow/5/HqpIK6GGfxV9jK6MViXr
         MIcEO30C50C2qFTTKx3ulQ2vKFbXa22pDpip62Caoj548Ecv3y+MiV5D4QtqKFXqYiqG
         JBlxxyaPNFvI0KwsnME1SAEjCA46L5Bi7xgdjf7R+cw2GEkZlOEymLAHONtddPauN5M4
         fGpmXA/xswE4RaiAM6qiNydJtlEWaLlRvyKxQ07PF4OxIvEe1pkPNo6Z3EKyVfWAQ5Uc
         5EXItGiksZvciqNeCVnTZl2mHUrcuSA/WBFQ+1uYbDxgqg7j0lrg9V9opsx22OfQbSC+
         biqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=P7tMDnEeGkYlF38PwhDl5wR3eFh08lAKI8j0M5pWmcc=;
        b=JP+pSLRUz8w0w3Yhl4zE6Ck6FroJcuZVcwgV9oWA+tHpfI6U9/fyER/0ghMp8zSmgc
         nCD1WojbXIs2nMkWIcm/8CrU2Un0XoSbMRuGjBokuT9N9qbCCdKBxo0PsBxn/sCvO+V7
         YGy8iwe0By7ozTM0XdZ+JtZUU1vlljBJr2CS/vCiJvAt91FNjrQhgAOcy2KX/q9aWlOW
         tfNiacpwIlzpZqTc8Ywu55Xep3Z3PFyp+n69z0j9h1fWFCvMyu1R4HomA9SNibvPI3ZS
         paNf83nDHos1XcWTiEYtk0MGcHlXkiFTL0F0NhquZ2XaoG7mh8MKZE/8vfVnK6QvEVO4
         yrSA==
X-Gm-Message-State: ACgBeo0xdpqW2EPjcqX2ODlh7xygiovJczQRy/Yx6sH6LXL6hw0+LsMA
        puKYi25DiJ1X6Wc1woGzyKQpkKoL2uQ=
X-Google-Smtp-Source: AA6agR6Ai4Xds1vvd/DuCHbf2KOheGQBR3Hilt3MsOP5LbzRk+RH0GArl9ojW76Jgkhs9Zta2wprdA==
X-Received: by 2002:a63:5d4e:0:b0:41d:dcc3:aa85 with SMTP id o14-20020a635d4e000000b0041ddcc3aa85mr986145pgm.324.1660259624134;
        Thu, 11 Aug 2022 16:13:44 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016d2db82962sm227644plg.16.2022.08.11.16.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:13:43 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 0/2] Support for changing address while powered
Date:   Thu, 11 Aug 2022 16:13:36 -0700
Message-Id: <20220811231338.563794-1-prestwoj@gmail.com>
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

James Prestwood (2):
  include: nl80211: Add POWERED_ADDR_CHANGE feature
  mac80211: Support POWERED_ADDR_CHANGE feature

 include/uapi/linux/nl80211.h |  9 +++++
 net/mac80211/iface.c         | 67 ++++++++++++++++++++++++++++++++++--
 net/mac80211/main.c          |  2 ++
 3 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.34.3

