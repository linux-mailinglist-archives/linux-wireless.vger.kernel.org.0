Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35CA152133
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 20:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgBDTeG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 14:34:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgBDTeG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 14:34:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so24574811wrx.11
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2020 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xa/VtTU0vSVS5LXqAKxKyIRX2SoYCDqOHmaanbAohys=;
        b=ni1Zc7mq56v+achnR0h9YpgMhDx7Q4ZtWxkaYlWr49GiO7iIGKTyqKIfxYScGb4sXB
         uTell2I8s/iVksVtuM52vYjgBDKGBgflF3TYUWl3YeqVi/vtFZyBEpjboq0dkDg66n55
         NJSqj4RG1jsf7w1m+RfwNGIM3uDgX2YcbFAsMyeuCYUOS3VP69M3QaZQzIc6xXVmRYn+
         YhTCghnGUyytH4H/tXJdJgueDBNRH0dmrPyoMz6Z5K98C4d3/j9i5LNkpUWZiZ+UDxzE
         dbcHHa3x+mX/0Dq4hPD9R0hYcrStpHI14WjfngDkglYFdZeyjB6Zpt9Gi05JXnJZ9MI6
         Bx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xa/VtTU0vSVS5LXqAKxKyIRX2SoYCDqOHmaanbAohys=;
        b=lO6zrTB05CFwWPacj0a1P30NL6X/7fx3/1EWy45AykFlgdWr4++BWfCli0dgRx1YIR
         C7Vqkq82a/yyRhm7TQo775WmA3AGYwbinj1U3LTbGkw5mRCxUjh8wg/Af0sABSBLdBpQ
         2aorbpJsNAkBwu98LQK7jhfftWKqvNkCH3xYCJYmZCQjSY+iIUcgyJ/5QVW9U2dDzFpJ
         ZHOpbHC26qnon3KQfxycP1CLsZCfA2hqrPLflfUqzGJlIAqi6Av6/VnSulWo7EiKk5CA
         lWOiTWmgnOFv0MyqohUOFAzR0iJGaJRtr92lBtrCL2Gkq7bYa9COVSdrGXhL8nK0ZzCM
         wHRA==
X-Gm-Message-State: APjAAAX0LTpvnYZ/uT4LxV728C2pyjAuH9CJUm5wfBkcWN9eGOzCG2UH
        sVLnW3rGboSsjxT626tqeV12HtoK
X-Google-Smtp-Source: APXvYqw3lGO1nuq8adpOUmJjHG/88maQx+MQRwdR8qaRacZrl5Wz/2oNS/WHkPisVaiYJ8qeUWzKQQ==
X-Received: by 2002:adf:f244:: with SMTP id b4mr22485206wrp.88.1580844844592;
        Tue, 04 Feb 2020 11:34:04 -0800 (PST)
Received: from [192.168.43.57] (94.197.120.219.threembb.co.uk. [94.197.120.219])
        by smtp.gmail.com with ESMTPSA id t131sm5075977wmb.13.2020.02.04.11.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 11:34:04 -0800 (PST)
Subject: [PATCH v2 1/2] staging: vt6656: fix sign of rx_dbm to bb_pre_ed_rssi.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        linux-wireless@vger.kernel.org
References: <9b3b92d6-3672-00be-d0b5-ccd222236ba9@gmail.com>
 <20200203094222.GM1778@kadam>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <aceac98c-6e69-3ce1-dfec-2bf27b980221@gmail.com>
Date:   Tue, 4 Feb 2020 19:34:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203094222.GM1778@kadam>
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

Fixes: 63b9907f58f1 ("staging: vt6656: mac80211 conversion: create rx function.")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
---
Added fixes tag

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
