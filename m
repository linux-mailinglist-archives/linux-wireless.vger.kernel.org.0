Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361E24F290D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiDEIZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiDEISL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 04:18:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39438B6E55
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 01:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFA26B81B90
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 08:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F64C385A3;
        Tue,  5 Apr 2022 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649146032;
        bh=XIDDvt1ftw2GOb3RkcuJpSwO8lvCv8diT65itEWJWmw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NbV3g6fVVH04VzcmTLZbQajhr1aGT8QvHyjPqI2PuhRhoKBwFqBLl8YZgb5Zegsqh
         BjBiffb3Z/ve42oKYVdtcKkkpDlkYVwJ9mVcvAOD7zJizSZgzwNGrKJP8QF5506wE1
         moOvUG0+mYZjZxK3sCMykvGzFJ1whpWiC/PihDQ+X6gSpMaFYWXP2C5xWq/gVFykui
         QF1Z/PfbtPmSymdCPhxX05XTziKLGFd2ZzOFSa9Sz0YHL91VB2hwRat4ky7sGW7aEx
         OGTAbtHCDbmLL1cp8ICblJe6S3xxymmdmdIOMxAz3j1z4tYXFaSgdiEOESMJMPJ6qG
         MdDi3NKrPT+dQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] ath11k: PCI changes to support WCN6750
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220328055714.6449-2-quic_mpubbise@quicinc.com>
References: <20220328055714.6449-2-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164914602727.12306.5327755878544147353.kvalo@kernel.org>
Date:   Tue,  5 Apr 2022 08:07:11 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> In order to add the support for WCN6750 in ATH11K , it is
> required to move certain PCI definitions to the header file.
> As a result, add ATH11K_PCI_* prefix to these definitions.
> 
> Also, change the scope of certain PCI APIs that are required
> to enable WCN6750 from static to global.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

5 patches applied to ath-next branch of ath.git, thanks.

948171b5f6fc ath11k: PCI changes to support WCN6750
bbfdc5a751a6 ath11k: Refactor PCI code to support WCN6750
8d06b8023ace ath11k: Choose MSI config based on HW revision
0cfaf2243e9e ath11k: Refactor MSI logic to support WCN6750
5b32b6dd9663 ath11k: Remove core PCI references from PCI common code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220328055714.6449-2-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

