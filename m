Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F201B3A7C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 10:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDVIrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 04:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgDVIrm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 04:47:42 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF2020656;
        Wed, 22 Apr 2020 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587545262;
        bh=lRtm0RuSuuJdGk0FeGI4yJbIwGk/UbBHHHyDcsmTDDo=;
        h=From:To:Cc:Subject:Date:From;
        b=Y4gQoXv9GZl/bIcULNiB9KkKllLIvBVRNhD+7hZKkI+f/AebTr1ZRmzFbnuIkAbxR
         T5dCtd+7tzo+gNY8zntQ77+W2YR/ofu3M7uoNUSvX4S8J09xtaFtlPBdEVX75hqQ1c
         f2fzV5k7oisssmxxI6ginPWjhE0lxqDoF0kgetZ4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] enable AirTimeFairness for mt7663u
Date:   Wed, 22 Apr 2020 10:47:22 +0200
Message-Id: <cover.1587545092.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize tx_status_data pointer in order to enable Air Time Fairness
for mt7663u chipset.
Rework mt7615_mac_sta_poll for usb code

Lorenzo Bianconi (2):
  mt76: mt7615: rework mt7615_mac_sta_poll for usb code
  mt76: mt7663u: enable AirTimeFairness

 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 20 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7615/usb.c   | 12 +++++++++++
 3 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.25.3

