Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903637381B3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjFUJm3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 05:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjFUJls (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 05:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51F1BC6
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 02:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF050614DE
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 09:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49291C433B9;
        Wed, 21 Jun 2023 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687340491;
        bh=Am9NL8L9eEag9mpNcdUvp8YnrDJy7hNusrhJfo2GqhI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LS76cS7BsA5/uFMe/r+nt4tpgVB8lJvHfnrbcmntckvg/f3MMRzGot8+CidSd7m7I
         12xhEJKgHgJqwYMTMWnVyqYhJGaYb4wffRGxFcNhVlJW1WYXIkmqb0CQn9juliq+MB
         tB4CKs1K2UYUqfvovaHxuLdYT/nkED85Ojwal+U4CIyjWUS88PlKHa85+HgNcbxglx
         B1MZvcJL1qbHyrbFVtC0205skE4fEj4DU1ov3SdYZFvWdUGLrAzzyhyZhfBFBSShDP
         Gyq0M3qpeapzHxp/HqkBzHm6D1l3hxcxI8GRIJJpF/IUOXRA0w8L2mtJzi7T+gYXlJ
         Xeg7mEQtRmbyQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: process VO packets without workqueue to
 avoid
 PTK rekey failed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230616031713.16769-1-pkshih@realtek.com>
References: <20230616031713.16769-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168734048798.380100.11902910174609581862.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 09:41:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> In the wpa_supplicant rekey flow, it sends an EAPOL packet 4/4 through
> nl80211_tx_control_port() and triggers wake_tx_queue() in the driver.
> Then, it sends nl80211_new_key() to configure a new key in mac80211.
> However, in wake_tx_queue(), a workqueue is used to process the tx packet,
> which might cause the driver to process the EAPOL packet later than
> nl80211_new_key(). As a result, the EAPOL 4/4 packet is dropped by mac80211
> due to the rekey configuration being finished. The EAPOL packets belongs to
> VO packets that need high priority. Therefore, we process VO packets
> directly without workqueue to ensure that packets can process immediately.
> 
> VO is normally used by voice application that is low traffic load and low
> latency, that doesn't affect user experience.
> We test iperf with VO packets(iperf3 -P4 -u -b 10000M -S 0xdf)
>                           before       after
> TX throughput             162M         162M
> ping RTT                  3.8ms        3.7ms
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

67d7f24b194e wifi: rtw88: process VO packets without workqueue to avoid PTK rekey failed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230616031713.16769-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

