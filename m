Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422E76D47F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjHBRBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 13:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjHBRBQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 13:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4021722
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 10:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC3461479
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 17:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF67C433C9;
        Wed,  2 Aug 2023 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690995670;
        bh=9poAHubW0lfhHnO2RdeD/r6F4kxYduzOpSWyHYRXlJg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dZ5Xm6EQ1O7O9lZUByBx0Y/DBhzK70k966kY8o08Sf5xE+62plO20mZrHj6cqbU6G
         OybJAm42jRhfM0CNVPxMjknpCQsehLPQAMj1ENuh7yoFD5J6nX27WaBa3mtzStw8iU
         HYqak/nWlDOUfULuwA/yGW2e6akt7qxMrA6Fuvsvg1uKiYuq/JTN6GS76aXqRBhYFi
         CpwW9Wk9xA+Xo8Q4mw7KYbnsxOH/+E9RspF9J6Anx8MzolDeq1cbHcAQZVTKe7zzOj
         1yP2y/jj+4/A0fZfk0a6KV2J7m3BOoY/oxsA4hwdgaZeClwJKQlux2M0YcJH8qPCfa
         a9vMHAKCbP/bw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: change to use dynamic memory for channel
 list
 of scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230717033431.21983-1-quic_wgong@quicinc.com>
References: <20230717033431.21983-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169099566749.463701.15800758617469545708.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 17:01:09 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Currently there are about 60 channels for 6 GHz, then the size of
> chan_list in struct scan_req_params which is 40 is not enough to
> fill all the channel list of 6 GHz.
> 
> Use dynamic memory to save the channel list of scan.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3742928a52d6 wifi: ath12k: change to use dynamic memory for channel list of scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230717033431.21983-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

