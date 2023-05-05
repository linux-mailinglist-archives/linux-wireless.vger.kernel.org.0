Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ACF6F8267
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjEEMAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjEEMAP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 08:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9B21C0FC
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 04:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 969E563D84
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 11:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47141C433EF;
        Fri,  5 May 2023 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683287991;
        bh=u7YjGOVJ51nC3ZY+Zve7cxEX8PTfX8jPvMJ5jhGl5YE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sF9JY6p/fIB1CePAWKqAKtdlol5uVEzAbhw2fJMeh6+eciQQGiPIplF2NH+jJzHkz
         RrSBmo4/TbZdASzASuORO8gPdWHU6VCf5HDejGpk5mqStMhvKknEwcrMnefpCBmwdQ
         x1k6KC6Bwen9F2LJEaiFP3Hh+DcdwGk3GaAlwM9LNBj/JeOhhpl//cLamGMJQ6ErhI
         cu1zqXBh9nqT4sug1urxsdmIpMqEBDZirVAql+CleQ+Xyt2pPg4H1MpAnbbDetSku9
         pAyJIn7WqcYbs1Wd2nOVlQzEk/J0TrLzX/+e1PdE+wl7wJq7RoXGjOzdYJnuG3afrN
         Jgcm2tfsKsZ+Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: release bit in
 rtw89_fw_h2c_del_pkt_offload()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <8cf5d45c5b04e7b680d4eb9dda62056cdce14cec.camel@realtek.com>
References: <8cf5d45c5b04e7b680d4eb9dda62056cdce14cec.camel@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168328798823.30117.8603596845633913823.kvalo@kernel.org>
Date:   Fri,  5 May 2023 11:59:50 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> We have a pair of FW functions, rtw89_fw_h2c_add_pkt_offload() and
> rtw89_fw_h2c_del_pkt_offload(). The rtw89_fw_h2c_add_pkt_offload()
> acquires the bit itself, but the bit needs to be released by the
> caller of rtw89_fw_h2c_del_pkt_offload(). This looks asymmetrical
> and is not friendly to callers.
> 
> Second, if callers always releases the bits, it might make driver
> unaligned to bitmap status of FW after some failures of calling
> rtw89_fw_h2c_del_pkt_offload(). So, this commit move bit release
> into rtw89_fw_h2c_del_pkt_offload().
> 
> In general, driver will call rtw89_fw_h2c_add_pkt_offload() and
> rtw89_fw_h2c_del_pkt_offload(), and then, SW bitmap can align
> with FW one. There is one exception when notify_fw is false.
> It happens when driver detects FW problems and is going to
> reset FW. Only in this case, driver needs to release bits
> outside rtw89_fw_h2c_del_pkt_offload().
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

25a7e5072ef1 wifi: rtw89: release bit in rtw89_fw_h2c_del_pkt_offload()
3ea1cd8d027f wifi: rtw89: refine packet offload delete flow of 6 GHz probe
8febd68be526 wifi: rtw89: packet offload wait for FW response
32bb12eb73dc wifi: rtw89: mac: handle C2H receive/done ACK in interrupt context
b9b632f43f1c wifi: rtw89: scan offload wait for FW done ACK

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8cf5d45c5b04e7b680d4eb9dda62056cdce14cec.camel@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

