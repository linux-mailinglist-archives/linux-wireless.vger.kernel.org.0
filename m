Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DC3DA140
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhG2Kks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:48 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34508
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236323AbhG2Kkq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:46 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 584083F226
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555242;
        bh=So1uUDkE721+BEqMeRM8NOIaRYftuFanUkfPQdOA99A=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DbF2ZXKWL2ZjowC+P+66F0i9AmExNlu4XnN2YRnEGYtKi+1nRR4PtnWKxVrHnqOi7
         2WWd0yKlmMWk5PsguM/zKjGrG17IXiPskbQMT6zh0cIXYS72pYFBHTVxtcOtjFxUDc
         vG6dRhUGxyM+f7OaIpWcGrK16y7a6ukjfZoULdpHZy4oyEYKwdOl/tmNZH/zSyH6LV
         Lwe8a/6D2W4rc/DrR100WCuNQ7Z/WttHFAQPdAd17W3iEmsemRIiRdoXVhpvF8NKWH
         CHLkR00QIl83Bs9yR7loGcM9v2qZMqLOSkvTurKooZfV6DGcrtXbMwlJn86TiWZr3D
         HAWb3OBg5PbSQ==
Received: by mail-ed1-f72.google.com with SMTP id c20-20020a0564021014b029039994f9cab9so1286997edu.22
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=So1uUDkE721+BEqMeRM8NOIaRYftuFanUkfPQdOA99A=;
        b=S23q8wbWK2vKYWsvp/LTCMXs2buyh3g4iSWAsOOQSjDlQV8gO4BUneFzyfQWp9loPi
         FumDfKCJluhc/Vzc4oyYk7adDRjN13b0gflOUs1SI9yAGNe/EYZmR2bpwaeUf34WmG32
         /OiCk6e/RCy3SgN2AwaQZT+FvnUN3guT4FLVXLtLxQFnQhg2W7UwoZ1QE4naySFgwJay
         m82NVkiXjg6BCJId479zbmsZGk9YweEA8oYhPuTu5Vh5Tfa0Xjjf7A68EsjQiG2n7Bw1
         vlXFuRCuO2kJhWpkXejhshI0TyE5yYFItOScQ/wF4zpstOx3uSmIUNSlAqcs45BqaylB
         zfmA==
X-Gm-Message-State: AOAM532KM45OyZKvIM3FQ+byAa8la7fCOdtQmtDuMAJ4FBOjrARPU3Y4
        zph+tSTvLQOQiEb4YAJlpD0E4kd/TLDGJSpAdUIzurLtQi59nMw+GbjjzSAUnq8ATgxMeLC5We/
        G0V6/mu3M02pfc22Rclo961iiKoM7RTC3Eec7K7ek3hBP
X-Received: by 2002:a05:6402:cb9:: with SMTP id cn25mr4576416edb.271.1627555240172;
        Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg8gQFeBPTWOxeoK6KYjuQRUdToXFwmH6p9ZgcYdRRS/mw4BXtIUndBzQfGalBkLacI2jz9A==
X-Received: by 2002:a05:6402:cb9:: with SMTP id cn25mr4576407edb.271.1627555240070;
        Thu, 29 Jul 2021 03:40:40 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 05/12] nfc: virtual_ncidev: constify pointer to nfc_dev
Date:   Thu, 29 Jul 2021 12:40:15 +0200
Message-Id: <20210729104022.47761-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

virtual_ncidev_ioctl() does not modify struct nfc_dev, so local variable
can be a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/virtual_ncidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b914ab2c2109..2ee0ec4bb739 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -170,7 +170,7 @@ static int virtual_ncidev_close(struct inode *inode, struct file *file)
 static long virtual_ncidev_ioctl(struct file *flip, unsigned int cmd,
 				 unsigned long arg)
 {
-	struct nfc_dev *nfc_dev = ndev->nfc_dev;
+	const struct nfc_dev *nfc_dev = ndev->nfc_dev;
 	void __user *p = (void __user *)arg;
 
 	if (cmd != IOCTL_GET_NCIDEV_IDX)
-- 
2.27.0

