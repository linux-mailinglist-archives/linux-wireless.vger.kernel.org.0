Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660DF53030B
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbiEVM2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiEVM2I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 08:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB30A3CA65
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 05:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45A1F60FBE
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 12:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDE3C385AA;
        Sun, 22 May 2022 12:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653222486;
        bh=Gr6lYAsULYInKXakt5MSXApQOLKEm9j6nKisVE6yrMg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=b2BVJAEeOC+9I1zZfh0k1UCp7EJHWSHs1NSRhe9dsY/AiIH7RDpSm69Ba6cNTPrDJ
         Kh3fVyRoIj72dNbEHtrZQyPWiZJevloeT/mpOA7Ox8zDDYaa717VEAgOHSQgYvk3H+
         kvtubdfDgN6FXBtF7o+/HumxrquwnmtmfmH3NSWh63zmMdZxFfOoHkG4pSXaeugcx5
         MjbWofwIiyPKIZ26oWklLqp0x0BHTfxhR3paKrFNnuEkn14wp4cJyl4EEqYW5f0eim
         ddbUI6Gdcat1RcfZg7DwxDLaW+q8fZ/b2jPXrOpMh8BNBc5sktDkL5X8bUaYYiya+m
         evzhyDGFvCJBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] ath10k: improve tx status reporting
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220516032519.29831-2-ryazanov.s.a@gmail.com>
References: <20220516032519.29831-2-ryazanov.s.a@gmail.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Edward Matijevic <motolav@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?utf-8?b?T2xkxZlpY2ggSmVkbGnEjWth?= <oldium.pro@gmail.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Zhijun You <hujy652@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165322248212.774.8451941042648724092.kvalo@kernel.org>
Date:   Sun, 22 May 2022 12:28:04 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:

> We use ieee80211_tx_status() to report each completed tx frame.
> Internally, this function calls sta_info_get_by_addrs(), what has a
> couple of drawbacks:
> 1. additional station lookup causes a performance degradation;
> 2. mac80211 can not properly account Ethernet encapsulated frames due
>    to the inability to properly determine the destination (station) MAC
>    address since ieee80211_tx_status() assumes the frame has a 802.11
>    header.
> 
> The latter is especially destructive if we want to use hardware frames
> encapsulation.
> 
> To fix both of these issues, replace ieee80211_tx_status() with
> ieee80211_tx_status_ext() call and feed it station pointer from the tx
> queue associated with the transmitted frame.
> 
> Tested-on: QCA9888 hw2.0 PCI 10.4-3.9.0.2-00131
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Tested-by: Oldřich Jedlička <oldium.pro@gmail.com> # TP-Link Archer C7 v4 & v5 (QCA9563 + QCA9880)
> Tested-by: Edward Matijevic <motolav@gmail.com> # TP-Link Archer C2600 (IPQ8064 + QCA9980 10.4.1.00030-1)
> Tested-by: Edward Matijevic <motolav@gmail.com> # QCA9377 PCI in Sta mode
> Tested-by: Zhijun You <hujy652@gmail.com> # NETGEAR R7800 (QCA9984 10.4-3.9.0.2-00159)
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

2587d5198aa5 ath10k: improve tx status reporting
70f119fb82af ath10k: htt_tx: do not interpret Eth frames as WiFi
a09740548275 ath10k: turn rawmode into frame_mode
af6d8265c47e ath10k: add encapsulation offloading support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220516032519.29831-2-ryazanov.s.a@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

