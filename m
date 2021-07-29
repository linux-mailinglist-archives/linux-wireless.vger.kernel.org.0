Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EDF3DA133
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbhG2Kkk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:40 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47712
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235880AbhG2Kkj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:39 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 578FA3F239
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555235;
        bh=2+MASfDeMXItUy0KRRU6qIh2N4zib4Lrz4DxPbXJr60=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=A8W42v4KoNY2p8NkFhp0mtMxil1RQC4pu9cte5lTrt1XD0539BEgQB7PK6aN6ZYP6
         uKH8w+ZyweDyj5M0Wz1AUqw8IX+K1BzCHq/7c4ze53HhMYT9RsFxw9PhD5FpXzdMbI
         FEQUyRRrCvYY2fBUtUsebDMlFPly9E7A/WFVUZSrgmrm/It0TKIg95gRzdkdgAy2+e
         ThACAkGKQCGNhA1TuHUlZvOmM30cYPz/Tj97HxxLkuK2q79DuGYTg74wdFS+Lz+etD
         S9yfErz6RP/RmowefzlgXKlnIgtpVqjW9Z3AVnkzUAYQ+VNLOHqFzwq2Noyapq9aX5
         IsuZ4qUNPbY4g==
Received: by mail-ej1-f70.google.com with SMTP id ju25-20020a17090798b9b029058c24b55273so1853398ejc.8
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+MASfDeMXItUy0KRRU6qIh2N4zib4Lrz4DxPbXJr60=;
        b=KXQgHe+iVyhxuLm2paympKlIhQOCQDDKMImdd3Djgvv9dsNIxXFnsTbpTfsiK1YU1y
         I1R+nZaVIza4t1fBbp0KieE6sVvbFjXWijrcvPkaA6OojuKl43D6YmNMDm77x9UWH+hu
         oKdQJmT+3g3W5wWOMrJABT5bO0njvriFEtzI//+oMNSLXo/mKzEjLkXlfqwBJwAD+W4n
         lMt6UlBS7A9aprnWhKVA36ju1ruQPRBq8W8J7J89KL7qcK5f2oKVemrMd7hASyN32TD7
         3RIgofKUXWm530ouEmVc4+bU/FnnEfzEAy2DqJC2i9lfwZKuUrbLWNCI0coI5i111RDv
         cdIA==
X-Gm-Message-State: AOAM530OiOuE1sZ+HsUpNOqTxgmkvDqYFEEaHlJvGPNDavvFv+c6OYBa
        joqEr5p/rvbspl7uU6SRl/iYYImNxE3QI12Myl2TGxwbtwmMl9shTpmZjRUHxlW/LXQwf8S8fLA
        Rb59OK8ygAQ2LmBP0pmgib+cVkude9E3GjI69Xv4jBFOI
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr5240275edb.12.1627555235120;
        Thu, 29 Jul 2021 03:40:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwJDOdp8Ic5sbEoP+ybcJEGMi8R0A1BITHI63lRz6KY4s1GLDvMBVi9ewCQtp/6p2bmUkfPA==
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr5240255edb.12.1627555234989;
        Thu, 29 Jul 2021 03:40:34 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 01/12] nfc: constify passed nfc_dev
Date:   Thu, 29 Jul 2021 12:40:11 +0200
Message-Id: <20210729104022.47761-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The struct nfc_dev is not modified by nfc_get_drvdata() and
nfc_device_name() so it can be made a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/net/nfc/nfc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index c9ff341d57e4..5dee575fbe86 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -245,7 +245,7 @@ static inline void nfc_set_drvdata(struct nfc_dev *dev, void *data)
  *
  * @dev: The nfc device
  */
-static inline void *nfc_get_drvdata(struct nfc_dev *dev)
+static inline void *nfc_get_drvdata(const struct nfc_dev *dev)
 {
 	return dev_get_drvdata(&dev->dev);
 }
@@ -255,7 +255,7 @@ static inline void *nfc_get_drvdata(struct nfc_dev *dev)
  *
  * @dev: The nfc device whose name to return
  */
-static inline const char *nfc_device_name(struct nfc_dev *dev)
+static inline const char *nfc_device_name(const struct nfc_dev *dev)
 {
 	return dev_name(&dev->dev);
 }
-- 
2.27.0

