Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A34287F5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 09:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhJKHm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 03:42:29 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57472
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234570AbhJKHlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 03:41:49 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3F88F4001C
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 07:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937987;
        bh=dKNe0YR2W1YWBul8nQdZBdCYA7T0luSH8qAs9JTPkS4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Nhh5O6gfPbBYiF2n2msQVeDEl1eSbaV76aYCqcft5IbmwkNeeB2mZMSUgEnMIxmnq
         9EoQjROIVRDLgA/vkTc/zuDdq51aVNM6f7bOD4q5Ksp2TtKzf2oC6i9YjOFkJqnE0l
         35bL8U2/MJPC4m6+8GqIltuYIxdS8nXi30J+/wUl45Pud1In6wDd9bbzYq4NJO9w7h
         nOnAm7z0ln8ib+25DXWRSVe3lUtoYegOJABvbBBNAbhDImvMzXWezKvPAPP6rti4P0
         NHV4dutEqCc4R8G/A0B9v1wSWtlu3FDn23v71pjLgfUXBKEjEsd29ZD/BKP5mjF8Dm
         3yVoFSNsbhMgg==
Received: by mail-ed1-f70.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so13035175edy.14
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 00:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dKNe0YR2W1YWBul8nQdZBdCYA7T0luSH8qAs9JTPkS4=;
        b=YuA3tON2ljkesMA0mEocGajOxz2E4lLJgVi6CAMvMSzoaodXU2jVMVFHCI115kk7d7
         j3BxO6itYhKq9/r/7THFCWyVeIddXTj5yLrasv9jth6FA/wEqgp3K0KEfDNrszHDGkui
         28sAw2Jv94R0MGiBWRqvRhmgXXoWewgKzVtu59XQ4EUwPr/wZ49qp/B9cfLh9lrq7j2j
         Ca5zcE7YpLm6lPQlhAXsjiHBRws3MCMbO85ZxqCckkKmomNoMFAhnEaUZ5k0UfexqGQt
         YhKu1tSkln+/ktcSKBpT+YiTeQk/vHrzrJPVCS1ebXBp8Le0Re6x9lCjWsqVQvY8lrDU
         gJmg==
X-Gm-Message-State: AOAM530hmnckOztqiG7xo+Jtgy0/DcbqABE+UKMFGZg3l7xPah+EaFbC
        9TGwIVHuYsTbvSVVsly0djdfEyIVJnmr8UCQtSJTIYyVpvSOMKsV8tuUDeNxWbL+0/PYPnjGETe
        kffKJKf0ZvuI35kVeKq2BjogcJ7XIGV/MWfWeTtx2un1V
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr27593660edz.283.1633937983838;
        Mon, 11 Oct 2021 00:39:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4TGueCUqr8nipt9y1eUTDZZZuo1QIc9IRv4KZo7UB7TGDm48xnJ0Nl+i+OLa1EhAIjhllxw==
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr27593641edz.283.1633937983622;
        Mon, 11 Oct 2021 00:39:43 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y8sm3023965ejm.104.2021.10.11.00.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:39:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 0/8] nfc: dt-bindings: convert to dt-schema
Date:   Mon, 11 Oct 2021 09:39:26 +0200
Message-Id: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Changes since v1:
1. Drop clock-frequency from I2C devices.
2. Update commit msg.
3. Add patch 2/8: NXP PN547 binding.

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  dt-bindings: nfc: nxp,nci: convert to dtschema
  dt-bindings: nfc: nxp,nci: document NXP PN547 binding
  dt-bindings: nfc: nxp,pn532: convert to dtschema
  dt-bindings: nfc: st,st21nfca: convert to dtschema
  dt-bindings: nfc: st,st95hf: convert to dtschema
  dt-bindings: nfc: st,nci: convert to dtschema
  dt-bindings: nfc: ti,trf7970a: convert to dtschema
  dt-bindings: nfc: marvell,nci: convert to dtschema

 .../bindings/net/nfc/marvell,nci.yaml         | 170 ++++++++++++++++++
 .../devicetree/bindings/net/nfc/nfcmrvl.txt   |  84 ---------
 .../devicetree/bindings/net/nfc/nxp,nci.yaml  |  61 +++++++
 .../bindings/net/nfc/nxp,pn532.yaml           |  65 +++++++
 .../devicetree/bindings/net/nfc/nxp-nci.txt   |  33 ----
 .../devicetree/bindings/net/nfc/pn532.txt     |  46 -----
 .../bindings/net/nfc/st,st-nci.yaml           | 106 +++++++++++
 .../bindings/net/nfc/st,st21nfca.yaml         |  64 +++++++
 .../bindings/net/nfc/st,st95hf.yaml           |  57 ++++++
 .../bindings/net/nfc/st-nci-i2c.txt           |  38 ----
 .../bindings/net/nfc/st-nci-spi.txt           |  36 ----
 .../devicetree/bindings/net/nfc/st21nfca.txt  |  37 ----
 .../devicetree/bindings/net/nfc/st95hf.txt    |  45 -----
 .../bindings/net/nfc/ti,trf7970a.yaml         |  98 ++++++++++
 .../devicetree/bindings/net/nfc/trf7970a.txt  |  43 -----
 MAINTAINERS                                   |   3 +-
 16 files changed, 623 insertions(+), 363 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nfcmrvl.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/nxp-nci.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn532.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st21nfca.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st95hf.txt
 create mode 100644 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/trf7970a.txt

-- 
2.30.2

