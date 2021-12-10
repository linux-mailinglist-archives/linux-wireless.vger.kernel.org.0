Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904E6470BD6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 21:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbhLJUd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 15:33:58 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:35688 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344099AbhLJUd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 15:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=+NpOehySltyCypzbVMhvv0tPbuHKZym6FFnLyfWkbDI=;
        b=e9qC7fJvzL5/PXnCsf4+OSPZBH0KVCni+h0iqsavUb95x4iyVXq3T3smLUAa8LfboVZB
        9Za+5PzarZRsSX50sXYJKWS1fbsd2OHuwYu8F4NZN90hDO5AWD7pn8kX7sQTGA5vLVQSOv
        SSk99NvZPItZ/HZ0idSqIjxNOduljUkZ/s12e+gkci23/S0Ise4t35CG9UKiwOsOXtLAx+
        BDXQp1kPzdvhcscmWTjOkb0JBmx9k9MFOc/Gh8hTSCcM9Td+XQiJGl99JIHDdbJVKlNuhL
        TUJOtOHv45Lg3BMcQjaEQZpuehg3tRUIcb0BdAM3VPD/zExkV1H0sbEvqtQWo82A==
Received: by filterdrecv-75ff7b5ffb-6sw96 with SMTP id filterdrecv-75ff7b5ffb-6sw96-1-61B3B8DD-62
        2021-12-10 20:30:21.820272493 +0000 UTC m=+8633433.891931294
Received: from pearl.egauge.net (unknown)
        by ismtpd0071p1las1.sendgrid.net (SG) with ESMTP
        id t6OXiadlTpmX_aJTM3IYrg
        Fri, 10 Dec 2021 20:30:21.741 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 0B9D27003A5; Fri, 10 Dec 2021 13:30:21 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH v2 0/1] wilc1000: Improve WILC TX performance when power_save
 is off
Date:   Fri, 10 Dec 2021 20:30:21 +0000 (UTC)
Message-Id: <20211210203016.3680425-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvMm3tHUznJY4FyN22?=
 =?us-ascii?Q?PQIX3ei8Vj3ZQzBa34y9VGXec41DgT5gGNirQyz?=
 =?us-ascii?Q?XDXXwgsRFMbDcuoDhRBiGnDSqnr8q0ZhAo52XBb?=
 =?us-ascii?Q?ft7mXR1F9QwxZ9GVNu1vMGa5Ppt6Sk4hx6iFHq=2F?=
 =?us-ascii?Q?8Ana6dVNT1BKXCQgbm8OWTzx9frBqhlyU+9VYXr?=
 =?us-ascii?Q?tC6bc4LHHpZLz3SI04GOw=3D=3D?=
To:     Ajay Singh <ajay.kathat@microchip.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v2 fixes a typo in the commit text and a merge error in netdev.h where
bool power_save_mode ended up in the wrong struct.  Sorry about that.

David Mosberger-Tang (1):
  wilc1000: Improve WILC TX performance when power_save is off

 drivers/net/wireless/microchip/wilc1000/hif.c    | 3 +++
 drivers/net/wireless/microchip/wilc1000/netdev.h | 1 +
 drivers/net/wireless/microchip/wilc1000/wlan.c   | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1

