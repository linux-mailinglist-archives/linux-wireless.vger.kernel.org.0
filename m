Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C225214FD0F
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Feb 2020 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgBBM1c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Feb 2020 07:27:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43853 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBBM1b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Feb 2020 07:27:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so2191435wrs.10
        for <linux-wireless@vger.kernel.org>; Sun, 02 Feb 2020 04:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IZlLOQyp62ykJD13LCRO0yd0g3YOI4L9Cfoqf+OJ1ac=;
        b=IoSJMGPjzVrIR30XKtivH8bXL/UMpssbQF9np3kKDvhfqV6JgBF8YekhOghnjcNbx9
         +z2BIViWpZe9XFiiSxUqMSWkFDayj9ZzoXYXMDuJHEwJjxWW4k55Y6elvxqhGYT7fU+u
         HHfhgsAyzMn8ZHLn59FLx8K96cRlcYd99UPz3amH8ogVbk+0Y4TBFBd/sMxpkQJG+wji
         1jXGD1UziEHpgpaqi2eAyEgAqQw+Ax74fSVh2UN5mFoafsHhv6CaMl00VQYFO4YVYSAI
         Sg4xJbfdFg8lFaTi6faFILno/ObL+EwQBVZVfIDR1bNEEfBrsbuYs0j0FaPT+B6OiZaL
         aBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IZlLOQyp62ykJD13LCRO0yd0g3YOI4L9Cfoqf+OJ1ac=;
        b=O8TNQGTC4q8vZz702mbvDnK82c9sURMLTrlLLUzXGHDjzCd6Xrp5GFDHakr9luRB01
         DvQQKlI5uH0Yl4VYeOy/nx+ehWIg59b7BPH2loFvtgLjPIGzbnbBsy2fzRSHpN9RKIyH
         iRqPb3g/ZUwRROmaPBImapYIAR9KNWGVE1UH+euQztu//QntIjDJNBvdOi8f/qlt2hFs
         SdunGHQzZOtpb7sdeHzwmmyjMaUCV70vGmMNlHZ85j/s4y2vv/j+ApRGq0S3Vq0X9G2U
         mbRFhSIC1drIlA9NnYj7tzrn+mFCDGDqgKdSG4rfkJeSGPp/7ZZa0Eil5ozyBM7Gen30
         SsjQ==
X-Gm-Message-State: APjAAAU71kh3/0kieTxh6KEg3nxwAvTXC0w0jkuKA9uXQHX+lp6Cwun4
        HCrKiyU8Ox817Q15wYVFv2QCuYCe
X-Google-Smtp-Source: APXvYqxMNkadPtwzcDYNPhLpggDxO4GDsCsSW7fyo+EFOP4rIEtEL4tnoN0DWyFP1eViLUF7e5/FDA==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr7776349wro.423.1580646448367;
        Sun, 02 Feb 2020 04:27:28 -0800 (PST)
Received: from [192.168.43.18] (92.40.248.192.threembb.co.uk. [92.40.248.192])
        by smtp.gmail.com with ESMTPSA id b16sm21796403wrj.23.2020.02.02.04.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2020 04:27:27 -0800 (PST)
From:   Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 1/2] staging: vt6656: fix sign of rx_dbm to bb_pre_ed_rssi.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-wireless@vger.kernel.org,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Message-ID: <9b3b92d6-3672-00be-d0b5-ccd222236ba9@gmail.com>
Date:   Sun, 2 Feb 2020 12:27:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bb_pre_ed_rssi is an u8 rx_dm always returns negative signed
values add minus operator to always yield positive.

fixes issue where rx sensitivity is always set to maximum because
the unsigned numbers were always greater then 100.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
 drivers/staging/vt6656/dpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/dpc.c b/drivers/staging/vt6656/dpc.c
index 821aae8ca402..a0b60e7d1086 100644
--- a/drivers/staging/vt6656/dpc.c
+++ b/drivers/staging/vt6656/dpc.c
@@ -98,7 +98,7 @@ int vnt_rx_data(struct vnt_private *priv, struct vnt_rcb *ptr_rcb,
 
 	vnt_rf_rssi_to_dbm(priv, tail->rssi, &rx_dbm);
 
-	priv->bb_pre_ed_rssi = (u8)rx_dbm + 1;
+	priv->bb_pre_ed_rssi = (u8)-rx_dbm + 1;
 	priv->current_rssi = priv->bb_pre_ed_rssi;
 
 	skb_pull(skb, sizeof(*head));
-- 
2.25.0
