Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A14E23CD
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 10:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbiCUJ76 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346123AbiCUJ7y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 05:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E58369E4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 02:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B317E612B9
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 09:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58092C340F9;
        Mon, 21 Mar 2022 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647856704;
        bh=zJtoj0yO3R4xRKDkQWATv5LNqCMME5ZZbwS6hJ0icOg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ATZKuocUM5w/IOnyMbheiQiKzfztxyr854Jhen/IX+PrVj2bAwHwd+9C3wE2mfkcA
         LHFOigdeLrLWI631u4vDGlnJWK9TRsrx1YG64DsTkNNqPJPw7v4egrX6TavKtSziaA
         aatdlNuxUqwbKJ0t3pvUtc5hORUqG6TnBkpHTGZ6yoxiSjoja2qdLQrJJsXTx5cPnc
         +PnuSsfVhsLyqI4rHtznX5+PVZ7rxnHMIVHtPxsnw3iing+4Ib3IglS4wFrUJ8PJ9M
         PNx379QEkfnNFmB9RxAY/kasrcJ9gxdq/YSILM9hofWmQAWCO15tYABFXMJ3NuXOOu
         0DxRuZNki3uSg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath11k: Add support for SAR
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220321022231.268197-1-quic_bqiang@quicinc.com>
References: <20220321022231.268197-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164785670143.6138.10862194405307750688.kvalo@kernel.org>
Date:   Mon, 21 Mar 2022 09:58:23 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Baochen told me this depends on this patch:

https://patchwork.kernel.org/project/linux-wireless/patch/20211224085236.9064-2-quic_wgong@quicinc.com/

But that patch is already dropped so dropping this one as well.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220321022231.268197-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

