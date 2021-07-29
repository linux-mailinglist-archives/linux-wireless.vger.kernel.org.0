Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6598E3DA130
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhG2Kki (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:38 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:47684
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233273AbhG2Kkh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:37 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E28013F110
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555233;
        bh=U5ZMYZkwqc8RmbQysqq1OTMd/Wgw4WsrTPEA4vYur0c=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=a3YPY3vYsKli7a7OqllP817DBrBPZwa7ng3bBFMBl/U1emu09C+a4XJ+/FUjGz2bw
         nsdLbmSUgTohopPTT2wajAk1iatWcBwh/vEJUvhSFu9JcAWg6DpxMs04OHnYrKsvhH
         zGHgBkXT8S6Z3Ed5w0uljGUcqVRPynivowlaNFRdOFTpudkyjtQF8zMdz5w3lfC1Ga
         sk6xKE4XLH2jYdIKfFBJitYPFovJcUWyl8IDxMslxe1INiMQ9sVv4XHG7rBDOpXe1q
         Eh/Iqk3wv9g7cjLWOcDWc7rz7NjO4ezhp3t7ohEh2vb/DWT+z3U5kALlnbw0ieV0t1
         n5Zorq4HVyjTw==
Received: by mail-ed1-f72.google.com with SMTP id cm18-20020a0564020c92b02903bc7f21d540so1303212edb.13
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5ZMYZkwqc8RmbQysqq1OTMd/Wgw4WsrTPEA4vYur0c=;
        b=iNqbPtwxKm4krXQZmpLVm5m8llZg/WHAn8TA0ruWGE5iPMuk185a+HJUJp36FSgK59
         fLYfyTbugaIpyIA+GvnBv9Pwh33NMbkYQCmnUg/a3JTq72ic5E4tf3QgpJ0OKum+WXbd
         /+WRSlRuXBdZRfe4JnG2OuuKWLh1Z8YALZVlHKC2MOvb70ms/TqRIT5veqMNm+MWI6tK
         eViYZq3E5JfjH2PwSgncGlqTtKaUExzYAMkWQYtW0DwdrrUOv6WYA0INS1cTSpwxNC3b
         YxOCl8f2UONLJqh6xrzpwOqUdGtruJbhmFOeydEFmDHYDreyJ8hkLKLsgpHZ/zZ5n8Tt
         xkhA==
X-Gm-Message-State: AOAM532QfAy306K1IEfcjWYhkbiftnMXVlatgCFV5Gx+a9JLqx15P2LH
        k1r+bMVpIyNksx57gdDR0MnXmaEh2xAqt4MG831hovZURS5ZgYJKZw620EHx/CmIvvJAMbkHOex
        E5Gc5LwMJEsjCn+7f0K3DEuY0eAgqAookgdMYBWVmnFjr
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr5191729ede.277.1627555233654;
        Thu, 29 Jul 2021 03:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0zzZMt4FRxj6/pkKudrZrKtAC8UcrWt1V+5uDuEVakkenlwbpg5EabX2DWunH4RtcpYeAvw==
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr5191710ede.277.1627555233472;
        Thu, 29 Jul 2021 03:40:33 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 00/12] nfc: constify, continued (part 2)
Date:   Thu, 29 Jul 2021 12:40:10 +0200
Message-Id: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On top of:
nfc: constify pointed data
https://lore.kernel.org/lkml/20210726145224.146006-1-krzysztof.kozlowski@canonical.com/

Best regards,
Krzysztof


Krzysztof Kozlowski (12):
  nfc: constify passed nfc_dev
  nfc: mei_phy: constify buffer passed to mei_nfc_send()
  nfc: port100: constify several pointers
  nfc: trf7970a: constify several pointers
  nfc: virtual_ncidev: constify pointer to nfc_dev
  nfc: nfcsim: constify drvdata (struct nfcsim)
  nfc: fdp: drop unneeded cast for printing firmware size in dev_dbg()
  nfc: fdp: use unsigned int as loop iterator
  nfc: fdp: constify several pointers
  nfc: microread: constify several pointers
  nfc: mrvl: constify several pointers
  nfc: mrvl: constify static nfcmrvl_if_ops

 drivers/nfc/fdp/fdp.c             | 27 +++++++++++-----------
 drivers/nfc/fdp/fdp.h             |  2 +-
 drivers/nfc/fdp/i2c.c             |  6 ++---
 drivers/nfc/mei_phy.c             |  2 +-
 drivers/nfc/microread/i2c.c       |  2 +-
 drivers/nfc/microread/microread.c |  4 ++--
 drivers/nfc/microread/microread.h |  2 +-
 drivers/nfc/nfcmrvl/fw_dnld.c     | 16 +++++++------
 drivers/nfc/nfcmrvl/i2c.c         |  4 ++--
 drivers/nfc/nfcmrvl/main.c        |  4 ++--
 drivers/nfc/nfcmrvl/nfcmrvl.h     |  6 ++---
 drivers/nfc/nfcmrvl/spi.c         |  6 ++---
 drivers/nfc/nfcmrvl/uart.c        |  4 ++--
 drivers/nfc/nfcmrvl/usb.c         |  2 +-
 drivers/nfc/nfcsim.c              |  2 +-
 drivers/nfc/port100.c             | 37 +++++++++++++++++--------------
 drivers/nfc/trf7970a.c            | 17 +++++++-------
 drivers/nfc/virtual_ncidev.c      |  2 +-
 include/net/nfc/nfc.h             |  4 ++--
 19 files changed, 78 insertions(+), 71 deletions(-)

-- 
2.27.0

