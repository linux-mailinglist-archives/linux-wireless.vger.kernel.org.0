Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1809292E40
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgJSTPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 15:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731106AbgJSTPI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 15:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603134908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=RGSj1Okw6bTtmOh6LtFIfqugUnOPwzH6b+MxduTDcFI=;
        b=IF/zGuTWIjSwfmFLEwqtLbNP7976s5g7cBsybwgy82kG8vADa81NEUTNBoGxtbYZnMHqtA
        64XA5n9iHSciQcnd3b56+1jTOTWzPIpwTYrP990nHBIXmjrFBIevFfyhbU3p7LkV21L5dz
        4EH2M0RHuJdwH4Ez4SIc/ifVPOhHkqA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-yk7r9UCBPxSElnS6FI_B5g-1; Mon, 19 Oct 2020 15:15:06 -0400
X-MC-Unique: yk7r9UCBPxSElnS6FI_B5g-1
Received: by mail-qt1-f197.google.com with SMTP id p2so649696qtw.16
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 12:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RGSj1Okw6bTtmOh6LtFIfqugUnOPwzH6b+MxduTDcFI=;
        b=HBakRDC68VJhO7i+K7JCBUEDsqJAq6eed85l49sc9Lfp30AnXHBapjFuSPNtnFuK8b
         VbtKYhPm+bCZjJaf0KhE3qcEo0mh5VhTGnzDHRXNM+R0kKx04Cou+HEAElmUcKeZlqc3
         8tiV6nU/iJHUkewZCQmcregR05o6KiLVivvgGH3WEfDMXQOaxjWV+99S9g7Gkfw+u9EU
         fibRB37DDX7LxsTK32h5dRw7XnBT6ST9no0PwWVUCmUQKohbu7NndTWYNx4ohTb+gCIG
         ufInZ8+Ouj5H97QHfWFCHdF/Vli9bRYZtN0hBvD36o7lefALBl8mu9R6607OzLQU8/eh
         Pqzg==
X-Gm-Message-State: AOAM531lWIaltRslLaUAsvMM+5L5zpqhD0K+ukChQQNwbg7LjtNzJVXo
        szS6OyBj62cP/oAnp1chIhZ2hl9KgKsjyA0P5SaT35xhlLYtn3XQRSsHHrP7nKNA96rcP82w2PV
        VH26OVcoV0enwuR80GPa+hfpCDv0=
X-Received: by 2002:a37:ac0e:: with SMTP id e14mr1073215qkm.336.1603134905682;
        Mon, 19 Oct 2020 12:15:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe7gZkbDPpHASbLaACCMlaKx46gerbINgHx+8qtcEjJmA0BMQ/ELyGF8Sg3X49xeIdSppc6w==
X-Received: by 2002:a37:ac0e:: with SMTP id e14mr1073199qkm.336.1603134905473;
        Mon, 19 Oct 2020 12:15:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b191sm419142qkg.81.2020.10.19.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:15:04 -0700 (PDT)
From:   trix@redhat.com
To:     mgreer@animalcreek.com, davem@davemloft.net, bianpan2016@163.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfc: remove unneeded break
Date:   Mon, 19 Oct 2020 12:15:00 -0700
Message-Id: <20201019191500.9264-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nfc/st21nfca/core.c | 1 -
 drivers/nfc/trf7970a.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 2ce17932a073..6ca0d2f56b18 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -794,7 +794,6 @@ static int st21nfca_hci_im_transceive(struct nfc_hci_dev *hdev,
 					      skb->len,
 					      st21nfca_hci_data_exchange_cb,
 					      info);
-		break;
 	default:
 		return 1;
 	}
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 3bd97c73f983..c70f62fe321e 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1382,7 +1382,6 @@ static int trf7970a_is_iso15693_write_or_lock(u8 cmd)
 	case ISO15693_CMD_WRITE_DSFID:
 	case ISO15693_CMD_LOCK_DSFID:
 		return 1;
-		break;
 	default:
 		return 0;
 	}
-- 
2.18.1

