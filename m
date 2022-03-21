Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58194E24BB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbiCUK6K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 06:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbiCUK5w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 06:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE4174855
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 03:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4216FB811AF
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BAEC340E8;
        Mon, 21 Mar 2022 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647860184;
        bh=4mYhdp7wdOTKJVNeK9LXMAkVP48EPteDhFnTB6L6ELM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uSrRzWCQi2jQox0ZbQmycba8Ywd4J8BAH5SBjABAVzB7KKy3CyoZUFWWdHGsaltp0
         YyqYKTy74YWWpxr3U+shBHJMzQRsoIKokVZAz2lEDmdH+GArVI78nDURQ45WfP1rIp
         sQ3Sa2sRNdY0SvjIaTwTcQx/IPEkEa4qo2gVatQhNE2c/UMaPpN1ZzgXvAJTVfwuaR
         T/X9AXfOPUgy0PbDhWRTeMTxXn5/5bqef553t/dD8i3R67XnrLgLe+Wjdr2iMjFoMk
         9buMNBMK8LGQctNQ4G15aEcF0JfBqYg7jB7o8gr1eeuMYLAcvBhECZmq/U6z/tgikq
         w69geHVwVrdjQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] ath11k: change fw build id format in driver init log
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1646825065-7736-1-git-send-email-quic_haric@quicinc.com>
References: <1646825065-7736-1-git-send-email-quic_haric@quicinc.com>
To:     <quic_haric@quicinc.com>
Cc:     <quic_kvalo@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        "Hari Chandrakanthan" <quic_haric@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164786017948.19083.6373161692942293952.kvalo@kernel.org>
Date:   Mon, 21 Mar 2022 10:56:23 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<quic_haric@quicinc.com> wrote:

> Currently fw build id is printed during init as follows.
> 
> fw_version 0x250684a5 fw_build_timestamp 2021-07-13 10:57
> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> The string "QC_IMAGE_VERSION_STRING=" is removed from the log
> to improve readability.
> 
> With this patch the fw build id is printed during init as follows.
> fw_version 0x250684a5 fw_build_timestamp 2021-07-13 10:57
> fw_build_id WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

72a9bff38654 ath11k: change fw build id format in driver init log

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1646825065-7736-1-git-send-email-quic_haric@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

