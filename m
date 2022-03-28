Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299AA4E90FD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 11:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiC1JTw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 05:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiC1JTv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 05:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61055522F2;
        Mon, 28 Mar 2022 02:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84E360F09;
        Mon, 28 Mar 2022 09:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E641CC340F0;
        Mon, 28 Mar 2022 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648459090;
        bh=pZuoXFadrtCx0LhURtPkckMaeaJRTSgMwySm5XoP3o8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rpfcRJbfbTQ/1PWK72CZFH/DNFfJCz/bTGavrkpjhpIzf9YriL5/44KTVk/9MJb0f
         30+Yax+oghiwC/s/Eu+S7Q/MJzsJH+bP1+Q0I5B4DAZaobi/m8JJzP6SNt3CSmm/n4
         YwC70m2oBxxXr/UXFbc4l754Jb6YbyQPfkDTGzgAnBikNYrp+su8K4BXwf3LrBRqKJ
         WYeWneNYcgo+LSl9Ubi5El48m2qaQwVfYvpEa2N+SZf3xrvgl1tWQs19nj/w76e+zq
         oWrUX6koNSMYOlqS9XGkJJ341g8eJATfsj2aJahjCh7hmC48UTd9UcKKRW4xBfIC4i
         y4qhMruXV1RHQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, "Rob Herring" <robh@kernel.org>
Subject: Re: [PATCH v3 01/12] dt: bindings: net: add bindings of WCN6750 for ath11k
References: <20220328060937.16738-1-quic_mpubbise@quicinc.com>
        <20220328060937.16738-2-quic_mpubbise@quicinc.com>
        <0256a6c6-088b-a7d5-68c4-b99238bbb0f4@quicinc.com>
Date:   Mon, 28 Mar 2022 12:18:05 +0300
In-Reply-To: <0256a6c6-088b-a7d5-68c4-b99238bbb0f4@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 28 Mar 2022 11:43:47 +0530")
Message-ID: <87sfr2zb8y.fsf@kernel.org>
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

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Sorry for top posting, missed to add device tree mail aliases.
> Adding them now.

IIRC DT maintainers use patchwork, so adding them to CC in a followup
email won't properly work.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
