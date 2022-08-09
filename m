Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3BC58D39A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 08:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiHIGPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 02:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbiHIGPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 02:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0D1F63F
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 23:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61D36611DC
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 06:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E15C433D6;
        Tue,  9 Aug 2022 06:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660025748;
        bh=k7OuGhnfskK7dll6V8t3jjANCTkSpibWPAEjmEo2dHA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HycFWDhiEN0sC++XhgJIpjbsg35hqKJt0/DKXHRF7tq+dxKWVgyG5oJnRNhzizy+H
         GSsRlhsd2BUJZz0ye6lDPXr40lY51hAuqEnSg9S/SF+Yx0r/3RuXjfxMAa89BnjKPn
         07H7fC05YUCEysa6xLgze+6xPLF9EttmN4e+X+KvpkPQhB5Cq/xWIZylFIfiI4rHwx
         Xq1CoZ1iBpAPXJVMuKrkF/60AlzbXhu46TvxfU+GCoJ5/XXDuA98HWScXZjuRsbOpE
         nLSmtwAtUNGSFYYXoKG1r+dYggbtOtaesiAJNd32zmaCZOewa3y9pyTuwL7PRso/MR
         8XzD5HheKo6qQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi:ath10k: Set tx credit to one for WCN3990 snoc based
 devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220801134941.15216-1-quic_youghand@quicinc.com>
References: <20220801134941.15216-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002574373.17823.14670540192835891455.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 06:15:47 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

> Currently host can send two WMI commands at once. There is possibility to
> cause SMMU issues or corruption, if host wants to initiate 2 DMA
> transfers, it is possible when copy complete interrupt for first DMA
> reaches host, CE has already updated SRRI (Source ring read index) for
> both DMA transfers and is in the middle of 2nd DMA. Host uses SRRI
> (Source ring read index) to interpret how many DMA’s have been completed
> and tries to unmap/free both the DMA entries. Hence now it is limiting to
> one.Because CE is  still in the middle of 2nd DMA which can cause these
> issues when handling two DMA transfers.
> 
> This change will not impact other targets, as it is only for WCN3990.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d81bbb684c25 wifi: ath10k: Set tx credit to one for WCN3990 snoc based devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220801134941.15216-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

