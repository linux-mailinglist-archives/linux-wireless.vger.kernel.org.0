Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F45C4743B8
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 14:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhLNNo2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 08:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhLNNo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 08:44:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E2C061574
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 05:44:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso884238wme.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Dec 2021 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mhRHP4X+oGbr9vUYJw9h3wTdvApii8dNl7z1JaMrVU=;
        b=LidxquP+3NEUrudqx/q2j3ktNE7QBC/g9p9t3UtU2V5eTjk9fFGsiVximNSB2XgX/G
         8w/VOfm57KiT9DGqnTtwCJrVRfF3jKFW4dt9BuQUpCG0N/g6pDTrKAuT0f/q0DbT+x03
         oZb8ZBOO27fjEca5fuvUf4xnv8WzQsKlMmwY0l4wDf53x/oT+FCK8gWOK/+AiJ/zckke
         SrRwrzIB2SHdDQa9Eu1r00UpBw6daOw2lnJcLYWBXVPHNDNSD8Tkcm2vJZPSZkMK6TRT
         TCv3Zgw9ov4JQsjdDPeoYWqm7W8wk9O3YVf1FbwCHnwPQ75YyMx3hP46R5tVAY/pchdd
         lqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1mhRHP4X+oGbr9vUYJw9h3wTdvApii8dNl7z1JaMrVU=;
        b=VSuOcV69ifXDtJHrn9q9WgtM2IZpVHf5aZeHrx8anVZ7Wstsplnb+JSQYt+1I6RX7E
         +3rQ+2O9nduXgcKezNGun70R/yNXgqV3UPXB4HU3iubzlOaO22I5pZmaAw9e4m7h/I5p
         2WGgwhIpRXIUYra+joV5RcED8Om7D4mF7mPDWHzzvfLJgciy4X9MalMMVa3sIMq05+SK
         8JOUpaOLqLjVLa4LbjdnV1XtUKNhn35uUHf86qVggd3gQpn9z0g8HMYIKx9lbCR2dAbY
         3GzxBJE3N/dfrirIn3bLA779lI7BWLyi7mRHvKepTwu5nKJ3wB7odh/tz+wIJE7PB0bU
         CEtg==
X-Gm-Message-State: AOAM5324H6t2czbY9Jel3F5X4b11lFR7bvXEy3jOMqVMMDXMlev5v24v
        G880A2yDeHAf1yvAu5jXNIhl7A==
X-Google-Smtp-Source: ABdhPJx8wSMHkWyLRrDH692NYaXXdnxRsQ8chUdOAHUNC0FVZ122HvTK5AsxIAUFHzJtiKwkNmlwBQ==
X-Received: by 2002:a05:600c:190c:: with SMTP id j12mr7079286wmq.117.1639489465891;
        Tue, 14 Dec 2021 05:44:25 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g19sm2309592wmg.12.2021.12.14.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:44:25 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 0/3] wcn36xx: Implement explicit beacon filter tables
Date:   Tue, 14 Dec 2021 13:46:27 +0000
Message-Id: <20211214134630.2214840-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V3:
Adds check to updating beacon filter for NL80211_IFTYPE_STATION only - Loic
Adds Reviewed-by as indicated - Loic

V2:
Removes duplicate definition of mask field defines

V1:
Downstream provides the ability to directly program the beacon filter
tables. Currently in upstream we rely on whatever is the default filtration
table in firmware.

A trivial packing fixup is required for the SMD structure. The downstream
filtration table from the Linux driver is applied but, we are not
necessarily constrained to using this table forever.

Tested on wcn3620 and wcn3680b.

Bryan O'Donoghue (3):
  wcn36xx: Fix beacon filter structure definitions
  wcn36xx: Fix physical location of beacon filter comment
  wcn36xx: Implement downstream compliant beacon filtering

 drivers/net/wireless/ath/wcn36xx/hal.h  | 30 +++++++--
 drivers/net/wireless/ath/wcn36xx/main.c |  2 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 87 +++++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/smd.h  |  3 +
 4 files changed, 116 insertions(+), 6 deletions(-)

-- 
2.33.0

