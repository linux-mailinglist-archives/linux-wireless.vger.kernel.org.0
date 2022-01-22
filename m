Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4D496CC0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 15:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiAVO7O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jan 2022 09:59:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57400 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiAVO7N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jan 2022 09:59:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 473CBB80092
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 14:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6794C004E1;
        Sat, 22 Jan 2022 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642863551;
        bh=0W+VI1N6sZjS7vHcKnn0vgvT7UkipBNau97emmZPgAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=u1N2Zumds50ZaR5v8/yG4iRWzTUsSMvv/8C0ivGp/+hNLdKgG6oxWaVtDJ1kXLYo3
         xbLnirIUdGGk2QFZrYrRCJ8d9DfR8zi8rHbFq9i9TYhyVL/VsXhtt2joKput3c1uTt
         316mSaiFxzeeDo5KHT0i3qLW+QeQViAfCmYHYboZytweuzyCvi2z8uJ58Id2RyK0zK
         aj3G9VZYnmHqkQRxTCj+jJsxuJ12pIkO+K+RoGD/+bUuyHDuEu0HkctlXeC2QgrS0B
         yItSz4gH2zJV0NKMik9tSrl//b2kEM0a5ZF3JB42vmxfBRu2RHRxi/0NbZBLnEEjWc
         e9hgBQ3dxH64w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 0/2] check sta_rates pointer in sta_rate_tbl_update callback
Date:   Sat, 22 Jan 2022 15:58:56 +0100
Message-Id: <cover.1642863255.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix potential NULL pointer dereference issue.

Lorenzo Bianconi (2):
  mt76: mt7603: check sta_rates pointer in mt7603_sta_rate_tbl_update
  mt76: mt7615: check sta_rates pointer in mt7615_sta_rate_tbl_update

 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 3 +++
 2 files changed, 6 insertions(+)

-- 
2.34.1

