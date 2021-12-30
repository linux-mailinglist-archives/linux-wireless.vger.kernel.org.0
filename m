Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01510482051
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Dec 2021 21:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhL3UrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Dec 2021 15:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbhL3UrU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Dec 2021 15:47:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A6DC061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 12:47:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C0A5B81D0C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 20:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74012C36AEA;
        Thu, 30 Dec 2021 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640897237;
        bh=aDUn5VmeR6XYGgXywJIGcOT9mT8VZN1pkrNmULVCWbc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZymQmfi2VlAcjz/T3B4x2xtvE6Qv98xgokCAc5r3i/dsbdB2sVtDGj50zSZ/4Qxsw
         yjdnCvIT3xY+4TG2cPkj2ODEmfeu0nMm9IIP6Xjnx7bXSc4d0cnWa9pc33Cd1FMs3L
         Rvicl7EXtRbHuTQBC+ZHBTzuD0ZLq84QZhxLO6qROXgqZo5v8IlVkJHXqIVbI2F0mJ
         kCWFBqawzKf3oVqFEBWDY79NSIaOWhdQyEo69lt4eLHkChRAOKIwI4jLuPSFg7hkTS
         zi0ieV5WEd4dkXCI5/6Jxs3vWsq2tDRpHr37Xq/G85vQVyuK9hlJQxPAd+4xi0i26y
         CqOJxudNnPLlA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH 0/2] mt76: fix a leftover race in runtime-pm for mt7663/mt7921
Date:   Thu, 30 Dec 2021 21:47:04 +0100
Message-Id: <cover.1640897147.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi (2):
  mt76: mt7921: fix a leftover race in runtime-pm
  mt76: mt7615: fix a leftover race in runtime-pm

 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
 2 files changed, 16 insertions(+)

-- 
2.33.1

