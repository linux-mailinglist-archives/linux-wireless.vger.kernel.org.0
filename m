Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2542DD507
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgLQQSd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 11:18:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:45479 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgLQQSc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 11:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608221818;
        bh=nxCXUf9seANU3wrKTen7gr4J7QdPCkxKX1AT+wOJnN8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=d5oSDotbwK/41RPvC71k5kSSrF7jR79Ixix9lG0VEcRJ9iJdt8lYp8ZhlX9RgN0xx
         hS4bu8HKdqNr1gmGfjIt4gRHNxum6GygDXZEF8OE7wRhWAMKIBbdbdMIMttHeTVcze
         qE96xFGtzaYnBr6a6uF/1944Ga2h2k6e8l0BzOis=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from E480 ([188.105.239.238]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1kFmGH246F-00aAF1; Thu, 17
 Dec 2020 17:16:58 +0100
Date:   Thu, 17 Dec 2020 17:16:57 +0100
From:   Zhi Han <z.han@gmx.net>
To:     linux-wireless@vger.kernel.org
Cc:     kuba@kernel.org
Subject: [PATCH] mt7601u: check the status of device in calibration
Message-ID: <20201217161657.GB12562@E480>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:wAbJD1Cd6P0gni3+u5UR/PEOa5VrGrGT3FI/gHWqlrIimeTY97v
 jMTCa5Ds2wm0F9xdyptKD8N8XGllPp3Oa8uAkag9Y/6AAeECpEPW5sKh09dNUiTac21KX9Z
 KeJPgGJvuHlvSUXL4/7MOZ7AX/0jz6xFzv7fX/vABeS07eZMqOyHTj+pzyWXdrBlFc9Gx13
 30NOAyL5HF+TfhVpeGZCg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x5L2z+qPmwc=:5cr7Z2s82YlWpKuMcZy8jS
 sW/fMzAUkkbrFA+Qp2uHi5jLDEOb7m/lUx5gzJ91PGsU56MbsjwB9Ou/KAZsF334O/VoKUNLY
 xh2QisFIEYwDm+wWi0OSPCmWjMFEQFNmFuMM8VgFZBRCRGr11fzVFsXHwIMsYFj6CI0xR8ksC
 r8HmoxugTxEt7oEjQfjzDmgUYQ3rRPI3fRF1bUMDcILdQVUWntV6UkSP80+byxyDBBFgtyvH7
 A4jhXZa9+q76/Six1mXIWG66+YwPrfL+1nq4zAspKxcrcxJOHYfs/5vwvQZkiIEIuUFmdKu2Z
 1P8Ky1nD1h4nxS8RowlsA0bf8fcaYN41RitgjzZHD9enJI4xdNg3oQaMEkRFmAwFe7vM2NPIL
 fhIZWHHuxZhEoo/bJQxnl+Vv8L/vvqIrLRXIU6FLShHbhhQ0NXqjc5NR24oDxkyldCzBvZ/sq
 2quW0wT9wiNEifU03AaLSGRuW6BZlcxuLQS8ehS3P88ppnicOf6eBezb0PsBBgVwO8EwWls2k
 TRNMPWe3ei686enAI1V0caJD0mOl2Oecoa4i2outBYAN7j6ZBqu7wzy5+aG3X20lN1EDAI1lb
 XLLWpqlq2+2DBFXLtSuNoJzme73ZRw4siZTJ6XoCPyCYwV4eTd0yGDViPT2Gp7vgSVx5PNBZu
 hTgHeFmzfKWunYo3TeuWKQUhr0dkII/RiyqOp+zqLF5rX2w4aF+Pn+o0NK2jnQCjhqZENvOqf
 bI1G+xj2Neicl353mcFzD6Rz+mvwI4vjZo6R9NxQXLcV1P+TDq7J4TgrYVclQgYZmyuIKO5sc
 pv2v1Eb9G+3meKhqXhqryGpRaToHC7XrxdrB0pTYyJDioG1zsVYYlBgpvJd2DGb8hEys2Nh4M
 Tdw+C9ox/v0gvWknM2gQ==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the usb device being plugged out, before ieee80211 gets to know the
hw being removed, it gets to know that the association status changed,
and thus ask for the device to do the calibration. This causes error as
the hw is absent.

This can be avoid by checking the status of the device before sending
the calibration request to the device.

Signed-off-by: Zhi Han <z.han@gmx.net>
---
 drivers/net/wireless/mediatek/mt7601u/phy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wireless/mediatek/mt7601u/phy.c
index 28db24a2b5e5..8a00f6a75ca9 100644
--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -586,6 +586,9 @@ static void mt7601u_rxdc_cal(struct mt7601u_dev *dev)

 void mt7601u_phy_recalibrate_after_assoc(struct mt7601u_dev *dev)
 {
+	if (test_bit(MT7601U_STATE_REMOVED, &dev->state))
+		return;
+
 	mt7601u_mcu_calibrate(dev, MCU_CAL_DPD, dev->curr_temp);

 	mt7601u_rxdc_cal(dev);
