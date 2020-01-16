Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764A213D8D2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2020 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgAPLSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jan 2020 06:18:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPLSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jan 2020 06:18:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so22180128ljg.3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2020 03:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVBoqVRFs4nAgEH34liC4NolHL4EzkTNuvEN3281IP0=;
        b=hlfW01HNb5EUNd2IMBpZCn88HjA65apCsfunkWKm5qgNDDqs2lateFqvd3NjiCS8eQ
         GxMO0NXRG5LMSnGjB6oyux6hWEIqmq/UgQa7jnUyZK8ggyTZ2p3Olq2//dru9pW3VB9e
         tkFQVugiu87cAltDpwac9ujpEXnFOOy2yjIpXT1l/kKwny/Uw2IT3oNTe7WTAQOCgsuf
         0Fchva729kKeU3NohyIGozf2KttQwNEQIlTGnOPIqIOcOGIRUWnsSKbcOVvlmnKboRm/
         EVL28dyhVYypEhu7CgLh1fYfNrS31vEWlPA5PlfRSVlrX0TCUHcH3BFPkuZuvV8zgJ3P
         IzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVBoqVRFs4nAgEH34liC4NolHL4EzkTNuvEN3281IP0=;
        b=MA3AvjIc61KAXTUzADfChEA55noxCXcY6Kx046Uhe19GtB9HcNxC3OYl+x288O1aOe
         3/RG9PjKqUDi4YfaQIe1cFbfil8Z8bKk4OiiP15Rr6kvQA+OLZAS9RhIFqvXqXUFa8st
         daqIfgtJIJpCXpBB4PO3HxcZG1nEklAAGhGp90ilfxcRBQcYdS2TE2OhFVceWmV3MGTL
         G49ziT/BjxrSeGSjDDoQgusLKXCJl9joN8RmPN688vg9Cad+XSI2SXpByXv9+8D/A+le
         AXtbjqHAqBejhGOGYUBgyy0KNtZuIZ99DfSx4sN8XPtapBVBpbH4B+yTnwQW1Dc5hUtX
         CwvQ==
X-Gm-Message-State: APjAAAVvQyy7EPXS1Y/Ki/ug6+7E7ZGbSwdkXWvlzz400jOV8A6sVQuU
        Ilq+fDkN33yao9Q62uINAZEn83Xv
X-Google-Smtp-Source: APXvYqw5ojxuwVPbAcAOYD1cNI0qxULJRyxto6kFVBv5KGDdXICj7/QhkAgOzmsLsJIT5rSQnFLdig==
X-Received: by 2002:a2e:9596:: with SMTP id w22mr1743364ljh.21.1579173498990;
        Thu, 16 Jan 2020 03:18:18 -0800 (PST)
Received: from debi.debi ([176.220.185.180])
        by smtp.gmail.com with ESMTPSA id h81sm10410543lfd.83.2020.01.16.03.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 03:18:18 -0800 (PST)
From:   Mert Dirik <mertdirik@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Pontus Fuchs <pontus.fuchs@gmail.com>,
        Mert Dirik <mertdirik@gmail.com>
Subject: [PATCH] ar5523: Add USB ID of SMCWUSBT-G2 wireless adapter
Date:   Thu, 16 Jan 2020 14:11:25 +0300
Message-Id: <20200116111125.28915-1-mertdirik@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the required USB ID for running SMCWUSBT-G2 wireless adapter (SMC
"EZ Connect g").

This device uses ar5523 chipset and requires firmware to be loaded. Even
though pid of the device is 4507, this patch adds it as 4506 so that
AR5523_DEVICE_UG macro can set the AR5523_FLAG_PRE_FIRMWARE flag for pid
4507.

Signed-off-by: Mert Dirik <mertdirik@gmail.com>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index da2d179430ca..4c57e79e5779 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1770,6 +1770,8 @@ static const struct usb_device_id ar5523_id_table[] = {
 	AR5523_DEVICE_UX(0x0846, 0x4300),	/* Netgear / WG111U */
 	AR5523_DEVICE_UG(0x0846, 0x4250),	/* Netgear / WG111T */
 	AR5523_DEVICE_UG(0x0846, 0x5f00),	/* Netgear / WPN111 */
+	AR5523_DEVICE_UG(0x083a, 0x4506),	/* SMC / EZ Connect
+						   SMCWUSBT-G2 */
 	AR5523_DEVICE_UG(0x157e, 0x3006),	/* Umedia / AR5523_1 */
 	AR5523_DEVICE_UX(0x157e, 0x3205),	/* Umedia / AR5523_2 */
 	AR5523_DEVICE_UG(0x157e, 0x3006),	/* Umedia / TEW444UBEU */
-- 
2.20.1

