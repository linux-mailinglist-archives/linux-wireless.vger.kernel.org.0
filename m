Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F1699415
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Feb 2023 13:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBPMPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Feb 2023 07:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBPMPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Feb 2023 07:15:18 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0362CA2D;
        Thu, 16 Feb 2023 04:15:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id fi26so2488216edb.7;
        Thu, 16 Feb 2023 04:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjOcvsZDIQCf+hq+MC47oV0H+OQ7PYaJvMVzLlaMG/g=;
        b=bLVOYgJbpodTUmrN6JEz8wHouhRjeij0pQm1HtJliwebNIB+uBscgGPxjOsodww3UL
         /IyVhn7TGvfsqrjfn+BuqfrFWYPaDyQWBBCGgVoTDTOE0KPkdl2k+h7ph5whuu9trUw5
         8aUebWPfpb2p1AupPxeLAoYTCHSOgJUFYPpNAhRLdTBXD89zxVIZFWEnp91Hz0dlUlv6
         UDtKrwj24I4pEBaIjVtEPeSrl/QaFOCfJ9aPYyVodOE2IlrR7gMGpPAtbxxnl+K8X1oH
         HTrJqivihA2UivxNoqXcaHdDCT1/hdPFWJTn4zW6tT71hMRvNjcgR/nw9lqmOhd1MGFS
         GPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjOcvsZDIQCf+hq+MC47oV0H+OQ7PYaJvMVzLlaMG/g=;
        b=xbsuDU8ELulirP3gau496Q5apRD7pHaUAQDXJOE7ksGOf4WoVKdJ7U+wB74yMy7vQn
         GhmF0YW2v2ybyzYlbJbWv1KbfuNHZm3yc+IFzITlbnFjQuvowB0YAPfagIg+rzotVBq3
         ATYhWYYb1MAcRLvGcY2HJsvXXYrEvb3Baggvar7PdeSkLc32H2guTcwx84Xw4T601YtG
         3fbt6Q9eNtgz3qAATPC71m4JlpadIqIR4MZL9L3btnM8s6dADHJdlkrBfxESg8Ai0apX
         Bu9w5qabs/5OrRdtcWKRpj8uL8zOa3Z1NAFJmdmdvQ3sT+IG1euRgPYPEPFJbwG1Z6Ob
         QIzA==
X-Gm-Message-State: AO0yUKVihT6h/OBXPdDCQ35MS7Slq9ZGJBKBiOLJ5KsL4cWHOPQIaLlx
        XRrCqhzG6rhxfSrbf1GXP68=
X-Google-Smtp-Source: AK7set++FMpxqDaSzuqmtTnlKrhVhMkeqZRMCr8YnZqw1C2uL/5q3tGz3OgBKKCOYhdz7nmD9qaGDg==
X-Received: by 2002:aa7:cf04:0:b0:4ac:b8eb:e398 with SMTP id a4-20020aa7cf04000000b004acb8ebe398mr5141813edy.6.1676549711175;
        Thu, 16 Feb 2023 04:15:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k2-20020a50ce42000000b004acbecf091esm780169edj.17.2023.02.16.04.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:15:10 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:15:05 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Howard Hsu <howard-yh.hsu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7915: unlock on error in
 mt7915_thermal_temp_store()
Message-ID: <Y+4eSSqaHCpfK1EG@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Drop the lock before returning -EINVAL.

Fixes: ecaccdae7a7e ("wifi: mt76: mt7915: rework mt7915_thermal_temp_store()")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 1ab768feccaa..728150b35537 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -89,6 +89,7 @@ static ssize_t mt7915_thermal_temp_store(struct device *dev,
 	     val < phy->throttle_temp[MT7915_CRIT_TEMP_IDX])) {
 		dev_err(phy->dev->mt76.dev,
 			"temp1_max shall be greater than temp1_crit.");
+		mutex_unlock(&phy->dev->mt76.mutex);
 		return -EINVAL;
 	}
 
-- 
2.39.1

