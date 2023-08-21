Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21D8782DFB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjHUQNO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjHUQNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCB5DB
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B65026105D
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 16:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D43C433C8;
        Mon, 21 Aug 2023 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634389;
        bh=oZ0GxRwofCUSAyMHGCcnhoF4YVCJeRZx+beuQ+n7C1w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hkEspuOJmJJNGSIJP1YVuSCOS/DkXlKbSUQ7j1353/iQraFvX3LIYoyoOHDMpiGZT
         /Wco33xYn+8s7HuEopP3gz29ZKoO+AHQQWJac+laL9diMnsP1+lSEsJks1nxYTDWMj
         R5oobZXPkMbyTITm3a8HSnuFKlJrwHKomEvnfvkC/ARi7SLzpC1T4YTq/oerAwnr2c
         7xrGoBJHq3fbHckM+hfgp40E+LnUTaZjLfLoanLb5dQGT/0WZjma40Uka+F9m4UmTS
         fALiznpVFf7xZNnmSJQzaDWyc+vPHk3WsK+mUa7mTjyD/jpwnacy/YNuovUjfMtnki
         wH9miJQCnP+mQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] wifi: rtlwifi: use eth_broadcast_addr() to assign
 broadcast address
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230804090120.1332091-1-yangyingliang@huawei.com>
References: <20230804090120.1332091-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263438647.572263.4734868947687411554.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 16:13:08 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> Use eth_broadcast_addr() to assign broadcast address instead
> of memcpy().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

66311106b20b wifi: rtlwifi: use eth_broadcast_addr() to assign broadcast address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230804090120.1332091-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

