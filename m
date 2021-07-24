Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7070B3D4A3F
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhGXVIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 17:08:09 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:43820
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhGXVHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 17:07:43 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id EFCE33F349
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163291;
        bh=ov7yn4H0ornXwxrX1ZBFt/XnbBsClxe6Xsh+B5h5Cag=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BjN0/bNBaiaHopwYXYLf3BdjG40rIjk9OiBA7Am9VklfQ3JD2ee+x5ZgiGtm9KM4e
         ZGr56xLuygUtRzN0watEHfSjmWidd6bhi1OjPqrmaXrrFP6bLoCoY3aNLxbR0FWolR
         URPbx4ZSC6BfpiKJ+F5RjeMzt77v2q0Z68WUhR2bwXHCSgcqenbPm8BodLx5iU2xwZ
         iKxO3SeO6tuBN9TDHlX9GTtFq48aF8RTCJX3qBepy+BsFOvqsyOmUNMHl79PWrFBAX
         U3iaQKDuB3HOUnsJ2v5ziIEoGGHBZ/pzFEk8pWMu9gehaodnm7OTYnEjXOsI0Ds/en
         6+WTOrTwW5a8A==
Received: by mail-ed1-f69.google.com with SMTP id dn8-20020a05640222e8b029039ef9536577so2803561edb.5
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 14:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ov7yn4H0ornXwxrX1ZBFt/XnbBsClxe6Xsh+B5h5Cag=;
        b=MznPSI2hxZqsLkjj3cDoBsINSqFYZgQNH6X7GeWXkPWjUaRtrwMz7sVmT0bgC5CCh3
         TpBE1ImKsQCd4kdoKK19HFkDTW5+Guc/xhOQlCNhOG1K31i3O1Z4rKkO2g8snbrlo6x2
         qpnVGssTbs2nYstn1HcN39hJrl31KU73k1faoUca7uFMoQZlmPW+zscworTy9kVvxwUI
         b9fvOg4X4RN8YSyffWR2vIYnImQLIwCAvwkjT7A965Jo0mj5Wd9twGNOZuXx09mwQdRv
         acB5B4594wDdDebAMnlz47uhhEX9gwJKM6huc07LdPpi+gpP2iXC442ksF9YA19EaDNF
         kgXw==
X-Gm-Message-State: AOAM530VFr7s2ZEBY8+ebAPz4YlpGz1aBjZdG3dhal/9QqkOKbCWBxPG
        leag1RQDFwiv7qV8086y8tk2UuMQhnWtyyMyGUoFVSPg53BlVTUbO1/P0WRJfwKYRIgcSahu+ky
        oO6ydEBj++n7m5pavACy9IJBC1ZuZYNuqbwcClS73+IdY
X-Received: by 2002:a17:906:5e4c:: with SMTP id b12mr10085428eju.230.1627163288267;
        Sat, 24 Jul 2021 14:48:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4DjgiuYIHPq50fWezEY5ArO3iNlytrDP/udlFADjFqzzpxgUDWdNRebg5J3N9yopeTwgO0Q==
X-Received: by 2002:a17:906:5e4c:: with SMTP id b12mr10085415eju.230.1627163288139;
        Sat, 24 Jul 2021 14:48:08 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id j5sm8383005edv.10.2021.07.24.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:48:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 01/12] nfc: constify payload argument in nci_send_cmd()
Date:   Sat, 24 Jul 2021 23:47:32 +0200
Message-Id: <20210724214743.121884-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The nci_send_cmd() payload argument is passed directly to skb_put_data()
which already accepts a pointer to const, so make it const as well for
correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/net/nfc/nci_core.h | 2 +-
 net/nfc/nci/core.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 1df0f8074c9d..bf573eca07ca 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -360,7 +360,7 @@ int nci_core_rsp_packet(struct nci_dev *ndev, __u16 opcode,
 int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 			struct sk_buff *skb);
 void nci_rx_data_packet(struct nci_dev *ndev, struct sk_buff *skb);
-int nci_send_cmd(struct nci_dev *ndev, __u16 opcode, __u8 plen, void *payload);
+int nci_send_cmd(struct nci_dev *ndev, __u16 opcode, __u8 plen, const void *payload);
 int nci_send_data(struct nci_dev *ndev, __u8 conn_id, struct sk_buff *skb);
 int nci_conn_max_data_pkt_payload_size(struct nci_dev *ndev, __u8 conn_id);
 void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index da7fe9db1b00..09967b836361 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1332,7 +1332,7 @@ int nci_send_frame(struct nci_dev *ndev, struct sk_buff *skb)
 EXPORT_SYMBOL(nci_send_frame);
 
 /* Send NCI command */
-int nci_send_cmd(struct nci_dev *ndev, __u16 opcode, __u8 plen, void *payload)
+int nci_send_cmd(struct nci_dev *ndev, __u16 opcode, __u8 plen, const void *payload)
 {
 	struct nci_ctrl_hdr *hdr;
 	struct sk_buff *skb;
-- 
2.27.0

