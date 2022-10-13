Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAAA5FD49F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJMGUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 02:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJMGUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 02:20:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA85120BFC
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 23:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90E8961703
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 06:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A3AC433D7;
        Thu, 13 Oct 2022 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665642029;
        bh=SX1tJx6PksBjMTylR2yTzCL3/MT4x3kaF/Nzi8ybxCQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jvEdbDpapPyxsUIS/h4btIoqCYUMgBtVeztg+vcnXML1fgTb1D9SkwHgwWM1exO/g
         AS6/JpoqjSzHP/crMcCDvDNzIGI9uNDu4vFaO5SZTsNpzQnBAgt+xovOPRHJzCa15r
         j3JszvMbVQr6hVsLR78BnNIDZUatkoXujVV2HNI7ecQV9fo3Qf6kGjhayYPwFg/03l
         9+A75DXLTTgeyZFJIhp9Tt1t+hXNPC8ss/Bk4358UW/7DcqqI3uwHfLS85JOKunRaG
         LOaKCNtjFxMS1QiXFRnix6VVaZIZXHbO9i61VviSMLJTSh2oB5HUwURZPtbf0YKVWx
         sBzBi9KL79q6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix firmware crash on vdev delete race condition
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221011095346.3901-1-quic_ssreeela@quicinc.com>
References: <20221011095346.3901-1-quic_ssreeela@quicinc.com>
To:     Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166564202593.7747.2576198553366967666.kvalo@kernel.org>
Date:   Thu, 13 Oct 2022 06:20:27 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com> wrote:

> Current code does not wait for vdev delete completion on vdev create
> failures and tries to send another vdev create followed by vdev set
> param to firmware with same vdev id. This causes firmware crash.
> Fix this crash by waiting for vdev delete completion on vdev
> create failures.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.6.0.1-00905-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3811fa1f231f wifi: ath11k: Fix firmware crash on vdev delete race condition

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221011095346.3901-1-quic_ssreeela@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

