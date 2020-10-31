Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A12A12D2
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Oct 2020 03:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgJaCWW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Oct 2020 22:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaCWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Oct 2020 22:22:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43668C0613D5
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w14so8360151wrs.9
        for <linux-wireless@vger.kernel.org>; Fri, 30 Oct 2020 19:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nID9K6h2pn7mi/8/QxMq+cTpvNlKmug44VkH6P31RKo=;
        b=e815eacTiNaFcs03FZcT7ZUOCTt5KIu4Z7V0jqLp5Wu/GQ6Kn8GKu2UWjN2Stchy2Z
         4XF5uNljg4spq4M7VS0D8nygi1joRuXKnIMXJscD4FzGRv6wSbMWXpoqixBxujjDKtR2
         Z9xdmKZ6wRc79FnyycPFbfpnOlbkxKe4e7j7BQSpbFj5QCyCHEUL7xW4qv/vZMz+VJwv
         WQoShqkXh/JPi12KcvrhRFfYsrmpMu0850YQlL0N//vztOfeXfqW6WkNWbgMV97gHq5b
         KJDifBO4iHG67r8DBw41O4XPdbWEO0FT+nmt6RtVSm6YsPguwcIpaj2YmvVwM+5VrxS9
         l4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nID9K6h2pn7mi/8/QxMq+cTpvNlKmug44VkH6P31RKo=;
        b=EKWknSVxXNCpsfYWT5j1A5jKkLp7P0u615UsMbZQc0CF6o3cnV+1ZzaHO4ZG6ADTdB
         5wgtvNKsUw90dtTvlJ/NBL7kX6JqpDh76Pu9nfEUuLESSWQ1mzcMxZrT/EW0JG3cbKDA
         2VeCwkXkjsELlaELGYCGmlqqQTMQb7mLm1z6kvdBz4WqEOudIGwOmhVJXRR50usKFf8Z
         ItXqiUVkW1VEacEgeVmc1Zct5dZGsuHp2ELTlkuKJarLZ0AnP8TrPYe4ZYKnTL3tXcaC
         JZNSWCiB9y3i+OG0LMn/IFRPoDdGZ52nH2XHsJpPqO6ldpkhlkhRmD92frScAwn7sZmf
         9gJg==
X-Gm-Message-State: AOAM532vfXZmc1YzP+qjyEgvN2U1v2o9niowMCkkgjoYiAOjg19lsbJ2
        Fkch8YygZAhRQCflvxhe68xpFg==
X-Google-Smtp-Source: ABdhPJw0rOnlFiJBdsdQYr4NOtV+7dW9keQrDNuTrWV5SYbAhvsbGlo9l8ykaKGFHqhswnfJjCWL+g==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr6685419wrn.253.1604110939086;
        Fri, 30 Oct 2020 19:22:19 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g4sm6663817wmh.13.2020.10.30.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 19:22:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH 0/3] wcn36xx: Firmware link monitor/keepalive offload
Date:   Sat, 31 Oct 2020 02:23:08 +0000
Message-Id: <20201031022311.1677337-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset enables various firmware offload features for

- Link keepalive
- Link monitoring

Keepalive is a necessary precursor for an upcoming series on
wake on wlan, since we need to inform the firmware to keep the link up in
suspend.

Testing shows that LINK_FAIL_TX_CNT is a link monitor enable field. Once
set to non-zero link monitoring becomes active. This series activates
CONNECTION_MONITOR after enabling LINK_FAIL_TX_CNT thus offloading link
monitoring to the firmware.

Bryan O'Donoghue (3):
  wcn36xx: Set LINK_FAIL_TX_CNT non zero on wcn3620/wcn3660
  wcn36xx: Enable firmware link monitoring
  wcn36xx: Enable firmware offloaded keepalive

 drivers/net/wireless/ath/wcn36xx/main.c | 3 +++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 1 +
 2 files changed, 4 insertions(+)

-- 
2.28.0

