Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8576247512D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 04:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhLODFK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 22:05:10 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:26142 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhLODFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 22:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=Ls8j47hOTarbmFkR53bHtGHdrkIH64MOaFw8ETpWEuw=;
        b=E45IPRM8T6ONU8lRlr6hNVhXHMFNA2USdrXtZkJwSsEz7ELAwFicD/dki2Bh6gVaYvTi
        vuCHqhVefFsrWlEpFHngbKzRZcFyTo65hDnNrdWKrvEH7A7WneEUsyLu2FVsOKZQbzMGNU
        qH4R87ZaD3n/yWg63BsDNQBgxSa75/hOHd5gJ9ICu3T5AMhYpd/aYG4lScZ6BHVGv6uYXh
        7Ue/+gS7S+FvC+1WQjvJW6BWXE+fvMZ8ANRLlelmgO97zVteY46w3bcGSQkBpM3O9DpyTG
        w5r9Vz43OegKABqQObKinav9FdRr71AHhukVXuuS1XgWYrc0aPQDYQ785EORLVkg==
Received: by filterdrecv-64fcb979b9-4vrtk with SMTP id filterdrecv-64fcb979b9-4vrtk-1-61B95B64-71
        2021-12-15 03:05:08.668624112 +0000 UTC m=+7960102.735415456
Received: from pearl.egauge.net (unknown)
        by geopod-ismtpd-4-0 (SG)
        with ESMTP
        id 3kHXgrz6SCq235HMX0p6oA
        Wed, 15 Dec 2021 03:05:08.450 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id A0FDD700269; Tue, 14 Dec 2021 20:05:07 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v5 0/2] wilc1000: Add reset/enable GPIO support to SPI driver
Date:   Wed, 15 Dec 2021 03:05:09 +0000 (UTC)
Message-Id: <20211215030501.3779911-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvIOjWBalr+hnP8B6L?=
 =?us-ascii?Q?8aWFjMIhUCNYw8purQU7DtUM4U1Xy9DQwyxhe7y?=
 =?us-ascii?Q?au6o4sI7Z=2F=2Fx1QNmQruWvJdfebgfBVICMPkpWXD?=
 =?us-ascii?Q?mFFqPZe2y=2FoYL=2FYyjxR+9sy=2FCwUdDiT9QmkhZFy?=
 =?us-ascii?Q?gnuGqBWepnBrnPB603FAgYcBDwV6=2Fo1jME=2Fwmsv?=
 =?us-ascii?Q?ZogEQ1vqt0EvtNUrnF8Nw=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Adham Abozaeid <adham.abozaeid@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The only change in this version is to fix a dt_binding_check error by
including <dt-bindings/gpio/gpio.h> in microchip,wilc1000.yaml.

David Mosberger-Tang (2):
  wilc1000: Add reset/enable GPIO support to SPI driver
  wilc1000: Document enable-gpios and reset-gpios properties

 .../net/wireless/microchip,wilc1000.yaml      | 19 ++++++
 drivers/net/wireless/microchip/wilc1000/spi.c | 58 ++++++++++++++++++-
 .../net/wireless/microchip/wilc1000/wlan.c    |  2 +-
 3 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.25.1

