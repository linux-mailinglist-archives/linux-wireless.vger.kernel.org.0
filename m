Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC57408D28
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhIMNXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 09:23:35 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33814
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240928AbhIMNV6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 09:21:58 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6AD2B3F091
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631539241;
        bh=q1oAxRnHPjktEWHzE6nf5nzfFGa2oa1TQ40ADKZqt7E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=aRcZGPEKgySaylI75jb8nJAkdGYSIxPfpVOl9Ds0/jKcQI7AEJ66R6q8WqVGM4PB0
         tgPEA8wfYI3/UrFWnrbKXJdBTMpIjp0cdtEDkxbLhp9a2jg9FvyeKUqI25jQ63X6LB
         l4OAFyFuK85269qiQ0YW99a3IK9zgYt4c7abaDDKrdCEgIiOhDKJE80HmV0a1OrrUo
         8qAfqa/8KPLjCF+hqSMGtkMo4JnLvx/95TRbQ0HM4/87futXm2xLbmOoBjnZvuWcFn
         o3VBs70swyVj+L+u8clnhUtXqfNkoSPz2zrl57+nkaRbyMo5r8Hgo6D27abp+2Fxs8
         q+nv3UoZ2jsHA==
Received: by mail-wr1-f70.google.com with SMTP id z1-20020adfec81000000b0015b085dbde3so2656727wrn.14
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 06:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q1oAxRnHPjktEWHzE6nf5nzfFGa2oa1TQ40ADKZqt7E=;
        b=j2vetaxeL9OuWIJ9MY7kFM6q1adDFGlRkN2V1BHB86ZUjmGhP8x2fVHumtsX1fRkM6
         +XCL43wjFAwMCHVMKNocjASxP1FX5T9X8RmN2p3WWi63lDxNQrXpQe/owzRhX+6/YfZE
         8qTLhiPanPSW9IAkbUSv7vWgu1Jg2sjOWdJ3EtoTefoEE4IMH9ZR/nSQT6xv8OmmsFHO
         VPUOumbKMYjsY5jq+j0fIxJGAagQUZ062NgQL3FaUati4y7S5aBEJpY4FOzohIEPeLyO
         XduJc3dlVqooP0AyMvfZreP8WamiZrJK6sxIp14XTOhtvdMs2eJ17lWykw4+cbTEXn5w
         lVoQ==
X-Gm-Message-State: AOAM532NrkGqto46enGNaShMebRhxfKlKscC7UX+9MBKo1eItqW24axr
        uLviR3i28wW419125pOKfjG1l3zTJG3hrW8hNPXwPH42MtW4LksiEHWT/C5GoBvIGSXdydmOgMd
        EvT5a956ZFfVGA6QYl0gfaQyQW2xPTwB6N6EKNwlxWft/
X-Received: by 2002:a5d:6792:: with SMTP id v18mr12575245wru.416.1631539241172;
        Mon, 13 Sep 2021 06:20:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTOtZe+s81L7x4FZ5sAOlsPP679r7GY65Ei3OGctm0ZlMIdQFVPXzyTPmiKUdFX6lmNBgSKQ==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr12575229wru.416.1631539241031;
        Mon, 13 Sep 2021 06:20:41 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm7195888wmi.0.2021.09.13.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 06:20:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH v2 00/15] nfc: minor printk cleanup
Date:   Mon, 13 Sep 2021 15:20:20 +0200
Message-Id: <20210913132035.242870-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Changes since v1:
1. Remove unused variable in pn533 (reported by kbuild).

Best regards,
Krzysztof

Krzysztof Kozlowski (15):
  nfc: drop unneeded debug prints
  nfc: do not break pr_debug() call into separate lines
  nfc: nci: replace GPLv2 boilerplate with SPDX
  nfc: fdp: drop unneeded debug prints
  nfc: pn533: drop unneeded debug prints
  nfc: pn533: use dev_err() instead of pr_err()
  nfc: pn544: drop unneeded debug prints
  nfc: pn544: drop unneeded memory allocation fail messages
  nfc: s3fwrn5: simplify dereferencing pointer to struct device
  nfc: st-nci: drop unneeded debug prints
  nfc: st21nfca: drop unneeded debug prints
  nfc: trf7970a: drop unneeded debug prints
  nfc: microread: drop unneeded debug prints
  nfc: microread: drop unneeded memory allocation fail messages
  nfc: mrvl: drop unneeded memory allocation fail messages

 drivers/nfc/fdp/i2c.c          |  1 -
 drivers/nfc/microread/i2c.c    |  4 ----
 drivers/nfc/microread/mei.c    |  6 +-----
 drivers/nfc/nfcmrvl/fw_dnld.c  |  4 +---
 drivers/nfc/pn533/i2c.c        |  4 ----
 drivers/nfc/pn533/pn533.c      |  4 +---
 drivers/nfc/pn544/mei.c        |  8 +-------
 drivers/nfc/s3fwrn5/firmware.c | 29 +++++++++++-----------------
 drivers/nfc/s3fwrn5/nci.c      | 18 +++++++----------
 drivers/nfc/st-nci/i2c.c       |  4 ----
 drivers/nfc/st-nci/ndlc.c      |  4 ----
 drivers/nfc/st-nci/se.c        |  6 ------
 drivers/nfc/st-nci/spi.c       |  4 ----
 drivers/nfc/st21nfca/i2c.c     |  4 ----
 drivers/nfc/st21nfca/se.c      |  4 ----
 drivers/nfc/trf7970a.c         |  8 --------
 net/nfc/hci/command.c          | 16 ----------------
 net/nfc/hci/llc_shdlc.c        | 35 +++++++++-------------------------
 net/nfc/llcp_commands.c        |  8 --------
 net/nfc/llcp_core.c            |  5 +----
 net/nfc/nci/core.c             |  4 ----
 net/nfc/nci/hci.c              |  4 ----
 net/nfc/nci/ntf.c              |  9 ---------
 net/nfc/nci/uart.c             | 16 ++--------------
 24 files changed, 34 insertions(+), 175 deletions(-)

-- 
2.30.2

