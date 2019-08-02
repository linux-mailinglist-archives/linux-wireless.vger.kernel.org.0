Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898D37E76C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 03:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfHBBVH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 21:21:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40189 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfHBBVH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 21:21:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so34225389oie.7
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 18:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=duxvo20Z87bldbnS1RdhNAWkKh8o11YtiM5F1ugvuww=;
        b=vW6f7IlmJGzZtjyVS1qxaPM+IZ81YMID0uG9osikgzWEfNVfbh+ScTXYIPelIiC6/8
         VTaWxTuH26KX5h0E8Bd9p/RkL0BX6Qhw00HYVzj6Y0jtg7pXlnAfvNWv2gXcuR7+ljnL
         d1/2/L7hLx3ib8bfI/I6ySHB8E25c8uIei7AI3VxmWNX4XKtpSm8GH7PN1Uf2+XzKZVn
         F0gva/DUosLu8P5pUxgG8HoKAJXErdOVQG22vWmsDsIuJQ5kPpE7IEbKcT5GpKYHO8qy
         4oTY+vNy/QVvsr6Pf+fGDhUfY57H8BVoFDTRxu0B1QjWW0p7gfrE6MKVtPVWGqj35K4l
         eP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=duxvo20Z87bldbnS1RdhNAWkKh8o11YtiM5F1ugvuww=;
        b=uTkHdL0xA/vHzVGVZQIrUiivtnCd8VGHb4s4dFpoOxs0tl2twBikKW4MxPcKfgGPkt
         zgA7i/n//Gh3oX6U9C+EM63NDYa0PZJ1XgUlI3aUqL2FfbWcGKVeybhhOjNR0FYgc7si
         s3p0UXc/OM+Ps/hs+KRNGB7b1CvFxWGuDJIpBcmfZbB2xRgY5DOt1pJtsZYGR9n45Dji
         dJF4iRFT7PanXN26u2dQEhLDkR0vfUHP1oysXU4RfPGT51sAg1wE+Xmmtn/eDY+Jhxxr
         SrAoW1DYEE4iPqs8LSt1iR67/48535cJ0a0K/KtgYhMd0J0Hdc644SXKsCSG65Fz7obE
         4KOA==
X-Gm-Message-State: APjAAAWCwqgTQZ7ABQL7wSXTySO5QRj9ycmsYh/AYEgSLdgy05G8wxC2
        ENLvPzEoE7NTQoUw2xfy5L0=
X-Google-Smtp-Source: APXvYqwFxteYGXQtg9YXNxL7nI8YimVxIxX8s3cWngsLeGqlX4gwMnWa+t2pY1fzl2pXVEVUGI7UyA==
X-Received: by 2002:aca:36c5:: with SMTP id d188mr1035483oia.151.1564708866936;
        Thu, 01 Aug 2019 18:21:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c64sm28112162otb.79.2019.08.01.18.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:21:05 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/4] rtlwifi: rtl8192ce: Replace local TX and RX bit manipulation macro
Date:   Thu,  1 Aug 2019 20:20:58 -0500
Message-Id: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These patches are part of a series intended to replace the bit-manipulation
macros used to set and read the various descriptors with a set of inline
routines.

The final patch removes a local configuration variable.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (4):
  rtlwifi: rtl8192ce: Remove unused GET_XXX and SET_XXX
  rtlwifi: rtl8192ce: Replace local bit manipulation macros
  rtlwifi: rtl8192ce: Convert macros that set descriptor
  rtlwifi: rtl8192ce: Convert inline routines to little-endian words

 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c  | 215 ++---
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.h  | 803 +++++++-----------
 2 files changed, 424 insertions(+), 594 deletions(-)

-- 
2.22.0

