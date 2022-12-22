Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C04653FB8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Dec 2022 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiLVLuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Dec 2022 06:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbiLVLsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Dec 2022 06:48:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F229350
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 03:48:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1090764wmb.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 03:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/E5LB2c4UxvbhS5/EA5bZiOntCYtat1IHin1Ect54NA=;
        b=j+WApeRdaz/mz0qlXz9IXN9nsb8xANbRB1Ezv1BaiOKdwGu0zOArKwHRN4P+vxbKYi
         zvh7ZkCnB40g1oMWzhXlsXPnRVmIhpb/+/hgeRQdmDDdnbdEz8W7N/eVyhFS/+Uny6s3
         6rlq23nY+vNq+T7IFPWREKNecLoIaeTIjJa/k6md0vdROdbFawRkQ/wDwVA7UOg7LrI4
         HAeqn8F9m2k/wgwOVSEY+rls0ua0ZLVXBkEc+OfqORR4Tz5tB9RCEBwgE42AzUdU2P+3
         nXSCYN8K6YA6sdRAHd2ngFE/5JuOritFrGjYNaXaSUtGP8geR4x48WHndSrJGxtOCkCM
         /IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/E5LB2c4UxvbhS5/EA5bZiOntCYtat1IHin1Ect54NA=;
        b=Hjfd87yuRWFgnMqYyqJIVQtfcSdS2TzurhAlhvN4ucDULdD/8g8WNv7bA2UojfRJFc
         ZkD/sTh53QtVglL2D+STe0x9i4v0U7ke/64MGLiKAPktPqhErW1E+AOimmK8SE1ecBLV
         nbKsrl3ZYH3lxMqCP1m7T4Et6MwmfSItZusu/H3mn/pY3sAkyiAu7Q1SnmLqBce9Rbhq
         JcjQOiLDneVDN6aAZ2EbHPX8BCKny057zjg+HkYYXFZAVtcMc2SNWkxgvJNrLbSWH47g
         UNoHC1oLtTMitf/R9OBmq+81hRmXteKZMtNyRw0cnuPStHFeo5n9J9FFpYywkXp3cepn
         0oOA==
X-Gm-Message-State: AFqh2ko+hYdw/Yu1SwQZ5ZySpSdQQnxd8eitzfQ2T+tphw2pxkF0ozuw
        3vki6GNJLzGIXSAft2HWnWP4Cba9rPQ=
X-Google-Smtp-Source: AMrXdXtze/ZR9L1DWK0C0J6v72jCnS+69oDoBwSrH7RaN0LgAXNtmlMbjR+52THmmNRil9mE3wynWw==
X-Received: by 2002:a05:600c:35d0:b0:3d2:3f55:f757 with SMTP id r16-20020a05600c35d000b003d23f55f757mr4084539wmq.20.1671709686933;
        Thu, 22 Dec 2022 03:48:06 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id iv7-20020a05600c548700b003d35c09d4b9sm6531469wmb.40.2022.12.22.03.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:48:06 -0800 (PST)
Message-ID: <03b099c1-c671-d252-36f4-57b70d721f9d@gmail.com>
Date:   Thu, 22 Dec 2022 13:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Fix memory leaks with RTL8723BU, RTL8192EU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wifi + bluetooth combo chip RTL8723BU can leak memory (especially?)
when it's connected to a bluetooth audio device. The busy bluetooth
traffic generates lots of C2H (card to host) messages, which are not
freed correctly.

To fix this, move the dev_kfree_skb() call in rtl8xxxu_c2hcmd_callback()
inside the loop where skb_dequeue() is called.

The RTL8192EU leaks memory because the C2H messages are added to the
queue and left there forever. (This was fine in the past because it
probably wasn't sending any C2H messages until commit e542e66b7c2e
("wifi: rtl8xxxu: gen2: Turn on the rate control"). Since that commit
it sends a C2H message when the TX rate changes.)

To fix this, delete the check for rf_paths > 1 and the goto. Let the
function process the C2H messages from RTL8192EU like the ones from
the other chips.

Theoretically the RTL8188FU could also leak like RTL8723BU, but it
most likely doesn't send C2H messages frequently enough.

This change was tested with RTL8723BU by Erhard F. I tested it with
RTL8188FU and RTL8192EU.

Reported-by: Erhard F. <erhard_f@mailbox.org>
Tested-by: Erhard F. <erhard_f@mailbox.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215197
Fixes: e542e66b7c2e ("rtl8xxxu: add bluetooth co-existence support for single antenna")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index fd97c040948a..03ffb99da7e2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5702,9 +5702,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 	btcoex = &priv->bt_coex;
 	rarpt = &priv->ra_report;
 
-	if (priv->rf_paths > 1)
-		goto out;
-
 	while (!skb_queue_empty(&priv->c2hcmd_queue)) {
 		skb = skb_dequeue(&priv->c2hcmd_queue);
 
@@ -5737,10 +5734,9 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 		default:
 			break;
 		}
-	}
 
-out:
-	dev_kfree_skb(skb);
+		dev_kfree_skb(skb);
+	}
 }
 
 static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,
-- 
2.38.0
