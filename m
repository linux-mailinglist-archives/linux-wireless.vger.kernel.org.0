Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB255AAF19
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiIBMdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiIBMcJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 08:32:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31A9D8B1B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 05:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9B1FB82A9B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 12:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C3C433D6;
        Fri,  2 Sep 2022 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662121642;
        bh=CgLnuouAB0vCyz3vDvXg4KuFUnRYa9HnnlVwJvFlqv0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gTMKyCNlsVgaMNY0T7ffNEF1KIA4QdXETjwQBeZq7sZtWPAjHaBfhtaAw385nsaUc
         L6C3M62ewoe+iLnW8mKPQZHKqNeqhawKUEc4hrfC4KgTCI5RB5kUbn7IIYcwJaF8it
         AcBWmUpqqOoJYMh8OjwPJPChnEpfax7iyo2AWmfFgoimvDFKtdu4fkBAVvGusbjRqM
         KR7mqdQgyd0wHg16m7s1VoaY1xmN3OvIkpWfJPBodsB/R2wwd8EXqF0tC4+Uck/eVP
         3nMgBqgp8OJEOJeB8oA4J53TMvX+h7UnCCCq2zL6Wiw8KJABUCLjk8R9Tesq6g8Q68
         XEBwonkY0UD0w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath11k: Add TWT debugfs support for STA interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220720135150.22193-2-quic_mpubbise@quicinc.com>
References: <20220720135150.22193-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166212163953.9935.11315879224878748482.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 12:27:21 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Currently TWT debugfs files required for manually testing the
> TWT feature are created only for the AP interfaces; these debugfs
> hooks are also required for the station interfaces in order to
> test the TWT feature manually, therefore create these debugfs
> hooks for station iftype as well.
> 
> In the case of station interfaces, TWT is entirely handled in the
> firmware based on input parameters passed to it during association
> via TWT enable WMI command. In order to manually test this feature,
> firmware expects to first disable the TWT feature and then send the
> enable command with sta_cong_timer_ms parameter set to 0.
> This is true for WCN6750, QCA6390 & WCN6855 hardwares.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

9e2747c31e5a wifi: ath11k: Add TWT debugfs support for STA interface
607c467eac7d wifi: ath11k: Fix hardware restart failure due to twt debugfs failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220720135150.22193-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

