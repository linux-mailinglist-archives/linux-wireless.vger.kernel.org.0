Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583D7761C15
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjGYOne (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjGYOna (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 10:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A1D116
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 07:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3C161782
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 14:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C29DC433C8;
        Tue, 25 Jul 2023 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296203;
        bh=DjitGUFzt+/lZlyqndo6wXVWIziMxb8daNDLFe19AAQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XP8WFxFudQAxtr58Qernp3Gn8Jx15ZO1dJ5HJgkCFhB1ZRFelPJ9lJVuBTNOvHqIy
         liKwyA79RN9EvSX/9v5hM2IA5sqZvx6aUTvD/vHbBAAS4Cv2rHOJyUfc4h462Yr8Zs
         1WIQojxPbCM/ryc4MBCKbdpKwS1RCIRiFjFJRePSQ63DxqsrP258x0VCPE5QZAP9j0
         MRbl6YZ1jHOZ4MfeCEBGrnf3LQOXV0UavOsIbSfw0xueDOXJDgWr7KR8aSFrcShiy7
         iYcEqsfxmrZGyqIWb6YNhlaPgKzdGY9Cfob/vAOTMPtQUBSkvpZosI02m1p/w87BB2
         F1qYbecGIfyNQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] [v6] wifi: rtw88: delete timer and free skb queue
 when
 unloading
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230628072327.167196-1-dmantipov@yandex.ru>
References: <20230628072327.167196-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Po-Hao Huang <phhuang@realtek.com>, linux-wireless@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029620004.3309254.5721712445389003158.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:43:22 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Fix possible crash and memory leak on driver unload by deleting
> TX purge timer and freeing C2H queue in 'rtw_core_deinit()',
> shrink critical section in the latter by freeing COEX queue
> out of TX report lock scope.
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

4 patches applied to wireless-next.git, thanks.

634fcbcaa406 wifi: rtw88: delete timer and free skb queue when unloading
6ca25a31e0a8 wifi: rtw88: remove unused and set but unused leftovers
e88c9558951f wifi: rtw88: remove unused USB bulkout size set
8986f0a9a3bb wifi: rtw88: simplify vif iterators

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230628072327.167196-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

