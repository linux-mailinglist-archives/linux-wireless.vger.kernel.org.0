Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE725BC613
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiISKJW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiISKJP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:09:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587DE237C4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 03:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4537B80B31
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 10:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4281BC433C1;
        Mon, 19 Sep 2022 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663582151;
        bh=wu9PhEwqplD47bFcvlR5s1vacQQ7TmZ98w6otRd5H7w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NVQirFPz5XrfzfdwcadSRi3UyCdLER8HFEAump8vTPwmBsZ4yfLvfegSM0/44Nghg
         TUqDosAce0dCYkq0fqkuv2w18A4SGjJXpbisspdJZVnxetpZjKjR08EDJi0hazwcb+
         9zoJaQdpR0+lBCZtl6nnVo3Rd5wcvkXfFjuX8N0tCV0Rmw2G9p7CE6SKy/4aa4MuOv
         r1vm3Cg/Q4CnnSw59kd+mfkT32a4UH+cCQZXs+h6U0DU+lXJgeIyxUu+E6MNqGjRGd
         F8m4jKesD/RJ+LIPslSbfkm76T+kxvCckvE8rQMfWT+DQx3PBMNA2Zk+UDCJUN9yjd
         TvAoPtMT0wXpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] wifi: rt2x00: Fix "Error - Attempt to send packet
 over
 invalid queue 2"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220908173618.155291-2-hdegoede@redhat.com>
References: <20220908173618.155291-2-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358214839.24821.10030211183220172513.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:09:10 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> Even though ieee80211_hw.queues is set to 2, the ralink rt2x00 driver
> is seeing tx skbs submitted to it with the queue-id set to 2 / set to
> IEEE80211_AC_BE on a rt2500 card when associating with an access-point.
> 
> This causes rt2x00queue_get_tx_queue() to return NULL and the following
> error to be logged: "ieee80211 phy0: rt2x00mac_tx: Error - Attempt to
> send packet over invalid queue 2", after which association with the AP
> fails.
> 
> This patch works around this by mapping QID_AC_BE and QID_AC_BK
> to QID_AC_VI when there are only 2 tx_queues.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

f2c6e7ca3ee6 wifi: rt2x00: Fix "Error - Attempt to send packet over invalid queue 2"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220908173618.155291-2-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

