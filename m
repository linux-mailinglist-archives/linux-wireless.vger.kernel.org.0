Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8660A603A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 06:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfICE34 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 00:29:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35529 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfICE34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 00:29:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so14607357lje.2
        for <linux-wireless@vger.kernel.org>; Mon, 02 Sep 2019 21:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGsNyS9+7uW1WVXEB7vhNVK26nLysHjh5G+batUF3LQ=;
        b=kS0CeNGq2940wPbthAV5JxtvXyrpYKrifw5/gkcmzAsVUiJO0Ntv/eBYkSotbprSSK
         5n5cfuUyGP+RjI6NR5PPRsRCauQDZYoRLKfunP3rLXeCA75lJS6jfKxUKObhShRqEsUR
         VjaQ5XxaNKcfFPH33Pgm1Yl8kTXb7HkIeHXIBe/sirRYlLVs9Xr62UVRorlrjvVl7hCH
         O++XDia9w49ivxJhurP3HzUHY6aqskFA4GyOY6TnZRi5Psu5f31CijEQhVSKtN+p9wsv
         ll/qn+ewvliql9c2NliLJsdFd/mRrz/IpVljFRt3CeBT6otUqHVkS5gNn7vRIvS1Pg4S
         QURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGsNyS9+7uW1WVXEB7vhNVK26nLysHjh5G+batUF3LQ=;
        b=XM0Kx+0lju+SXPJhTlBps8rI3MhlRsHqCnICgF/qwDJnsfFOkRbWRGtFbFVcVeqF5N
         fpmuj2qomYuAPb8nkDvhTCWmw7tbn0mSLzS6oEI5hEXI4FMLa7cIKGuDpl6s2UFt3lbc
         lhyTXVyCN8SVwBHAnaMKjOJSbjHh9Bx6TlojfuVBe2wHI5PXzgObl823txv6VUoUSh29
         cd4XdEWPxog6tqHnA95mNWX5lGqpFcs9rcTaH9WlFB8yj86qpe6cbVtHSj0HFSQ9rql8
         YuvaYRmesT2hrQf0J06eRnz5Lia+GkKPbU1TXX70ar9cjH2t0W3lM/W6WN+sYord1+Wl
         fvPg==
X-Gm-Message-State: APjAAAUx+wl4qSvqdMhW8RSN57cPuWthub6DfD6LqxJU1cB7wwEKCRU+
        2oLVjHVIwgUamXOaeh0DA0g=
X-Google-Smtp-Source: APXvYqyn3Rd78qwyyF3ZMpacdRgXLflX9aXoOh8s8CA9W0GyEPXWqoPsyVbDzWQFl2Lg1cGvfC8n6A==
X-Received: by 2002:a2e:7604:: with SMTP id r4mr18358076ljc.225.1567484994377;
        Mon, 02 Sep 2019 21:29:54 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d25sm2265125lfj.15.2019.09.02.21.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 21:29:53 -0700 (PDT)
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
Subject: [PATCH 3/3] brcmfmac: don't realloc wiphy during PCIe reset
Date:   Tue,  3 Sep 2019 06:29:28 +0200
Message-Id: <20190903042928.18621-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903042928.18621-1-zajec5@gmail.com>
References: <20190903042928.18621-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Providing a new wiphy on every PCIe reset was confusing and was causing
configuration problems for some users (supplicant and authenticators).
Sticking to the existing wiphy should make error recovery much simpler
and more reliable.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index b01b33e99c14..6c463475e90b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1430,7 +1430,6 @@ static int brcmf_pcie_reset(struct device *dev)
 	brcmf_pcie_bus_console_read(devinfo, true);
 
 	brcmf_detach(dev);
-	brcmf_free(dev);
 
 	brcmf_pcie_release_irq(devinfo);
 	brcmf_pcie_release_scratchbuffers(devinfo);
@@ -1826,9 +1825,6 @@ static void brcmf_pcie_setup(struct device *dev, int ret,
 	brcmf_pcie_intr_enable(devinfo);
 	brcmf_pcie_hostready(devinfo);
 
-	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
-	if (ret)
-		goto fail;
 	ret = brcmf_attach(&devinfo->pdev->dev);
 	if (ret)
 		goto fail;
@@ -1931,6 +1927,10 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
 	dev_set_drvdata(&pdev->dev, bus);
 
+	ret = brcmf_alloc(&devinfo->pdev->dev, devinfo->settings);
+	if (ret)
+		goto fail_bus;
+
 	fwreq = brcmf_pcie_prepare_fw_request(devinfo);
 	if (!fwreq) {
 		ret = -ENOMEM;
-- 
2.21.0

