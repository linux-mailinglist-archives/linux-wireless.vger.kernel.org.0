Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2717D24CED1
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgHUHS3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHUHSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E859C061348
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so975654wrm.12
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhbLFeeUnXIVGU1eOiDrbU+gQsxY/cBKEYP7/4MCrLk=;
        b=kt+Oz5/Guc0OMiYL/RbMLd1EoMi3UUjUjxjDZQtiTu6rCXqTKBVUUAyXYnSOZLXBr2
         iwe5d7opEM+HeFviPE2v2KjOXExGVdCb4ijqAPjZ8qRhZD+zvhtZd1aDnJktap99nYpU
         ciMApTG7JXjQKc8gFVQJMnxPt4pkCVAGiSQCkYr0PKiF+tLuFSuqxrCb/M5OYUqLFK4Y
         omOaqgI/rsUwW5XlsTXslblhc+ig3ucvYUgvSy/CcFO9g8Kk8fMw/lg9RR0Y6neLfdzI
         sP5rCTx+yQkKsnD5Q0dehsHKxpOyKxT0hz3Y8G+4zlNahztdFGsEy2vwuLbrFb/f8Ozv
         YPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhbLFeeUnXIVGU1eOiDrbU+gQsxY/cBKEYP7/4MCrLk=;
        b=M7Vdns1TwFzqQ3ZLwT8aj/r3bl8vfYLfIL7POtwH+ZIVx4/qaob7x+PeEVh+ostSL3
         fJL/Zy3NyxtfI1lKOHz1wvVvmLFqy85BG0kWccNpt7s5eeV65oxp3oXN6CELLFxfFGgi
         yP0JkEdwWjpTnGskNVKM3WlqQ6IVDsDYys1Ia2vF+Eq5mttwj3E3u1h/ZdZPlR9c3geT
         CchYnXKxENxrw5eXlCSRv3uEML5vS4I6pYCo3a4Cx1F3eNhmIXuZsGN9najgM1jPpRdq
         yAF7zhPhG2tzpv/deZX1d88BRExijxZ7jhmoODRvjrO6D5KH5+Kfrwcxkh0CgO5Y0E7g
         uTRA==
X-Gm-Message-State: AOAM531shoDmoU/3WO+PID4+Qaekj+6o8MsLSI7Knu0o0pHXew2mh+aq
        +OTZcymBy2vm1JOb3l80G1zPjA==
X-Google-Smtp-Source: ABdhPJyHOVv55ct2DNh1mX90E5Ko+y+vDMR+i42zeCzP9KM++B/cTXhA8BYuAkK7d9HIbCVX+YRVRQ==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr1346304wrq.238.1597994236949;
        Fri, 21 Aug 2020 00:17:16 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Linux Wireless <ilw@linux.intel.com>
Subject: [PATCH 23/32] wireless: intel: iwlegacy: 4965-calib: Demote seemingly accidental kernel-doc header
Date:   Fri, 21 Aug 2020 08:16:35 +0100
Message-Id: <20200821071644.109970-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No parameters were documented and it's the only one in the file.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/4965-calib.c:608: warning: Function parameter or member 'il' not described in 'il4965_find_disconn_antenna'
 drivers/net/wireless/intel/iwlegacy/4965-calib.c:608: warning: Function parameter or member 'average_sig' not described in 'il4965_find_disconn_antenna'
 drivers/net/wireless/intel/iwlegacy/4965-calib.c:608: warning: Function parameter or member 'data' not described in 'il4965_find_disconn_antenna'

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/4965-calib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-calib.c b/drivers/net/wireless/intel/iwlegacy/4965-calib.c
index e78bdefb8952c..2f97cbd423202 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-calib.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-calib.c
@@ -598,7 +598,7 @@ il4965_find_first_chain(u8 mask)
 	return CHAIN_C;
 }
 
-/**
+/*
  * Run disconnected antenna algorithm to find out which antennas are
  * disconnected.
  */
-- 
2.25.1

