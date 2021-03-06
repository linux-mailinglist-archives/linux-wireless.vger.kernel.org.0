Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADB32FCDF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Mar 2021 20:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCFTrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 6 Mar 2021 14:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCFTrR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 6 Mar 2021 14:47:17 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB1C06174A
        for <linux-wireless@vger.kernel.org>; Sat,  6 Mar 2021 11:47:17 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a17so5318520oto.5
        for <linux-wireless@vger.kernel.org>; Sat, 06 Mar 2021 11:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Xmi0rHoThxmVAwKADHBN2StwB49iy48ak0XOknAe5mc=;
        b=oct8kALmhW4nQruRqaUxBzaqiTi36phR45XxP6kCwTI3/1iasmQORazxg4ezR2steA
         grKNURyc2+KjQ9N0uRzRpds/MSocvJIoTgcfOBmU2bFOI8HS2ZvEydaAu4W0RtqZvPwB
         Sqr1ZvCFogBtN8PpPCEoi4kfJKnoMv+3fwhpp3qCcDGtyb9lPYnm6slQJGzhA8Oe9Trh
         udD68EVvA2YVJb8j46yXS5B45Ou0Osx7ODZwfwf37Uz81fSYofcsE2/KAVo3fA6PtzcR
         JI6fQ/hsWFqHE5RMzliWyBeL+dTxyltpeJz06aKalFv6uf/GAicHEo6RjGLTpg0iDQ+K
         AKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Xmi0rHoThxmVAwKADHBN2StwB49iy48ak0XOknAe5mc=;
        b=f6WvJgEgze4s6y8+jvW4obTC3uMAr+9y/1oKQMJAfWIo7RTLjgOPEebazmeghdrSVG
         CvueB6yENDjrJLX+N6xmHeLMyg1d+3YpUX8GWqo0uRhCt2F0cMDkfdN2u/Bsku9bBk0j
         FA2hbaxJcKLUtfsqAQcPrFzE8ua8p8hz7dvY/Fiw72gPFOtruKYU0OK4dZJxIdBSnUou
         AyNQxxWW/t5veLQbm9MnCXdXn79abyOF2u+zm6ibF/JIq+euG424rM7DIAKPs0HrIXL7
         w2QWgtjUGxqAtu6LgQ6RL3BLg+XeP8zGA1IMIltzCPi02MT3YzJ431IVjRKZjsthBYf8
         EFDA==
X-Gm-Message-State: AOAM533m0XSKf1m7OqRR7ju1GW8Jh2tCTCfNpkjupQygqaBHMyBeGeS5
        +IW1lZeCzOIy03xun2p/5lJ1gw==
X-Google-Smtp-Source: ABdhPJzQGU+WJ+f4Vx4/sS/E5LLQf2dsh9y7bU5WYY7dYregoUEPQ3VFYo3oWJZf4yZr95C475c6sA==
X-Received: by 2002:a05:6830:1416:: with SMTP id v22mr13105708otp.239.1615060036544;
        Sat, 06 Mar 2021 11:47:16 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 85sm1361683oii.39.2021.03.06.11.47.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 06 Mar 2021 11:47:16 -0800 (PST)
Date:   Sat, 6 Mar 2021 11:47:05 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Luca Coelho <luciano.coelho@intel.com>
cc:     Kalle Valo <kvalo@codeaurora.org>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iwlwifi: fix DVM build regression in 5.12-rc
Message-ID: <alpine.LSU.2.11.2103061139200.1285@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no iwl_so_trans_cfg if CONFIG_IWLDVM but not CONFIG_IWLMVM:
move the CONFIG_IWLMVM guard up before the problematic SnJ workaround
to fix the build breakage.

Fixes: 930be4e76f26 ("iwlwifi: add support for SnJ with Jf devices")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 5.12-rc2/drivers/net/wireless/intel/iwlwifi/pcie/drv.c	2021-02-28 16:58:55.082425755 -0800
+++ linux/drivers/net/wireless/intel/iwlwifi/pcie/drv.c	2021-03-05 18:42:53.650809293 -0800
@@ -1106,6 +1106,7 @@ static int iwl_pci_probe(struct pci_dev
 		}
 	}
 
+#if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * Workaround for problematic SnJ device: sometimes when
 	 * certain RF modules are connected to SnJ, the device ID
@@ -1116,7 +1117,6 @@ static int iwl_pci_probe(struct pci_dev
 	if (CSR_HW_REV_TYPE(iwl_trans->hw_rev) == IWL_CFG_MAC_TYPE_SNJ)
 		iwl_trans->trans_cfg = &iwl_so_trans_cfg;
 
-#if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
 	 *
