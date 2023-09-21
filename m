Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D1D7A9D2F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjIUT31 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjIUT3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6EBA9EF
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080BEC43391;
        Thu, 21 Sep 2023 06:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695277821;
        bh=dKmYQDeeA+4tWlPl/hXjWoF4/bbTVRwllO7onRmJL+0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eLzh8Ig4u72Uj2sGFguKUGAtHu4czACt/T77ipE49xeulYAOZPm08CiOeJqqgYU07
         k/OoczkUaVyS/hdwVPjD+7c6r+kauadhqLQZeVdyPoL7jGTKD9vBDHF9l3500IzDvT
         +wi54E72bHId0TJRH07mY/p2n/t1BAJcfk0VomMbTG0dMMIhjYYtE3Cl5UilW4le9J
         cIz34FohzW77hacdkZu2YO4xZ1Y7jZsnrORmYLXV5onzVjesm6anyWXbGUtoVtNbko
         Lu8aIezMtKcDtzUddL6kNOeL9LZ1z73xvNHsLKY6NZJ9xuio7b6Ys0clE0Av9Gkl/1
         a/Zq5kywfpZFg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] wifi: wilc1000: add back-off algorithm to balance tx
 queue
 packets
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915175946.4361-1-prasurjya.rohansaikia@microchip.com>
References: <20230915175946.4361-1-prasurjya.rohansaikia@microchip.com>
To:     <Prasurjya.Rohansaikia@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <claudiu.beznea@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169527781889.1469888.3059237937183223820.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 06:30:20 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Prasurjya.Rohansaikia@microchip.com> wrote:

> From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
> 
> Add an algorithm to backoff the Tx Task when low memory scenario is
> triggered at firmware. During high data transfer from host, the firmware
> runs out of VMM memory, which is used to hold the frames from the host.
> So, adding the flow control delays the transmit from host side when
> there is not enough space to accommodate frames in firmware side.
> 
> Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless-next.git, thanks.

a08bb28f6eb6 wifi: wilc1000: add back-off algorithm to balance tx queue packets

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915175946.4361-1-prasurjya.rohansaikia@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

