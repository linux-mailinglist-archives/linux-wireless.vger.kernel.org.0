Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F70189701
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCRI1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 04:27:13 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:32865 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRI1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 04:27:12 -0400
Received: by mail-pg1-f181.google.com with SMTP id m5so13266305pgg.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2020 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LGJ1tadBVSKcXHWmxYL9RsY79DWIeIh5wKubnO5eqk=;
        b=e8dl+UdnULDH7XYMFNjJmuLS6sr66005KzMrcl9E+V3VoFx05HjvO7RQSNdU3ghaz8
         Q33IZFKTfLuuV2UEmgENXMwlL4GJ5ZGoWgCw/rVr8Dk/OB60kYw90aArMAJPWrxFTWjb
         A9+oCSEQABtZCuvwV8fQfvNVVjG1pyk3Q274b2+QgDjyAs0z9vtEXTVKqlexteUwHjHX
         I1TD5yvw5EWCHxX6FqwK5wJC8+NPPvrzzX/gy2yZbfDSrQ1kMBFUnprUjynugofCz8gA
         KWeEH6ztWip0/HbPthW6yFu5oxajfN4xXYhrmVI4jD1N4+0K3bhN+2EhWM4DIw9AyCU2
         MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LGJ1tadBVSKcXHWmxYL9RsY79DWIeIh5wKubnO5eqk=;
        b=iMSmNj6Vqw6h7WnqkANZCQt2p8MYFnsxl7Q8/WeAlMc9joZxpoJ3oETJNizXs0IDvn
         L6Q62XRlSwPUQ7RhzrnH3d+tN7Zt34N4d+dJviXNQg9wpkQ9b3KAZ09n1WbeuEydK/Gr
         H6XZHsCq5sPWNeUvRn934a0pbKOsjcbUG3LCpAe28vjqNKQJWQoB9vxwY07WWa5EILZm
         PvJ7/KvdnpsWtcjpqmNu6T+3KtC0u0tS+Tn7Z2+souFsr73OPkbJ79jkXfaKfmfA0TdM
         gQ3F8kt1Fe6McAvTCj/k2JQ/FHH+kQV6kU6V+QGVqK8ldHYUR5Z7O8Z9ZlokNC0IKqcJ
         nGvg==
X-Gm-Message-State: ANhLgQ3M1psS+WJrj9/De6kdbiiGp7ZZDbcapCae4UMqc2iu7w7Jugt7
        6KRD3rIzAlEHLR56wT3T8dvbyA==
X-Google-Smtp-Source: ADFU+vtzMfXeCeHxOSeg+6PKfpDdbNC5fJZ5fLgsY4UNtVtABqiqbRlsTey5zSb/YgEPIRFuWf+OLg==
X-Received: by 2002:a63:5f13:: with SMTP id t19mr3302456pgb.265.1584520029786;
        Wed, 18 Mar 2020 01:27:09 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id 18sm5492148pfj.140.2020.03.18.01.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 01:27:09 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH 0/2] Feed current txrate information for mac80211
Date:   Wed, 18 Mar 2020 16:26:58 +0800
Message-Id: <20200318082700.71875-1-chiu@endlessm.com>
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

Chris Chiu (2):
  rtl8xxxu: add enumeration for channel bandwidth
  rtl8xxxu: Feed current txrate information for nl80211 commands

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 21 ++++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 77 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.20.1

