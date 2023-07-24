Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43275F3B3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjGXKpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGXKpv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205249C
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFCE6106D
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9051C433C8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195550;
        bh=/wymqEZNyXebqdPfJPPCImVJkce8w5/B2KWeFpdygi4=;
        h=From:To:Subject:Date:From;
        b=Q+G9go4FYGsHNXSRIcyV7+oH5e1shz3IoGW4qdV6Nd3V2Ugoq6D/Ql6Nie4Ds1bwv
         IgUYPcZNXMd+W271D3vSXbLVtSwKCXMafakroL3TLF9OTmaF/AcklsT4fFauMXp7ek
         D+RGxDi8E+CZrnbaXKtfH06h6uZWlTfmbLc5FsyVmoFUIc8YbM/5UwW6mOXgXPnY5H
         ER5OGNFR2m0qWTJlxUIRvmirQue7rEABTPa8I/ua4Bq1qkW3I4x57ICiC9WKPxBaX+
         /dNJn3Mh5yYhXsaWIvaEh+QKSJM/av10oDs7Xt5/lJg2Hi77I+jAHddZ9jI1SX+JhR
         jLBw1lsifh4IA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 0/9] MAINTAINERS: wifi: driver cleanup
Date:   Mon, 24 Jul 2023 13:45:38 +0300
Message-Id: <20230724104547.3061709-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
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

I did some cleanup in MAINTAINERS file. Marking Ping as the rtw88 maintainer
and orphaning a lot of old drivers.

Please review.

Kalle Valo (9):
  MAINTAINERS: wifi: rtw88: change Ping as the maintainer
  MAINTAINERS: wifi: atmel: mark as orphan
  MAINTAINERS: wifi: mark cw1200 as orphan
  MAINTAINERS: wifi: mark ar5523 as orphan
  MAINTAINERS: wifi: mark rndis_wlan as orphan
  MAINTAINERS: wifi: mark wl3501 as orphan
  MAINTAINERS: wifi: mark zd1211rw as orphan
  MAINTAINERS: wifi: mark b43 as orphan
  MAINTAINERS: wifi: mark mlw8k as orphan

 MAINTAINERS | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)


base-commit: ac528649f7c63bc233cc0d33cff11f767cc666e3
-- 
2.39.2

