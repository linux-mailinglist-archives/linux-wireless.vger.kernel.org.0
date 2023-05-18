Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD29670849F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 17:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjERPGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjERPGQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 11:06:16 -0400
X-Greylist: delayed 1568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 08:05:44 PDT
Received: from durkon.wrar.name (wrar.name [116.203.248.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD05619B1
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wrar.name;
        s=20160710; h=Content-Disposition:Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Content-Disposition:In-Reply-To:References;
        bh=IUDXPaR3HByrD+Ua2T6+WJzRwIqYMPKFgDK2Bw3UsHo=; b=p1hFnED046Hq2gyfPxfFFyI2fN
        /ZdoOtzhf0bGJLBcIJrbyOeowp0761zWfNEVkuXifxfRLRuALNQneixrojNwJxK3K+zZYso5U1+0t
        2+te3QmBYr/WBFOPdlqy1/ZsXnt3xpqt/6KToCHlhRqd/u9p6LrhEZV0w+nu929A60eY=;
Received: from wrar by durkon.wrar.name with local (Exim 4.96)
        (envelope-from <wrar@wrar.name>)
        id 1pzemz-002Aqs-2t;
        Thu, 18 May 2023 16:39:33 +0200
Date:   Thu, 18 May 2023 16:39:33 +0200
From:   Andrey Rakhmatullin <wrar@wrar.name>
To:     linux-wireless@vger.kernel.org, Neil Chen <yn.chen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: MT7922 problem with "fix rx filter incorrect by drv/fw inconsistent"
Message-ID: <ZGY4peApQnPAmDkY@durkon.wrar.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello. I have a "MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless
Network Adapter" (14c3:0616) and when the commit c222f77fd4 ("wifi: mt76:
mt7921: fix rx filter incorrect by drv/fw inconsistent") is applied (found
by bisecting, checked by reverting it on v6.3) I have the following
problem on my machine: when I connect to my router no DHCPv4 exchange
happens, I don't see responses in tcpdump. My network setup is non-trivial
though, and it looks like the problem is specific to it, but I still
wonder if it's some bug in the aforementioned patch as my setup works with
all other devices and I would expect it to work as long as the network
packets sent by the device are the same.

My setup is as follows: I have an ISP router which provides a 2.4GHz
network and another router (Xiaomi R4AC with OpenWRT) connected by
Ethernet to it that provides a 5GHz network and is configured as a "Relay
bridge" (using relayd) to forward packets to the ISP router and back. This
includes DHCPv4 packets, which are handled by the ISP router. tcpdump on
the machine with MT7922 shows that the DHCP requests are sent while the
responses are not received, while tcpdump on the bridge router shows both
requests and responses.

I've tried connecting the machine to the ISP router network directly and
also to another AP (one on my phone) and those work correctly on all
kernels.

Please let me know if I need to do any other debugging or troubleshooting
steps. Thank you.
