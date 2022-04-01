Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1934EF8FA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 19:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350103AbiDARck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350104AbiDARci (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 13:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D62B1AAA40
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 10:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E66B8258E
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 17:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FADC2BBE4;
        Fri,  1 Apr 2022 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648834246;
        bh=RQCpqP+2w7fIiUWEq3fqVySlWEsSP9xopeGa9g2TQvM=;
        h=From:To:Cc:Subject:Date:From;
        b=SBC9ji05Bx1olG2OYwBczO6gZD+dmndI0v4FwYNzJlTAyxV0vJdtdcipRPsW5Sj0n
         GvodO2j4JcON7160b0DYeyg9alADnburI6ZB9TZeqHu13tSjoSjlmi5RKtMoZdglxg
         uh3FC76wczXLUtt8iNmSf6jJ0dmZHyn5Exp1fiqBjrRo+ThmJXiRCVK1ntsZCA8CY5
         E5yebZt4/oFBB0E6SqwoZWxje3EIaAkN2a5AlDH/OuW+y2FJUJS+BrKgkXUefnKj5n
         b6b+Xv+eneKZqSpikqDb7zWiIkZwEWPqmowqmq3Hfo2bCkEy5SZEXtwveZN6R3LznR
         r9Aqta/ii3+zg==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] ath11k: mhi cleanup
Date:   Fri,  1 Apr 2022 20:30:39 +0300
Message-Id: <20220401173042.17467-1-kvalo@kernel.org>
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

From: Kalle Valo <quic_kvalo@quicinc.com>

Some minor cleanup to mhi.c, please review.

Kalle Valo (3):
  ath11k: mhi: remove state machine
  ath11k: mhi: add error handling for suspend and resume
  ath11k: mhi: remove unnecessary goto from ath11k_mhi_start()

 drivers/net/wireless/ath/ath11k/mhi.c | 222 ++++----------------------
 drivers/net/wireless/ath/ath11k/mhi.h |  17 +-
 drivers/net/wireless/ath/ath11k/pci.c |   8 +-
 drivers/net/wireless/ath/ath11k/pci.h |   1 -
 4 files changed, 38 insertions(+), 210 deletions(-)


base-commit: 57b7042c114767b7330b14a260f61732e556742e
-- 
2.30.2

