Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2DE543A73
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 19:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiFHRbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiFHRbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 13:31:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EAD262
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 10:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31617CE2A89
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 17:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BCFC34116;
        Wed,  8 Jun 2022 17:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654709462;
        bh=QbcyWsGQ9KyrU9tJ8M0OMYhG79eUIdjiXxT637ZpXmg=;
        h=From:To:Cc:Subject:Date:From;
        b=EIM+CCjuQj+DBiNlA8t0SV+rTr416E9Dh9UwNkrBuqPQRttvFoYTyjbXd2uIU0vhm
         f1B2M9K25tQKP6u+dnJDrhvHQ+YekHERCShk0TrFgm/XW2h2uge40sYHJqOyxntuQc
         aXtN9csnwalKvAssaYRCxUJ8wbSF4wbqrw6UGh//YQ2wyyhC+TwAVZVPhB8QjI5zU/
         qIm40JEpSTd0g0OT9iqKH+SgoEYvZAXcpSvzfNhSNPNBby/tsceJ7sJzmzAuqJQczs
         ZhZpOiszVMP85uv3Y132FE+rvYC6+yIxi5xzoevbhp+/POf3tm9mHj9Cu5JlGEXkJs
         CMpEACg2kXilw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 0/3] mt76: move rx connac2 shared code in connac module
Date:   Wed,  8 Jun 2022 19:30:28 +0200
Message-Id: <cover.1654709072.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to tx counterpart, move mac rx shared code between mt7921 and mt7915 in
mt76-connac module.

Lorenzo Bianconi (3):
  mt76: connac: move HE radiotap parsing in connac module
  mt76: connac: move mt76_connac2_reverse_frag0_hdr_trans in mt76-connac
    module
  mt76: connac: move mt76_connac2_mac_fill_rx_rate in connac module

 .../net/wireless/mediatek/mt76/mt76_connac.h  |   9 +
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 142 +++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 368 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 381 +-----------------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 139 -------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 360 +----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 136 -------
 7 files changed, 554 insertions(+), 981 deletions(-)

-- 
2.35.3

