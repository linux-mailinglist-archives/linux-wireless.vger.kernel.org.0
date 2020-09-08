Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0076B261A3B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbgIHSeJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgIHSdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A9C061755
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:33:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so320166wmi.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6cIfxBcFjZq6+1VuY/24vXo1lFfqHVn9WQbeI8mA4k=;
        b=TRFMLOzC63yjZB+OPXC2DFboqN0JVhn/89Vq3Zjivo2DUMa3o1PqhL3f4KOQj2Nb0b
         uvhOLmABxLpbwyCvLCON4gK/W39+ap0Odxa5qgdt6CYPJF+o8jVZaO1GLVF9DrRWbh/C
         VFi5ywlCK2IH/qIMwcJ8CKiFcvOsS0+pRiurmXQnBa9vJtVV+It58HsWh9NZl3CxUBeQ
         NxU3He9j1cLLVjcdDXrqXAEK0GohzwEbDebPcWRaW+4qiGP05IFuWkGsOFsojVujkUKw
         +ick0ogmlK/fzG3PWD9yD+hpwrQA9HEmSIiBvg4q+Hc3Ded9Ziavn1krQzaYmR7QxolB
         JSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m6cIfxBcFjZq6+1VuY/24vXo1lFfqHVn9WQbeI8mA4k=;
        b=WmmwyON33PYU7j6cpREDX9cW0vcUPVMeYnHvoW3zey5p2Wsvldc5Kb+TKg5xwOFxub
         5Lg3wcPyC4knaKV4P/gr9f4n4RkzOQz/FAHYBIExVZYgyHZM8w9P3Kblqg58X/CH7KGV
         vJO3ytDNUjvmjDFwf1+65Ztg6xOe+Q/an8+tVzZ8hjkBr7Fha1BCdR0JW6ZZ0VrcCNEw
         KqAPl5SvX7EB4ID0ShXkbeTHL7fi2F6DQZkDWx9SszpXenkkpAD/qLHN3Ib//2zhFp9a
         t1lA8TYNrLMlXdH12NDTNWU4ToZwe2CRvoBC06Jv4bQkWjyN85ihbYTwzCKPKQ03Wk5b
         MSkg==
X-Gm-Message-State: AOAM530p67BXjKPB5OpbegsXmf3lOghbIlQtQlaLU3BjhRsRFXv2h6sC
        UyYDlYUFNk56lEnwFr0C/CJQ5nUvKdbOQw==
X-Google-Smtp-Source: ABdhPJyEI+lVTd1UuRYDzmaBCDS1H7ql5nZNEJPhHzQ2rI6RzwNT+DWkSnIPFNqHu/zjNVAdopBurg==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr402341wmf.109.1599590016609;
        Tue, 08 Sep 2020 11:33:36 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b194sm294992wmd.42.2020.09.08.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:33:36 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [RESEND PATCH v3 0/2] wcn36xx: Miscellaneous updates
Date:   Tue,  8 Sep 2020 19:34:22 +0100
Message-Id: <20200908183424.2871101-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

RESEND:
- Messed up my .git/config resending from my @linaro.org address

Bryan O'Donoghue (2):
  wcn36xx: Mark internal smd functions static
  wcn36xx: Ensure spaces between functions

 drivers/net/wireless/ath/wcn36xx/main.c |  1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 38 ++++++++++++++-----------
 2 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.27.0

