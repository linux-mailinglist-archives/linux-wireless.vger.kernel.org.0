Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774E1261A3D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgIHSeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgIHSdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAFDC061387
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so206639wrm.9
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LSc7CLirxvJ1mV5aD8frfdm6e2nE4ZYeQj4UXbY9m4=;
        b=ouLHPbH2VmIJXn3uQxvSYP72ixvs4jwX2TXwCX2IvG25npcV4CZ3mZsojt99MB3dMh
         33nnIYvSUtloo7vgcaeBX7WThhfT2Eh6afGFzxt0jOxwT+vKraSvPRBxogY9XcQYF820
         x7JWWPZpVVHZ+vrg9Y1baDo4kabG876ts93tdQoLPANJt13vz/XAjUwTrdRayMK/i9VQ
         Vs6jh68gDsFvhqK5hSztcdy9AsT/UYdUXJWT76I6xHiuyYHMDGhrMOdzvPmWmbwprSPn
         kEaP8qWUkmagoF/FswJgSS6BLoE4jvE+0h0NVI8/N970trQvLCsEeuMrGQSlYjMVcVmN
         5PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+LSc7CLirxvJ1mV5aD8frfdm6e2nE4ZYeQj4UXbY9m4=;
        b=O2JmaaDQfXc9XSnDjw4LxR/OiYpBNYrJrNHsuCPi7N+NofkS/VcQGIpDLmE6uXE2hf
         ofjInH4tCxMGvlpa/aV20rlsG2ejrLrG9fJH+OgUCrE4ahljoxPypPqYO36XvhvO10Bu
         caJteEbpCy8PLvlU5jCEyAr25gufXffYNDP8l1oCCIEw20XYn5BuqQ/LDrfk8Tb3NwbI
         y2q81doQxv7tzovBSa3cNb5hNNXFbivOoxf8HpwsQkQ3d86OUkbnFmVaMJnysZrsglmV
         /Vdd/n8uKNnu7x3Qjs4LPkDhMSiilUbbd9Sk5jfN3qwvD3gHAm3c1JoSkcVjnqa7JzMA
         4LVA==
X-Gm-Message-State: AOAM53040TDRjzl0XcCvIRGv61uVN/8lnXsVk+qXbBNINSr8h39DDKwU
        0PdBR+tKnAcGFzb1Dp+q2nUjUg==
X-Google-Smtp-Source: ABdhPJyXhGFl5NMkBkcM+ZjqjGx+2d7uVvZlzvBUxVjoUGd+fcZ3sV7+VyIx4mGR8nBtBgwqIB2Ayg==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr966587wru.73.1599589495475;
        Tue, 08 Sep 2020 11:24:55 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c4sm334348wrp.85.2020.09.08.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:54 -0700 (PDT)
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/2] wcn36xx: Enable VHT when supported
Date:   Tue,  8 Sep 2020 19:25:40 +0100
Message-Id: <20200908182542.2870535-1-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This series is six in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

These two commits have been moved later in the set of commits so that the
patches to enable advertisement of VHT capabilities happen after all of the
supporting code has been comitted.

Changes from V2:

- Rename "wcn36xx: Add ieee802.11 VHT flags" to "wcn36xx: Advertise
  ieee802.11 VHT flags"

https://lore.kernel.org/linux-wireless/20200829033908.2167689-5-bryan.odonoghue@linaro.org/T/#u
https://lore.kernel.org/linux-wireless/20200829033846.2167619-4-bryan.odonoghue@linaro.org/T/#u


Bryan O'Donoghue (2):
  wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
  wcn36xx: Advertise ieee802.11 VHT flags

 drivers/net/wireless/ath/wcn36xx/main.c | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

-- 
2.27.0

