Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E61640E64
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Dec 2022 20:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiLBTZL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Dec 2022 14:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbiLBTZJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Dec 2022 14:25:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3364BF2885
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 11:25:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA66D6204E
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 19:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D1C433C1;
        Fri,  2 Dec 2022 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670009107;
        bh=niygrwuNu2LXyVpVbjfZ+XaxCkwfGwDgvy/CzSUqj0g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UtxFBmSgu1DXB/qeIQqJvddL4RclbJPhoqtlG00cBHMg3R9vzxVGWNf9zL5cESk68
         nuYs7XJI53icZ2Yh4JUTvvLdVGuisJhdCcdBDYcgD6AZa1Yrc8iZqlFyxM5KGZrSIt
         kuLDD07etFrGd46zb8CJzuFcDj5GomwjsB9ZjNJWB0WNk0/lMA+gPzrLK9WPTcPLNh
         4pP9HICiaPD7Z3NihQm3//ZSQEjIO0kNHzkU9Lde+1K7msqo+zATCt63nP5SAy/cqb
         Lk2JARSItaS2zdmLWfvrnggCaN1Y/dZjRZ75ajBS5RBf0AOko7r1wRws3nvBQmArXL
         9fSOuzHT81skA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: Re: [PATCHv2 1/8] wifi: dt: bindings: net: add IPQ5018 compatible entry for ath11k
References: <20221122132152.17771-1-quic_kathirve@quicinc.com>
        <20221122132152.17771-2-quic_kathirve@quicinc.com>
Date:   Fri, 02 Dec 2022 21:25:03 +0200
In-Reply-To: <20221122132152.17771-2-quic_kathirve@quicinc.com> (Karthikeyan
        Kathirvel's message of "Tue, 22 Nov 2022 18:51:45 +0530")
Message-ID: <87o7sl38xc.fsf@kernel.org>
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

> From: Sriram R <quic_srirrama@quicinc.com>
>
> Add IPQ5018 device support for ath11k.
>
> Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1

It should be

Tested-on: ....

But no point of having it in a documentation patch anyway, so I just
removed it.

I also changed the subject to:

dt: bindings: net: ath11k: add IPQ5018 compatible

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
