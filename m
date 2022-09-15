Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130765B91D8
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 02:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiIOAl2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 20:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiIOAl0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 20:41:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC886FFF
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 17:41:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v185-20020a1cacc2000000b003b42e4f278cso13609444wme.5
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=J//+WymCkxAKbyApy8R91YiSHN6Iph+FDvrIqQgf7Q0=;
        b=CcGShTlOE0aWLle2jb0G2g96FpzJWV0FTWW2ZSYCZE39XVoc8JInBM4nR3y0/vAbOi
         BveJp1DwGuzLqHdIwmV3h3Aj3LXsSYdkMT/vIqLLtvxCJcjbV3uu1PZa+BhzXUe/tpZG
         J+NXClbLPywnpkwtYAeG4LiiZZFHgF7frevTsjZLkjSu/wNNh5tgo7P5Mnh1rhNbUDIH
         7+rxzmBBbYHPMLKf/VVWk4v+njM7ZXREvHcjpE5TXBGmVraYMRrg28u3BBUlLucSeMDF
         6PgvoNeV8Yj7zM/LG894cAMwhOQ8j6J6XJbLvb1V9TtYg//qq8B9dn/lfOCshMV4sQ4m
         4Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=J//+WymCkxAKbyApy8R91YiSHN6Iph+FDvrIqQgf7Q0=;
        b=a2rI4Y94uz+wyfsGaMMOUpI8nCM6ZH4CBeKAYT/k8QtK988dG6AUBikNMRXPoMUHA5
         FWszjP8lMbKz9/vHaCLwMDJoHA9SNVLmr15GsNpxQ6jlH9afmrndyeeJrjKD2QxL9nej
         +9fi34usCND9U2SxG8TZcfKbc2fICpDJDxUb+nFrWLFTmoBiHo6FC593uKcClqdemqmu
         mlJcUhFqCIs22WSBjBQwwqqF2Uy6dTThuw8enoIrcnYo3t9yhfMAwfxLE7fGR9OaE4em
         6uXYRkSQcDz5MNwyoPD7ar7X/ifNnLyeiNpT9j2GPehjnH7n089bKPRjetbZMMi59k5d
         hJqg==
X-Gm-Message-State: ACgBeo09xir+NYUdN+hnzRehHzCDvBwmOGbDxH7VGRthbA76Sf5SJpFA
        R71/PPyZTj/VTXbG3uNwuz/zqA==
X-Google-Smtp-Source: AA6agR6hsAbIEn4dM3zpyXg6FbohTXcuVeebojTAMvh6TiDIp/77ziegBgAjUJvhD/ZpWIf2IYapBg==
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id p34-20020a05600c1da200b003b4856a162cmr4736962wms.28.1663202484207;
        Wed, 14 Sep 2022 17:41:24 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b002250c35826dsm645476wro.104.2022.09.14.17.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:41:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     loic.poulain@linaro.org, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/1] wcn36xx: Use SNR as a source of system entropy
Date:   Thu, 15 Sep 2022 01:41:16 +0100
Message-Id: <20220915004117.1562703-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v3:
- Add explict mask for lower-bits per Jason's preference

v2:
- Pass sizeof(s8) not sizeof(int) as Loic pointed out only eight bits of data
  are relevant in the SNR.

- Reword the commit log. I didn't really like it on a second reading.
  It describes the theory a little better now I think.

Bryan O'Donoghue (1):
  wcn36xx: Add RX frame SNR as a source of system entropy

 drivers/net/wireless/ath/wcn36xx/txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.37.3

