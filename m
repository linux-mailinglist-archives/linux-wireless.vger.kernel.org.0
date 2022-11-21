Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313CD6328C6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiKUP5L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 10:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiKUP5K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 10:57:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD4CB966
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 07:57:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 315D5B810E5
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 15:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47687C433D6;
        Mon, 21 Nov 2022 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669046226;
        bh=VA/Ub/T6G0dvtPxPA4A+MYTinZfP6nxhETy8kou7t98=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YaC1Zo/DgdB1BbgNZg4N8EzqLIEOtU0kGlUuWA+1C6nbXMWG3EzgusaGnpvneXIi6
         0E1Lv41oGZCcWrz2S5ol1RYzzvGdsBfZm12VKSUTPVuXggj9E75yIevYK5ePHJCb4N
         9v7WeMjJjXmEa/y1qlUa4uTon4nGDc19FByJSrmnsTOvbS3WfHwGVfm97z0VuHAA0w
         TROcfyDMLznkKhT2BRV0qIQAHkF6BliTsmN4nsguvoyJo5GG1RXVJXqfszhlkyLTFJ
         RUjrPSfMiOc4byQQmg7didVKoFuLuPPSn7z5fzw2fRkuIlC/SNkF9Qkii6DO/1KZj+
         YbBrnxlQBIdtQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: Re: [PATCH v2 00/50] wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org> (Kalle Valo's message
        of "Wed, 16 Nov 2022 18:38:12 +0200")
References: <20221116163902.24996-1-kvalo@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 21 Nov 2022 17:57:00 +0200
Message-ID: <878rk49u7n.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> ath12k is a new mac80211 driver for Qualcomm Wi-Fi 7 devices, first
> supporting QCN9274 and WCN7850 PCI devices.  QCN9274 supports both AP
> and station; WCN7850 supports only station mode. Monitor mode is not
> (yet) supported. Only PCI bus devices are supported.
>

[...]

> Unfortunately the firmware images are not yet available but they will be soon, the
> plan is to publish them any day now.

The firmware for WCN7850 hw2.0 is temporarily available here:

https://github.com/kvalo/ath11k-firmware/tree/master/ath12k-testing/WCN7850/hw2.0

Later I will create a proper place for ath12k firmware images. And
naturally submit them also to linux-firmware.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
