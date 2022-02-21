Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7794BDDC5
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347773AbiBULOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 06:14:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355471AbiBULNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 06:13:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88928988
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 02:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC6B3B80F9A
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 10:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7F9C340E9;
        Mon, 21 Feb 2022 10:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645440529;
        bh=J0KhS6AlqO4yuf9zyX2QAgoBYvw2YeO02ZDAQwuNc8U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nKmlHNb9dAoLUWshjyMZUNeOzVvF2ugTA4xWnaka/82HRdHOxSJGft0mpz+lkpTYB
         ZVx+sU5BoBVvYNIEo84qXIe+cQAjNawxgJgxNVeHZvnovJbgOWoKXI52w0pGCXIaB8
         OI8s9MlVIH8M6eCb7/T46pvxfuluEQKQy2jyxb/vZwIXaD4kVSG8qIImA4MCHO2rx9
         FlS3ooyQpay07HUn4o8cdK/AVjDL6I3PVtYzQBoU66ANRsCCzc+gBOkuMeuEdq6Gf+
         yfisRxYItHS/m+7yuXUPRok4xddKGIvXQS9kmx0p5peia4S20YnJa9QK5Gm8c0w6J1
         gVk4f6+Q7q+uQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 2/3] ath11k: decode HE status tlv
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220217012112.31211-3-pradeepc@codeaurora.org>
References: <20220217012112.31211-3-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164544052552.18502.8389290948480372442.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 10:48:48 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> Add new bitmasks and macro definitions required for parsing HE
> status tlvs. Decode HE status tlvs, which will used in dumping
> ppdu stats as well as updating radiotap headers.
> 
> Co-developed-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This had a new warning:

drivers/net/wireless/ath/ath11k/dp_rx.c:4859: braces {} are not necessary for single statement blocks

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220217012112.31211-3-pradeepc@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

