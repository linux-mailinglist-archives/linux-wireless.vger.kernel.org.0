Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6624DDD4A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 16:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiCRPwG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Mar 2022 11:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiCRPwG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Mar 2022 11:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7002EAF43
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 08:50:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E932A60AF7
        for <linux-wireless@vger.kernel.org>; Fri, 18 Mar 2022 15:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99892C340E8;
        Fri, 18 Mar 2022 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647618646;
        bh=z9ElKH/RPJ8dL6ucObv3OjEkF6xDUpmy50+aWINS/t0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pCE+1ifPe3yI5D4B1URHeIbCjWDCQz3EL6E4xqrNO+pqvqi8CUy/Pfc4mkZ02/P7w
         RWcFMNuDx4c0ZH3Uh2v3ctgJfuYk2te/q2NO1MuTsWOC/sdqsiE35N0E+aNe2WpJph
         ZINFmtJdSutwIFYR6STciopg7RrTVjNGXIT5+hR8pNso8cTlNKHhZbZ69OTZeR2QrT
         YzL9F+5IfVR2xgc4xernihANYAkUxf99Ehg3jh1Qt/AurITA+wZ6Ddt5e1zv1pAn7Q
         mVHnYYOnKyg4vyVZwd865avHb/WcleYaqOvCk2X7J/sLfHvKYeVB3zF3FQlpq0jo4t
         +LEhkqSrkD3jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Add support for SAR
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220317012728.18932-1-quic_bqiang@quicinc.com>
References: <20220317012728.18932-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164761864196.8951.13534371903381562941.kvalo@kernel.org>
Date:   Fri, 18 Mar 2022 15:50:45 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops,
> and this function is called when user space application
> calls NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR
> type and frequency ranges to wiphy so user space can query
> SAR capabilities.
> 
> This feature is currently enabled for WCN6855.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

What did you use as the baseline? I could not able to find an ath- tag to which
this patch would apply. I strongly recommend using --base, that way I don't need to
waste time trying to guess what was the baseline.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220317012728.18932-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

