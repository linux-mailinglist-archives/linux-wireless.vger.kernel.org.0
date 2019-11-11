Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C882FF804D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 20:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKKTkx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 14:40:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42630 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKKTkx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 14:40:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so12241542otk.9
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 11:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MMMfgex227wAwNO0hi5koMKI2QbfnX7c+Q2qmCwmvcI=;
        b=IohY3zWbnn70X1hIjEDaXITtPfA9kcZWXnMJjry7HHFJ4yswI9Z/PqkwYL7gj7N6G0
         xZWoOivp0vNYLppMJiGEHR/13bvqXmvwPLs0gD7Vib/if/E5EWIN4jR5+pfpVZle0mqc
         IfQI/OV94fNSE30EBTAzXUB2ZVzqhqaUZI1EqNbtARirnGkmOetE88k4gCfev9Gg3Ldr
         jElGvC4XUrY8ZMEr1Q8NlWwMM81LzA3ZtIpNFUm7WyyIWLLvIw+Z0DJSse/ZI80ER34B
         uwoiQ5ry6fqMpFPe0Z7mZ8U9kzpVXOudMEVAf1DK5BxdOoEGZtFPtjawP3mYGbw/jO0E
         dM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MMMfgex227wAwNO0hi5koMKI2QbfnX7c+Q2qmCwmvcI=;
        b=QcKDEPIBMLqZ4biPjzoSjO4ecnyVuw9Ed4DPLXL6EQd4B6qjGj/6+et5zAO3Vi4w3f
         BfDI0+rXwwi/JZUjmbO4zdEnUsL34igVgkpXjua6XHjLLoKVc22jM+GK8NkFVuhM3Zh5
         FJOpJdAlLbQWgK/PET0kNs0ucU7x2UcPwzxF4t3v3qRPUsYwNqlBXB29omK5FeXTGFq/
         YilY/qyRLQZlTBigKhl14y9rGL+0JhkrW0w9Q71CVwE6FrSx0V+t64LUz60GgFUaERSj
         gpizisFlIlS1lz1HiXe55jPyWkARn4hOXx0/8poLk9SMiKX63AIZS09X53ntB9f1ufYb
         60rg==
X-Gm-Message-State: APjAAAWc6Ui3W5DnEzZNqtqR2ldEgtXzXbObSvMdAXz3RlGug0vL7Ntb
        PKIgM8xY708UVLNHcRvrTRdK6Aa6
X-Google-Smtp-Source: APXvYqxaqW1rVao1SVtfbICGbA4AEu7QxWoHwrVJ1pyLZroMOnZJjn9d/iPPFQtDKo3MvuFRshSxQQ==
X-Received: by 2002:a9d:5cc7:: with SMTP id r7mr14759011oti.331.1573501252471;
        Mon, 11 Nov 2019 11:40:52 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o22sm5031002otk.47.2019.11.11.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 11:40:51 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/3] rtlwifi: rtl8192de: Fixes for several regressions
Date:   Mon, 11 Nov 2019 13:40:43 -0600
Message-Id: <20191111194046.26908-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In commit 38506ecefab9 ("rtlwifi: rtl_pci: Start modification for
new drivers"), several changes that should have been applied to
rtl8192de were missed. Even though the driver has not functioned
since kernel 3.17, I found this problem when I was converting the
local bit manipulation macros. To my knowledge, no one has reported
this issue. Obviously, this particular card is not heavily used.

The 3 patches are marked for stable and fix obvious regressions;
however, there is no real need for special handling. They can
be applied to kernel 5.6.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry Finger (3):
  rtlwifi: rtl8192de: Fix missing code to retrieve RX buffer address
  rtlwifi: rtl8192de: Fix missing callback that tests for hw release of
    buffer
  rtlwifi: rtl8192de: Fix missing enable interrupt flag

 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   |  9 ++++---
 .../wireless/realtek/rtlwifi/rtl8192de/sw.c   |  1 +
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  | 25 ++++++++++++++++---
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  |  2 ++
 4 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.23.0

