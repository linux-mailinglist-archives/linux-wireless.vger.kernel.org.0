Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E364F7826
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 09:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiDGHxq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 03:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiDGHxo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 03:53:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2476912BFA1
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 00:51:44 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso3375120otp.4
        for <linux-wireless@vger.kernel.org>; Thu, 07 Apr 2022 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zkp0zwWOyLH4OMghyJOhEkyW9DwPPbOZjAVPCN67mlQ=;
        b=gYweY4EUEjN5IPVfmPBaWPTilxvuGo4UdLkdkJ8e5xPrDo+DmcvjzMJlDdMHXuQvDN
         JUHHmL+HdUUsfvJ8lW7TfhFTGws5G6V1lFHplf57Vi+70mgr4VaRWuwDTsIujJamEJZ6
         1XjZ/6hSKmtD0jlPGf6ZKWfEit/cVv5XuugNeeCjsjE8O8F/oLk5b/IYE9MP00XwsvpA
         F6nhPr2V1hHNgl7XYZVghShChe4msYoqhIknrO94V61ZW7iKF+06uNE29q8Z30WebaW5
         Twki9O0ROZWyhLpCDbuJrgajNV0bhRAwlP64Ku/Xo0RlMgpHhr0IykZOSMv2lSMCaKwi
         KRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zkp0zwWOyLH4OMghyJOhEkyW9DwPPbOZjAVPCN67mlQ=;
        b=sFBMJKZ7jC7qojPoEzvrlWuD5oS+4DiNY0ZwRA3TG0qmj7csVIsJCC6oGKhhIOZc4A
         FutnUMQzCccSw84qaABnggbyDPOmIeomkpXTuaMoYjdVndx2zlZJ6VYucfq3Svdu1Ok2
         s3H1AI8BCqcyksLiXvSpCzc9wdcCQ9yVs9eLe5bq/MGV3dS7tgxVrZYktDk1TJCYiDWL
         3QSL1qjIro0Za+nlOsoSLhfPYTSVw36bWrxlCdvrlsJ70FxOe4OU12LMx/6EA5u+x92N
         n2Ni6hWNNGqSz7ziDKeUjzJrsslX58G8ofxvayli7vGGvZUHObc+rA8dgtwuQQjYNcxU
         jKPg==
X-Gm-Message-State: AOAM530f6XqHVutJ3l/CJux6AdFDf1klKGm/32WQF73A8yTq7TK6NWNS
        QjOB5GIYlH4ZmtxzNUezg46OiCpJeCg=
X-Google-Smtp-Source: ABdhPJx+0TmDkOUnvsD8Op7/F2qfKYDFDaaB9jCKTRjTtLUSYV0HJ6YpjKC5YbV1HmcbL59Zm5HlGQ==
X-Received: by 2002:a05:6830:10e:b0:5b2:4639:a523 with SMTP id i14-20020a056830010e00b005b24639a523mr4357239otp.101.1649317903319;
        Thu, 07 Apr 2022 00:51:43 -0700 (PDT)
Received: from tower.austin.rr.com (cpe-68-203-212-228.rgv.res.rr.com. [68.203.212.228])
        by smtp.gmail.com with ESMTPSA id v13-20020a4ae6cd000000b00328882a2388sm6906245oot.14.2022.04.07.00.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:51:42 -0700 (PDT)
From:   Jimmy Hon <honyuenkwun@gmail.com>
To:     tony0620emma@gmail.com
Cc:     linux-wireless@vger.kernel.org, Jimmy Hon <honyuenkwun@gmail.com>
Subject: [PATCH v2 0/2] rtw88: 8821ce: add support for device ID 0xb821
Date:   Thu,  7 Apr 2022 02:51:21 -0500
Message-Id: <20220407075123.420696-1-honyuenkwun@gmail.com>
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

Jimmy Hon (2):
  rtw88: 8821ce: add support for device ID 0xb821
  rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID

 drivers/net/wireless/realtek/rtw88/pci.c       | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.35.1

