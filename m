Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3FF3581C9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhDHLav (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 07:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhDHLav (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 07:30:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7BDC061763
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 04:30:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d5-20020a17090a2a45b029014d934553c4so2133022pjg.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Apr 2021 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=idLyBB53a+zb7rBWXo0Xtc4Y2VYfNc3H3ETOy2Iv8JU=;
        b=haLvNZtI2/mr3CY4J+ayFNZg2Zb3d9szad6P8KL5g1mtbbXrvfWZx+MLyRpAWCP3Mk
         us3iS8EBJ4wfY0GZ5rbj1EU+7LFYsvH7Jjq7aRRB8ZCQsdOuLkBEB9+uz3uLdST8hMxz
         wsxx1b/GWF9MI//5jJZDKn79rJOOZ736GoYJDjsWs2M+0t+Kp1guqw47GDstTCW7BfsR
         c1bEmoPp5RTn/67fgDymzUY5U8n8l0tBpm1yR1GfcSTvx1BEcSxZRfFeh/qyd2UOIQhB
         SlexiSoabIELDQ61SnkykN499yYR1tN/xlGL/6XC6BnKdwgz7jHVc25ncN40rrqWID4D
         96Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idLyBB53a+zb7rBWXo0Xtc4Y2VYfNc3H3ETOy2Iv8JU=;
        b=LRIHrDw2OPmV1o95ZMKS1c5YCI9ZfCizyJ4sjRwB99eDl/XaZ4rT7V2i1P21OLMl0b
         CkcGZeeFjiw92Eq5l5qKy2TjoHimGJJm2Z3ouPhAlBffvgGRoaUvO77jlPaUbQs2eAxD
         pVxUcmb8xb4Y/05pBQv2v31I27JOK3qdlW23Ax4aDoqXPDXublyKBzjbYc2RJwj9T3FH
         bzMgs/N22EoaNmZJH/paP4lqt0VXPz0sNJAIXo/1YdsYbUvidKtEIxqg6CsYsIXibEal
         Ih1VHgAwfocRIrxu68kUBcTINquI9t6KhY2m+t1URImzewM7O17bksEuUIWlwTWaZhJF
         7v1g==
X-Gm-Message-State: AOAM5304msBIcvlLkw0a0NiaJps4eJi1yh/HeIPoKNHqjRcugvutS1Lp
        l38C/zGmIKI3BQB27utDgoTCSg==
X-Google-Smtp-Source: ABdhPJxx3aj0+FumS5hLI1oRIvCZsO6w/JQp2J14V39WZ1ohHPEo50HXwT9OIwsmIeXRr+kT00pPBg==
X-Received: by 2002:a17:90a:94cc:: with SMTP id j12mr8196394pjw.159.1617881439623;
        Thu, 08 Apr 2021 04:30:39 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x18sm7753267pfi.105.2021.04.08.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:30:39 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] brcmfmac: support parse country code map from DT
Date:   Thu,  8 Apr 2021 19:30:20 +0800
Message-Id: <20210408113022.18180-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a couple of patches adding optional brcm,ccode-map bindings for
brcmfmac driver to parse country code map from DT.

Shawn Guo (2):
  dt-binding: bcm43xx-fmac: add optional brcm,ccode-map
  brcmfmac: support parse country code map from DT

 .../net/wireless/brcm,bcm43xx-fmac.txt        |  7 +++
 .../wireless/broadcom/brcm80211/brcmfmac/of.c | 53 +++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.17.1

