Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFEA68DCAA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjBGPNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 10:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBGPNv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 10:13:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21DAD9
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 07:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3249BB819AA
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 15:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C36C4339B;
        Tue,  7 Feb 2023 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675782826;
        bh=eT8DCRKozFM6txzjiXImuZ9IEKVrUIeb9EJEJ0a1LkU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jQHKSRPBvkTY8tD9SE0Vc1A9ETMCm/QTXg87mR0HxWsUI0Yi3RbqWgubCMVnuL/lg
         xHL5RyO0aoo+TSgF3DJJVGWyX9mZyTrmSNMU6Ksa585zekkFnWR/IyZUIUsWN+EXPR
         44XgS7OYPR1tpDNTJZ3JyJSW2qhsGGwhB010XeLCy2tIRERstkLaSp7gaf23Y9OPyf
         mb8QGF4yfdC2WRtRcUA8/Bi8XM2sZzcLwnt5DEE9S/9EVaFjnMR4ZpVQ5IEdoyWxaQ
         ZtCmGXY8lglicXurB1stS+wTSvpWEpq/JyWp047x1Wkdo/HbkItZvLlj3Vwa6lvojj
         zcvP0LIfJTJYQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     carson.vandegriffe@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] wifi: mt76: mt7916: Support per-radio configuration 'firmware' file.
References: <20230123175500.3375542-1-carson.vandegriffe@candelatech.com>
Date:   Tue, 07 Feb 2023 17:13:43 +0200
In-Reply-To: <20230123175500.3375542-1-carson.vandegriffe@candelatech.com>
        (carson vandegriffe's message of "Mon, 23 Jan 2023 09:55:00 -0800")
Message-ID: <87lel97bko.fsf@kernel.org>
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

carson.vandegriffe@candelatech.com writes:

> From: Carson Vandegriffe <carson.vandegriffe@candelatech.com>
>
> This lets users specify the upper band that the 7916 radio should use.
> Upon reboot, the 7916 will be using that upper band.
>
> Example config file:
>
> myhost@: cat /usr/lib/firmware/mediatek/fwcfg-mmio-0000\:04\:00.0.txt
>
> high_band=6
>
> Signed-off-by: Carson Vandegriffe <carson.vandegriffe@candelatech.com>

So this is basically an .ini file with settings for the driver? It's a
long standing request feature request how wireless drivers should handle
thatbut there's still no resolution. Having an ASCII parser in the
driver does not sound a good idea.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
