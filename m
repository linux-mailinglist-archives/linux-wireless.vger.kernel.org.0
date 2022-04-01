Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF34EE89A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245708AbiDAGox (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 02:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344630AbiDAGon (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 02:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23411DEA2
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 23:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15D561181
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 06:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEB5C2BBE4;
        Fri,  1 Apr 2022 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648795374;
        bh=zpGusPb2GLs2SQoY5se99PFqzVJuoqfex/4tGGoevZc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=N5Ea4BGxpsw//UFyoH62ycEWvEBiVAwoIF/FMoLgiTcBr35nPlxCu/4w1ajovK6it
         q8nCzxUemFlnigkoxMohwSc1R7/EzPDwgaVf2bGWpQW/aZz1If1WqsaXZkHPLG9gzv
         7p+nK24AbO5YU78uh4toUeIjwj3G0sEdQ1o+E1F+xd8lQpfYBvO7MGU5PRNcfARMTV
         2Xa/T/cJ2V7u09zR2iuqmjjqkHFA4t2qo0Eta6q8NVLhWdEEciK1zoqAR2Z2OcmxLT
         Me/RxBVhqUduZumeF+rglptocwaFPwB+4qhatlw/2QoQ+oo/BKdDChohRzUzhjFOdL
         r6R9m83J9HFxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.18] Revert "ath11k: mesh: add support for 256 bitmap in
 blockack frames in 11ax"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1648701477-16367-1-git-send-email-quic_akolli@quicinc.com>
References: <1648701477-16367-1-git-send-email-quic_akolli@quicinc.com>
To:     Anilkumar Kolli <quic_akolli@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164879537083.4811.14737896570748276541.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 06:42:52 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <quic_akolli@quicinc.com> wrote:

> This reverts commit 743b9065fe6348a5f8f5ce04869ce2d701e5e1bc.
> 
> The original commit breaks the 256 bitmap in blockack frames in AP
> mode. After reverting the commit the feature works again in both AP and
> mesh modes
> 
> Tested-on: IPQ8074 hw2.0 PCI WLAN.HK.2.6.0.1-00786-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>

I'll add:

Fixes: 743b9065fe63 ("ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax")

It's not clear for me if reverts should have the Fixes tag, but to be on the
safe side I'll add it.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1648701477-16367-1-git-send-email-quic_akolli@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

