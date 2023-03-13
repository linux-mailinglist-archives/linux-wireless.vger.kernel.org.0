Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA46B775B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 13:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCMMVX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCMMVV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 08:21:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011351FA8
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 05:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 47926CE1048
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 12:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22855C433D2;
        Mon, 13 Mar 2023 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678710069;
        bh=JgDvYzN6YxVum9eHZ/d+wPLy0NmyaZFS6qgpGnpgco4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KJge0beXo2uL/yrcI8ua9XHPjDY1TJdyegpdrGH4RuBV8hPk2X3Meos5ulorbqQIm
         5QNA9FdRJ1BH5utGkoANI1AHJ3QZlM2acsTK01xhvWkk/GeiYiadv2HXIVmFEukAOD
         F6/xf5JotXimwtzVK4S/FzcTiF3QgsBc6q/iuxj5+0C0i3ivLAkfvUseaHYusqslGO
         1EyhaquQfjs/kp6xGdaUzpi+qH3w+bmxodvF7CsEQpwcgTdc5P4ncoxq744bY1oGj6
         zIeNfzQqlbzpt79MHNBxtUhTJRRlkuqFspfdYG6vu0eYD05SSt825Jf63ikQzwEOJE
         fZFDXF9WjrI6w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/2] ath11k: factory test mode support
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
Date:   Mon, 13 Mar 2023 14:21:07 +0200
In-Reply-To: <20230213130854.2473-1-quic_rajkbhag@quicinc.com> (Raj Kumar
        Bhagat's message of "Mon, 13 Feb 2023 18:38:52 +0530")
Message-ID: <87edpson9o.fsf@kernel.org>
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

Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:

> Device is booted in factory test mode to calibrate the board.
> The commands are sent from a userspace application, which is
> sent to firmware using wmi commands. Firmware will send the
> response back to the application which stores the calibration
> data in caldata.bin file. This file will be loaded when the
> device boots up normally next time.
>
> Govindaraj Saminathan (1):
>   wifi: ath11k: factory test mode support
>
> Sowmiya Sree Elavalagan (1):
>   wifi: ath11k: Allow ath11k to boot without caldata in ftm mode

While reviewing the patches I made quite a few style cleanup to patches
(too many to list):

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=4a5ca29c396ace5c46b208a8c15a3ba53eabaddd

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=ba74c7478f5d15ce38e609b9ad4810db7511a3dd

I only compile tested them. Please use these as the baseline for v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
