Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A73A17494A
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Feb 2020 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgB2Uhp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Feb 2020 15:37:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45256 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgB2Uhp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Feb 2020 15:37:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id v2so7545201wrp.12
        for <linux-wireless@vger.kernel.org>; Sat, 29 Feb 2020 12:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=l56A/14PXkqGHLE8YMBNeU8cv7OpOINY7Us8P01pWEE=;
        b=MO2KphJIj8hI5R88Gmx0Gw2qjjdCiav9FlUhpY1aqLoMGZl1QkFTGZ3iz5gffN96oU
         bBGNA6Z79h5IeTF1VW5ZOru6p1u50ifOp1/ticiSPwxDx7nJC/OrlxnAR9RZlXcee85k
         u+Mz8/012JjFwXBcRPsxZ3sol82QY/iAZblG4KzlTTwil9ECebkMrs7WenJ9gOsENb1P
         j+ruhdDbP826ZJ9w/llk/VXDqW/gDWmiz7lcXDfh+3NfcEIgJ1fGWaVPB49LiI6vdWno
         FMKbVYUoHrbFz6qnZz9PZk23lnHVb4pSElMS/bfP/4g6H7URw+dWybdfIZzt+CNnLHo1
         B3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=l56A/14PXkqGHLE8YMBNeU8cv7OpOINY7Us8P01pWEE=;
        b=lwHMsAl5c4SPkM+GzCR+O2ZuOepXUuHiBUNKJAE0AgJY5YuJaBPzD9t1UiAeBi1CPQ
         n7puUljcNYavX15an9hvSwnwCRPmx5ZMQ2PBLImpjKbuK0oTFdp1esb6+IGmJqADNmhR
         DVS5VNvnIUAdF9vcmOe/U0YRQen64hmoxERN1VdlMZH0XigZCYIQdOJ9UH9SJz0XlNzB
         ReFma56WJ6LewTbZCWq4M734r7/rXmidqWcKDauqoW2ki4bnUAQSJwbbfZvX4qoidK02
         XteR8Zsg0ZtC6UcEtli09Sh9HtF8JwHVkinEdfDkNLCcQdzZzU2+2ZCAW0L7gq3yaAKS
         ZxhA==
X-Gm-Message-State: APjAAAXEVoM0ibVOCWZNrTgHKerLM+RhbnOxCyfC3/ez8rtGmWU1L5sZ
        ZfcbRwrYpkRRea94BRRm46wri3As
X-Google-Smtp-Source: APXvYqyUwQEDtNilxtgNPnUsu8tsFDjgOhgZ1G3ZWAF+6VctctdlipuzAfGqQVaThsjBWldBYIyrGQ==
X-Received: by 2002:adf:de09:: with SMTP id b9mr11826474wrm.160.1583008663505;
        Sat, 29 Feb 2020 12:37:43 -0800 (PST)
Received: from [192.168.43.18] (94.197.121.166.threembb.co.uk. [94.197.121.166])
        by smtp.gmail.com with ESMTPSA id b186sm7771432wmb.40.2020.02.29.12.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 12:37:43 -0800 (PST)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 2/2] staging: vt6656: vnt_vt3184_init remove stack copy to
 array.
Message-ID: <49f34764-c90c-8c5f-b4f2-a3668b13e519@gmail.com>
Date:   Sat, 29 Feb 2020 20:37:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

use u8 pointer addr directly and remove stack array.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/baseband.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
index 48a624bf00c0..74b620b4261e 100644
--- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -367,7 +367,6 @@ int vnt_vt3184_init(struct vnt_private *priv)
 	int ret = 0;
 	u16 length;
 	u8 *addr;
-	u8 array[256];
 	u8 data;
 
 	ret = vnt_control_in(priv, MESSAGE_TYPE_READ, 0, MESSAGE_REQUEST_EEPROM,
@@ -437,10 +436,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
 		goto end;
 	}
 
-	memcpy(array, addr, length);
-
 	ret = vnt_control_out_blocks(priv, VNT_REG_BLOCK_SIZE,
-				     MESSAGE_REQUEST_BBREG, length, array);
+				     MESSAGE_REQUEST_BBREG, length, addr);
 	if (ret)
 		goto end;
 
-- 
2.25.1
