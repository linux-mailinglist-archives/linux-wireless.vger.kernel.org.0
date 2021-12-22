Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201147CCC4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 07:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbhLVGCq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 01:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242608AbhLVGCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 01:02:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2640C061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 22:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E4F617F0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 06:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C29C36AE5;
        Wed, 22 Dec 2021 06:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640152961;
        bh=E6qzX9u92PoJMrIOXKLOmI6ylwQgEE5xeTtwjCDDyW0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VE+1Z2T8DQwAP0NWGbrVBaOrqDUuHFPhYJJDyO/20rrbfBgOmlWWXhV9sjqIB7Ymq
         koqlB5u4cxyJM08LvE0dogkgwnEzBL+ElvDSYt8RSnMzGiWhA0b4lfJkyLmGSY/3gI
         5bsHJkrQ1RAl/KH0nAvtOd4INhLkWvYNQZFqLOEgF7spVoTVqjlGFrRT2Vs4mPp7Zi
         ka5dccEeQ7tew6fno+heVL/Q5jpCv5e40+v4iCCisa65k8nyIyPae2sZ0isNjobmkt
         ZVWjNyJm9OPASgnD4iETPx0qVCYs89ArPmMb9J0VNVzRl1/gxi6OKq0G2OuyaTRVRX
         zvdhWjHmA0XDg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k:  Fix napi related hang
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20200903195254.29379-1-greearb@candelatech.com>
References: <20200903195254.29379-1-greearb@candelatech.com>
To:     greearb@candelatech.com
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164015295930.20356.10535530063354087568.kvalo@kernel.org>
Date:   Wed, 22 Dec 2021 06:02:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

greearb@candelatech.com wrote:

> Similar to the same bug in ath10k, a napi disable w/out it being enabled
> will hang forever.  I believe I saw this while trying rmmod after driver
> had some failure on startup.  Fix it by keeping state on whether napi is
> enabled or not.
> 
> And, remove un-used napi pointer in ath11k driver base struct.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d943fdad7589 ath11k: Fix napi related hang

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20200903195254.29379-1-greearb@candelatech.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

