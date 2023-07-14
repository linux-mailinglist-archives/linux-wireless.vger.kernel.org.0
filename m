Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB72D7530BA
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 06:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjGNEvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 00:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjGNEvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 00:51:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B782D63;
        Thu, 13 Jul 2023 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fBHNk/5teiKF0xP49UxyZpW8fISmJXjYny9DANXhPDk=; b=2COurhKX5QFYivf6i7Zr/aNn73
        QFFQ79/cPF9S01KhV09HQkEqM5Bt35VjzWKVmNOKOT3MEeM6pkE3uEDw8ivqQBpq9erUaV3YkcIvf
        4KKB3kjBHTP34sgqauv/08O/xu4iuu66FaTGHGzWq+YYuAeG1ih+6cqEkeUsYVeJQ23Ksa24W33I3
        eIVIANOCr6Z4LCeia34z+kHDpbc3bsUYs8FLvJPlbpV5AWHUNH/9CxsPCBrqTMHsyr6o+iU71HABO
        HhpCvEEbemhL+GihI88F8uZQPx0QmjmcwABlhqL2FW8SBPTYWqGXFgOvVYXoRjVyNu5+T2K6gZcvL
        8CIe6Kgw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qKAm8-0050ZV-2k;
        Fri, 14 Jul 2023 04:51:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     netdev@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Dave Taht <dave.taht@bufferbloat.net>,
        Moshe Shemesh <moshe@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Jiri Benc <jbenc@redhat.com>,
        Leslie Monis <lesliemonis@gmail.com>,
        "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
        Gautam Ramakrishnan <gautamramk@gmail.com>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v2 net 0/9] net: fix kernel-doc problems in include/net/
Date:   Thu, 13 Jul 2023 21:51:18 -0700
Message-ID: <20230714045127.18752-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix many (but not all) kernel-doc warnings in include/net/.

 [PATCH v2 net 1/9] net: bonding: remove kernel-doc comment marker
 [PATCH v2 net 2/9] net: cfg802154: fix kernel-doc notation warnings
 [PATCH v2 net 3/9] codel: fix kernel-doc notation warnings
 [PATCH v2 net 4/9] devlink: fix kernel-doc notation warnings
 [PATCH v2 net 5/9] inet: frags: remove kernel-doc comment marker
 [PATCH v2 net 6/9] net: llc: fix kernel-doc notation warnings
 [PATCH v2 net 7/9] net: NSH: fix kernel-doc notation warning
 [PATCH v2 net 8/9] pie: fix kernel-doc notation warning
 [PATCH v2 net 9/9] rsi: remove kernel-doc comment marker

v2: drop the wifi/80211 patches, waiting for their reviewers or
    maintainers;
    include/linux/inet_frag.h: keep the kernel-doc comment;

 include/net/bonding.h            |    2 +-
 include/net/cfg80211.h           |    1 -
 include/net/cfg802154.h          |    3 ++-
 include/net/codel.h              |    4 ++--
 include/net/devlink.h            |   28 ++++++++++++++++------------
 include/net/ieee80211_radiotap.h |    3 ++-
 include/net/inet_frag.h          |    2 +-
 include/net/llc_pdu.h            |    6 ++++--
 include/net/mac80211.h           |    1 +
 include/net/nsh.h                |    2 +-
 include/net/pie.h                |    2 +-
 include/net/rsi_91x.h            |    2 +-
 12 files changed, 32 insertions(+), 24 deletions(-)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: linux-wpan@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Dave Taht <dave.taht@bufferbloat.net>
Cc: Moshe Shemesh <moshe@mellanox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Leslie Monis <lesliemonis@gmail.com>
Cc: "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>
Cc: Gautam Ramakrishnan <gautamramk@gmail.com>
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
Cc: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Cc: Kalle Valo <kvalo@kernel.org>
