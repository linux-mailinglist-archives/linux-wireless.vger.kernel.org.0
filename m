Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A304E33BD
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 00:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiCUXKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 19:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiCUXIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 19:08:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F07156413
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 15:57:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg10so32789493ejb.4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTDlP+uXn5kbgAw1udfHWGoa/+ze9Zqyhy1PS/mbCas=;
        b=aqEMYq2Uh+dZtSswuQ1d/cNppXoA7f2SZjrw52Lk6BwVSAZpdojLtqRF7lSKo7htZh
         6mhhr3ZpVIqaVt3dGPPXdwNphDNbc8NAQ+WxjkUFlMhqKy/DA2XeAzk29aEKxwI34Xqv
         5YTBNRi8XqgKloH6ObtWDnRv/SVW/tt12QIAOIMKi1IAMRx210EwgDe7pDLI1ZeSCFhV
         DrPz6G90KIqeQBw8jEk1xhDpQiNcOrjfAgegyMZeV7zidux+ZHthpy9A6TZEMhGT3NcM
         1h3GOy9dqv479ezZzMRMU84kIrjFi9ugE6qe4E6yj6UuxrxLcaTzlVPejtT1uHNzdSc9
         Tzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTDlP+uXn5kbgAw1udfHWGoa/+ze9Zqyhy1PS/mbCas=;
        b=mDCFvC8csnvHqW8Oc4fGkpg5txi3S5ZBWVzN4uJ8dr3IvzOLR++X1j7Ko/hA0jPaLg
         A15Wf5EAhp/ggYVGomLLCGu68qfFMgU1iI3JYKHJxNMg0AvoKOEskH96hLT0vTPTKP6f
         GaCF/FTvjZVLoYAS7WBCDTYlT5dx/q9WPSyU+LcQuNAFTZ7PncLEeuO955QxtVS6dJKF
         uiIvhmth4lUfpPq5tWC4QS1X41s869aFwAPAY2g6sySVVBj0RK5DJqOG1WP0L8oSoBP5
         nBBMa1VXCp/Isc/BgBwcXfRGG1l8mMG7HIXWMG7DFLltQOz5eVMN++bomMJQqCr+3tec
         Mbfg==
X-Gm-Message-State: AOAM533njp1ZX/XxHNeRbarZgysz9x3VWFmFRwRnECN2vzkurjeIg5/H
        jREux1ECGUnSSOSxcq5AUjwG6LBD0tBMKw==
X-Google-Smtp-Source: ABdhPJxhTtd+aIVKFzaa1FWoa8PUG/jOFLti2wQ8kjmzshz/wOJyJIXF5MITYRgUUvo/1qIFqZZNiQ==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id ds2-20020a170907724200b006dab561d523mr22536109ejc.118.1647903339018;
        Mon, 21 Mar 2022 15:55:39 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7dd0a000000b00419286d4824sm3320099edv.40.2022.03.21.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:55:38 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH v2] mwifiex: add mutex lock for call in mwifiex_dfs_chan_sw_work_queue
Date:   Mon, 21 Mar 2022 23:55:16 +0100
Message-Id: <20220321225515.32113-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211_ch_switch_notify uses ASSERT_WDEV_LOCK to assert that
net_device->ieee80211_ptr->mtx (which is the same as priv->wdev.mtx)
is held during the function's execution.
mwifiex_dfs_chan_sw_work_queue is one of its callers, which does not
hold that lock, therefore violating the assertion.
Add a lock around the call.

Disclaimer:
I am currently working on a static analyser to detect missing locks.
This was a reported case. I manually verified the report by looking
at the code, so that I do not send wrong information or patches.
After concluding that this seems to be a true positive, I created
this patch.
However, as I do not in fact have this particular hardware,
I was unable to test it.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/11h.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index d2ee6469e67b..3fa25cd64cda 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -303,5 +303,7 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 
 	mwifiex_dbg(priv->adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
+	mutex_lock(&priv->wdev.mtx);
 	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef);
+	mutex_unlock(&priv->wdev.mtx);
 }
-- 
2.35.1

