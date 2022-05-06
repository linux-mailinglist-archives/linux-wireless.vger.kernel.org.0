Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8FB51D393
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 10:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386983AbiEFIqF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiEFIqD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 04:46:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8AD5BD35
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 01:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FA0FB8341D
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 08:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7FBC385AA
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 08:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651826538;
        bh=qeV7doCT75Z9k28TKV4rfHx7NDXDKm6k9J9J24cYSvE=;
        h=From:To:Subject:Date:From;
        b=Q95qyRP6WwD4itPna60lSYTG623fOYuANBzkA7X+jv6emBLGAZZU1nhXZ2GFwKjkH
         0o8kBnN10GI8McMf62Q6mtdGh901pBngamaw80jshXLGOOlhHnQpMS74hq9cMzat0H
         P5nED3bivTFIjg9cwYHfgHVYmSFgPH0DDDs035ztxdIOyUCyQJVPGxS9JIkN3AIa17
         r2uUCxyy7tdyr1vbkBAtHij0K0qArcxFGyXlWEMPKfRrqd2AI71WY7B2mnDPen3GEU
         K7l8pF9eWPQHejT8h/MgQ4ISzW/oMIYgAI+RUk65+HvymvhueuAHXveF1m+y1jIpwA
         dGK5CXpy51LPQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mailmap: update Kalle Valo's email
Date:   Fri,  6 May 2022 11:42:12 +0300
Message-Id: <20220506084212.8952-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I switched to use my kernel.org address, the old kvalo@codeaurora.org address
doesn't work anymore.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 93458154ce7d..5bbed50e9d3a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -204,6 +204,7 @@ Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
 Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
+Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
 Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
 Kay Sievers <kay.sievers@vrfy.org>
 Kees Cook <keescook@chromium.org> <kees.cook@canonical.com>

base-commit: 454744754cbf2c21b3fc7344e46e10bee2768094
-- 
2.30.2

