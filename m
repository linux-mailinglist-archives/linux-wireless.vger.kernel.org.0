Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048CC46CF33
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbhLHIlU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 03:41:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57304 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhLHIlU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 03:41:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA8DAB81FDA
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 08:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2C2C341C8;
        Wed,  8 Dec 2021 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638952666;
        bh=7x+7ugH2AjWqMoowMPRzNp8VW4hURUYt0U0WtBtaVmg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aj2N5BELsn+R1GzrhfmU3EAgkKbfZ+0adFw0+ACM4nauUXuV0FDJZgiTcGLGJhfcl
         N6EmZJKb/XpvmpnFx/OXsa8zMQzAOLldauMRxYa1abOJdQs1rHK8fxdXgOIiuHjTA3
         pM5DBscqpENqYnG5605oMGH1rJA8Jr41d8Vfq62Ms/5e4yfKaYWG83M+VEiTxH7+5g
         3ygPCC6EaJQrv2qGUysqP0bkDNDXrQkT6y6HH/sYp+mjhpubs/yBXLCmjXvjMp8UEh
         b12kZhjTtefAA7HgxcyW5zONy5bng8Ibhysr16n8xLV1ilVvXc3gdtn6SnxDuxXo7q
         f8Ih3QJtc4adg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath: regdom: extend South Korea regulatory domain support
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20210915185611.6195-1-ebmajor.dev@gmail.com>
References: <20210915185611.6195-1-ebmajor.dev@gmail.com>
To:     Peter Oh <ebmajor.dev@gmail.com>
Cc:     ath10k@lists.infradead.org, kvalo@qca.qualcomm.com,
        Peter Oh <ebmajor.dev@gmail.com>,
        linux-wireless@vger.kernel.org, andreas.tepe@debitel.net
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163895266361.29041.5797831485020437683.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 08:37:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Oh <ebmajor.dev@gmail.com> wrote:

> South Korea manufacturer, Samsung, has extended South Korea
> regulatory domain pair with 0x5F and has used it for their
> devices such as Samsung Galaxy book. Hence add support
> 0x5F as a regulatory domain pair along with extended country
> code, 413.
> 
> Signed-off-by: Peter Oh <ebmajor.dev@gmail.com>
> Signed-off-by: Andreas Tepe <andreas.tepe@debitel.net>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

dec05cdf78af ath: regdom: extend South Korea regulatory domain support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210915185611.6195-1-ebmajor.dev@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

