Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393946E7C9D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjDSO2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 10:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbjDSO2g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 10:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B7D308
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 07:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD222637F4
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 14:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F01C433EF;
        Wed, 19 Apr 2023 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681914472;
        bh=gWx+QASjkKFafxQB5xDEyDa4ePFAJmevoPkXkrErHlE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=sL16OfcCytZToDgGENVBX+ixCL2tBubPsvP2YOacxBAdZrT/VEtcwt15hNQLC43Um
         zRBvdSzoDb0lqOf1Iu7VpjKbvIv8hrJX2+xfPoXt1hr8QjUYT5CV0bCTSqW0KgGi9t
         zXjr56llaXmT+EnE8eePFym0KnqlPrAzep8LpFMb+wW7VVdFusoYTk5iQdvXv+kQZP
         bkZuuIb5VK3B1DvBAP0fqJR67oQ7W9Gvb719jShzE2px3TMmHXj4xa/FUCHBwCX9I+
         CYF3eIsHRmAQixr6OZXmfdwfR5bCDWoneb2XSuchI6rSwHlrjFOcL8qG4p8A2YbNsr
         cLeyGHFbTlZ0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Remove disabling of 80+80 and 160 MHz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1681762947-13882-1-git-send-email-quic_msinada@quicinc.com>
References: <1681762947-13882-1-git-send-email-quic_msinada@quicinc.com>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168191446902.4082.1552676324698320209.kvalo@kernel.org>
Date:   Wed, 19 Apr 2023 14:27:50 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <quic_msinada@quicinc.com> wrote:

> This is a regression fix for 80+80 and 160 MHz support bits being
> cleared, therefore not adverised. Remove disable of 80+80 and 160 MHz
> capability flags and assign valid center frequency 2 similar to
> VHT80_80.
> 
> Fixes: 38dfe775d0ab ("wifi: ath11k: push MU-MIMO params from hostapd to hardware")
> Reported-by: Robert Marko <robert.marko@sartura.hr>
> Tested-by: Robert Marko <robert.marko@sartura.hr> # IPQ8074 WLAN.HK.2.9.0.1-01385-QCAHKSWPL_SILICONZ-1
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217299
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b100722a777f wifi: ath11k: Remove disabling of 80+80 and 160 MHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1681762947-13882-1-git-send-email-quic_msinada@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

