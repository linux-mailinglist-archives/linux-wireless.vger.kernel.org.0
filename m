Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2830BC7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfEaJjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 05:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfEaJjC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 05:39:02 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CD6D266FD;
        Fri, 31 May 2019 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559295542;
        bh=+eiytJyZx9ZqZGyeuytr5k+fhLSuQwqrKYMTPYmlakw=;
        h=From:To:Cc:Subject:Date:From;
        b=z5uEEmFZReJsiUJ+quaLxb6lZ4hMpZ22Ey3eLfs7MGGNvQXSR1F6DKUH19kH8cbNB
         z78L341gr2cri6sfOn1SpcHEBjKms7+Tr60JtJBy+OpsloORlZGUWTB3eepZiC0d9H
         fxCVFHTtTQSRT4bx/xLu9zFQMW4PH48FZzXhdm6s=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sgruszka@redhat.com
Subject: [PATCH v2 0/2] mt76: usb: fix A-MSDU support
Date:   Fri, 31 May 2019 11:38:21 +0200
Message-Id: <cover.1559293385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reallocate the skb if there is no enough space to manage the AMSDU rx packets.
Do not always copy the first part of received frames if A-MSDU is enabled
for SG capable devices

Changes since v1:
- do not allocate multiple page buffers but rely on fragmented skbs
  if there is no enough space to manage the AMSDU rx packets

@Felix: do you prefer to take this series in your tree or is it better
to merge it in wireless-drivers?

Lorenzo Bianconi (2):
  mt76: usb: fix rx A-MSDU support
  mt76: usb: do not always copy the first part of received frames

 drivers/net/wireless/mediatek/mt76/mt76.h |  4 ++
 drivers/net/wireless/mediatek/mt76/usb.c  | 64 ++++++++++++++++++-----
 2 files changed, 55 insertions(+), 13 deletions(-)

-- 
2.21.0

