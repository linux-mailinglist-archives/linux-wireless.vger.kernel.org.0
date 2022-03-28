Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22604E95C4
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbiC1Ly7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbiC1Lyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 07:54:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3693B02B
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 04:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B294BB80EAE
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 11:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA04C004DD;
        Mon, 28 Mar 2022 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648468205;
        bh=x9eKyuj2KmrT7dFpC0fUVZrekzKi7+BNPmEVT2exOK0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hmmJNrjsVxR2lMahV4w1UzWvSzvDm+OY66Y0nIRwp0Szk9qx37wNZHA0gL3US453d
         kctXdoMDRIGLW4HNAq531f9cAjXCX3tT9Q7RjU/l0m4kOk68u1NsopxB5CeqRCubse
         GNkYmN8FWdFGOf0YmZ5nbCzCMnRuJo4Wy0HOtj4ovSopXQUGKdt+x1lJbmbqZMKCiB
         ZiooffZBAlS/PFsX8OZjfIOnMG84xdIbftJB/DSkH+hwOxohhPvzLhXGZZp0tfTphB
         ngMSJp6Qst6nTRyDKMDxeOJ54/AmOifrXZFT7CvFmYnc15kjNpBHOgYhL6HIcprO2H
         79nxoUk0K2XGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: store and send country code to firmware after
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220324011856.11014-1-quic_wgong@quicinc.com>
References: <20220324011856.11014-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164846820213.31335.9001260494172365360.kvalo@kernel.org>
Date:   Mon, 28 Mar 2022 11:50:04 +0000 (UTC)
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

> Currently ath11k does not send the country code to firmware after device
> recovery, as a result the regdomain info is reported from firmware by
> default. Regdomain info is important, so ath11k also need to restore
> it to the value which was used before recovery.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b2beae327e03 ath11k: store and send country code to firmware after recovery

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220324011856.11014-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

