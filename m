Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C132B74E8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Nov 2020 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRDmP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Nov 2020 22:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgKRDmP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Nov 2020 22:42:15 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807DFC0613D4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:15 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b63so523882pfg.12
        for <linux-wireless@vger.kernel.org>; Tue, 17 Nov 2020 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlMnPeSZ8iwqOV+lWZaDg14k1FQemTxFV5V9b9kh3Ew=;
        b=NbDP6YLFtda0bZcNmewD6aVY77eaB1/PSnXYlGqFT3wPUp65xjEMftvxUva8dAd6aW
         RmkKQHk/Xt8/JZlcjCEw3atIftt9w2/Y9MjXnqCF1ThlqQ96tE/sL3Pqm9iIVUUkbAp8
         0p7hbmWtvZ3WGKg/if5h6Kedku5TkPIUOJC4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlMnPeSZ8iwqOV+lWZaDg14k1FQemTxFV5V9b9kh3Ew=;
        b=JKCJkKYm7OQKYa/lAK3pluzs5VhWmaTJgnt5116/LbJFXtyRtXDOodRRny4YSqMEsw
         9wDcPOdVatom870O5y7trzU2KFcjXJfYDS1mHTiSYlkkzW9Io7jwmAxXibRx2yNprPFe
         C//s89t63DlSHDfclovxgH7v7tgLzSuKBAa/d33AwfahfRvg5H/1XfrNiZwGZqYoOV4E
         MuD6g7r0GuXd8A74MEx3JIImRJYfJd1lwyvrqdzfnssao3O+UkkaIC+aNAQ5S4psAl/W
         QF+QqWa7q8tRncFTif3hbipOrKFP8kS6wubrvcW8ppBYxPVFfXyE2JPqsBxY/iX7Pgkc
         v0xQ==
X-Gm-Message-State: AOAM531iMwfmX1aaBICf2SB7RacSGInL7shVHX3xsBAAcZ/x0+G7cjk2
        VKiALNAYuvvmtj9/0aZB0aFd+dSvXrOZ5g==
X-Google-Smtp-Source: ABdhPJytGEfByn2b9XE1UcLXcTnSLER2uRWCWzzsbBIU0UkcA+BhOuv+dIvGhjNajkUfvSl86+HfRw==
X-Received: by 2002:aa7:950b:0:b029:18a:df47:ef90 with SMTP id b11-20020aa7950b0000b029018adf47ef90mr2734176pfp.74.1605670935082;
        Tue, 17 Nov 2020 19:42:15 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id w2sm16097617pfb.104.2020.11.17.19.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 19:42:14 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        David Poole <dpoole@cradlepoint.com>,
        Ben Greear <greearb@candelatech.com>,
        John Crispin <john@phrozen.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/4] iw: add HE capabilities scan parsing
Date:   Tue, 17 Nov 2020 19:39:32 -0800
Message-Id: <20201118033936.3667788-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Several others have made halting mentions of doing this:

Subject: iw scan dump for /AX attributes?
https://lore.kernel.org/linux-wireless/8afa882e-64de-7c8b-49f4-ac318f395102@candelatech.com/t/#u

Subject: Adding 802.11ax decode to 'iw scan dump'  Checking for interest and looking for feedback.
https://lore.kernel.org/linux-wireless/MWHPR12MB1533B5C250E9B35367EAF628D9330@MWHPR12MB1533.namprd12.prod.outlook.com/

But none of those have materialized in acceptable form. So here goes my
bad attempt! I only attempted HE capabilities for now, since that's
partially supported already.

Regards,
Brian

Brian Norris (4):
  iw: scan: add extension tag parsing
  iw: util: factor out HE capability parser
  iw: scan: parse HE capabilities
  iw: scan: fixup HE caps whitespace

 iw.h   |   1 +
 scan.c |  40 ++++++++++++
 util.c | 187 ++++++++++++++++++++++++++++++++++++---------------------
 3 files changed, 159 insertions(+), 69 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

