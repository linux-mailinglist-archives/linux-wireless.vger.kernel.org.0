Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39585573327
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbiGMJpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiGMJpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04EB62A0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=ntfFaUBBrSlMKcfCL6OeBKbZKroLZWeE6Vly50t1VbI=; t=1657705508; x=1658915108; 
        b=Uy3/ooF3J3UNWYts77bgrKVUEpNWaWJvtUGio41zlRmCzL8zOKJthqV7tUsuwhuKAs1/aJjR7sP
        LX5pvkSLGg/AmNgTvW6kyBnDIkykJaswSbm9P3sSpezNi1LN/PW5cV3WVvvrPW2HwXDY3Of0xp2pw
        DmCvBEcm/ixpTCETlwSRvf3kifNolIXorm88Zgqvj5NhiJuR8349GdqB/Flrl+VJzYe9BLmsxXbdy
        s5bO2ZX3GJrDG87kmpHTQ6flCTLw04BwsCsmHN8+PP4p0AV85Oy3X4QtJuYouY7MRDitCdYGLKwB9
        oPom6Qv9O3mghKhVvk1yrOOWWBn7MrT3Fp3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvY-00EgvB-Rs
        for linux-wireless@vger.kernel.org;
        Wed, 13 Jul 2022 11:45:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 00/76] wifi: more MLO work
Date:   Wed, 13 Jul 2022 11:43:46 +0200
Message-Id: <20220713094502.163926-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So our MLO work is progressing. Internally, I have limited support
for MLO connections now (over hwsim), but that's at least another
25 patches on top of this series.

But would be good to get things out first anyway. I'm tempted to
just apply this (after net-next merges wireless-next and we will
merge back) though - even if we have more fixes to it later.

johannes


