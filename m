Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12878F045
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 17:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244342AbjHaP15 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbjHaP14 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 11:27:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520AB8
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 08:27:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A721FB81FE8
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 15:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84665C433C7;
        Thu, 31 Aug 2023 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693495671;
        bh=RChlf7sNnlla1bk8aQ9fJlAckK82BDukWAF14ibCRYw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FSVeVd9TdURBaRoL2h14T2qbLnhUCZvDYvH+tCXP9QkhsjWI0LcNbW4Mb/X1rsSTX
         OtsnwD6m/SJ2BavTtlnZDtRs+6Hr5MYPWG2rLuUPSrNw+H3TN/TF8Sre0VY+6WkfZB
         zcDiPQMJ5eYZJhkth1x/E6TgZSe7WITkRxEel+cCzvrW9hFtwdGsOVLghmcELZjfhx
         Rq0GC/Gta8iCVhNkxsz6lWT7lQFKdlKRbA/I74O6Vi8Vy/mFPorBGBeyGav4QYtczF
         3l1jH+urvcVRaqAfGj2lh1yPMSdnDUuur7Uvp3TziUsA5eFTeBfdzV02WgYhKUpCZk
         e+UDWP25AB16w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <gregory.greenman@intel.com>, <briannorris@chromium.org>,
        <nbd@nbd.name>, <lorenzo@kernel.org>, <ryder.lee@mediatek.com>,
        <shayne.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <avraham.stern@intel.com>, <johannes.berg@intel.com>,
        <emmanuel.grumbach@intel.com>, <trix@redhat.com>,
        <dmantipov@yandex.ru>, <christophe.jaillet@wanadoo.fr>,
        <yangyang@marvell.com>, <linville@tuxdriver.com>,
        <rramesh@marvell.com>, <akarwar@marvell.com>,
        <nishants@marvell.com>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH net 0/3] wifi: Fix the NULL vs IS_ERR() bugs for
 debugfs_create_dir()
References: <20230831141347.3166988-1-ruanjinjie@huawei.com>
Date:   Thu, 31 Aug 2023 18:27:44 +0300
In-Reply-To: <20230831141347.3166988-1-ruanjinjie@huawei.com> (Jinjie Ruan's
        message of "Thu, 31 Aug 2023 22:13:44 +0800")
Message-ID: <87v8cvdyfj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> Since debugfs_create_dir() returns ERR_PTR and never return NULL, So use
> IS_ERR() to check it instead of checking NULL.
>
> Jinjie Ruan (3):
>   wifi: iwlwifi: mei: Fix the NULL vs IS_ERR() bug for
>     debugfs_create_dir()
>   mwifiex: debugfs: Fix the NULL vs IS_ERR() bug for
>     debugfs_create_dir()
>   wifi: mt76: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
>
>  drivers/net/wireless/intel/iwlwifi/mei/main.c  | 2 +-
>  drivers/net/wireless/marvell/mwifiex/debugfs.c | 2 +-
>  drivers/net/wireless/mediatek/mt76/debugfs.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Wireless patches go wireless-next tree, not net tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
