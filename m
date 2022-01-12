Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D2148CA79
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 18:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355847AbiALRy5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 12:54:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46402 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355857AbiALRy1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 12:54:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B1361965;
        Wed, 12 Jan 2022 17:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A879C36AEC;
        Wed, 12 Jan 2022 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010067;
        bh=KlbSJ84GxXqtKytAOuyf5OkkogjD00waHhv49ntp9Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeHSJgvf19JVSzLsW/plfX7fWYAVImyKZu7o5k+xIsTAxqhvRGAco0JXDWGh1EeaK
         jFNDj/5iZE75H8m5k07x6oeNmfk11XmKLi3ZKtucDm9Pu2y/0Y870WYSjBtV019d2h
         Rd2WcZbk3O4HGTPNjTU83XfcX2l/q1PaQUDMmLG2kMOrGSWvpG25ghEwU0D+Nx2Dpp
         b6iwDpUFJvT5iw1rI2bBAYxhqpAXfXjnMGF1nNasDa+E+Cg1XRxS24lLqVZ9dz19Ad
         paX/PV6DZUiac/6kRyy6nvYbsXhPYXTKrldmQGou67/7eVSwFTm/Ygr8enuYZVCJyO
         DQKj/+mdlBq1g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com, devicetree@vger.kernel.org, robh@kernel.org
Subject: [PATCH v2 6/6] dt-bindings:net:wireless:mediatek,mt76: add disable-radar-offchan
Date:   Wed, 12 Jan 2022 18:53:55 +0100
Message-Id: <221dab8bcc95160652e608def16d822da78717bd.1642009736.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1642009736.git.lorenzo@kernel.org>
References: <cover.1642009736.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the capability to disable/enable radar/CAC detection running on
a dedicated offchannel chain available on some hw.
Offchannel radar/CAC detection allows to avoid CAC downtime switching
on a different channel during CAC detection on the selected radar
channel.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/wireless/mediatek,mt76.yaml  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index 1489d3c1cd6e..4a564bb59552 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -69,6 +69,15 @@ properties:
       calibration data is generic and specific calibration data should be
       pulled from the OTP ROM
 
+  mediatek,disable-radar-background:
+    type: boolean
+    description:
+      Disable/enable radar/CAC detection running on a dedicated offchannel
+      chain available on some hw.
+      Background radar/CAC detection allows to avoid the CAC downtime
+      switching on a different channel during CAC detection on the selected
+      radar channel.
+
   led:
     type: object
     $ref: /schemas/leds/common.yaml#
-- 
2.34.1

