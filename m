Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D556C8045
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjCXOtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjCXOtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 10:49:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BA540D8
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D32ECCE2632
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 14:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15072C4339B;
        Fri, 24 Mar 2023 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679669323;
        bh=fxpFTFNtK6KxsnmJvUbcE+rOKlYPFIvAHTBY4bVor9k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q8RnldNCSKJJLBC08psJY2xH88COFrsN6K+uixAxREnaLR5UQ2zFg7iXkgd+zXg1k
         dboolhorQ4+Mvt2gd0BlNItA3NfBeJJ0QY0avuu8l0ejtiENUucRPi9Y5q23iB8ZxF
         yfKrPtBl6AVxxANIobfUvH8h23lLVRmZekYu5PnIa++6v/zK/SPZ8Rju/un/0PSwUH
         +R1DnVCYMNV+/Ntnza9+AfcBoT/xHSOy0FpGz7xISOARffdSMvOs+jfjwJMqeUXyXq
         IwbwOprvADwdRUz7wAtAQbxMpODn/VW7H/vVj/kYlCIFWqB9hYwVismFFgBmLjhP35
         xrWWYxyw2X4hQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix packets are sent in native wifi mode
 while
 we set raw mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320052427.12271-1-quic_aarasahu@quicinc.com>
References: <20230320052427.12271-1-quic_aarasahu@quicinc.com>
To:     Aaradhana Sahu <quic_aarasahu@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167966931995.27260.4748683209503916457.kvalo@kernel.org>
Date:   Fri, 24 Mar 2023 14:48:41 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aaradhana Sahu <quic_aarasahu@quicinc.com> wrote:

> Currently, if we set raw mode as encap type, packets are sent
> in native wifi mode which is default mode. This is caused by
> no check being present for raw mode in ath12k_dp_tx_get_encap_type
> function, so it's always going in native wifi mode.
> 
> Fix, this issue by adding check condition for raw mode.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

e93bbd65547e wifi: ath12k: fix packets are sent in native wifi mode while we set raw mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320052427.12271-1-quic_aarasahu@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

