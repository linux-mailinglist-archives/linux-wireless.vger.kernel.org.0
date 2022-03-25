Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACB4E6CED
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 04:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353286AbiCYD7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Mar 2022 23:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbiCYD7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Mar 2022 23:59:31 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E350C55B1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 20:57:57 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 727A23F195
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 03:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1648180670;
        bh=rL+Lk+TkLUe4IB3XxddpXwlP/mqkcE0LsSD1mSoD/6Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=b3FoH5NTBaoTexQsT7R5d4PQxup5HXvBwZ1WZJQHQh6F7JQnvaxmSjXKXvNBZlUFJ
         mhDtILpJHRDomO6MNLXmUYGXTSkGePxoo3MZsp5wCrxbrEDjG/XnsINA9bjOs8PESQ
         /QXIeQtH8h3JdyeFOG9QTfeLBGtM45jv12S+gvztyzWGW3zwFHZf1tYOOSVyZpMxGZ
         Quqb5ZYBaaKwvaL3+hOvGRXkW4y7ACQYoFexeNPC6nCEYRz5epRipBJ3NTKCq9F1xo
         mKFLZIkYaHYMRQonr1JQJXUYrLT7hVnHExsu5xPd0szdDkfwZcMlj0fETYCHEV2pp1
         6YKki8uIYNH7g==
Received: by mail-pf1-f199.google.com with SMTP id t66-20020a625f45000000b004fabd8f5cc1so3542978pfb.11
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 20:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rL+Lk+TkLUe4IB3XxddpXwlP/mqkcE0LsSD1mSoD/6Y=;
        b=6bDhOxVXXvJyFgrQbBAji32GTkqGM2jy8ojpgbzlinTpUPdLwLnXt6E/J8JJRUJTwy
         oyHRd+7/puZIGLVIjdBgmFMNgCiPopQ3uv2suyZNm1c//azjs0DEPRfjQaEWE53Bipzh
         EDIlLxv/rY/iHI5fJ+6cls1gj9EMdQHzmR+Dqk9eALVUCe0UjDHo4jhWJj98nxAgzDSa
         QxixzUe+xMN9AikBhvwT+aASUmnqj2AWwUGwzEvCzfYJV/GQp1NwlCu6+2tHk5xxtF5Y
         V4+ECUFP/UDkTVrhDJzeweYfurEncu8MQY7ote4oxbudvRQ/lytY/49nP8vr62QS7XZL
         QO8A==
X-Gm-Message-State: AOAM533ODkAoSINXigeUjluLbKKie+Zkl2pDKydDVlAp72Ik6ZYfbwIx
        WP5yupwXkKrbDHcSgObcO+8oIE01wUCoGgAAP4I8g/knAMtBol9TKNYGMxJ4Q27Y4Oplrpq5x3a
        Ih73MxWIMqFbsd36muFvBzBy/I3Ss2IQOEznMUpGHxdaX
X-Received: by 2002:a17:902:d4c8:b0:154:2416:2185 with SMTP id o8-20020a170902d4c800b0015424162185mr9592703plg.25.1648180668949;
        Thu, 24 Mar 2022 20:57:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA3xdgqaavwF82ZP1ZAM+oGXZMZcWjM/y5nFGCHqIG/Ucn/hx021c9U9OO0rL6spHjyn789w==
X-Received: by 2002:a17:902:d4c8:b0:154:2416:2185 with SMTP id o8-20020a170902d4c800b0015424162185mr9592674plg.25.1648180668594;
        Thu, 24 Mar 2022 20:57:48 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e286-bae1-8fdb-11c6-cf63-1f23.emome-ip6.hinet.net. [2001:b400:e286:bae1:8fdb:11c6:cf63:1f23])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm3825801pgb.11.2022.03.24.20.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 20:57:48 -0700 (PDT)
From:   Chris Chiu <chris.chiu@canonical.com>
To:     kvalo@kernel.org, Jes.Sorensen@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     code@reto-schneider.ch, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Chiu <chris.chiu@canonical.com>
Subject: [PATCH v3 0/2] rtl8xxxu: Fill up more TX information
Date:   Fri, 25 Mar 2022 11:57:33 +0800
Message-Id: <20220325035735.4745-1-chris.chiu@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The antenna information is missing in rtl8xxxu and txrate is NULL
in 8188cu and 8192cu. Fill up the missing information for iw
commands.

Chris Chiu (2):
  rtl8xxxu: feed antenna information for cfg80211
  rtl8xxxu: fill up txrate info for gen1 chips

 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 104 +++++++++++++-----
 1 file changed, 75 insertions(+), 29 deletions(-)

-- 
2.25.1

