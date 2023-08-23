Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C2785A08
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbjHWOIa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHWOI3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 10:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE87E46
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 07:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C7F62353
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 14:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0A6C433C7;
        Wed, 23 Aug 2023 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692799706;
        bh=wlPZUJtwIjOU67ARs1NWL8noFWW1XT2B5EgDGcarzqg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jjEepA/o941RRSBqT8phh6gU6jDQpgZAqMhEWu4/QHn8KwUuLbN4MBaoWMl1IgtPA
         B4mRtJkwdMsrUl/KJ7IcObhUdr7VjvGtY3BJ9M3BLRqefdpynpMELyKPt8KuhELr04
         bFeLPt6yJQXPWphI5a9aE/xv0hwpbwDim7GBMF9joWRcpXHjwZ/WbumNdt0inn6qT4
         qaERTdsTXepIHHxNz89gb/SwtNbJ7PDol+14OZHSGEtnTtiDbqLY7ZbJanjyx7gxU7
         zCfFgZeCmH3cYflh/v20oOFTrZ2KecfwX6IM3yV3KqA5e2EKTFJQC6qPqVe/pWqDPT
         1amfpJchUFcfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] wifi: ath11k: simplify the code with
 module_platform_driver
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230804091255.1347178-1-yangyingliang@huawei.com>
References: <20230804091255.1347178-1-yangyingliang@huawei.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <quic_jjohnson@quicinc.com>, <yangyingliang@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169279970384.1241462.812415762244736136.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 14:08:25 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> wrote:

> The init/exit() of driver only calls platform_driver_register/unregister,
> it can be simpilfied with module_platform_driver.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

749a660b3903 wifi: ath11k: simplify the code with module_platform_driver

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230804091255.1347178-1-yangyingliang@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

