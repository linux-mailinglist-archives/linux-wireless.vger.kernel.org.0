Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A57B20A9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjI1PMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjI1PMr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:12:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6EF9
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:12:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1104C433C7;
        Thu, 28 Sep 2023 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913964;
        bh=SM8aoie+ezJU9UWpCf9w3qJBLObW5VTQZ19AGhyBUxw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GZj0DAFMD9JPXISv+El0rXTFMqeUskYVNuYuNVgU8ohhHofxRHXtjVIxLKE6irDsl
         3bNss1PayM8GEbVLewPA0gB9nf3RYeCk2L1MBvH1PT9f35ddNpFZv+ggafyTQ6ZEQZ
         q0zN5zhZp1VeBfQZbgDwnfsaJLD2+oJd5QQXL5zFgURb0oeC7X+RK34v7SZd7DgCRP
         ruU6SzvA2r+BW5x7vqJwrAeXdrbcXkIUfOy+EeNIrqRm7olCplsXkNSENzvdYbOAVg
         5Xd7Fvwm0zXla86xlE4krH3n8GKU5KLMq3aQKyRZNTMQJeYHJF9JXsQ9Txar7cCths
         UM2iux660tXEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: add msdu_end structure for WCN7850
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230911093054.74943-1-quic_kangyang@quicinc.com>
References: <20230911093054.74943-1-quic_kangyang@quicinc.com>
To:     Kang Yang <quic_kangyang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591396177.3019228.6958340171406115973.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:12:43 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kang Yang <quic_kangyang@quicinc.com> wrote:

> WCN7850 and QCN9274 currently use the same structure rx_msdu_end_qcn9274
> for msdu_end. But content of msdu_end on WCN7850 is different from that of
> QCN9274. Need to update it for WCN7850, otherwise will get the wrong
> values when using it.
> 
> For example, TID is no longer in WCN7850's msdu_end. But
> ath12k_dp_rx_process_err() and ath12k_dp_rx_process_wbm_err() still get
> TID from msdu_end. So an uncertain value will be used in these two
> functions on WCN7850.
> 
> Therefore, add new structure rx_msdu_end_wcn7850 for WCN7850.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ed823fd113b7 wifi: ath12k: add msdu_end structure for WCN7850

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230911093054.74943-1-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

