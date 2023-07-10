Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2830174E1AF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 01:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGJXDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 19:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGJXDV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 19:03:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B798E42;
        Mon, 10 Jul 2023 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hEmg3A0RYm7ry5jQKFwhBPeFaR0jwydfS2VR7x1r72Y=; b=W3k4lCx1bPdNRNN0M14srtcpat
        2p26tO4jXRFFQyO45qpXAT83Vjaj9en+Wyg4syI+e6pmY+zV8d7vBiHGSMnMRnvEUq2vvX6zOqnSL
        3ghf7W0Oq/cblsFUiqQFCcqKC2QoLPLPStw0a9SwIgBi9fH5K+wHzOL81Gm1lYtDdg4vfpJwX5GPK
        AHt3u9Pm1/YySHr70TzWMhmPFyQZ/I1PSXFjXrq601W5sU3gY0ptzpfHXumxAwQQ+NXuWhpjPtEg2
        om6bIXqMgTL31pssKF5Z+gexvdcAANlwSgchRSGOIFlKO0JfEkTGfXEjvhd+cVz4ziK/qU2IMwFDr
        gMDK/7mw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIzuU-00CuO1-0m;
        Mon, 10 Jul 2023 23:03:14 +0000
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
        Arkadi Sharshevsky <arkadis@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Yi Yang <yi.y.yang@intel.com>, Jiri Benc <jbenc@redhat.com>,
        Leslie Monis <lesliemonis@gmail.com>,
        "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
        Gautam Ramakrishnan <gautamramk@gmail.com>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH net 00/12] net: fix kernel-doc problems in include/net/
Date:   Mon, 10 Jul 2023 16:03:00 -0700
Message-ID: <20230710230312.31197-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
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

Fix many (but not all) kernel-doc warnings in include/net/.

 [PATCH net 01/12] net: bonding: remove kernel-doc comment marker
 [PATCH net 02/12] wifi: cfg80211: remove dead/unused enum value
 [PATCH net 03/12] net: cfg802154: fix kernel-doc notation warnings
 [PATCH net 04/12] codel: fix kernel-doc notation warnings
 [PATCH net 05/12] devlink: fix kernel-doc notation warnings
 [PATCH net 06/12] wifi: radiotap: fix kernel-doc notation warnings
 [PATCH net 07/12] inet: frags: remove kernel-doc comment marker
 [PATCH net 08/12] net: llc: fix kernel-doc notation warnings
 [PATCH net 09/12] wifi: mac80211: fix kernel-doc notation warning
 [PATCH net 10/12] net: NSH: fix kernel-doc notation warning
 [PATCH net 11/12] pie: fix kernel-doc notation warning
 [PATCH net 12/12] rsi: remove kernel-doc comment marker

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
Cc: Arkadi Sharshevsky <arkadis@mellanox.com>
Cc: Moshe Shemesh <moshe@mellanox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Cc: Yi Yang <yi.y.yang@intel.com>
Cc: Jiri Benc <jbenc@redhat.com>
Cc: Leslie Monis <lesliemonis@gmail.com>
Cc: "Mohit P. Tahiliani" <tahiliani@nitk.edu.in>
Cc: Gautam Ramakrishnan <gautamramk@gmail.com>
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
Cc: Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Cc: Amitkumar Karwar <amit.karwar@redpinesignals.com>
Cc: Kalle Valo <kvalo@kernel.org>
