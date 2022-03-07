Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B64CFF4D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiCGNAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 08:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCGNAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 08:00:03 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31635BD1E
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 04:59:09 -0800 (PST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 648DB3F5FC
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646657941;
        bh=Bt5u+dqRXX5TG4kpL4NYCF0+7EST57EITnb/tm+FvLo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=fO4tnTqfah9YMraVyAMVwe7Q5vFFWVvz+t8yxJkH8pY01owT9qMTpTzLUMy3eFIYF
         f9z2oSri+vQIeDUYefh3xOo6iyqslbh2fAel3k8gQ23097bqhVaJ3mtm2d4965y5DL
         MJjPEmSbK+fraiVmVsU+uRM9WDGbYCjdyEC9P41Lik9NWidvXDTLelN5a+cyZ0XCak
         7Lq08nBglT2W6FKT/0FUdRkGYXx27+KeCY7ETrT+1SBooltqbkZGLVqB7NT++wx+Dy
         SDK6gC3oNl+CGXNshwVJBw+c2w+Yl4G9ljyP5w7MC2Qh+7nlgjlLcLqEb6ogowgk+y
         6tmZVjzbrHSeQ==
Received: by mail-pj1-f71.google.com with SMTP id m9-20020a17090ade0900b001bedf2d1d4cso12064619pjv.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Mar 2022 04:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bt5u+dqRXX5TG4kpL4NYCF0+7EST57EITnb/tm+FvLo=;
        b=NKPB/3BqWh8r3YhX/1G/t5VUeBjPWU0GEtlvOuNBpjo9u1vXlvD+2Rf0GzWDdbY79v
         610uPPQqQSrif+JyDLXKKh3yxSbu9ti5dpk2TzAfEJBaNT4pbnJnthJT9czfovXruUnT
         ngrirM9fuzlcWgY/7MN0NYQMOvHC4LDWOFefJeUwmfPt8gstTNqEi1PQfaC0zdJXtOhx
         ExnTs6PUYoZiIfbD/LLZ7H9jbr58tT0w0rCkhNoGNdSwlDl6F2ZdyKwKrucGffd97Wez
         nVi5pOzxDAZyrKyf/s/EgVcZnpqzQSm0o/e+gdDJoVL5CC0E9JK1+hmqblxljcgpsMey
         q+vA==
X-Gm-Message-State: AOAM533tAt4jLoviZOCWoeOnCAZoOlf/h6MgPLYS3D/fEwkKs2QYnxrH
        20pB+0kmytZj08/T8fJey5m3wyEijmmg3or4yPetm+SEfhQElXnmBc4gAxzXAnoa/eDGw83/QQc
        /yIc3K+qy/hzG1yGJDkdjl57g1A0IxAnZ+r7KJeb5BqaO
X-Received: by 2002:a05:6a00:a0c:b0:4f6:661e:8dda with SMTP id p12-20020a056a000a0c00b004f6661e8ddamr12438885pfh.66.1646657939790;
        Mon, 07 Mar 2022 04:58:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy9yA/OTQvBvHKNNW5XGHzthyGWKSUTICmCcAolHezpN95KQGZU/FDyK/zmjLJcdIBCiZggg==
X-Received: by 2002:a05:6a00:a0c:b0:4f6:661e:8dda with SMTP id p12-20020a056a000a0c00b004f6661e8ddamr12438852pfh.66.1646657939280;
        Mon, 07 Mar 2022 04:58:59 -0800 (PST)
Received: from localhost.localdomain (59-115-216-226.dynamic-ip.hinet.net. [59.115.216.226])
        by smtp.gmail.com with ESMTPSA id oj2-20020a17090b4d8200b001bef79ea006sm17545682pjb.29.2022.03.07.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:58:58 -0800 (PST)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH 0/2] rtl8xxxu: Fill up more TX information 
Date:   Mon,  7 Mar 2022 20:58:50 +0800
Message-Id: <20220307125852.13606-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The antenna information is missing in rtl8xxxu and txrate is NULL 
in 8188cu and 8192cu. Fill up the missing information for iw
commands.

Chris Chiu (2):
  rtl8xxxu: feed antenna information for cfg80211
  rtl8xxxu: fill up txrate info for gen1 chips

 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

-- 
2.20.1

