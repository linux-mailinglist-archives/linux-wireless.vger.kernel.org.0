Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9372C4E8913
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Mar 2022 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiC0RPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Mar 2022 13:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiC0RPl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Mar 2022 13:15:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DFC10D8
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 10:14:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lr4so15841899ejb.11
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJiZgtMpnnKZghJq9M/2REIUrPjoQgvKIygn28S38dc=;
        b=lZ2FfcaQ/aIDDfkz687qiDg4ajAlSGHHaFC2y7CgBFbcAUHE8ZwMsnHxhAfOOKP9z2
         owO40n0lSj68X47qdcdor+2PyB9Eslr7qVeYMji8uYGKQPZbHGq+JJh1+mxk/T4Y1sXy
         AaXYJV2D7hDAonZD2WXiXJAV9WMeko9FnAHOJ0hjuT9VUF7VOeMC5B+vw/JVCbomvhLp
         ZJ+tGUnNvjsYSCZ3Q43bW2Xad53rzufhDzRwir6Pd4pkgGsstUdYCxsqGodjK5ecbDVH
         Mi8RJjSH7wF8YYizBKzs0mBIgCbLKKI4yT+xmq5M+XOfLnZY6L+orwIjDAeTF7JKUq/Q
         KFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJiZgtMpnnKZghJq9M/2REIUrPjoQgvKIygn28S38dc=;
        b=VowwvrTZg2zLv565DQazw8knGbTfnRdJan2aBouf6bY7nnvHMeTsKZX9qNSPHFVdKZ
         3CN/3nJa2gQvB4pBir7yiTECas+IR3bpXTMVg+xHFrgb2QAbh9oYJMXSSZ7kM6O8V6Zb
         BevMDX4DYbkmb61MWFCSggn23X38/y4AZloPoxlXsviGZzB5I25fbiCyRirZ1D2ATFcR
         2cYo22TmhxyUi6zYs7WiN4xFp0YZqmvqK7uoJ+0gwblVhVjCyRFj2XixYGx2QG6QBuNZ
         tkERJMYnyDtaw/3UomK/WRBKCVk8wUW/NcJZkzOChbRRMenehgmk9aikcqbZUZ2YKXtS
         1fyA==
X-Gm-Message-State: AOAM5300hXrsc4w6O4do/IusTTEh2kfA08JpfS31XBexXmxWzX+Kb0km
        B4RISo0gF2aAD9fyZ7Cmilc=
X-Google-Smtp-Source: ABdhPJyr1tkcVLcBTPM00pRI6ySmJhP6cRynmCVqOHg8FVP8QfVpI8Hoiu6/GWIw8VFdVUM6wXsBFg==
X-Received: by 2002:a17:906:dc90:b0:6e0:1ef7:638f with SMTP id cs16-20020a170906dc9000b006e01ef7638fmr23154612ejc.234.1648401241220;
        Sun, 27 Mar 2022 10:14:01 -0700 (PDT)
Received: from localhost.localdomain (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id o5-20020a170906974500b006dfc781498dsm4866769ejy.37.2022.03.27.10.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 10:14:00 -0700 (PDT)
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, davem@davemloft.net, kuba@kernel.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH 1/2] ath10k: add support for MSDU IDs for USB devices
Date:   Sun, 27 Mar 2022 19:13:39 +0200
Message-Id: <20220327171340.7893-1-erik.stromdahl@gmail.com>
X-Mailer: git-send-email 2.34.1
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

commit 93bbdec6683e1c8ba2cc4e6 ("ath10k: htt: support MSDU ids with
SDIO") introduced MSDU ID allocation in the htt TX path for high latency
devices. This feature needs to be enabled for USB as well in order to
have a functional TX path.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
---
 drivers/net/wireless/ath/ath10k/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 3d98f19c6ec8..7ed2022ac3c2 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -1013,6 +1013,7 @@ static int ath10k_usb_probe(struct usb_interface *interface,
 	bus_params.dev_type = ATH10K_DEV_TYPE_HL;
 	/* TODO: don't know yet how to get chip_id with USB */
 	bus_params.chip_id = 0;
+	bus_params.hl_msdu_ids = true;
 	ret = ath10k_core_register(ar, &bus_params);
 	if (ret) {
 		ath10k_warn(ar, "failed to register driver core: %d\n", ret);
-- 
2.35.1

