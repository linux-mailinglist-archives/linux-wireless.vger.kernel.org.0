Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4479F7D88A9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjJZTBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJZTBK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 15:01:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9CD7;
        Thu, 26 Oct 2023 12:01:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB37C433C7;
        Thu, 26 Oct 2023 19:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698346868;
        bh=Zt0u6/5yjWvfQjaE7CB0100aQqTkMVSs6sc0OBl6Scw=;
        h=From:To:Cc:Subject:Date:From;
        b=HOHdtexBWDxHWU+J9CjxvmeZXCoBxZ8Oazg4JSUbWjEXp4mMJuN7bN/+4eQJrOfrN
         w9DAxXktMeNmNtxTLeBH0vs9m9tgBtHrp4YIzWJWhpsavW9CQKx/M1NqPo4UYh1Qzm
         48GeyVTL4bFxPD07c1Ioe2FGgPHu5zHRBt8n0xDnypGI0YD8UmGDd01IV+DQ53lrkV
         IIPTx6Gx14FeQxc9SE4ArILlCkpR3vJ41snO5ZyvUM7tn61xh5n0EyjimRFE5xDt6u
         i7Ucl7m3L2CU09kMdE+uv/7OZOD6zR6pwQxQUgm/FfBInKEk2k1Hr7ao9fzdeBSAzR
         mNlDaMwyh5EHQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, jhs@mojatatu.com,
        netfilter-devel@vger.kernel.org, razor@blackwall.org,
        bpf@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH net-next 0/4] net: fill in 18 MODULE_DESCRIPTION()s
Date:   Thu, 26 Oct 2023 12:00:57 -0700
Message-ID: <20231026190101.1413939-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Fill in the first 18 that jumped out at me, and those missing
in modules I maintain.

FWIW here is the list of places we're still missing some,
as far as I can grep. Please lend a hand and populate
the missing descriptions in your area of expertise if you have
the cycles:

CC: linux-wireless@vger.kernel.org
CC: jhs@mojatatu.com
CC: netfilter-devel@vger.kernel.org
CC: razor@blackwall.org
CC: bpf@vger.kernel.org
CC: krzysztof.kozlowski@linaro.org

     46 in drivers/net/wireless
     34 in net/sched
     25 in net/netfilter
     18 in net/dsa
     17 in net/ipv4
     11 in net/ipv6
     11 in drivers/net/arcnet
      6 in net/bridge
      5 in drivers/net/ppp
      5 in drivers/net/phy
      5 in drivers/net/mdio
      5 in drivers/net/ethernet/broadcom
      4 in net/caif
      3 in net/sunrpc
      3 in net/nfc
      3 in net/mptcp
      3 in net/atm
      3 in drivers/net/pcs
      3 in drivers/net/ethernet/smsc
      3 in drivers/net/ethernet/freescale
      2 in net/xfrm
      2 in net/packet
      2 in net/ieee802154
      2 in drivers/net/slip
      2 in drivers/net/ethernet/qualcomm
      1 in net/xdp
      1 in net/vmw_vsock
      1 in net/unix
      1 in net/tipc
      1 in net/smc
      1 in net/sctp
      1 in net/netlink
      1 in net/key
      1 in net/kcm
      1 in net/hsr
      1 in net/bpfilter
      1 in net/6lowpan
      1 in drivers/net/xen-netback
      1 in drivers/net/wan
      1 in drivers/net/ieee802154
      1 in drivers/net/fddi
      1 in drivers/net/ethernet/wangxun
      1 in drivers/net/ethernet/ti
      1 in drivers/net/ethernet/stmicro
      1 in drivers/net/ethernet/neterion
      1 in drivers/net/ethernet/mscc
      1 in drivers/net/ethernet/microchip
      1 in drivers/net/ethernet/marvell
      1 in drivers/net/ethernet/litex
      1 in drivers/net/ethernet/ezchip
      1 in drivers/net/ethernet/ec_bhf.o
      1 in drivers/net/ethernet/cirrus
      1 in drivers/net/ethernet/cavium
      1 in drivers/net/ethernet/8390
      1 in drivers/net/dsa

Jakub Kicinski (4):
  net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
  net: fill in MODULE_DESCRIPTION()s under net/core
  net: fill in MODULE_DESCRIPTION()s under net/802*
  net: fill in MODULE_DESCRIPTION()s under drivers/net/

 drivers/net/amt.c                           | 1 +
 drivers/net/dummy.c                         | 1 +
 drivers/net/eql.c                           | 1 +
 drivers/net/ifb.c                           | 1 +
 drivers/net/macvtap.c                       | 1 +
 drivers/net/netdevsim/netdev.c              | 1 +
 drivers/net/sungem_phy.c                    | 1 +
 drivers/net/tap.c                           | 1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
 net/802/fddi.c                              | 1 +
 net/802/garp.c                              | 1 +
 net/802/mrp.c                               | 1 +
 net/802/p8022.c                             | 1 +
 net/802/psnap.c                             | 1 +
 net/802/stp.c                               | 1 +
 net/8021q/vlan.c                            | 1 +
 net/core/dev_addr_lists_test.c              | 1 +
 net/core/selftests.c                        | 1 +
 18 files changed, 18 insertions(+)

-- 
2.41.0

