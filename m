Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3262DA24
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 13:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbiKQMEI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 07:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiKQMEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 07:04:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3CE5E9FA
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 04:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A76361564
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 12:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264ACC433D6;
        Thu, 17 Nov 2022 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668686644;
        bh=Ikq5sCPgb4XtQZfCV6zAGcn1drm+mhwPZncFZ+Fvdq0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Hzff2FbWP9+TtMFKGifeHDPfgg8phvXlbUzSDvaQk3IYN15hXa9B0bGvs7GkyAles
         4GrVeAHN/A3lXWWp++zXsRT5qn7YI9eQp7KgAlRsoW4dmMPakpfWMJEAdjPPpHssew
         hgmpqCCWwdFx6YCf4uvlYLzivW9ROOEQhnYRIOYPAkcwjrpCrQiall3Xjla2WiSBm4
         QkRGtQD0QjpIoaP0Wm+/Y18UinKKXzzp57wbl9D873vlxrXHwR+W1/yIdbZmtxwVhm
         oazlWYgQRk7oKWkWJ3jMcBpXS8Fm0uRXzNxOe9rVjGlLyhR0/sB1g3aNLHRPBq2Cew
         wDruEFaNJdB0Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 4/4] wifi: mt76: mt7915: enable coredump support
References: <26aefa69d1002616412c4b00bf2e779f71ca3289.1667929344.git.ryder.lee@mediatek.com>
        <b26b285a001be954967ec77a1772a8b51faee21a.1667929344.git.ryder.lee@mediatek.com>
Date:   Thu, 17 Nov 2022 14:04:00 +0200
In-Reply-To: <b26b285a001be954967ec77a1772a8b51faee21a.1667929344.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Wed, 9 Nov 2022 03:02:10 +0800")
Message-ID: <87mt8prdn3.fsf@kernel.org>
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

If you add module parameters please always document them in the commit log.

> +static bool coredump_memdump;
> +module_param(coredump_memdump, bool, 0644);

Please also add documentation here so that it's visible with modinfo
command.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
