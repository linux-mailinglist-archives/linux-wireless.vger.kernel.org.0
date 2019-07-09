Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B576386C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2019 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfGIPO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jul 2019 11:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGIPO7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jul 2019 11:14:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE1DF81E0F;
        Tue,  9 Jul 2019 15:14:58 +0000 (UTC)
Received: from localhost (ovpn-204-53.brq.redhat.com [10.40.204.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A05C87046;
        Tue,  9 Jul 2019 15:14:56 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: [PATCH v2 0/2]  mt76: usb: alignment and endianes improvements
Date:   Tue,  9 Jul 2019 17:14:53 +0200
Message-Id: <20190709151455.24003-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 09 Jul 2019 15:14:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix endian bug and do some minor optimizations in mt76u_{copy,rr,wr} .

v1 -> v2:
- drop patch 3
- fix pointer size in patch 1

Stanislaw Gruszka (2):
  mt76: usb: fix endian in mt76u_copy
  mt76: usb: remove unneeded {put,get}_unaligned

 drivers/net/wireless/mediatek/mt76/mt76.h |  5 ++++-
 drivers/net/wireless/mediatek/mt76/usb.c  | 12 ++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

-- 
2.20.1

