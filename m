Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC2477611
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhLPPh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 10:37:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43686 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhLPPh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 10:37:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7557CCE2161;
        Thu, 16 Dec 2021 15:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B0BC36AE0;
        Thu, 16 Dec 2021 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639669075;
        bh=7k5DTrm8gQNw6E1QpHPXE9tU4dFSpXqtZXmLiH1X7G0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rVvfFChNqBMb3hFfH/xw8YK3vHSyXys1bc9LLFdCRAhZGWc8Gsnk3fgv6ewhYzRVC
         SE8Tzwx4DDLc2F44M6CLPO67G/SKAZJPkxpQC74vJ2hQmSeTtweEE5RZeaBrCu7KVA
         G8O53CXXBydpJw0CuglSmhgRo7N18TQG3kbcGY1bWKDg4ye0NoNJlCanTRv2Dqucgd
         a40/d0RKYwzjQGLVvDG9W6K+BzmNnXJGuNeoaP0Kyyw6EDf+3AGzQpeQ9xxkRnRYYh
         eIBfRVMgfhiuODESGJfSCnHDhbYbIdGlwMIvKoHJkpyQZxoS9/SacFVGb4AhnoZjXZ
         TBahgtNSdqXTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wcn36xx: Fix beacon filter structure definitions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211214134630.2214840-2-bryan.odonoghue@linaro.org>
References: <20211214134630.2214840-2-bryan.odonoghue@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163966907191.4646.874650165148774096.kvalo@kernel.org>
Date:   Thu, 16 Dec 2021 15:37:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> wrote:

> The beacon filter structures need to be packed. Right now its fine because
> we don't yet use these structures so just pack them without marking it for
> backporting.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

7effbf7af91e wcn36xx: Fix beacon filter structure definitions
bc4e7f2432bb wcn36xx: Fix physical location of beacon filter comment
bebd87eea29a wcn36xx: Implement beacon filtering

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211214134630.2214840-2-bryan.odonoghue@linaro.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

