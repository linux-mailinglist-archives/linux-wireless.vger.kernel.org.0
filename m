Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B6702AFF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 13:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjEOLBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 07:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjEOLBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 07:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1F493
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 04:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C632D62280
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 11:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0F1C433D2;
        Mon, 15 May 2023 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148499;
        bh=4mAlHlm1TO+UKzBjyEfEjZ5xwoceajajA0/RCVAfT9c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KRueawOOoYcKfWSH7TfEO522jF9PaGfxSKPu0QxQKWiqfTz1nRZhxeKa2m75dAjUq
         8Jrd868VI7XxsTavXjpnE1hxwK5ghwDbybsd7vuY7mnapbyiOe83GmmG2ZXZOjRq7N
         BbEcWFIyc2tWp13VlKyroY2QalRUmBMbciPFb3/clg96l5HE9XBl0JodYtUomJNDEb
         UvKS2TvD3HCiS9J8GQFQcpfZP/s8nCuaULTXKYsK65ch7ocOFufq9lZcUzCx68C6sG
         OBydeKSp4N+aiUtwDTi/mJG0e4TNq7gBqt1UZZwVsJZjQH6VzO+KNTzDOpf39+dbRF
         r8lTnnbFHn0DQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jaewan@google.com>, <steen.hegelund@microchip.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com>
Subject: Re: [PATCH net-next,v2] mac80211_hwsim: fix memory leak in hwsim_new_radio_nl
References: <20230515092227.2691437-1-shaozhengchao@huawei.com>
Date:   Mon, 15 May 2023 14:01:34 +0300
In-Reply-To: <20230515092227.2691437-1-shaozhengchao@huawei.com> (Zhengchao
        Shao's message of "Mon, 15 May 2023 17:22:27 +0800")
Message-ID: <87ilctn9ip.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> When parse_pmsr_capa failed in hwsim_new_radio_nl, the memory resources
> applied for by pmsr_capa are not released. Add release processing to the
> incorrect path.
>
> Fixes: 92d13386ec55 ("mac80211_hwsim: add PMSR capability support")
> Reported-by: syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: move the value assigned to pmsr_capa before parse_pmsr_capa
> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

drivers/net/wireless changes go to wireless-next, not net-next. But no
need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
