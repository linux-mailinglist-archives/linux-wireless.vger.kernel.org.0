Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39743A6035
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 06:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfICE3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 00:29:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42879 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfICE3t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 00:29:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so3494546lje.9
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=enTt+jkm0v3fng6HHcPOq5aNP3rxl48YxOS+5cW4FlQ=;
        b=kYzm06n7cCz0CiV/2F0/S5KjNr77uXEUEMYwnTrmhPwcC7Fqw20OMYeHoBRCue33qp
         R6VSX/jqwH3sk22Z6MnnlWo0ITWsWtEEmjvhlgWheGlmN4PQJo0Z7rijRo6aNoxfhIxs
         an5P0rszhjXUHbHikLqQoXCMvrb97DPDlCgoIa2yhu6s7HndPvFtqHPebZ+sBEEYQ3nD
         n0HZSLoatFNa+X8WTMmFrtP1Dl3CRUIcTouMKN0UFIEbsMvfU4dcPjiKwHO72YI7nxCv
         hbrjQVruTrxyVZPvqlC1ZoEsJlsq9pstzJ8l/6OUO5cr6KRPOnVSdiDF8BvOMBFo1OrN
         GDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=enTt+jkm0v3fng6HHcPOq5aNP3rxl48YxOS+5cW4FlQ=;
        b=rfRs5TXaS50n8U+26dX8LYzm3qpOHp/umcwJ8jFxVb3E31/847STkfuqgaWp83xHe4
         DfPkMzrMLHrKCDI4WkA+CErVOTeeb+9dx4Nm27Za5VlvG22lfC33IEdA+J6+I9v2IZAY
         i/mwi5gwtCo5RuorKTKVA4vsEoOs+t54CcTs1V/AveFVWDiv5zGgG++Chh6WISLsq8kV
         h/NOf29QAmca45QmQGNV0XBL8kYRssz+0doSg6Edfjsv/3Y7dBNnF/LrQfIi57SA0hhp
         ssy7ITkSSU32p6/wBkVuH/MVQmeCOT8XsZRUeX9dFUo9qJIdxYfaW3pz2g02WiYcuvmn
         uqlA==
X-Gm-Message-State: APjAAAW5r+Og16eKJmOVhUG0xvOZvMC8M2rji6Up7ZdCwxa5kOsS0jrt
        lFWFkxyo3mJJYUh7ffAaNsA=
X-Google-Smtp-Source: APXvYqzmd0rztYD5rmCmdSKp0sDfe/KmKI950pVgmUl2ZvPYW/xqOK21PqDXcMYIXTgmabfuyY2HGQ==
X-Received: by 2002:a2e:1409:: with SMTP id u9mr6465706ljd.162.1567484987628;
        Mon, 02 Sep 2019 21:29:47 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d25sm2265125lfj.15.2019.09.02.21.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 21:29:46 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/3] brcmfmac: keep wiphy during PCIe driver lifetime
Date:   Tue,  3 Sep 2019 06:29:25 +0200
Message-Id: <20190903042928.18621-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Driver's main init/attach function brcmf_attach() was handling both:
wiphy allocation and driver initialization. It meant getting a new wiphy
on every init (initial, resume, error recovery).

For supplicants/authenticators and Linux users it's move convenient to
have the same wiphy over driver's lifetime. It allows e.g. automatic
recovery after a firmware crash.

This patchset was tested on BCM4366 (PCIe) and BCM43430 (SDIO).

Right now only PCIe makes use of keeping the same wiphy. I got RPi Zero
W so I'm planning to add firmware crash recovery & keep wiphy for SDIO
in the future.

Rafał Miłecki (3):
  brcmfmac: move "cfg80211_ops" pointer to another struct
  brcmfmac: split brcmf_attach() and brcmf_detach() functions
  brcmfmac: don't realloc wiphy during PCIe reset

 .../broadcom/brcm80211/brcmfmac/bus.h         |  4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  1 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  1 -
 .../broadcom/brcm80211/brcmfmac/core.c        | 42 ++++++++++++++-----
 .../broadcom/brcm80211/brcmfmac/core.h        |  1 +
 .../broadcom/brcm80211/brcmfmac/pcie.c        | 13 +++++-
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 15 +++++--
 .../broadcom/brcm80211/brcmfmac/usb.c         | 34 ++++++++++++---
 8 files changed, 87 insertions(+), 24 deletions(-)

-- 
2.21.0

