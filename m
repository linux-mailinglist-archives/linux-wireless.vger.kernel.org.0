Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6656E4502
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQKSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDQKSR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 06:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61572698
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 03:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBD13619CB
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 10:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093FBC433D2;
        Mon, 17 Apr 2023 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681726554;
        bh=BoWLgyjpa03Gf/MUIqi36FWdFoNOD1x6WzPGN7MDxsk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r0Pb/F5e24dWHomrRigt8nuU00IEuThB2GcW3ofoekj9tm3UP1PrM8g7vcia0LOYy
         ZN7k9UrpisRMzA79wWzLvOdphMEP5id1lo/rXUebcqSxF6IBi/MhkrME17TcxXTJvy
         UnIWX82MhVGwaslcp58mFcCHia3HNUG9SS0IGkzc+XGMrR2M9T+Y64RZhCNj2Lfi1P
         3y3/ePQ28m6JSowDYtFSuj5Gghy7MI1LCywhfjQatN9RmYaGvZVnW7z/bPwauNXGE8
         NXQQUNpoNRwTSztJW4beK6sagxsm6/A+UtxSRc+GElepmJDgtupsW2XCFXCz/HYRDf
         rF+2fl+9dsVZg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Add SAR support on WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230328113455.11252-1-quic_youghand@quicinc.com>
References: <20230328113455.11252-1-quic_youghand@quicinc.com>
To:     Youghandhar Chintala <quic_youghand@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <--cc=linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172654895.12889.1342006760262786492.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 10:15:52 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Youghandhar Chintala <quic_youghand@quicinc.com> wrote:

> Currently, SAR is enabled only on WCN6855, enable this for WCN6750 too. This
> functionality gets triggered, when the user space application calls
> NL80211_CMD_SET_SAR_SPECS.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

abf57d84973c wifi: ath11k: enable SAR support on WCN6750

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230328113455.11252-1-quic_youghand@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

