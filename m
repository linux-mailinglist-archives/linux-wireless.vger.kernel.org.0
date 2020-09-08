Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CD1261A3C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgIHSdU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbgIHScm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E4C06138A
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:25:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so306506wme.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnE8SVokG7Tv+24oBs3VfcRkmFWLKmbRTI9v5/LbQh0=;
        b=W7So8kJiVhd8AptNXBqe1ST/Mk5fiLhBZbvFZWiF8XxvTXBguHgbNPlxB/8Li/KPcX
         mf016T3VOG7Zur9Wr7aKN3MY3ZpRuJHOQ+hLdVLHWFemxersjbqb2auLbZYD/Bbz4kGM
         o1P/FhAkgeZ9aueorIEZOXOTdGzawqzM/dSxVLCz5AQO2NmenMMTBW4t1JTHxz8/VOy7
         oqTL898L8DfoGAII8InQz9LKa5bPG30fpPc2V9JLn4/H0c5ep/hdJcv7H3JXKImbew1v
         wt0sXseHQUXh8JO05/bF9z7/rVduNQNFfGKrilOaqOOtW4U6wXYbmP1BN2GCMFpFH93s
         2SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnE8SVokG7Tv+24oBs3VfcRkmFWLKmbRTI9v5/LbQh0=;
        b=ugZK1f+92CcQNXRQlyHuFe1narwNgiPJIgZj5eQBtuLSk7wYxcIdicoM09JPJD5d8t
         eRnNHtu69J/iIA/i+mmTXmNWNsgqAjbHCoCEKAJEbxGxNbVIQKS2LmTCRt+VfSjb4x6B
         pM6fjc3Fj6iEy1vBRRHWPR8t7vnb+ZJ8tvPJdcF8BvtV9GY2LRaYTqX/U8LlQcSVdKeq
         8bwy2seZoaZ77JCuEU6rR3h9boIHb9mRMmHOVgWTWmAZuIFDmw/zay/81iwG5HqLzjHA
         p/hTkpYsWK+QzfLzMoZGdp7AW38g4A2Vj0EXdrBrO4D44te56d3LeQzmaBZl7So2whnQ
         TjRg==
X-Gm-Message-State: AOAM532kFu+/G81vu/8UOa4IKEpRNCRkE94HCSGfX/A+zfEWtNcaa5RU
        RBLBK1BCBulGGvWmV5ygVSziuA==
X-Google-Smtp-Source: ABdhPJw7mOH4Sv0JWogv2AoX8PqgTAQZlk8EN8rVTbWUR/vT+wzFEgj/2WHNJFhUNjowyiBisytekA==
X-Received: by 2002:a1c:a953:: with SMTP id s80mr404827wme.70.1599589506007;
        Tue, 08 Sep 2020 11:25:06 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c18sm376908wrx.63.2020.09.08.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:25:05 -0700 (PDT)
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/2] wcn36xx: Miscellaneous updates
Date:   Tue,  8 Sep 2020 19:25:51 +0100
Message-Id: <20200908182553.2870585-1-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This series is seven in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

This set marks functions previously declared non-static as static. In order
to facilitate granular standalone commits and avoid single patch
code-bombs. A series of functions were previously declared non-static.
Antecedent changes have made use of those functions so we can now mark them
static.

In a similar theme of cleanup, I've added on a fix for some whitespace
damage in main.c and smd.c which while not strictly related to wcn3680 I've
opted to throw into the bucket under a "miscellaneous update" title.

Hope that's OK.

Bryan O'Donoghue (2):
  wcn36xx: Mark internal smd functions static
  wcn36xx: Ensure spaces between functions

 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 38 ++++++++++++++-----------
 2 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.27.0

