Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A919A6DF16D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDLKBp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDLKBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 06:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A3076B7
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 03:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A006C62D5C
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 10:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221EBC433D2;
        Wed, 12 Apr 2023 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293687;
        bh=vGpPRHSc8ZffrKJ/mbrxrrpaOdGMrHu7FQNPIsAjjMQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gLcseSvo2jn2tXYrpc/8R0ZSjPUekxZKfG9Ubm0imOFhr0Z3Dyb1BbJC48pGXSGfK
         NkndqH6OTHQoi8BPXbq1ko2vk6CO66CKITwSrgMELNQzXIl02YQixDsa5mNkr5xsm4
         /J7e29El1SnuNHY3pnBXQDzCGk5o1RlgZEUWaEWqMznKIEyS333C1DeMrc/IVOseF+
         Td3vM9vwD1JjuGyUsNrOt2XbW+4RboHnTkqcqQeWb9jKE1R0KqWXEuV58Rei5EZnWE
         Q4Qmtyks01Vjt90q+pqB9FCx1d4Advr3wm3zhRpprm9mxp+6QPF+02v7yLo5ohxl5Z
         4DAZWM6go817g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Send 11d scan start before
 WMI_START_SCAN_CMDID
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230315161817.29627-1-quic_mpubbise@quicinc.com>
References: <20230315161817.29627-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168129368423.14673.5586980853495473147.kvalo@kernel.org>
Date:   Wed, 12 Apr 2023 10:01:25 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Firmwares advertising the support of triggering 11d algorithm on the
> scan results of a regular scan expects driver to send
> WMI_11D_SCAN_START_CMDID before sending WMI_START_SCAN_CMDID.
> Triggering 11d algorithm on the scan results of a normal scan helps
> in completely avoiding a separate 11d scan for determining regdomain.
> This indirectly helps in speeding up connections on station
> interfaces on the chipsets supporting 11D scan.
> 
> To enable this feature, send WMI_11D_SCAN_START_CMDID just before
> sending WMI_START_SCAN_CMDID if the firmware advertises
> WMI_TLV_SERVICE_SUPPORT_11D_FOR_HOST_SCAN service flag.
> 
> WCN6750 & WCN6855 supports this feature.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e89a51aedf38 wifi: ath11k: Send 11d scan start before WMI_START_SCAN_CMDID

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230315161817.29627-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

