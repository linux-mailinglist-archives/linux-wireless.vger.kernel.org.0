Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382D5E8C6B
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIXMby (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIXMbx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 08:31:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9271022B29
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 05:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CC7CB80D1E
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 12:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E9C433D6;
        Sat, 24 Sep 2022 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664022709;
        bh=ms44idjvGuiZltrBs09GQh0HkhmKtdI8UOYh5ONZmwM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PabQl5sYwgEEjF2k0sEj2fdYYtF48gIa9Bfdw9vJCkf9/KA2lgo9LKEcbIXeUtfrK
         j/E0TROYxTkYLGaEEgN8Vxg9UsUNKQJzRQXu5NYC61mGPd87NHpW5CupdBruYu27MY
         CMmyx+KXN59FrqSyxaZTkU9YOhCzfwKwAnL0t+iizi48XcdEghdcyQcfzTi6HRDi9d
         8yYHrrErV1aS1dLedhVGe8NJxmd2l3hHecPXcig2hsGXiK3/62i0+T+q4BhVwxBYIH
         rw6V+mi5TQRF5rlMHmlkd8aKdmQw3WSe4dcGn6QIx6MWfGVc1MdQ2/2iex/ilbGvgg
         /ybx8qAnVKvQA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [v3,01/16] wifi: rt2x00: define RF5592 in init_eeprom routine
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <d7eccb2c7b8ec4cd360fa2007796abffc35abb0d.1663445157.git.daniel@makrotopia.org>
References: <d7eccb2c7b8ec4cd360fa2007796abffc35abb0d.1663445157.git.daniel@makrotopia.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166402270428.7040.13730201639422300853.kvalo@kernel.org>
Date:   Sat, 24 Sep 2022 12:31:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Daniel Golle <daniel@makrotopia.org> wrote:

> From: Tomislav Požega <pozega.tomislav@gmail.com>
> 
> Fix incorrect RF value encoded in EEPROM on devices with Ralink Rt5592
> PCIe radio (a single chip 2T2R 802.11abgn solution).
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

16 patches applied to wireless-next.git, thanks.

3fdff7e08117 wifi: rt2x00: define RF5592 in init_eeprom routine
47c40fd2440e wifi: rt2x00: add throughput LED trigger
d7320a377168 wifi: rt2x00: add support for external PA on MT7620
685bcf2f9a13 wifi: rt2x00: move up and reuse busy wait functions
26d76c370f69 wifi: rt2x00: add RF self TXDC calibration for MT7620
bdcac97f143e wifi: rt2x00: add r calibration for MT7620
c8ce49ff0b83 wifi: rt2x00: add RXDCOC calibration for MT7620
ab7b2295732f wifi: rt2x00: add RXIQ calibration for MT7620
d3aad83d05ae wifi: rt2x00: don't run Rt5592 IQ calibration on MT7620
dab902fe1d29 wifi: rt2x00: add TX LOFT calibration for MT7620
79b4c9455e0b wifi: rt2x00: move helper functions up in file
d5ed439cf00a wifi: rt2x00: fix HT20/HT40 bandwidth switch on MT7620
eeb50acf1576 wifi: rt2x00: set correct TX_SW_CFG1 MAC register for MT7620
0e09768c0857 wifi: rt2x00: set VGC gain for both chains of MT7620
cbde6ed406a5 wifi: rt2x00: set SoC wmac clock register
c9aada64fe64 wifi: rt2x00: correctly set BBP register 86 for MT7620

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d7eccb2c7b8ec4cd360fa2007796abffc35abb0d.1663445157.git.daniel@makrotopia.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

