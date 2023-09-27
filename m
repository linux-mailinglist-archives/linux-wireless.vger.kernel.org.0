Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBF47B06B7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjI0O1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjI0O1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 10:27:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081CEFC
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 07:27:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BE7C433C8;
        Wed, 27 Sep 2023 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695824831;
        bh=/K4oe3X/dlVARO85QHUA5C1y7kL3dVI9yU92xRcX9uI=;
        h=From:To:Cc:Subject:Date:From;
        b=r00jlFpr0NfaxbkDhKWGLWr4aB7jZaGhdPxUrSUnVQIaZsohG3Hz7ER3cIFng0JpY
         xZquEYYq0fXHWrYkuUeqjs0cRV6vsgXHZCbkaMCjrXXxtv4fh+9/n1MyPf3ZrpxyDf
         rRl9RLM2IuZqbia3WUlbFljwQ6reyWMkNa46QqaTxCIg9gR0QTlSxVDA3F4EilNk2Q
         l7mt1YL5e3CveJYLY8xBTxuaeC2TDbZl9shAjKF4GdT4KyNoK2vROk9GQ3vOjLkSWz
         NMF0JCOC+kHSd3XNJk4qDj8ewYO6QzLISWg6i0KU9zXFDBh6hYPkfyKyXB34Jnag9A
         OGeav2+r9RJIQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 0/1] wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling
Date:   Wed, 27 Sep 2023 17:27:07 +0300
Message-Id: <20230927142708.2897504-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

Fix a sparse warning in ath11k.

v3:

* check NULL from ieee80211_get_he_iftype_cap_vif()

v2: https://patchwork.kernel.org/project/linux-wireless/patch/20230926163350.2641064-1-kvalo@kernel.org/

* use ieee80211_get_he_iftype_cap_vif() instead of open coding it

v1: https://patchwork.kernel.org/project/linux-wireless/patch/20230921075440.1539515-1-kvalo@kernel.org/

Kalle Valo (1):
  wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling

 drivers/net/wireless/ath/ath11k/mac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)


base-commit: 73e13f6a439b75a9dbc84bbfa0b0d6624b354853
-- 
2.39.2

