Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135EB4F261E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiDEHyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Apr 2022 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiDEHyC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Apr 2022 03:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9121EEEC
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 00:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88ABD616DE
        for <linux-wireless@vger.kernel.org>; Tue,  5 Apr 2022 07:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9ECC340EE;
        Tue,  5 Apr 2022 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649144952;
        bh=FsWGZRZU5luoFcJ8Wj2q+FnEHag6sXtG+zcjWXjN7P8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=X8YtQXq96B1J3ZAkb/S4eA0njiU95WZPOewAlV4RA6I8veRnAAOv1Jlri1nzaN+7u
         6K1/WcL5JJbq8Vdmdl1T4fmaUSGDjbEzmZQWeh21SBNYK7d/RD5ksGNHwJN1i1Ak3l
         4QpOwv0N+gXZ3gUE3LKxA/Pl/Pdd6ssyvZblsKxzx0evmwY6wPm+KJKU8PQowQ3JAY
         ERVorqCLWR2juZN99x3Yto/316s3Ke8+5wpOoAMLFzaeVPSZ3v/z7t224a/WUbs2AV
         z2IS6LHE04p+yVSL3qBT4BIgNIwa+A6KsfEARJ+HJ4a0P6IzKsyPcFtfm/qf+qeujG
         PbwemzEjRq1Yg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Aloka Dixit <quic_alokad@quicinc.com>
Cc:     john@phrozen.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [bug report] ath11k: add debugfs for TWT debug calls
References: <20220301074905.GA13071@kili>
Date:   Tue, 05 Apr 2022 10:49:05 +0300
In-Reply-To: <20220301074905.GA13071@kili> (Dan Carpenter's message of "Tue, 1
        Mar 2022 10:49:05 +0300")
Message-ID: <8735isrmvi.fsf@kernel.org>
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

+ aloka

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello John Crispin,
>
> The patch fe98a6137d03: "ath11k: add debugfs for TWT debug calls"
> from Jan 31, 2022, leads to the following Smatch static checker
> warning:
>
> 	drivers/net/wireless/ath/ath11k/debugfs.c:1642 ath11k_debugfs_add_interface()
> 	warn: 'arvif->debugfs_twt' is an error pointer or valid
>
> drivers/net/wireless/ath/ath11k/debugfs.c
>     1637 int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
>     1638 {
>     1639         if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
>     1640                 arvif->debugfs_twt = debugfs_create_dir("twt",
>     1641                                                         arvif->vif->debugfs_dir);
> --> 1642                 if (!arvif->debugfs_twt || IS_ERR(arvif->debugfs_twt)) {
>     1643                         ath11k_warn(arvif->ar->ab,
>     1644                                     "failed to create directory %p\n",
>     1645                                     arvif->debugfs_twt);
>
> The debugfs_create_dir() function never returns NULL.  It's generally
> not supposed to checked for errors.  This code here looks like a
> layering violation because it's trying to check if debugfs is already
> registered.  But the clean up code just unregisters on the first call.
> Should it be ref counted or can the !arvif->debugfs_twt check be
> removed?
>
> Also if the user deliberately disabled debugfs then this prints an error
> message.
>
>     1646                         arvif->debugfs_twt = NULL;
>     1647                         return -1;

Please also use proper error values, not -1.

>     1648                 }
>     1649 
>     1650                 debugfs_create_file("add_dialog", 0200, arvif->debugfs_twt,
>     1651                                     arvif, &ath11k_fops_twt_add_dialog);
>     1652 
>     1653                 debugfs_create_file("del_dialog", 0200, arvif->debugfs_twt,
>     1654                                     arvif, &ath11k_fops_twt_del_dialog);
>     1655 
>     1656                 debugfs_create_file("pause_dialog", 0200, arvif->debugfs_twt,
>     1657                                     arvif, &ath11k_fops_twt_pause_dialog);
>     1658 
>     1659                 debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
>     1660                                     arvif, &ath11k_fops_twt_resume_dialog);
>     1661         }
>     1662         return 0;
>     1663 }

Aloka, you submitted this patch. Please take a look and fix the issues.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
