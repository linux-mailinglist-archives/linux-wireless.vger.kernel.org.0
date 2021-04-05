Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E7354213
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhDEMkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 08:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235289AbhDEMkv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 08:40:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90CAA613A7;
        Mon,  5 Apr 2021 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626445;
        bh=gH8Vg05NoIbo+2nK3Pz6VTvJppFutEeqZ+HhOdzn4IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKIazAPdeadBu3sFSydRk5i53GGpo55p+Qgkk7H6/oSZeDMyVpJXW+SfOzTMwg7S4
         nT+TQMgNEfpf+pp6vrAne/vzAYyWLdMOpbtB7xYgw4P0ge+EaXZRrYaxixXN8qRZ0s
         mkO4UrptlA6ziMIPsKkXu+MbwxAAn6n1hMwXPE3ctPEhzoGB8hpW1E3ewZ82tQQfTs
         K0mt+GLLAUdVDG1DLEbO95gX8bSLwa5m32qVtp8ej5PtJKCr8lseoVvxB/eZJFulAP
         8ID5H6k1nGW9Ubpbj4ajMfGRaoGCHIUZ7NVc6P5ZpPiidoQCW7A+NWgAnee7DT8eL+
         aodo5hidBEafg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH 1/8] dt-bindings:net:wireless:ieee80211: introduce regdomain property
Date:   Mon,  5 Apr 2021 14:40:25 +0200
Message-Id: <1ff764d84e1fb83768c2e9d233c27b0ed1ef4294.1617625912.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617625912.git.lorenzo@kernel.org>
References: <cover.1617625912.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add regdomain property to ieee80211 binding

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/wireless/ieee80211.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
index d58e1571df9b..6557c6348cac 100644
--- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
@@ -30,6 +30,15 @@ properties:
       different 5 GHz subbands. Using them incorrectly could not work or
       decrease performance noticeably
 
+  regdomain:
+    minItems: 1
+    maxItems: 1
+    contains:
+      enum:
+        - FCC
+        - ETSI
+        - JP
+
 additionalProperties: true
 
 examples:
-- 
2.30.2

