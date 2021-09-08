Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7877B403A94
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Sep 2021 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbhIHN3f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbhIHN3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 09:29:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D90C061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 06:28:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so3318705wrn.5
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58S/hFVavA2/B0LoPiOH8cF1b6vL2Ja/HtpHyCoubBc=;
        b=h2sWF7znJyG+MchH5qhRFFoIDqC9kBt3T71x1yBU7ktiHKXY9ZzcXpeNXKckgqro5J
         4nbimy8ewXBKaLyBRxjMHz8hPDBguQeKXSFlc2JMgUPm3L4BTSAtrzXk1XJDBtqJ+N6x
         h7ZGZwPEULZwVsd8RtIV/y95H6U/o5zvEjhHoyZhU/U7YJqusgWHMg7phygk5KK4G1ar
         92A/g9/SrkzKeNSXtfmV8WAmT/bL6jYYR8AicNTJ3czAHxRoyX7TRpcTLc8ZeOF1zVYL
         pxVZOaJB3R6ryg0ahWIpuhHS/kvUr6IQ1cCVFC6Y5jdlWSWvIG2xtFxTFtRuDuESQ5VW
         PzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58S/hFVavA2/B0LoPiOH8cF1b6vL2Ja/HtpHyCoubBc=;
        b=FQHiFVQzaBgZ8U3LQhkrO0n0QxTG7AYQi/f63RBkEzpjr1yn9xcvEcBgMfSHPSsau4
         PlTtZ3xMWLar2gm8WEdX+YGimfnXMjxcK6CjyGjLjPOYPtQ5XFLgdEnY8kDR4us2buAv
         Jr+c6BBRqbQG6JN+DGrIYUFxIRg3akBgvpb0KJ65ijU/HG224ekGG0IkeCxWaxk2uLNE
         a3p23E8fajRLHdsJNU8zMapqMgN1cWP5VLyy7ju18ggbfnAktXtF0/CDKxLfv7jW9Cyx
         qQ1jarPXEKlcgB/XlvgxKUPqRzhBehizoanJfZVJkcHd+QLlhthttFefXTvbIdc+zlli
         EmMw==
X-Gm-Message-State: AOAM532a+qlyzB5wOo1E5qqGv8hSZYSyK/jxgzmVQIbXPTFdZswFg1Mh
        8S3bfxe8weCdd7PU8pvSQZozzg==
X-Google-Smtp-Source: ABdhPJxwQb/PKB1+jY88eWhH+exhieCVjhjjh2ZCSvPeBeB6Tcz3v2l3YKQtRUqjVp59MUEcaQ45GQ==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr4212346wrq.213.1631107705937;
        Wed, 08 Sep 2021 06:28:25 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u25sm2136139wmj.10.2021.09.08.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:28:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 0/2] wcn36xx: Two one line fixes for Antenna Diveristy Switching
Date:   Wed,  8 Sep 2021 14:30:17 +0100
Message-Id: <20210908133019.2408092-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here are two one liners.

The first fixes a fairly major bug that is apparent with Antenna Diveristy
Switching (ADS) but, is not limited to ADS. The bug is a basic firmware
table corruption problem, which just happens to manifest itself clearly
with the ADS logic.

The second fix is a fairly trivial one-liner which prevents us from sending
negative, two's complement integers to the firmware via the SMD backdoor
"dump" command.

Bryan O'Donoghue (2):
  wcn36xx: Fix Antenna Diversity Switching
  wcn36xx: Add ability for wcn36xx_smd_dump_cmd_req to pass two's
    complement

 drivers/net/wireless/ath/wcn36xx/debug.c | 2 +-
 drivers/net/wireless/ath/wcn36xx/main.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.33.0

