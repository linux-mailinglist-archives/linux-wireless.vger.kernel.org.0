Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9A1005BD
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 13:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfKRMjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 07:39:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38767 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRMjH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 07:39:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so18754182ljh.5
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 04:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Obwar3Frv5I5Lb9Y60rWjIuAOoBlmDPKvdqZOjbYHQ=;
        b=qI2i8wyXLefxEerYFE7aHUx3bDs84hlX3zE9EePmZ7fE9MHnFFdHaSwJDSq15teqlw
         QX1p6I0su5Qa7juuON4rWaAxC9l05SaKliBVfAisVtgJeWJpcCjxv5SFdMuGKdLRouE5
         xxHIRMbLszwqcBffTAy81gx97RBVLTckGQfguOLvlD1pXooRfO7rm+NrV0BNfx01k3z8
         Va75wHlv4y0ENx+cnPqTKYn1LgLAl8laOTTI8PqdwMxEVAkTvYMCrleqivS2VHYsWSxb
         YKQ4YAYa845GvIhcNfQESdTgsIBW4X5eSNqCPShaISxZbHjjQhREXzguvTSQGpUv3urO
         s+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Obwar3Frv5I5Lb9Y60rWjIuAOoBlmDPKvdqZOjbYHQ=;
        b=kZrZoqJW7vA9fJ+79sATkybfwlEGyRAJ5xG0USrYC+m9GwH/LROSDR99rlA3qOokjO
         2nd/07XYiEa12xmmLBjOytW77Eelz4UQOcoooytP14/DfLBozEPkopMytEC7URJdBe8O
         CqrYKRQnj/jpNd+U5NmBLMmFuOGV4Hb6BBh+hpsvGvZOyJVyFyStOzsJgPlRwSVT7yn5
         TqXBZRHdVM6g1rZO17xE++64Pj1v8ZCkHse3hKIpTTVGVe7ORWQyDahVwUBek5w0du3a
         UPtQMoxro5fOjnh1ntHHEZgJNJfDVvXb9Kew7i7fbu8/cdlpezGQ35ceqlBDoKYXZxwb
         ECRA==
X-Gm-Message-State: APjAAAWLgkwNJPXzWBHVoDBpNWj10AD1PxlE1gobQPWmM4mx7+fccJPA
        zQDk7K/0e6IDD6w35j00ysUbOyAz
X-Google-Smtp-Source: APXvYqwChOmhZHDulhLGWrE+MUPlTFn+0c8XrB6nAQV4CD4xH1SJ1X6UwcWoc5rHSSTCiApEihk0Wg==
X-Received: by 2002:a2e:9016:: with SMTP id h22mr21213302ljg.137.1574080743725;
        Mon, 18 Nov 2019 04:39:03 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id k19sm9712289ljg.18.2019.11.18.04.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 04:39:03 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 5.5] brcmfmac: remove monitor interface when detaching
Date:   Mon, 18 Nov 2019 13:38:55 +0100
Message-Id: <20191118123855.31696-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This fixes a minor WARNING in the cfg80211:
[  130.658034] ------------[ cut here ]------------
[  130.662805] WARNING: CPU: 1 PID: 610 at net/wireless/core.c:954 wiphy_unregister+0xb4/0x198 [cfg80211]

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
Kalle: it doesn't seem critical enough for stable but would be nice to
       have for 5.5.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 406b367c284c..85cf96461dde 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1350,6 +1350,11 @@ void brcmf_detach(struct device *dev)
 	brcmf_fweh_detach(drvr);
 	brcmf_proto_detach(drvr);
 
+	if (drvr->mon_if) {
+		brcmf_net_detach(drvr->mon_if->ndev, false);
+		drvr->mon_if = NULL;
+	}
+
 	/* make sure primary interface removed last */
 	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
 		if (drvr->iflist[i])
-- 
2.21.0

