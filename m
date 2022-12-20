Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CF652024
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiLTMHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 07:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiLTMHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 07:07:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A6BC2B
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 04:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CBBF6132F
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 12:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54F1C433D2;
        Tue, 20 Dec 2022 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671538021;
        bh=I0giWys/WuNUhEH0mVskkiDhpsbm4tMM5S+RvjQ5T/4=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5mUEDgS8IU/zDJJMWjwaj3ctlMr8m0d5eePKy7FF2LmL/HrXuhqo3xmJLInxq9Pq
         Fe0oppxmpyfAB1ECDmvWHLEb3piRm4BejkeTEbQ7KNexcSymkRZ0veUdZFIjGpNHA2
         TJP35gpJV/4KtD0sAojzs3WpbHeaFOQ+XaIgWNi/6zPy7S/E2+6Q07P1PS93iYUsI0
         EThGrRv9WZZLExqbNyPSJ4DohJe7FxIwbJkKTwEU+HiTQXtMlFY1Gxm6bzNGuCqORW
         98D0N/u1rMhs0JBS8JounyGwOmc7IAdlbpHET46tojF0o1qT7HLuJAmPxLvV6mpNWg
         puf0216w2SjoQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] wifi: ath12k: small cleanup in HAL and WMI
Date:   Tue, 20 Dec 2022 14:06:52 +0200
Message-Id: <20221220120655.19389-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Small cleanup found during review.

Kalle Valo (3):
  wifi: ath12k: hal: add ab parameter to macros using it
  wifi: ath12k: hal: convert offset macros to functions
  wifi: ath12k: wmi: delete PSOC_HOST_MAX_NUM_SS

 drivers/net/wireless/ath/ath12k/hal.c | 63 +++++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/hal.h | 24 ----------
 drivers/net/wireless/ath/ath12k/wmi.c | 10 ++---
 drivers/net/wireless/ath/ath12k/wmi.h |  4 +-
 4 files changed, 60 insertions(+), 41 deletions(-)


base-commit: 58e4b9df840cad439a4c878f81bc105cac2197a7
-- 
2.30.2

