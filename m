Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218E0261A32
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgIHSck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbgIHScN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7FCC0613ED
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so178429wrn.13
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4/iHYTbaUfeXj4d2AY2VWmQvFonv3pkBLf3dzzwrYY=;
        b=TunDpIghchb0FErk/FzbkSILa1x+Dg4x68cFzpA/41Fkk/9bNANaZytosHz+H/TMlR
         e3c57xMjV6j3jBHhvvx2Utdwqj7rQWevlfSZtk6aQLvFENyw8R4HmpVGjvK0V0OUu9hN
         ACJULKB9l7M/dxohDkB5HL1XVloEx9bc1HASuBWYLkzJj9tcLHZ71fkReRkpxwBOJy2h
         bWovR4lCyhAr3NQ7vmZs1+oppWvt4ksWre4T5aPoidIN3Bk9S0dGdyr0+AsVNDQBYY47
         6i2wBGehPH3+/YNdCs4hGiFOqPYvW+bQBtNq0QsYMG62VCDciEo8WAmaEFRNC3uhd6nq
         kS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4/iHYTbaUfeXj4d2AY2VWmQvFonv3pkBLf3dzzwrYY=;
        b=FhPzxDBfxVfyVlACa/p8mrr7RaMvg1sI2r/LaaTiO8uiwIFCst+Hgd5NUJZcnyfk4k
         FLI/gWKBq4UR8lGjcR22RoNxBF16vATPwhd9Uq0X0I/AaLHpx297fC2fmE7WpHALxnJ8
         SJtX8ab49rhudDEjBK6eed+NZdOejcWtHhI4NWfFc5VFeV3RrJysNizfKbqAwt59pG2s
         /pI1sIcqK61e0jBsju9Co+WHRJezT33Y0/alK3P4vc2AkVk6DfyYNsCZNMvPvZWZs/gb
         VmnXWMsNpjC7wXBBMtO3RS6l+iANP89+GQrcG9DuTPxODBbBun+jZbPgAyoYImy/ZWE2
         zJLA==
X-Gm-Message-State: AOAM530eSi1TWwrecN+E5YAG6m7qw63XFHT8VrAG4uR1qWxCUXd+7DpE
        2mW52he8lfaXon9Rnb31tVmly+j6YNTdfA==
X-Google-Smtp-Source: ABdhPJx1QzLPwTLgQ9BhtRmDyCp3rQaC11gW8QIyYr8BFLHnz4QOHz75KJGNSBoR8+BZOUxhqivrlA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr879390wrq.297.1599589420676;
        Tue, 08 Sep 2020 11:23:40 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id g186sm286202wmg.25.2020.09.08.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:40 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 0/2] wcn36xx: Extend V1 data-structures
Date:   Tue,  8 Sep 2020 19:24:26 +0100
Message-Id: <20200908182428.2870226-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series is one in a set of seven to add support for wcn3680 at 802.11ac
data-rates.

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

-- 
2.27.0

