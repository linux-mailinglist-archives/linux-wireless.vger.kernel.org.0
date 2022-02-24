Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF764C2480
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 08:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiBXHfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 02:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiBXHfJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 02:35:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC2136692
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 23:34:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37DBAB8219B
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 07:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DF3C340E9;
        Thu, 24 Feb 2022 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645688076;
        bh=hCx4bfRDSPHmPlJNCzGAjut5sDcvgiG2vT3x1XsbKF4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kc5MgOdbz3o5uijwKLzpywe317WhUh01lpH8gp41ErSC+ykSrqaM4u3o5wNi+OHVW
         V36mY7kZ3C2FRNJWXS+2YTUNOFTiL7gg4P8zBz906nRClh/qwniswXCRcVfNkz4PiO
         uTvy3pZB/IQpmi+huOiaPq+35gc8j+tSyKrHbkx4YMMv//oyiCe7SPjgo2m0wKIzpd
         nCq0mPhQwJdgbvLFD8+4mE+bPBfg9n+kXpsw4uAmwYZ1ZvJ/nXRA3HjtesRHbgyZdp
         TEPB5PvM7L6k3g+bJYxqQBCwnwuSi62KR87fExRzLfEvgL+glScd0rpq140kJ1shMn
         s2ovPgbuoDKGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Francesco Magliocca <franciman12@gmail.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        rmanohar@qti.qualcomm.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: fix pointer arithmetic error in trace call
References: <20220221122638.7971-1-franciman12@gmail.com>
        <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
        <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
Date:   Thu, 24 Feb 2022 09:34:31 +0200
In-Reply-To: <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
        (Francesco Magliocca's message of "Wed, 23 Feb 2022 12:48:36 +0100")
Message-ID: <87o82wvhtk.fsf@kernel.org>
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

Francesco Magliocca <franciman12@gmail.com> writes:

> Hi, I picked (void*) to be conformant with the other examples in htt_rx.c
> For example at line 1431:
>>    rxd = HTT_RX_BUF_TO_RX_DESC(hw,
>>                    (void *)msdu->data - hw->rx_desc_ops->rx_desc_size);
>
> But for me it is ok. Maybe we should fix all the occurrences of this kind.

Yeah, it would be good to fix the void pointer arithmetic in a separate
patch. I have planning to enable -Wpointer-arith in my ath10k-check and
ath11k-check scripts, so patches are very welcome.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
