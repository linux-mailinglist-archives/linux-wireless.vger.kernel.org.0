Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E684D261A3E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgIHSeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbgIHSdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1CC0613ED
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:32:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so220319wrn.10
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In2FyHUty7S2UAR+sFsA8QF+sOyJldhFJVMmzkKndPg=;
        b=nEn9SX8/YTTxRifrHt3OvfUh5eoukmDTHmqCvF+KeyCXTtUq6SJU6GYuuFJ/wB5mbh
         x97ndFA4p6LopMqLThTgC/23PYySHvmNZSbbomUUevWrsYacYgBiBJVXVlKrkTaGrDSq
         Tahm/N3g/9TRiBOYqJl3lsuVI7Ty4T4s4pTGJf7X9iOCOPXguUsxi4pf9o3QO+YTLJek
         HjxakLS0sYLF8ocELX0L63ezChqHfCWaQZBJUlPYiGI6K3vdd7SoY/vwM1szIgUjMqpx
         iG/C+gTmqbQTyVdoTKX1uNa9p8Q9L9gQvWBHc5knb2n6CfNMBYevYVk22wlhnJc9Rlzg
         TjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=In2FyHUty7S2UAR+sFsA8QF+sOyJldhFJVMmzkKndPg=;
        b=WS1K/MkubUXDKxIqo4eM0bfEEvOnAgPdx9USAT6+a7O9Yf15A4IA4RRYdbpKphvFRz
         inej5g72BADnsQf0KWvDvklDsZyBNwLgocihN0odgVgevvx8GzLgoIW9odUtHAaqDOK6
         Y5Ln5PMKLaZ7WnF4cYVIM0DAIlE2Cc2Vd+FfM0NPegigSiX+5e+MP4Dk6ulrWK0GmOIp
         veraiNeN8cc/qAda8IzgRQ4npKzp4+bSiTM+CCrUHdUNWDr0Zu1QIpplG2MdYOfzLvkh
         NyX+RNYpAelkdJUmei4s88bQL2SmCUFkCOGkZWAN8ZRnwCqeUIFwqJj1X+cM47ebKWSN
         IO3w==
X-Gm-Message-State: AOAM532vDghtTJAUts7ED+uWKkqJTZzovl/RIiO5lw5eMmh+jznhTpeG
        mUpgocyvsc79XVq9Db0ZEMz0L/cDqqLbyQ==
X-Google-Smtp-Source: ABdhPJwIzKzssE4KBik5CcLzgWVDDFsov6qcWvGBuILcNH2bWiVHaTon/fRKeW7/a0Z3pFSgjE53/A==
X-Received: by 2002:adf:edd2:: with SMTP id v18mr937211wro.242.1599589965361;
        Tue, 08 Sep 2020 11:32:45 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm380267wrv.72.2020.09.08.11.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:32:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [RESEND PATCH v3 0/2] wcn36xx: Enable VHT when supported
Date:   Tue,  8 Sep 2020 19:33:29 +0100
Message-Id: <20200908183331.2871016-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is six in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

These two commits have been moved later in the set of commits so that the
patches to enable advertisement of VHT capabilities happen after all of the
supporting code has been comitted.

RESEND:
- Messed up my .git/config resending from my @linaro.org address

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

