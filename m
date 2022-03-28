Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D134E910E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiC1JVY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbiC1JVX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 05:21:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735779FE9;
        Mon, 28 Mar 2022 02:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7AD6CE12AE;
        Mon, 28 Mar 2022 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F80EC004DD;
        Mon, 28 Mar 2022 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648459180;
        bh=ClHjhWRmcFOdOaa/lPlhbdmH1GQdx/klSYpf8w5b4sU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZdC3lku6nl26vPWvj2h9LtHRt4ivBjHX1scpK9quD/5QBa3grT5Oi2fAddW/FBSdo
         9SKGBy1cWpZ/Jg14D68e1ZJxlxpaAb4xjAgE7Z8gRHEoZHQdOQqK32OrHDhkzNAw14
         ahQ8JYbOWsMZFtQ0TRewIquMMPKQvApFdGrPU5n5FKbrvzB+L+VRUL3Xv6MP8iZhSZ
         76TK9E+A0AJngoGsH0NhEwZesFXmYuNthrDo0x3UfQr3QTc+tlcZMLK5eCTXgViNcd
         86RG10eE9OVo3Q+dqTKQ0Hk/HwTKOKm6AkmKFOLKFKADXz2CL1g/TPTC331sQ/9cTd
         GPL7+8Fmh2Irw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v3 01/12] dt: bindings: net: add bindings of WCN6750 for ath11k
References: <20220328060937.16738-1-quic_mpubbise@quicinc.com>
        <20220328060937.16738-2-quic_mpubbise@quicinc.com>
        <0256a6c6-088b-a7d5-68c4-b99238bbb0f4@quicinc.com>
        <87sfr2zb8y.fsf@kernel.org>
Date:   Mon, 28 Mar 2022 12:19:36 +0300
In-Reply-To: <87sfr2zb8y.fsf@kernel.org> (Kalle Valo's message of "Mon, 28 Mar
        2022 12:18:05 +0300")
Message-ID: <87o81qzb6f.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>
>> Sorry for top posting, missed to add device tree mail aliases.
>> Adding them now.
>
> IIRC DT maintainers use patchwork, so adding them to CC in a followup
> email won't properly work.

Argh, s/properly/probably/. I blame it on the DST switch we had
yesterday :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
