Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757D251529E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379349AbiD2RuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344488AbiD2RuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDE230F4B
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 10:46:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85D85623E1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F8C385A4;
        Fri, 29 Apr 2022 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254409;
        bh=jtGa6D++zfPj4DquZL0Vra8maSB2Yo0PlZirZ2iDbuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lACooIMqKdYOwdP+R4D0O68lQe/sQQH/TddfpA33dotTqEjlRXBqJPOfy+lC1EIyY
         GopTeo9TbOms9SxQKTtmvloo12h3rrpCqtCgnVCfhU0R5y3nST91NjbQ7eNkRKkf+H
         SC1u16en+Tq8IIz1JAxzyKILVxiEsPWb5MuW2ICK36pvHfu2g+LETTUEiufqBhU1u5
         hLZcgBhKQDGaW6ts5dod8M38QfGqgmkCptmzjKD8tidxbbrZBFXIqzub7AAHr1+fbB
         rA22sLcEwgk/H9QdJP+fTh09VA/nmSzLnm3PNMvAxA0OKeMt6ED7zmMIrLmivGh4sK
         0+X9fs7sdDrrQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH wireless-next 0/3] wifi: remove copies of the NAPI_POLL_WEIGHT define
Date:   Fri, 29 Apr 2022 10:46:40 -0700
Message-Id: <20220429174643.196994-1-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is prep for a small refactoring of the netif_napi_add() API.

Jakub Kicinski (3):
  wifi: rtw88: remove a copy of the NAPI_POLL_WEIGHT define
  wifi: ath10k: remove a copy of the NAPI_POLL_WEIGHT define
  wifi: wil6210: use NAPI_POLL_WEIGHT for napi budget

 drivers/net/wireless/ath/ath10k/core.h     | 3 ---
 drivers/net/wireless/ath/ath10k/pci.c      | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c     | 2 +-
 drivers/net/wireless/ath/ath10k/snoc.c     | 2 +-
 drivers/net/wireless/ath/wil6210/netdev.c  | 8 ++++----
 drivers/net/wireless/ath/wil6210/wil6210.h | 1 -
 drivers/net/wireless/realtek/rtw88/main.h  | 1 -
 drivers/net/wireless/realtek/rtw88/pci.c   | 2 +-
 8 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.34.1

