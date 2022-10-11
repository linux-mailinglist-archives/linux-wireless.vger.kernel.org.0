Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1256B5FADA1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJKHlV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKHlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A5C5851F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 056E761132
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 07:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A73C433C1;
        Tue, 11 Oct 2022 07:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665474079;
        bh=eZLFPz9jyULlRshtRhiac1HlUMwUZ+tJMhu0+WfBtuM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W2hguDYnF7ZN1qEErnaPXeJVrplGvzoxC9Cd8an0K8bQTHUFGlR6nTqU8OuR2xz7+
         dgMjDUV6AUffPHK0AR6Dmy7jpAhrZoHLs4TIIhrCIbo0sh/dW7Ds1oz56ivbI1peJT
         ex93zS96QKGcTvkK7LON5ruryrFC4lPo5oFlMItF8IJ/hY1GwD5PwuFvN9GiNTIO1s
         TLlfeUi3Lveqaw8Lm7fZCsXvNfCjfY911mpYn6H6Lx/jJSE2qWQIQzZ3Tee4YWV/Sp
         4Kma3Oc98XWl1pHpOsqH+SbUkFNSbrw63LXdbNTYyNkTWZ8/zdUpXEKXnlwxbBkUc3
         jXP6BIz6ySVww==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH 1/8] wifi: dt: bindings: net: add IPQ5018 compatible entry for ath11k
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
        <20221006105913.18356-2-quic_kathirve@quicinc.com>
Date:   Tue, 11 Oct 2022 10:41:16 +0300
In-Reply-To: <20221006105913.18356-2-quic_kathirve@quicinc.com> (Karthikeyan
        Kathirvel's message of "Thu, 6 Oct 2022 16:29:06 +0530")
Message-ID: <8735buq02r.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> writes:

> Add IPQ5018 device support for ath11k.
>
> Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1
>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml | 1 +
>  1 file changed, 1 insertion(+)

Remember to include devicetree@vger.kernel.org list as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
