Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855042937BA
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Oct 2020 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392613AbgJTJNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Oct 2020 05:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392600AbgJTJNR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Oct 2020 05:13:17 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB74522283;
        Tue, 20 Oct 2020 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603185196;
        bh=IEagPhxO2seQqIZQ8MdGdt+nesUXIe9CF3ekVSQdzPA=;
        h=From:To:Cc:Subject:Date:From;
        b=G8sW6mtWMPTtezsm/5B4sU3mRznXf3fjvCqudlPWW1Blxfnv34YkFme1UdjadEtDt
         doa/lYiBN0sE5418eXhiKRMOVcRvUhLQ0Vprax1tVfYrH3g9NIqI7tyaCzHmhAMRv8
         gnhi973dok9I0JZpyCsIKEBMoaRdOntzjlqkpQ4Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 0/2] mt76u: convert rx/status path to worker APIs
Date:   Tue, 20 Oct 2020 11:13:09 +0200
Message-Id: <cover.1603184783.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to improve parallelism and improve performances, convert
rx and status path in mt76-usb module to mt76 worker APIs.

mt7663u upstream codepath:
TCP tx: ~420Mbps
TCP rx: ~360Mbps

mt7663u worker APIs:
TCP tx: ~455Mbps
TCP rx: ~380Mbps

Lorenzo Bianconi (2):
  mt76: mt76u: rely on woker APIs for rx work
  mt76: mt76u: use dedicated thread for status work

 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  9 ++-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  1 +
 drivers/net/wireless/mediatek/mt76/usb.c      | 68 +++++++++++++------
 5 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.26.2

