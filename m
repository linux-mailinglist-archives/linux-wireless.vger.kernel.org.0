Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DAA7AA142
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjIUU75 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjIUU7l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:59:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7137C83F4C
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D205FC116B5;
        Thu, 21 Sep 2023 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283868;
        bh=BF5T2JUpulkKw7ZaTHQ7jYNUb96c3nyDhbUTrlFhR+k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=AH8XaTC3X8eulTN2GAW+nx+kJTnDVN5Lk13e29I4hCbVQO/2hKx3Y0x38XlWGzXom
         UEs587qrjFgh9oeW7JmL41081t+ik76ock2lq2FRLOhEJ6WLug16rm8UPDuGv1b1qr
         HdTJ4wgXNgWpiGSNhb2k3j5RZ85lTA3YDjA7USSqYilFhqIwh/EtIYkVAcQcQxa3i/
         rrQrnyHofwJeNR1psysby/ju2tLfqZo17S8//7kHRv1t3I4FIgvGI7JZ2utXMgmARR
         h0smcRAe8lRjfWQ2jgrmkzsBpqDn3ilj70PM+hVSLwT9CoSw68lRZr6fJB/EN6ukcJ
         jgQqTcq/XQR0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: drop HTT_DATA_TX_STATUS_DOWNLOAD_FAIL
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230914160744.155903-1-dmantipov@yandex.ru>
References: <20230914160744.155903-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
        ath10k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528386511.1539628.17402529453391015773.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:11:06 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> According to Jeff, 'HTT_DATA_TX_STATUS_DOWNLOAD_FAIL' from
> 'enum htt_data_tx_status' is never actually used by the
> firmware code and so may be dropped, with the related
> adjustment to 'ath10k_htt_rx_tx_compl_ind()'.
> 
> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

30e7099a6dc9 wifi: ath10k: drop HTT_DATA_TX_STATUS_DOWNLOAD_FAIL

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230914160744.155903-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

