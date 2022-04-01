Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BC4EEC6E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbiDALiA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiDALh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:37:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BA31D66F6
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25E9CB823FB
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF25C2BBE4;
        Fri,  1 Apr 2022 11:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648812967;
        bh=Dn8GxYYoKdiprWzq8y1aKENiOHr1hreiRmk3/mdeR4Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=s5csr6uaZk87fztZKT22Sb/VLfAtsgltmgrvT0saTr6IeFNe+9hNzOjbMJlwoCdVU
         e/bZB8c55E16mKtYownWFIE8nOQi4i+SwExZLUQpymX53Ckrn6syjDdFVe1lHNu30D
         0cZzwAIIFmeBAFv7bBKNAc7gPSncD4/CAj9dVfOHiJ9il3IHMCDeRC33Mf2tECaB4A
         P3EB40eAREjB//ss7Hlz5lc98WziMHc3Q4bMtKj9UidiGN/cbffuTJRReOp0msDM4u
         jFbXiZd332veK3OdFC4jZgR1PPkLuiv+eTHxhjGtx1An7W3YIN2lzMnsyPswrKPaco
         TV+cDuiJZIcfg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] ath11k: Add support for SAR
References: <20220401073142.1195018-1-quic_bqiang@quicinc.com>
Date:   Fri, 01 Apr 2022 14:36:01 +0300
In-Reply-To: <20220401073142.1195018-1-quic_bqiang@quicinc.com> (Baochen
        Qiang's message of "Fri, 1 Apr 2022 15:31:42 +0800")
Message-ID: <87a6d5ujby.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> This is to add support for SAR. Currently SAR is enabled
> only for WCN6855.
>
> v3:
>  1. rebased on latest ath.git
>  2. add Wen's patch "ath11k: add support for extended wmi service bit"
>     to this patch set so that there will be no dependency for the SAR patch.
> v2:
>  1. rebased on latest ath.git
>  2. add base-commit tag.
>
> Baochen Qiang (1):
>   ath11k: Add support for SAR
>
> Wen Gong (1):
>   ath11k: add support for extended wmi service bit

From looking at the timestamps I'm guessing you are submitting each
patch in a separate git send-email call? The problem with that it breaks
threading in email clients. The preference is that all mails are
submitted in one run, like in this example all patches are in foo
directory:

git format-patch -o foo master..
git send-email foo

In other words, run git send-email only once per patchset.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
