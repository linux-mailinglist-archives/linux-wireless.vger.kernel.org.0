Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8520472E561
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbjFMOLG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242863AbjFMOJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 10:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1AF1BDA
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 07:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5C162CFD
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEECC433F0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686665360;
        bh=M37Sv73b8CvSrciyd7DmeQQ3VCJY4QyyCJDDEgG1ejQ=;
        h=From:To:Subject:Date:From;
        b=McV8OTQsdqMDMp0oTIfwGtwNctQNWYoe671iI6KGQSS3Vcl7jEDTq/sJWuc6NG4bF
         G4y9NHp4at1h6cNcQ6J8hgkaaB+tTgtCqdGgI1q5E5UmB5LeDJuRR0dY1g++lB2gtF
         GoOjBognz1aAcs6f2Be/Aqx7VrJ9+5a2DjtzAVISDbreskH8yQ53E2PjWMR9VQsME5
         lCJKAmcZGnOaeowS6gA5MtcHUWVlYkruJKCqsft3hTlRjwfiNa1cVnEGSBGcwKSGvF
         EpvRz6QPzMKqK6PAaIymOqeuL06b6Yq8uojvKj5U0GxwEnodaXJ3iG7pBwQm3qckxa
         pU5VhrtI6FWMw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: drivers: fix remaining W=1 warnings
Date:   Tue, 13 Jun 2023 17:09:14 +0300
Message-Id: <20230613140918.389690-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Here are the final fixes and workarounds I see with W=1. After this patchset my
plan is to compile wireless driver patches with W=1 before applying them.

Please review.

Kalle Valo (4):
  wifi: brcmfmac: fix gnu_printf warnings
  wifi: brcmsmac: fix gnu_printf warnings
  wifi: hostap: fix stringop-truncations GCC warning
  wifi: ray_cs: fix stringop-truncation GCC warning

 .../net/wireless/broadcom/brcm80211/brcmfmac/tracepoint.h | 7 +++++++
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h         | 8 ++++++++
 drivers/net/wireless/intersil/hostap/hostap_ioctl.c       | 2 +-
 drivers/net/wireless/legacy/ray_cs.c                      | 2 +-
 4 files changed, 17 insertions(+), 2 deletions(-)


base-commit: cabb8b48e542e1401f6881c4f7d3bb82f723ee40
-- 
2.30.2

