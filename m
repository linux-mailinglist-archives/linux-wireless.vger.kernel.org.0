Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B07256475
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgH2DjC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgH2Dip (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF0C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so859901wrn.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/tDMzToGhn5zkUCIJf+cXavnQyI/guUVXMmCWA+AHU=;
        b=Szt7SoQfWq5T4YtzuYZmAB+4D8tCwMcyzI/THkSiJ6LG+XRdvXu3CfEaWcBhPErzGm
         r/r2jPO8uYdt4JUrAZYiSK16aPjHJEyzB5mCcfNo92fEmpb0TY4mHyBo8hoL3uxP5Pd1
         7TLrr8BPsdPVbGbp6rgnP5B6NJjDFw49UyeywFh/kLQdtjpSHgctodW+jyHplQhVcVAA
         Tu3HDyTipbbwwxdysMx3h5NJcQ9pjBXqbLOBsVMEJ/WSiHIhEk4CEeoCyqD6sqU0qolu
         x7elNaR28H+yyz/FehxaPoG0o7dRB2DMjtAWp7TtnDsTRUN1mvAnSjspeCgYAQ8sIOWL
         obig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/tDMzToGhn5zkUCIJf+cXavnQyI/guUVXMmCWA+AHU=;
        b=s2WtPgGuBVFX0WPVvmSABEWVhJi/ElshyRHx9xxSXNImxJqHxZpN/ebuWoaMwFVHGu
         Gq3TAODmvRTcjq1gFDJ5B0vovvuvwaatXGtG89uV6AsKXpz2KdBW7e8iZZCKbDPltYY8
         G8pLo6zt9iW9jd/26gqaAjykAr8pnCiyaS+e8SPmRUfm+LoXNvZ/NvLmMrsIRfsbbUKB
         NsNGt9x7oPE1moG0GfL0IhRlPqdwkU2gtr9J/ZvF6IVQzl4nbWyHQbsCOmsgxSwsLBGK
         RnvCemEx7dFZJ+H0cY4Wmhn6f1NSo3j7cVMPpFJ4F3R0ghT7lz9fjmKvKkBQAwdRRsGh
         RjGg==
X-Gm-Message-State: AOAM531fpkRE5OWhLqQ4SXHYT3iV2go+Yt4r9YDlHvN8ZXI2w7jYw4dV
        Bh1+aQhYOWXtreZu82gsds8IBw==
X-Google-Smtp-Source: ABdhPJw8p0CjthemEG/9A5gWbC3H6QtFejbHbtc/adbBC9l/Rn638hohb0p9GKDitcMO85c5e/lSIQ==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr1795594wrl.313.1598672323489;
        Fri, 28 Aug 2020 20:38:43 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:43 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 0/7] wcn36xx: Tidy up BSS/STA config
Date:   Sat, 29 Aug 2020 04:39:22 +0100
Message-Id: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is three of a set of five to add support for wcn3680 at
802.11ac data-rates.

Both the BSS and STA config paths have redundant/duplicate code and before
adding more code to either it makes sense to reduce/reuse and functionally
decompose as much as possible.

While not strictly necessary to get the wcn3680/80211.ac functioning in
this driver, it seems like a missed opportunity to leave the code as is.

Lets reduce down before adding more.

V2:
- Adds a memset to wcn36xx_smd_config_bss_v1()
  Since we are doing one less kzalloc() we need to make sure we clear
  out the bss config.

V1:
https://lore.kernel.org/linux-wireless/87eensldhi.fsf@codeaurora.org/T/#t

Bryan O'Donoghue (7):
  wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
  wcn36xx: Move wcn36xx_smd_set_sta_params() inside
    wcn36xx_smd_config_bss()
  wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
  wcn36xx: Add wcn36xx_smd_config_bss_v0
  wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
  wcn36xx: Convert to using wcn36xx_smd_config_bss_v0()
  wcn36xx: Remove dead code in wcn36xx_smd_config_bss()

 drivers/net/wireless/ath/wcn36xx/smd.c | 416 ++++++++++++++-----------
 1 file changed, 227 insertions(+), 189 deletions(-)

-- 
2.27.0

