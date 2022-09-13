Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F05B6861
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Sep 2022 09:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiIMHJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Sep 2022 03:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIMHJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Sep 2022 03:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D41081
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 00:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B6CCB80DFE
        for <linux-wireless@vger.kernel.org>; Tue, 13 Sep 2022 07:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AA5C433D6;
        Tue, 13 Sep 2022 07:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663052970;
        bh=x6LmdKaqxICKtVErYgsixOPS4R/RpN+mwZXJAXXX2vY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=tyKj5QDtVZ/GeyGAWD4NMT5xR98xuiqJ8nCDqmv4XxCFL5/uW0xs/ckCLcIGAr8oR
         LQdfSYu1Rwfog0epk97/0l6ck7oZMNqTP3hiwkzd1at8ZyKEv8PGq5jLQ/sqsmkhf2
         u+t8VmjrlfVL20Gtw/74lOdJRVk161uqbdThb7jkDBlVk1/1NEF6goTpJsKi79R1XS
         +08aNh1ahi9ujkR9lpe1t8R77/rhmv5lcdQZZiKfvr91l0r8iyjkOrPpSUbDsd2K5Z
         ngBRaoCiue2VW5Ng6EerLUX4xO8Qz7vvJqsBSC9mfgNgemy15gjADppJXkHBSWm9/+
         qdpb0SdyloPbw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] wifi: ath11k: add support for 6 GHz station for various modes : LPI, SP and VLP
References: <20220913051518.23051-1-quic_wgong@quicinc.com>
Date:   Tue, 13 Sep 2022 10:09:21 +0300
In-Reply-To: <20220913051518.23051-1-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 13 Sep 2022 01:15:03 -0400")
Message-ID: <87tu5b7ntq.fsf@kernel.org>
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

Wen Gong <quic_wgong@quicinc.com> writes:

> v3: 
>    1. added "ath11k: fix a possible dead lock caused by ab->base_lock".
>    3. deleted "ath11k: add support for extended wmi service bit" which is alreay upstream.
>
> v2:
>    1. change some minor comments by Kalle.
>    2. rebased to ath.git ath-202112220603
>
> Depends on one patch:
> [v5] cfg80211: save power spectral density(psd) of regulatory rule
> https://patchwork.kernel.org/project/linux-wireless/patch/20210928085211.26186-1-wgong@codeaurora.org/

The dependency is in "Changes Requested" state so I'll mark this the
same.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
