Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A602A531C74
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiEWT7O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiEWT7M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 15:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840E7A468
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 12:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B6161416
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 19:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796A6C385A9;
        Mon, 23 May 2022 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653335947;
        bh=750BtSsys/aCl5NK4dgSOi4e3+swQOIgrDjtOxmTdrI=;
        h=Date:From:To:Cc:Subject:From;
        b=NNA2Q8zl52P188ta4zKFUrvkY9yiL1Hh48zF3kGYWe0tdevgn+FFwnQln3psfTZ7/
         SNSOOukpRuh8zb34J/a2roE2zXpgjyQJ80h+4awOHUP+On9MWmz4Z3PTn5XwKti1HS
         D/pJTkf838s7e/+xEFx5WYIJx3lcuVj5XgN2PW/q5tfc/c2XSHW8n5DLJrYpMGjXcL
         KJWEOrnTuKFYOBHXBX8WF9e/I0+Bzcd7YmT+yZ4y0WCxetTEiIMiJi6twwsoHk4I1T
         60+AXEqO8U1dpmK4bZfFPBbhVxczp0dVV6pEAtF6A6i61JTcGwvnA6LVxBCu9YhzA2
         4cfEspK2cMAMQ==
Date:   Mon, 23 May 2022 12:59:06 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: iwlwifi build warning on mips64
Message-ID: <20220523125906.20d60f1d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi folks,

looks like I'm hitting this on a mips64 build:

drivers/net/wireless/intel/iwlwifi/pcie/trans.c:1093: warning: "CAUSE" redefined
 1093 | #define CAUSE(reg, mask)                                                \
      | 
In file included from ../arch/mips/include/asm/ptrace.h:19,
                 from ../include/linux/sched/signal.h:14,
                 from ../include/linux/rcuwait.h:6,
                 from ../include/linux/percpu-rwsem.h:7,
                 from ../include/linux/fs.h:33,
                 from ../arch/mips/include/asm/elf.h:12,
                 from ../include/linux/elf.h:6,
                 from ../include/linux/module.h:19,
                 from ../include/linux/device/driver.h:21,
                 from ../include/linux/device.h:32,
                 from ../include/linux/pci.h:37,
                 from ../drivers/net/wireless/intel/iwlwifi/pcie/trans.c:7:
arch/mips/include/uapi/asm/ptrace.h:18: note: this is the location of the previous definition
   18 | #define CAUSE           65
      | 

Throw an IWL_ before it, maybe?
