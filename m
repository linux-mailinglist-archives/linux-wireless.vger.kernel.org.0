Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40FD264FA6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIJTrv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgIJPE3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1EC0617A3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:04:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so7038836wrl.12
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHdpY0CApLqz4yYTmxevGojYcT17gfjN6v5WrrEuc9A=;
        b=fcDbbfzTN5QxxsnQS+U2i9XUdVKeVXH6IMZHI/pZs0BLVMlMg6/fRJ4ltEYGjcGswq
         NBfjwIg7l4NfdAD28S6RuoELy6ywJEHmU7bNt7NAo7bXEuwoXYBezbYYMGHSwyeDx+q4
         ZL7z6rMPQM0Ku7LOpdy7ba2+Fgfq9exQ9JLVUbRI3X7FAgld3/MdqZJnC7rd3uLPxgva
         HDFyBN2CQOjtH2TxVR0vFIim9p09KXABj7wpDwuu0kN3++0R8d6UTYxE3UBd98+IjBZQ
         t8W+umTqRjXwehS47KBwjGlvTeWfsVgS+jodsTtqhUuzqdQ+jK3I66VJkrBJ0/IlwOqr
         E5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OHdpY0CApLqz4yYTmxevGojYcT17gfjN6v5WrrEuc9A=;
        b=cixWvZYn0shocUfMhFSG+3K+/CqjmItH9JXc6/FDFH3PYlHl/bASmXgVgE9qaq74hW
         MF7ugRhAmBxciPlGKWdthnH6EzqkaoJrsGwdCcj6PBbpvrvJMeRFkC5015F3ahQv9wIW
         X8XwebvlQPVtPz0gNL87DaaaoMmw3TK/PMw1D4RiMlVZXNXk/OibrUvrKBw2cKr2LBF5
         d8iFiESOe1MaWFxtVpKFW+pNFnT+gG6UiD0JWo54IkEq0edZVhXS6vU8ABgHw3/n1pyo
         g5/hs0VduXkpNJuepGg2gXW2Gg3vw5hNHV9evNXddlL/uX8rXGrKL4m5D/AE2g9RLqxc
         91Qg==
X-Gm-Message-State: AOAM531vkcakvocA3aA+bD9Ecu98PP4v/FpaH59GbfhtcRmgW+CHetlm
        6DHVWozOXQQdMzHvgXII2jkKuG4WNsjdnA==
X-Google-Smtp-Source: ABdhPJzLXf00454JQXfaDZZxLFy61BDvyrkMlwHj8JeFiPG66sY8njHXx/iY0ceyoR1Crg5DMld2WQ==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr9381917wrt.159.1599750246985;
        Thu, 10 Sep 2020 08:04:06 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q186sm4075754wma.45.2020.09.10.08.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:04:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 0/2] wcn36xx: Extend V1 data-structures
Date:   Thu, 10 Sep 2020 16:04:48 +0100
Message-Id: <20200910150450.2178784-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is one in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

V5:
- No change to V4 sending entire set again for clairty

V4:
- No functional change.
  Sending out full set again using --base=ath-202009090652 to aid kernel
  test robot
- https://lore.kernel.org/linux-wireless/20200908182428.2870226-1-bryan.odonoghue@linaro.org/T/#t

V3:
In order to pass VHT parameters to the firmware, we need to extend the
parameter data-structure. In the V2 series, this was accomplished in two
patches.

https://lore.kernel.org/linux-wireless/20200829033908.2167689-13-bryan.odonoghue@linaro.org/T/#u
https://lore.kernel.org/linux-wireless/20200829033908.2167689-2-bryan.odonoghue@linaro.org/T/#u

However since I was rebasing this series anyway I thought it would be a
better idea to do the conversion in one go, so that if someone is
rebasing/bisecting in the future every single patch will still be
functional and testable on wcn3620. If the data-structure is extended and
then the code is subsequently updated, then the patches in-between the
data-structure update and the code update will not be testable on hardware.

As a result I've opted to front-load the conversion. The first patch is
atomic with respect to ongoing functionality on wcn3620, which I think is a
better result for not much extra code.

The eventual enabling for wcn3680 comes in a later patch in a later set.

For a similar reason I thought it best to front-load the conversion to
using the extended V1 data-structure for storing parameters internal to the
driver.


Bryan O'Donoghue (2):
  wcn36xx: Add VHT fields to parameter data structures
  wcn36xx: Use V1 data structure to store supported rates

 drivers/net/wireless/ath/wcn36xx/hal.h     | 14 +++++++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c     |  7 +++++--
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  2 +-
 3 files changed, 19 insertions(+), 4 deletions(-)


base-commit: 160b351d75cb50a0dd2abf9b63e1891935aa9e4a
-- 
2.27.0

