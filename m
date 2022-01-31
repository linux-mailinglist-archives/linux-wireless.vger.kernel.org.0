Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772A84A4B0C
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 16:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiAaPyp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 10:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiAaPyo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 10:54:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7098FC061714
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 07:54:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3D1361463
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 15:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808AEC340E8;
        Mon, 31 Jan 2022 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643644483;
        bh=XjgXnk56VBpYuxPqqOYcNDdKyUYrXHlDmK0jPPkPnAo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=evyk4yvZIe5x/feS8bkljam74/Z6WvlGR50tss+/4EdViS/ZiewSgJEag4R5MHjbL
         7hcqTfem2wuhD/Jv9OcvmLxqxfImBawVGNjBLQMjCxNOqYs62I+0R/vXrAgR5cE3Qp
         VSVzEQLoYKKwd0DJtSrgFWnA2ap7ZiDcQO5vMF73PK3vnbQmNU3wSM08A4k5Vja9hg
         T08l8LN48QlwLrT31rrSeIbZbJJ/8jMcGLPfBT0GwbGnX6Dj0/i5JbVTfC9Uye99TQ
         c8938gEhep7S1nsFHqN6XXF8wCxGksIadgyX1WkFOVJBEN33wS3UbBrKn/GM+KKVFj
         WkgE+ul3Qu5+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless v2 1/4] MAINTAINERS: mark ath6kl as orphan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220128135841.1926-1-kvalo@kernel.org>
References: <20220128135841.1926-1-kvalo@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164364447955.10149.2039554956500411422.kvalo@kernel.org>
Date:   Mon, 31 Jan 2022 15:54:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> wrote:

> I don't have time to maintain ath6kl anymore so mark it as orphan.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

4 patches applied to wireless.git, thanks.

533da5077b63 MAINTAINERS: mark ath6kl as orphan
3451613c338b MAINTAINERS: change Loic as wcn36xx maintainer
e2ac75e0619b MAINTAINERS: hand over ath9k maintainership to Toke
fcda1cb81663 MAINTAINERS: add DT bindings files for ath10k and ath11k

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220128135841.1926-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

