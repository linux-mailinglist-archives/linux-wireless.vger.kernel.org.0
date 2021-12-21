Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B711F47C240
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 16:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbhLUPHd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 10:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhLUPHd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 10:07:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F205C06173F
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 07:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 272A4B81097
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 15:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CF8C36AE9;
        Tue, 21 Dec 2021 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640099251;
        bh=IXzXYGDuehgwGEY3XC2v7jGKpJXRNnYZq3o0JAZ3GUo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oDhqhzUt2B0qG4Aw65JP+bXyh6Ybe1dU67fU9Jj5QgLt7h/vWmskRxoJvv3wmDQae
         8SbToqakpEMggdW9zOYFUpA2jEn4KeNV7HWYbPslNgHfHxTkTdqS/UWgzErHVgQOi3
         b0Rx6UhDJxoUP1XgSFF36FNmGcD/fpTWVhbteNnW8amCkz6F0cHpBd5/ekU+1Vc+xE
         vaZ1xpwsV0hYXXAODvN388EHAKeiQj5k51pMjekgTPcmV6uD7lRVG0sJi/2i2JjNcf
         Hq2AzeFQ0VRmB1MloFfWwYjYZ+gUCDtsEPLsrDECw7XMFZxGsCu7hupnXGECMDqPJU
         YxSb85TmSdBRw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, deren.wu@mediatek.com,
        sean.wang@mediatek.com, sven@narfation.org
Subject: Re: [PATCH wireless-drivers] mt76: mt7921: fix a possible race enabling/disabling runtime-pm
References: <0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org>
Date:   Tue, 21 Dec 2021 17:07:25 +0200
In-Reply-To: <0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Tue, 21 Dec 2021 14:57:09 +0100")
Message-ID: <878rwe6loy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Fix a possible race enabling/disabling runtime-pm between
> mt7921_pm_set() and mt7921_poll_rx() since mt7921_pm_wake_work()
> always schedules rx-napi callback and it will trigger
> mt7921_pm_power_save_work routine putting chip to in low-power state
> during mt7921_pm_set processing.
>
> Suggested-by: Deren Wu <deren.wu@mediatek.com>
> Tested-by: Deren Wu <deren.wu@mediatek.com>
> Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

We are in -rc6 already, so I would prefer to take this to
wireless-drivers-next instead. Is that ok?

Felix, ack?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
