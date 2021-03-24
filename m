Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36ED8348423
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhCXVu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 17:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231904AbhCXVuQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 17:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1BF36191C;
        Wed, 24 Mar 2021 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616622615;
        bh=lbn5IZ8HCqmBvnqx93N+qW0Wafron55Vddr9PsIMY/g=;
        h=From:To:Cc:Subject:Date:From;
        b=ploiUUcrM3zhbC0NeQkyo1L8xaJasTLIcB4jrF3Yj+Vq0vX0J461nvVghHjFqSRSV
         6MvdC9ItxtHXL3CQSHPP/cbNW0IobKpS/YY6oUuLU5oRxgidQdixwW8TKqYRlFdMjp
         GfopC0nQ5JG5FFQmFcbCIYs8Frndk8EA/T5oOdM6FOAQnjzF8EUIfgkgGq8/8FemQe
         irIMOhgFaejwRQVbptDZGKtqwdli1XcdobMrKEYQaq080TEbtecSQTEyGUJP/OAcS/
         DnFW2Itw9jTBfeYIiCABOmk9Z54O9g67WFflW32igfI6FnG1Vl/ODYzuAA7Mxu5LnL
         EEGU5T7Qj5p3Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, robh@kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] dt-bindings: convert mt76 and ieee80211 in yaml
Date:   Wed, 24 Mar 2021 22:49:58 +0100
Message-Id: <cover.1616621229.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert mt76 and ieee802111 dts bindings from .txt to .yaml

Changes since v2:
- add myself as ieee80211.yaml maintainer
- add Ryder as mt76.yaml maintainer
- fix led node in mt76.yaml
- fix ieee80211.yaml refernce in mt76.yaml
- fix ieee80211-freq-limit property in ieee80211.yaml

Changes since v1:
- introduce ieee80211.yaml bindings
- remove unnecessary properties in mt76.yaml

Lorenzo Bianconi (2):
  dt-bindings:net:wireless:ieee80211: txt to yaml conversion
  dt-bindings:net:wireless:mediatek,mt76: txt to yaml conversion

 .../bindings/net/wireless/ieee80211.txt       |  24 ----
 .../bindings/net/wireless/ieee80211.yaml      |  45 +++++++
 .../bindings/net/wireless/mediatek,mt76.txt   |  78 -----------
 .../bindings/net/wireless/mediatek,mt76.yaml  | 122 ++++++++++++++++++
 4 files changed, 167 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml

-- 
2.30.2

