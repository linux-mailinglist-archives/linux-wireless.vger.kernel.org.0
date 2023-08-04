Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D11770BE7
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjHDWYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 18:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjHDWYr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 18:24:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B741722
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 15:24:44 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bc9de53ee2so2244834a34.2
        for <linux-wireless@vger.kernel.org>; Fri, 04 Aug 2023 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691187883; x=1691792683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LXnLuGNBqx/nlO9SYkCh3Vo0Ost+TfRLqWBhpbSRCqw=;
        b=FIoIMW5tFa0SMRg6yQIovbyZEwLyU5HvRdNXMEP3uUAvp6BsgeeSrJN5mgTf3Ddb+S
         xZZCo/XzeL+kOmaj48plSHJZvp3wsrwQ6Ul9zfHyxacdxXrhf12TTbC4NAdD4He9iyym
         i3j4CUxtIFQb4MtoKFNx9LrLBo3Y/COJjtVqh0qqo0bdZ9kVA9zZ7HnBWmMg4jNoenOS
         cwuM2tEn8Y/hurCEOxVcCB3yhuBed3L2gaNsxSqX52qhmshxIbL0ONJPD+AwSHOd8Lzx
         5VThOA88HiXA8vskGOZNOGwWX5a7bVIPiGPEpkjauRmKAMP2zPNDJgYrFeN35rRKyJXH
         2zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187883; x=1691792683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXnLuGNBqx/nlO9SYkCh3Vo0Ost+TfRLqWBhpbSRCqw=;
        b=hIdRo0u89C9bcSnKhwcQFBJZwv36A+H5VWDpmSzxsFrWqfIulH0jJuLDzGuZWq5kJO
         zN2fp7rs8q77Z54pn7NxNA9P+J8hGSM63yMAcm4WCSSTuUuPUbLo/Iqr61b9Al8e+tZh
         IQyLQ45NHqn/s6Se9vPlSMcROPZyk7QARPg+1wpZqbASU1irh1A1DnlhZ0HK56ksFjWS
         9MiyYyRwsIzxg/ZzCtTiDNv+82/OP9dps51dE1xGrgS1Ewk4qOIJkLvV9jMWfSn5T4iA
         asyG/2qDveNlSnGgg9IM7GzSd7dZZfUvj+OY1igrAs2o6cFilcBmzweQ+W4P+D2APCpd
         s/Lw==
X-Gm-Message-State: AOJu0Yz8AlKYFYt6JRwqSiIv0/4WIhD9ws/e+Gn6fSPtwHUzWR6C2wQ+
        /OZthFokoCKsD/5XkTsp1El6X5LTR8o=
X-Google-Smtp-Source: AGHT+IH1mDPbxaGw1usCBW/6gwz5z2Sg3qGtcODZZO66+UPc37y3Koc+UrkljRFVrdiGy+yrOttaXA==
X-Received: by 2002:a9d:74c7:0:b0:6af:95f9:7adc with SMTP id a7-20020a9d74c7000000b006af95f97adcmr2888442otl.14.1691187883467;
        Fri, 04 Aug 2023 15:24:43 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id x24-20020a05683000d800b006b8bf76174fsm1728379oto.21.2023.08.04.15.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:24:42 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 0/2] Change MAINTAINERS for rtl8180 and rtl8187
Date:   Fri,  4 Aug 2023 17:24:36 -0500
Message-ID: <20230804222438.16076-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The MAINTAINERS entry for rtl8180 and rtw8187 are out of date.

v2 - Remove the git tree entries as requested by Kalle.
     Update the E-mail address for Hin-Tak Leung, rather than delete
     his maintainer entry.

Larry Finger (2):
  MAINTAINERS: Update entry for rtl8187
  MAINTAINERS: Remove tree entry for rtl8180

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.41.0

