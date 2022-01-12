Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E55D48C5BF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 15:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354053AbiALOPE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 09:15:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34256 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354020AbiALOOn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 09:14:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32DC6B81EFB
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 14:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FFFC36AEB;
        Wed, 12 Jan 2022 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641996880;
        bh=KlbSJ84GxXqtKytAOuyf5OkkogjD00waHhv49ntp9Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fj2e8uVpDCyNdx7g/ALJWdJ1KxcDKg/3wAvsnw7HKYKPZyTWpazoZ2YYVdkFu1qSL
         46v2BCiYU7xulH6yvHXiLqHcUKAlExEofDS4meut7j5gvBU7RAMmz18Be1WVOv2V6O
         WGwrs8aTfgMNqP9YfkY6Ez1+SOlXnWPpGWmWIOK8yDuOMJ53zS7puGeBQ5iWIChSQq
         9BQ2cK2DDDguSrUckUo3bNyJI2fiBgituEzE5pvnEKLMR+ML5+Rdt8JuN7Y9oB7ksX
         HO1z56TLqivZPwWM9gmupFZR8nrtQ2c7OLu6cQ1H6OP/pqSKUN1AFiS6aMvwm6oN9q
         ymDJ4N6u7XN7w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        owen.peng@mediatek.com
Subject: [PATCH 6/6] dt-bindings:net:wireless:mediatek,mt76: add disable-radar-offchan
Date:   Wed, 12 Jan 2022 15:13:53 +0100
Message-Id: <221dab8bcc95160652e608def16d822da78717bd.1641996493.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641996493.git.lorenzo@kernel.org>
References: <cover.1641996493.git.lorenzo@kernel.org>
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

