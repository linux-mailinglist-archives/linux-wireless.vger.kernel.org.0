Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01CA46DB0C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhLHSbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:31:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhLHSbE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:31:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0057CB82090
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47CDC00446;
        Wed,  8 Dec 2021 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988050;
        bh=uFJbAl0eNtOdiOiOvD76MxWlZI4rYjUX64AAIGw9qhs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GVJ28gkoS79/0Tf/FyZDS5rB+46qkFHiS1SiXt6abOjocfBwUpAGGJHTkEIG0xyJv
         xNKPhy9jDQGbhx7JpPNVviqWc2N5ddcefYHomDVkUcZp/J0Pkq8xHRvd+o2Of5QScb
         I0G53OCMCwaLPyCF0JBeilsIZAB4u+qYYtXWqZOTjr3zRiYcOMeHRrh6RLotAjn/Cb
         h8WqUkZEqX3kOgwfFToEjkrcuB2HROQlRD9eu0/zVmSQY4U4TkkbW3EzIs9mSa5bi6
         g/IEFEtMv7nSwyU5S4q8Vf+q9ZNUyNbYdJzBGdcP8RUXqPMVjL2btjppmGKPpII63q
         OJkW6S5qPxwEw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw89: update scan_mac_addr during scanning period
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211111023706.14154-2-pkshih@realtek.com>
References: <20211111023706.14154-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898804821.25635.692304454753657552.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:27:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Update scan_mac_addr to address CAM as A1, so hardware can ACK probe
> response properly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

e45a9e6265d2 rtw89: update scan_mac_addr during scanning period
eb4e52b3f38d rtw89: fix incorrect channel info during scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211111023706.14154-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

