Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E114855038C
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jun 2022 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiFRIvX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Jun 2022 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFRIvW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Jun 2022 04:51:22 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA68633E16
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jun 2022 01:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vKAp6midrKFUl/VRdMpx6UqjKFIdvS8wKcBMNQpctPE=; b=QJmOouAgqF22rj/fHlb2IRnFBG
        bYx1JgW9kBlpzRXdCDtkxHf5mfu/ODnhbvdsK3qz4xs/jQqL65EBhVEXt4KP0m92JqblYhBZCAxzp
        WOR0e2seUJHC3XG2vIeN+KsNQn8GpAq56GrFM9LR6/6xjQhw23RGkhXPM0Ew2Z17hG9Q=;
Received: from [217.114.218.26] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o2UAo-0004nW-VU; Sat, 18 Jun 2022 10:51:19 +0200
Message-ID: <bcdb70fe-de2f-a46b-66e2-ff92f8b86425@nbd.name>
Date:   Sat, 18 Jun 2022 10:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/4] mac80211: fix overflow issues in airtime fairness
 code
Content-Language: en-US
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, toke@kernel.org
References: <20220611200106.34319-1-nbd@nbd.name>
In-Reply-To: <20220611200106.34319-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11.06.22 22:01, Felix Fietkau wrote:
> The airtime weight calculation overflows with a default weight value of 256
> whenever more than 8ms worth of airtime is reported.
> Bigger weight values impose even smaller limits on maximum airtime values.
> This can mess up airtime based calculations for drivers that don't report
> per-PPDU airtime values, but batch up values instead.
> 
> Fix this by reordering multiplications/shifts and by reducing unnecessary
> intermediate precision (which was lost in a later stage anyway).
> 
> The new shift value limits the maximum weight to 4096, which should be more
> than enough. Any values bigger than that will be rejected
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
Please don't merge this series yet. I'm still investigating reports of 
regressions caused by it.

- Felix
