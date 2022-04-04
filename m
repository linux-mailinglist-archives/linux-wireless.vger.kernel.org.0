Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8B4F0FE1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 09:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbiDDHRS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 03:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiDDHRR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 03:17:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1121E3E2
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 00:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7247CB80E83
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 07:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3A9C2BBE4;
        Mon,  4 Apr 2022 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649056519;
        bh=33JNaffd8otlV35YViy6jbj0lroij12UsvFEKWkDUX0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sW9LQZuy5V2Si3gEkIjeOIOiAQBRX6aglO6grAFRG9O9pw26ieOEBWrtM/X2XyeUA
         eTrLOm6sfxpud/rFZx77fief7nxdJfWg0TaSuol3rGNGNh7axFCk+uyvlqw6Sh5Xmt
         4QmBhgWbaF12XqC8LOdIE8xuMEphoME2LZuTP3HNYcZtTdCV8efS0HuBZh1u5j4Pn1
         RejfZws/kQPA5ByQGubSq4MBHsR854bYJmaAxGH2nBkhrVGsFugQOpcWuO8aTgowEM
         hLfMvBSnmCWsNszYkZ0hiWfrfvNeJ0eG9LoNbba7keXTZdo71DQWcQ8ecyTB2TMGPj
         EigQjLnCGK36Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] ath10k: add encapsulation offloading support
References: <20220402153615.9593-1-ryazanov.s.a@gmail.com>
Date:   Mon, 04 Apr 2022 10:15:15 +0300
In-Reply-To: <20220402153615.9593-1-ryazanov.s.a@gmail.com> (Sergey Ryazanov's
        message of "Sat, 2 Apr 2022 18:36:12 +0300")
Message-ID: <87v8vps4jg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Ryazanov <ryazanov.s.a@gmail.com> writes:

> Hello,
>
> this series introduces driver support for hardware encapsulation
> offloading feature.
>
> The main goal of the series is an overall improvement of system
> performance. On a QCA9563+QCA9888-based access point in bridged mode,
> encapsulation offloading increases TCP 16-streams DL throughput from
> 365 to 396 mbps (+8%) and UDP DL throughput from 436 to 483 mbps (+11%).
>
> The series consist of three patches, the first two prepare the code, and
> the last one introduces the offloading support itself. The first patch
> reworks transmission status reporting to make it flexible enough to
> support 802.11 and Ethernet encapsulated frames reporting. The second
> patch reworks the module parameter that configures the main
> encapsulation format of frames that are passed from the driver to the
> hardware. It makes it possible to configure more encapsulation methods
> than just raw or not-raw. And, as stated before, the third patch
> actually introduces offloading support. It changes a couple of frame
> analysis places along the xmit path and starts reporting offloading
> support to mac80211 via the corresponding hw attribute.
>
> The new feature has been extensively tested with QCA9888 and works well,
> but it may introduces some regression for other untested chips. So the
> series is just an RFC for now.

This looks very good to me. But the testing part concerns me as well, it
would be good to have some quick testing at least with QCA6174/QCA9377
PCI devices to make sure we don't break those. Preferably also
QCA6174/QCA9377 SDIO devices should be tested, they work somewhat
differently. Can anyone help?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
