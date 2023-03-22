Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109B6C4738
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 11:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCVKHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCVKHC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 06:07:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C0580F7
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 03:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFE06B81A0A
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 10:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C12A7C433D2;
        Wed, 22 Mar 2023 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679479618;
        bh=wCJnJTR4oGvE/EPFhoBPtcrLE7Op0BsLuBzqdLDvQ2s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tQK2RFOGRqNNHlCUenv/YgvqIPKllJ7OFCJKHUo40E63fWJ5A7e1WWtO+D2WUywUg
         YZPRk6wyqYgJ96D2+QU4IMrI1fTmQjBZvILaWFXAX4GFeEbfFsEHhk/pAUdkMimoI3
         N8dZFl9KjHAByKAIWkivqe3R3nE3sUjjSRPYj4jliYtYUQup9C8sUpE367Flp2PNpB
         nknEQUu3ielxbTTMaiZDT02C7nExxDCm4W+iXVUtQTA1319SyRvYlUvmNa6F2+EHQn
         pfOV7YzoFNsut2mQW0Venry6hcouwPE0+NmG6+kkCNj5ovRwxrJGxp0C+UJcnHdtrd
         4aJsYWVITRVQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: Enable IMPS for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230317062533.18240-1-quic_bqiang@quicinc.com>
References: <20230317062533.18240-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167947961588.29931.6965015392105440936.kvalo@kernel.org>
Date:   Wed, 22 Mar 2023 10:06:57 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> To reduce power consumption, change idle_ps to true to enable
> Idle Mode Power Save (IMPS) for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

72d17c3e86d0 wifi: ath12k: Enable IMPS for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230317062533.18240-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

