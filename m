Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479086D45F2
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 15:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjDCNiN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 09:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDCNiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 09:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1CA46BF
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 06:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A14C861B5A
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56159C433EF;
        Mon,  3 Apr 2023 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680529090;
        bh=3FhAR0Vp6qMlOcCGCLna7MY+v1QGCDSjLLteYum4hOg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LSn76jD4ng3IZ8NmF3YPFRFX+sDnuIfn4/cPBO1fMG4kufpAt8hEvrBhvVPeCY52+
         Ni5kTs6D/d0AKJypQj1M8Yb32oworXUy0jCT5QcWzNaex/0qI81SOCq+uR9NWZkUOn
         0qyHDH7+F9g0Dfbh/pOx+NxAcgyYB5spD2x/8wRuI1+dI7DeIZfrSWdZ+4dKZhGYFw
         zN6CMwGT/YDNJgKotL7I0yAR99AybWUDmCnRIFx90x/Q47DRxU5+ySy+AjnhU2H5q1
         Ylr/HDBV2kuph7jqOPSNvhYjywESKxKn8E920HltNvvSqf7zzOzVT1c+cdz+ZRDamg
         +Q4lsLMkbkwQQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: config EDCCA threshold during scan to
 prevent TX
 failed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230322060238.43922-1-pkshih@realtek.com>
References: <20230322060238.43922-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168052908713.11825.1555556959472075135.kvalo@kernel.org>
Date:   Mon,  3 Apr 2023 13:38:09 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Need to configure EDCCA threshold to default value before scan, and recall
> original value after scan to prevent probe request can't be sent out.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

280c444745aa wifi: rtw89: config EDCCA threshold during scan to prevent TX failed

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230322060238.43922-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

