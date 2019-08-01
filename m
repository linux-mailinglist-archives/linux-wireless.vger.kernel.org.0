Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4D7D787
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfHAI0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 04:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbfHAI0c (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 04:26:32 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597972087E;
        Thu,  1 Aug 2019 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564647991;
        bh=OUCyEnxXJeVibf3oJuE+8cQbZuPsHQNLSgJz2webqng=;
        h=From:To:Cc:Subject:Date:From;
        b=gsD1+GQ+k4S2v9AzDln9zRAwELlf98frgjffkKN1Wxj0brhz6VqXWQGmKya5UCclL
         WmnvLFFvAF9O58Dq1CAdjkMZLOgn0OW7ef+ma8YLRa4H0XQIwnfOkE0yGf2evpt0+v
         tuOcdOGdp7KJKYIAJysww5qNdXdGsiHtUMDEc1JQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sgruszka@redhat.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] mt76x02: tidy up beacon shared code
Date:   Thu,  1 Aug 2019 10:26:21 +0200
Message-Id: <cover.1564647482.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not copy beacon skb in mt76x02_mac_set_beacon_enable for usb devices
since it will be done in tbtt tasklet. Moreover tidy up a bit beacon
shared code

Lorenzo Bianconi (2):
  mt76: mt76x02: introduce mt76x02_pre_tbtt_enable and
    mt76x02_beacon_enable macros
  mt76: mt76x02: do not copy beacon skb in mt76x02_mac_set_beacon_enable

 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  5 ++
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 66 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  4 +-
 5 files changed, 37 insertions(+), 44 deletions(-)

-- 
2.21.0

