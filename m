Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479CA33A7F1
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Mar 2021 21:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhCNUWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Mar 2021 16:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234619AbhCNUVf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Mar 2021 16:21:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9207964EB7;
        Sun, 14 Mar 2021 20:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615753293;
        bh=oavXZw40rrGBhM8i17b2Df3mhJmgDuv/OD8BdCXkduM=;
        h=From:To:Cc:Subject:Date:From;
        b=fGTv2F/hD44Cc8CKgDlmaJcEPvRicqYZLgShaDXufW4aLerHsPlNSyMy4vEwnVnCL
         9jynSBD4eHzjqjWRBLHPAMfeq0BOqmc+vQedYS0cU6bDAPh1343xll5NH4/rano5Ob
         h8/k7LXg4N8PU9D9ZQ9RL3hGp07n3877BUQTTvOoNLV6QDH4KrwE7BMwQHcScBYjXS
         C8z1TOC3zJ8chXVxwcjqstRDvhkA2KSmvP8XmcW+q1a4TflUwGgnLQ+As4cNDG5GSq
         hhcy9gqI4sBLnUEL9EgIVkfA9O3YYSfvOXV27jhI14JCvL5MH441Qkvynvzcw2aXwW
         toTtJuUxtinSg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        johannes@sipsolutions.net
Subject: [PATCH v2 0/2] dt-bindings: convert mt76 and ieee80211 in yaml
Date:   Sun, 14 Mar 2021 21:21:05 +0100
Message-Id: <cover.1615752835.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert mt76 and ieee802111 dts bindings from .txt to .yaml

Changes since v1:
- introduce ieee80211.yaml bindings
- remove unnecessary properties in mt76.yaml

Lorenzo Bianconi (2):
  dt-bindings:net:wireless:ieee80211: txt to yaml conversion
  dt-bindings:net:wireless:mediatek,mt76: txt to yaml conversion

 .../bindings/net/wireless/ieee80211.txt       |  24 ----
 .../bindings/net/wireless/ieee80211.yaml      |  41 ++++++
 .../bindings/net/wireless/mediatek,mt76.txt   |  78 ------------
 .../bindings/net/wireless/mediatek,mt76.yaml  | 117 ++++++++++++++++++
 4 files changed, 158 insertions(+), 102 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml

-- 
2.29.2

