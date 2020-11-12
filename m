Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165A92B0ECE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 21:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKLUJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 15:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgKLUJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 15:09:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA57C0613D4
        for <linux-wireless@vger.kernel.org>; Thu, 12 Nov 2020 12:09:47 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z3so5545330pfb.10
        for <linux-wireless@vger.kernel.org>; Thu, 12 Nov 2020 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlzNb4pK13Y32cyp+ePumv3+g3DVvwiDXlCyJDmMOcc=;
        b=gSefMmGnwMapYEAtZk9AyZgTOIzuZkVsJ9ewbfiNaCylEybtcHFmKefAO4+auhVoIx
         9ErY33tMtqOfp/KvZJCPONVnbC7VAxM5WbMMO5KiHK+osN54xexUCfKVG645KEU0fWSe
         Q1tlXO217th/ITMJqJ7X5jTR+JIFe4TnQI27A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HlzNb4pK13Y32cyp+ePumv3+g3DVvwiDXlCyJDmMOcc=;
        b=SWPwFcZ25UxHYVDWpU5i441J0vnlc5KM/tEFj0jgK+NMwAh+2dguMczFTkvzL0LFGU
         v5E1Cswmjw7peWpnMnHBYosgpgeOX36W1sX2CSaIdbVqzdVs5FQA0mW9feKgw3u0Ve0H
         NVdp0pZDBM5GKA0XlVFDffbWaK8tswPuM5WyldafGFOUZlxnJqPu/8OPaQWftzAK3d0K
         Gu2HkLJypxBum/L3+JlPIjjm8PTkVHRc5UxFF1DSnvLiYoT86bvjiOFBPwDbfaOt96JO
         DIcFd0FCJT0mhfpXtq07zaGpsizVGs0iqd/qjWAdGPgN7uCxleo/dkmWn6DF6H5c6Dni
         l+GQ==
X-Gm-Message-State: AOAM530/36LDaIS/wMS6tCW4xUmbJiZMzlcFnNfqBsf1tKXBd/jlm6vF
        z6aD1cBW3RpLthHUkIlTudoYYg==
X-Google-Smtp-Source: ABdhPJwRWJ+1GrJ74JTL6+W7sqUQ70o4CpjRlVXDjOeHzUWuBxAvGHKlX7dugtjpWKuEkwObYvW09g==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr892040pja.132.1605211787047;
        Thu, 12 Nov 2020 12:09:47 -0800 (PST)
Received: from kuabhs-cdev.c.googlers.com.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id gc17sm7590260pjb.47.2020.11.12.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:09:46 -0800 (PST)
From:   Abhishek Kumar <kuabhs@chromium.org>
To:     kvalo@codeaurora.org, pillair@codeaurora.org
Cc:     dianders@chromium.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, briannorris@chromium.org,
        linux-wireless@vger.kernel.org,
        Abhishek Kumar <kuabhs@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v2 0/1] This patch address comments on patch v1
Date:   Thu, 12 Nov 2020 20:09:05 +0000
Message-Id: <20201112200906.991086-1-kuabhs@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch extends ath10k_core_create_board_name function to support chip id
based BDF selection and not add provision for fallback_boardname2, thus
introducing lesser lines of code.

(no changes since v1)

Abhishek Kumar (1):
  ath10k: add option for chip-id based BDF selection

 drivers/net/wireless/ath/ath10k/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8-goog

