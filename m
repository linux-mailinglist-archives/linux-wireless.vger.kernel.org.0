Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943226D22E9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 16:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjCaOsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 10:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjCaOsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 10:48:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3521C1C0;
        Fri, 31 Mar 2023 07:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AD31B83003;
        Fri, 31 Mar 2023 14:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF33BC433D2;
        Fri, 31 Mar 2023 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680274097;
        bh=JkdJm3yuG0Ps4tJEaq7VKc4kOt9N0e6Hc8fNPIFrqeA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=T1ukgqgOiGbbVtGnAWgma8AvhBoHq4APvpOIMzx2RJtIQKowWJCSfYQxHThIr5Ekc
         9wwpTLBSEC69euOnBja0sjGYsVIVYCnhgLzYOc3RTynvOxAJsjdSFqQnF+LtdDP5X8
         ZMn7G6Q60tIkrRXHpdqfRccbqWLDfKEZC23wQ06qQl9ARjNTzRmxrdrlr+4gCG0Zlh
         WmopJ8Vc7Jqth4pf2bYYQbGGxRlVszO7wFNNn8989y5vjj4cRAZ8xcbukwPAqxi7hc
         m1POeg/avnspa9kItBjZQdTfCjw6i03Vcb9U1M1mpOc/+T8XtCddXmRV2gaDLPMV9w
         UC+7BUECBq+DQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rndis_wlan: clean up a type issue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <d1f250a3-653a-497d-9c92-12dd628b7927@kili.mountain>
References: <d1f250a3-653a-497d-9c92-12dd628b7927@kili.mountain>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168027409365.32751.3315767812349876215.kvalo@kernel.org>
Date:   Fri, 31 Mar 2023 14:48:16 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <error27@gmail.com> wrote:

> The rndis_bss_info_update() returns type bool.  Change the NULL
> returns to false.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Patch applied to wireless-next.git, thanks.

703f15b6dce1 wifi: rndis_wlan: clean up a type issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d1f250a3-653a-497d-9c92-12dd628b7927@kili.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

