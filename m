Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7584A6F575
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2019 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGUTw4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jul 2019 15:52:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43212 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUTw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jul 2019 15:52:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so10854673ljk.10
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jul 2019 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrUJZU7YyFOWbwdcPp0bR8k4tpBTyHyLQUSZesyY2eQ=;
        b=gYfUa6pBUkaJrqml0XS0p3BWjLAGot/gxNktLaf5C32NPkOn680yEOinjPgyjDkK/7
         FMBiXwik7I5vRUrrtjGXp9KgH+5wI711y5GN3JQDwn0D84CQy16xlSaN3b9vglWkRgx4
         rBMvaggvV6406DTBmquTgyHzN10BE2A64mIagT1ZFYwXnpBmdfJythZ/ZjN0Pgk4SPoD
         6vg5MddzbeRcwUl/4h7NwAKOWOTEHeOxVFtGu/PIFyi8/Xw/hOE/IINSAnf4ZUDUElSF
         ESQoXKaXGn0FkQ/KLaYCYD19SlNimiXSgQZsKM+67ydWNE3APFCzxwkP71GfL0+zVnGE
         il5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrUJZU7YyFOWbwdcPp0bR8k4tpBTyHyLQUSZesyY2eQ=;
        b=SR/t/QpCVuWn6I03qVzS9tCwiiiEWwvxeSN/IawUazC2SPIVFOzFYeIjN3G/3wHejH
         +JfhWkx+ZGGG2CdH2+9rflxJr8S1jRnxu4z1ymVDATtkhizPBkMSDmYT6I8V0OAry8Gj
         EmmeEg3uBoMOG5nKx2R6R2ZMymLBEKbAwOVsPSG92duQE5sB8unIsUo3RH1v+be02hhl
         vhhZYXXD9NxCieEF4HUqFi+ath8aVrd7QgDUc7IWawCzn3iMaqGVyDdN+gv5DPr9Erh2
         RHwat25NXZxUibDNIKNul4vb04sO8m+RGOYPzkLTvw+Oxo0OW/Ax01/JKYqA35Bh3rOe
         EYWA==
X-Gm-Message-State: APjAAAU/zhRZZLvdpfZnxaa19EeahJqHg7DnArZwIt37yRmfjqtn+o1g
        5jGfh1e2Pv9uexJmNtL5Xu0=
X-Google-Smtp-Source: APXvYqwdnj+UfUXF1WVcfVKFfTr1/F8OdRt6taU4WdfUoSG8qwyfPUe7ep/Rnqo7ood2qoVF1Jrt1g==
X-Received: by 2002:a2e:3602:: with SMTP id d2mr34799309lja.112.1563738774118;
        Sun, 21 Jul 2019 12:52:54 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b192sm5677595lfg.75.2019.07.21.12.52.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 12:52:53 -0700 (PDT)
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
Subject: [PATCH] brcmfmac: don't net_ratelimit() CONSOLE messages on firmware crash
Date:   Sun, 21 Jul 2019 21:52:17 +0200
Message-Id: <20190721195217.26838-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Firmware crash is a pretty rare event and can't happen too frequently as
it has to be followed by a hardware reinitialization and config reload.
It should be safe to don't use net_ratelimit() when it happens.

For reporting & debugging purposes it's important to provide a complete
log as the last lines are actually the most important. This change
modifies brcmfmac to print all messages in an unlimited way in that
specific case. With this change there should be finally a backtrace of
firmware finally visible after a crash.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index e488b1aaaee2..7ac945369762 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -794,7 +794,8 @@ static void brcmf_pcie_bus_console_read(struct brcmf_pciedev_info *devinfo,
 		if (ch == '\n') {
 			console->log_str[console->log_idx] = 0;
 			if (error)
-				brcmf_err(bus, "CONSOLE: %s", console->log_str);
+				__brcmf_err(bus, __func__, "CONSOLE: %s",
+					    console->log_str);
 			else
 				pr_debug("CONSOLE: %s", console->log_str);
 			console->log_idx = 0;
-- 
2.21.0

