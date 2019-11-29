Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82010D5B4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 13:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfK2Mcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 07:32:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfK2Mcl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 07:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575030759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aVajMN793z3MwU2nyV7htsNWtWzcj31OH9XrcpEPIVU=;
        b=DMNql7cjVkHeFo/7yCaO78+MPtNsSuTVyoFVdKpwYNFj+JVuSdnZ43JmE9/O5CLizH++dP
        BWkBeAaaqs9+k9oTz4MAUso0T/DADic83simZ24XEyUA4VjurSFO4myHHBoEF5S8ypi32B
        4ckArUjBwAF+xRdQQdIvn0wtIWpJcaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-G4QbuEbJP9SjcROH5AjwdA-1; Fri, 29 Nov 2019 07:32:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3436107ACC9;
        Fri, 29 Nov 2019 12:32:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84D8819C58;
        Fri, 29 Nov 2019 12:32:34 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 0/3] mt76: some further beaconing optimizations and cleanups
Date:   Fri, 29 Nov 2019 13:32:25 +0100
Message-Id: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: G4QbuEbJP9SjcROH5AjwdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is based on top:
[PATCH v9 0/6] mt76: channel switch support for USB devices
https://lore.kernel.org/linux-wireless/20191126214704.27297-1-markus.theil@=
tu-ilmenau.de/T/#t

Stanislaw Gruszka (3):
  mt76: usb: use max packet length for m76u_copy
  mt76: mt76x02u: do not set NULL beacons
  mt76: mt76x02: minor mt76x02_mac_set_beacon optimization

 drivers/net/wireless/mediatek/mt76/mt76.h          |  7 +++---
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c    | 14 ++++-------
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |  6 ++---
 drivers/net/wireless/mediatek/mt76/usb.c           | 27 ++++++++++++++----=
----
 5 files changed, 27 insertions(+), 29 deletions(-)

--=20
1.9.3

