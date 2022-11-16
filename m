Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36262C52B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbiKPQox (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbiKPQnu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6C56EFA
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:40:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9018661EE6
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50EFC433D6;
        Wed, 16 Nov 2022 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616800;
        bh=BEx0VdeZ1XIdZPpAz33Ip1VWpLLqTaOVhzeD8qXteLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqnYtuLZPph4MIVY9jkDAkjNyVrjdPj0Bw7TsRww8Wkk3GCkKw+XcKI70wmNvMTVA
         9gVSYbGN60KnuPzH2ZkZ2tYJkvDwyzxtRuxlC6eSUSWa/OHZmSh+jMNOW/79GWw8tD
         dSmYr+05ClK2mKwIx8wpra7U24kPottpAiRcJXjxqWoQ4TiIEP7xsmNntV6Hpx+MXw
         1qrtr2jLvFPYRAp0aJKBZgP9nNItAhG62Si0AVaOVF3CLXUchyqOpE+pixUKh27I1I
         /ndhZZedTYTXz7wyTEo1rBkP19pMR7s8lTiSrpVsCsOBwtV8MUJxO4nS6BFPf2UAeI
         V5LduFLPxtAaQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 50/50] MAINTAINERS: add ath12k
Date:   Wed, 16 Nov 2022 18:39:02 +0200
Message-Id: <20221116163902.24996-51-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add an entry for ath12k to the MAINTAINERS file.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66738c8330db..98d7b5ba058b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16571,6 +16571,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
 F:	drivers/net/wireless/ath/ath11k/
 
+QUALCOMM ATH12K WIRELESS DRIVER
+M:	Kalle Valo <kvalo@kernel.org>
+L:	ath12k@lists.infradead.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
+F:	drivers/net/wireless/ath/ath12k/
+
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	Toke Høiland-Jørgensen <toke@toke.dk>
 L:	linux-wireless@vger.kernel.org

