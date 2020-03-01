Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7482C174D5B
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Mar 2020 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgCAMrK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Mar 2020 07:47:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgCAMrJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Mar 2020 07:47:09 -0500
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDFA2087F;
        Sun,  1 Mar 2020 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583066829;
        bh=vztHrmDDBt1Ip3rczVEprxqmls2zFfl3jSXX7WCqGlg=;
        h=From:To:Cc:Subject:Date:From;
        b=RE5e50IMweRlDt122866yi1XVqsjCeGsgOMWhze0rfbz3TV1Qzs2l7DoA5IXbXtSx
         bwjzvEuu1uLn8PuNqQ8/u7eT8ZrjVXc9BYyO/n78MU7Um+Bm0Fo/JfMgal1ICvKRlK
         sJ9dkdtJFBK1z2fdu8ogrWW08ZcleJjBdGBKZwc4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 0/4] use proper size for mt7615 sta mcu commands
Date:   Sun,  1 Mar 2020 13:46:50 +0100
Message-Id: <cover.1583066508.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use proper buffer size for mcu messages in mt7615_mcu_set_sta since
MT7615_WTBL_UPDATE_MAX_SIZE takes into account just wtbl headers while
the mcu message contains even sta related headers.
Use proper buffer size for mcu messages in mt7615_mcu_set_rx_ba,
mt7615_mcu_set_tx_ba and mt7615_mcu_set_bmc routines

Lorenzo Bianconi (4):
  mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_tx_ba
  mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_rx_ba
  mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_sta
  mt76: mt7615: use proper size for mcu msg in mt7615_mcu_set_bmc

 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 354 ++++++++++--------
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  20 +
 2 files changed, 213 insertions(+), 161 deletions(-)

-- 
2.24.1

