Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D951C62DA37
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 13:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiKQMGn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 07:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiKQMGm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 07:06:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154E21B2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 04:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48836B81FE9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 12:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00A3C433C1;
        Thu, 17 Nov 2022 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668686799;
        bh=DZ5U+Y/bMNLErZT7zR7UCQD8u/fakXriCnn+jYFVtYE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iaAxqQeB8FQQwZ57uTQbszkV4dUo9TT+zp90ROO7JDd3ncb4OLPf+ZUMoASKV5nrV
         A7x9Zsvlq0hqL5WZvoLodjs8zQeA9d5uvUVXURCF/I9SRqMl+wC7ldGc/OCLaDXcVg
         jIwdUjcHB7PJcqMsvAflQfWpAg60AfsOMB+ZVNSXuBBeBx8P2H2SX04CCPIxqNHBJG
         1tO5fueaITlArmBRSNMWXyKbWXzSBxga84x6R0mY6AvME3+1m9MIHK/BrQ8XhQ64bR
         yY/OEJqe7n6F+/o2vGVQmtWVcyZHcIlLeLryV7j6IKjw0ERFhYLTTa0vVUOlFPw6QY
         MDJ7eC3C3lV2w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] wifi: mt76: mt7915: enable coredump support
References: <3e6ef9fb1d2e09d415b4c489cc9c62134a05b3c1.1668024217.git.ryder.lee@mediatek.com>
        <b65f419a0c7319a6f661e07af7778fecb6cc7547.1668024217.git.ryder.lee@mediatek.com>
Date:   Thu, 17 Nov 2022 14:06:35 +0200
In-Reply-To: <b65f419a0c7319a6f661e07af7778fecb6cc7547.1668024217.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Thu, 10 Nov 2022 04:36:34 +0800")
Message-ID: <87iljdrdis.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Host triggered and catastrophic event triggered firmware core dumping
> for basic firmware issues triage, including state reporting, task/irq
> info, function calltrace and MCU memory dump.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

I missed that there was v3, please check my comments from v1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
