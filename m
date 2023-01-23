Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DFE6779A3
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 11:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAWKzr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 05:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjAWKzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 05:55:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F31630C
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 02:55:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 948E7B80B4C
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 10:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B27C433D2;
        Mon, 23 Jan 2023 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674471343;
        bh=yODRROQ5ygjCv2PYhqnNIF3i8t7fLL9xRhOQ6q62eCc=;
        h=From:To:Cc:Subject:Date:From;
        b=cNof1euwNqcj3zVVS7ZC2+5EbtJmy6FExRkT5ebVaTzfsY26/bHAKxOSCK+xkmNH1
         A/30uzFXs1AIQAvUMxsXIZFS0iTK933JiKV24047JT1nFjgTI4D8FNlSbNl4TpXu9n
         sfodwWHIJWfvz1qtXDGQ/2uAt6qisP/XYYhBu/6GzzKwf/uJV4adMDYUWt2FCIjE4m
         l/yMvhwwEJYuFT+xhJ/6dz8JgE/a7BAcENskf3LySGwQ7elK7vKbl7XYNT3LoMZoDI
         BKfwClszjOPlEP4hvADwPp8gxU4R9/3jYFIYSOI8KT4FCMcNOgDc0OvtJH+SvNq6po
         aKtCAKc7GRQQw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 0/2] mt76: avoid mcu_restart function pointer
Date:   Mon, 23 Jan 2023 11:55:27 +0100
Message-Id: <cover.1674471203.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
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

Avoid mcu_restart function pointer whenever it is possible.

Changes since v1:
- rebase on top of mt76 tree
- drop already merged patches

Lorenzo Bianconi (2):
  wifi: mt76: mt7996: avoid mcu_restart function pointer
  wifi: mt76: remove __mt76_mcu_restart macro

 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 45 +++++++++----------
 2 files changed, 22 insertions(+), 24 deletions(-)

-- 
2.39.1

