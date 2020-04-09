Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEE071A3305
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgDILPG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 07:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgDILPG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 07:15:06 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B0620757;
        Thu,  9 Apr 2020 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586430906;
        bh=G0QTWF9B9m5sqzs0Qv3MdvSUuoGSy1ZlZD6ekbWLFew=;
        h=From:To:Cc:Subject:Date:From;
        b=J10f1+HSrxk8CCGotAxiQQjaKwYrznBPolJ3c87aWsumVbniSbbNEhAFizfkpbnbN
         r8VWgH2JdJdKgeHwVCMQ6d3IpG/y+0Afwe/RTwe2zLjDHKOtjVKaROZNUfItzHzMY/
         frfNQxC72MEcNxQf7omQ4NlCx9BBhUzi7pNeDVbg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        soul.huang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] fix TXP DMA unmap for mt7622/mt7623
Date:   Thu,  9 Apr 2020 13:14:55 +0200
Message-Id: <cover.1586430566.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible data corruption unmapping hw txp from DMA engine

Changes since v1:
- remove usb series dependency to make backportig easier
- add specific macro for 7663

Lorenzo Bianconi (2):
  mt76: mt7622: fix DMA unmap length
  mt76: mt7663: fix DMA unmap length

 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 26 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  3 +++
 2 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.25.2

