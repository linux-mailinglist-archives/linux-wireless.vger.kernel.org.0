Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE70918C790
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 07:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgCTGiv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 02:38:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39040 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgCTGiv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 02:38:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id m1so2089262pll.6
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2020 23:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRVhjjDD7XDl/ETxhVS+N5qQy7f2YR4UjmY+Va7NcIg=;
        b=k1jXwyAuASqdG4q2GMsWq8R3D3oD+CJtwwbeFsM3NNte3Tjo3tG5Fri927exJdRwAL
         Ucd1dVzBECsE31JCm+u6WELtE0af5EZDyXmEmwLTV+J2UvBNe47Ww+o2K/eXG6pypM83
         zkldNrNgDw8wplWNZKixLdMI15c0g/GPxxjyWwa/VxY/rEMRzqFx+fEKjup2+0g0cdYa
         8M/YadjWpEu5Bm+7PcGkV5I9QiMQUzDkB3KnOscWkQdVF7tQEubXcu4FhtqqjYbEAD2w
         Ip5tc0+5uOQcFmjwTov/u48CNTFF6npBneeL5Q9fX3HS+qPF82hpVWec7jf+ahf3GXOB
         6NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRVhjjDD7XDl/ETxhVS+N5qQy7f2YR4UjmY+Va7NcIg=;
        b=HmyGkzXDyaWWETtnM36ee0zFy0VABqc0RriguOx9L3p8QJemFIoeVai466fNszONwZ
         wdbgIAa1R2nosg1mp5XAPu6LnI7T5F4peIDcA20Badtv7BBYMlVvrG6LO0MERgFkzDsL
         5wnOO9WRu4sGs3O96Pk0ooc+cDfOhCnGvBVylEH0cOu5Brnn50PH7PaQSQfLMvfCUwof
         +5SApJbpgkgZQrRcDO3YY37szhsNYZsI6D0sFL+UJbzZ/FrTBC3XB8R9EVjn7bEALp6M
         EprAD/G6GRwo0cMHBKqVZaL91ssT7DpLuT4n+xA0I4CfXOEU4GYhb/H+IILIqRkL2mS4
         XxCg==
X-Gm-Message-State: ANhLgQ2VW9mYPyjNUBBnIMRHfJcuygcXcUNp++nZSA4SPdB8coSS1vVK
        Cq97UCTf2JciDXNIPjrAMj/URw==
X-Google-Smtp-Source: ADFU+vuAqL4vQjKPSkB3rW0832Dll8GemgDdGRZ6ZhihE6tUalFcheR5/sWW60aa9pISP4cH2vAnDg==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr7658748pje.123.1584686330284;
        Thu, 19 Mar 2020 23:38:50 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id y3sm4370901pfy.158.2020.03.19.23.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 23:38:49 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH v2 0/2] Feed current txrate information for mac80211
Date:   Fri, 20 Mar 2020 14:38:31 +0800
Message-Id: <20200320063833.1058-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset fills the txrate, sgi, bandwidth information
in the sta_statistics function. Then the nl80211 commands
such as 'iw link' can show the correct txrate information.

v2: make the rtl8xxxu_desc_to_mcsrate() static


Chris Chiu (2):
  rtl8xxxu: add enumeration for channel bandwidth
  rtl8xxxu: Feed current txrate information for mac80211

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 21 ++++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 77 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.20.1

