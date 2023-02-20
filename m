Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1D69C6EB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 09:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjBTIp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 03:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBTIp1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 03:45:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B38A5C9
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 00:45:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F4ED60D29
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 08:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD6DC433EF;
        Mon, 20 Feb 2023 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676882725;
        bh=0wTN7oW3rrs6FmwbULgoC20s6jWSMg1bdkb9tqdgGDk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LIhht1LZjILKKOD/6LmKz6LUmiZ7UkToMU8W0aZy+QbCvc/p+Tt7gIFGwRjVyGoLE
         84ljRazPWPYsxzr4ZnBhIZEHKkTCWIEUSvM1+ogtbkCwlY/0tcqpO+Vnu7Gwo4M2bk
         Bpo2ugBE+jApelY4sqy587oJK0+7UeexvG8/jGuKuwepNl7LxmoOI6gpJc4ZmG9oCk
         RNDUM8CsyV2upxDm51wQ/NAwEJiixrIGuCnfqTPmqb6NwHN3wkO9YQZT8SFpUEpMvT
         QcpKzQpesSlIJrm7jLdEgcMM/Hty5FspD4BPkg6LnAWDi1+7KSbxwZo2/Od+R7xZ/c
         7El7BzZxKKBQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] wifi: ath12k: use kfree_skb() instead of kfree()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230217072739.181304-1-yangyingliang@huawei.com>
References: <20230217072739.181304-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_kvalo@quicinc.com>, <quic_jjohnson@quicinc.com>,
        <quic_bselvara@quicinc.com>, <quic_srirrama@quicinc.com>,
        <quic_pradeepc@quicinc.com>, <quic_bqiang@quicinc.com>,
        <yangyingliang@huawei.com>, <liwei391@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167688272149.21606.14556668506385773594.kvalo@kernel.org>
Date:   Mon, 20 Feb 2023 08:45:23 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> The sk_buff should be freed with kfree_skb(), replace
> the kfree() with kfree_skb().
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Dan already submitted an identical patch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=8c464d16809fa02982f6341ea598ec5d07457f19

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230217072739.181304-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

