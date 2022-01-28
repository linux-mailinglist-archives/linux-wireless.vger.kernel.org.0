Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35A849F780
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 11:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239043AbiA1KkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 05:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiA1KkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 05:40:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A44CC061714;
        Fri, 28 Jan 2022 02:40:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26DDB61E92;
        Fri, 28 Jan 2022 10:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E75C340E0;
        Fri, 28 Jan 2022 10:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643366399;
        bh=5ZYPGoe4Z/8bZLzjkru39spkwNs6rMO5FMpqtHS75Lo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jQYH/s8MZ9GBMiGcf31uNDjRqAA5tfwcQ1zdcmE3QKbd9RqR1jcAUqVFnMWWCnj6a
         i0lOiBbGd8+YYRq8lP05irglsVZ04OvT9YHqVm5NTVNdNnMeK9nNgTZqrdAjumRrND
         u1b56pxPWyt1v8S77x/r7J1zCk4zkH1jKrLbyQMlLWMR8Urabkvq88h3uyNPLVlIUs
         Oizb72eAgqYFHHcA4DxHSjMc8zmzSs0dl0ac8fTu/6wbEjJuncsEdH14ymCrMzLN6g
         yMJbI//lB1K9ip08oP/7QubfqXSS1mCfYR/ddibpBXd7RgjkLMKvTilKYO455/9PhZ
         G6euLpqaZJAyg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
Subject: Re: [PATCH v2 19/19] dt: bindings: net: add bindings of WCN6750 for ath11k
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
        <1642337235-8618-20-git-send-email-quic_mpubbise@quicinc.com>
Date:   Fri, 28 Jan 2022 12:39:56 +0200
In-Reply-To: <1642337235-8618-20-git-send-email-quic_mpubbise@quicinc.com>
        (Manikanta Pubbisetty's message of "Sun, 16 Jan 2022 18:17:15 +0530")
Message-ID: <87wnikf8jn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Add WCN6750 wireless driver support, its based on ath11k driver.
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Device tree bindings should be first in the patchset.

I'm no DT expert, but you have a lot of changes in the bindings and it
would be nice to have some kind of description what you are doing here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
