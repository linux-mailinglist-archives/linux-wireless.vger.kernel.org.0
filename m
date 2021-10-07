Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF0425445
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Oct 2021 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbhJGNkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Oct 2021 09:40:14 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51870
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241609AbhJGNkN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Oct 2021 09:40:13 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 80C2940004
        for <linux-wireless@vger.kernel.org>; Thu,  7 Oct 2021 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633613899;
        bh=upOlM+YeqtC352ZviJAd3z51Fz6iHXHCRP6fI5EVtCE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=K5uPIBXYNqgj8WIbZHM0hMG99YXTHyO+Zovg4ikX+hRJC2O1bpHSFvA3kuTx9sSnO
         VzhbizAApl2oBaiTMoD1M8r87qsbRPPHJ8iU6naqHZEbE8t9nZEBOMce5SvlQvtoQw
         eYM7ZVfys1sbwbZrUKTcI20rb8b7YGUaOayHhX5Fc6bsWRXmiRi8+G9V+1loYzyM6i
         PbkO9W6CPTxNCO2VkI4gE6RJ1ivFs7Mnrzsn629kzGx94QfPk+fUi3ITaCMOzwXThX
         rpkg7yyPnSsR7HqMCSM5VrEV7tbLrUFmFvtef/BpjOLvpYeZPiJPPZ4E8s6XQ5UVMv
         6tp0izuzWVg+g==
Received: by mail-ed1-f70.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso5917727edv.13
        for <linux-wireless@vger.kernel.org>; Thu, 07 Oct 2021 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upOlM+YeqtC352ZviJAd3z51Fz6iHXHCRP6fI5EVtCE=;
        b=RHhiT47hQs8rBwO1chL5zBAzFhshO712se6jCVIh+rJ3E0fUYLcJHyhZIXLbC3vQeF
         J9g8LfjHah6Q5okE2j4FuIpgAS6WMAp1tbBHbzTDBIDvZ3Oit3nf47e6OyeduW4FSD9l
         dSL7Revn7qKrHS1hrsXTaGAxhR3IZxp81BofajoBkvkzFGHjy9KmFG92QQEV8p7EbQJh
         iLVf/BHWgvLyaIGuYsxkW/AZzkvWTPSSRHGuMmaNy5Ex48idZ8PDHdXlAB/eJ7A2QxXO
         F/cxO4EXfyybOcofamNqIFCchKxlX35M+J/AY1vQSdXjP+kVfrzkO5qwwSWqPQeQqDmi
         b+Wg==
X-Gm-Message-State: AOAM533+mUozp1ZrcIC2aYf3QAZC+wcwDa0IaP9JkCRRtGBFttO0iibI
        FZ8i8VE7DG9VZ9Td467SczAY+q9T8YPZ6RjvGadb/+NvIgYOkHMNAtcyb1lIsyiD4tpPmjPnbZt
        phujfPWXnXjWryia5VdMlCQrSYr/Hh4YJqJ6skyDE0uaQ
X-Received: by 2002:a17:906:2cc9:: with SMTP id r9mr5959249ejr.138.1633613899064;
        Thu, 07 Oct 2021 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysz8D0vmS0o8wE8Hx/CAwpkXQSt/jJcGqT2FQLo0gEaR7VKf/x4sZjGm1ZRgWQW1Xzl63ykg==
X-Received: by 2002:a17:906:2cc9:: with SMTP id r9mr5959208ejr.138.1633613898754;
        Thu, 07 Oct 2021 06:38:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id ay19sm8585613edb.20.2021.10.07.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 06:38:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [RESEND PATCH v2 0/7] nfc: minor printk cleanup
Date:   Thu,  7 Oct 2021 15:30:14 +0200
Message-Id: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This is a rebase and resend of v2. No other changes.

Changes since v1:
1. Remove unused variable in pn533 (reported by kbuild).

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  nfc: drop unneeded debug prints
  nfc: nci: replace GPLv2 boilerplate with SPDX
  nfc: s3fwrn5: simplify dereferencing pointer to struct device
  nfc: st-nci: drop unneeded debug prints
  nfc: st21nfca: drop unneeded debug prints
  nfc: trf7970a: drop unneeded debug prints
  nfc: microread: drop unneeded debug prints

 drivers/nfc/microread/i2c.c    |  4 ----
 drivers/nfc/microread/mei.c    |  2 --
 drivers/nfc/s3fwrn5/firmware.c | 29 +++++++++++------------------
 drivers/nfc/s3fwrn5/nci.c      | 18 +++++++-----------
 drivers/nfc/st-nci/i2c.c       |  4 ----
 drivers/nfc/st-nci/ndlc.c      |  4 ----
 drivers/nfc/st-nci/se.c        |  6 ------
 drivers/nfc/st-nci/spi.c       |  4 ----
 drivers/nfc/st21nfca/i2c.c     |  4 ----
 drivers/nfc/st21nfca/se.c      |  4 ----
 drivers/nfc/trf7970a.c         |  8 --------
 net/nfc/hci/command.c          | 16 ----------------
 net/nfc/hci/llc_shdlc.c        | 12 ------------
 net/nfc/llcp_commands.c        |  8 --------
 net/nfc/llcp_core.c            |  5 +----
 net/nfc/nci/core.c             |  4 ----
 net/nfc/nci/hci.c              |  4 ----
 net/nfc/nci/ntf.c              |  9 ---------
 net/nfc/nci/uart.c             | 16 ++--------------
 19 files changed, 21 insertions(+), 140 deletions(-)

-- 
2.30.2

