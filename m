Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2465F46C214
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 18:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhLGRvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 12:51:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54396 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhLGRvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 12:51:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54ACACE1C53
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 17:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EBFC341C1;
        Tue,  7 Dec 2021 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638899258;
        bh=vwyuVDyRBHBHtjQAZ0ZBqofJI6JV7zSH7jyMIsKuZlE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PGC8T9lEsGcGN8u6gM+p+Gc/cBo7GLJS5f7xxIiDZXktDGjL0MHhEmTXElK/DeG0i
         j7i4F686dqs3m2UIF4IF2ZqzsCCdwhIAC5b0a49y0oXpYhqUXwTI8OCrfy1+t+E8Jp
         Jtdue/IrzoKoFfvERNAWPMbkQMr08n51+Ryan9CgeKElzy188IO6coYE354+SKyY+o
         fnorzYjiHQ51BS/jbfAyACjun5DOs7X4f5xmTtZvggU8NnunPJ/VUrUfaYAVbQ3Zr4
         mFsEJ2+l+UBv1ieEqlnVZR/spWxmGa3uxFxIhrY0ci78qZVIFaDZUaGKKGaV28NGoN
         AGudRklTs8eQA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>
Subject: Re: [PATCH 2/3] ath11k: Move pdev debugfs creation ahead
References: <20210913180902.193874-1-jouni@codeaurora.org>
        <20210913180902.193874-3-jouni@codeaurora.org>
Date:   Tue, 07 Dec 2021 19:47:34 +0200
In-Reply-To: <20210913180902.193874-3-jouni@codeaurora.org> (Jouni Malinen's
        message of "Mon, 13 Sep 2021 21:09:01 +0300")
Message-ID: <87pmq8joi1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Baochen Qiang <bqiang@codeaurora.org>
>
> The sram dump debugfs interface has to be put under pdev directory
> located under /sys/kernel/debug/ath11k/<pdev name>. Currently pdev directory
> is created after firmware is ready, this is too late for sram dump.
> Suppose that if errors happen and ath11k fails to reach firmware
> ready, we have no way to dump sram content to debug cause the
> interface has not been created yet. So move it ahead.

I'm not sure about this. What will happen with other debugfs files now
that they are created before the firmware is ready, doesn't that create
race conditions?

Also we need to do some refactoring in debugfs, for example see Anil's
patch:

https://patchwork.kernel.org/project/linux-wireless/patch/1614160542-27882-1-git-send-email-akolli@codeaurora.org/

So I recommend dropping patch 2 for now and get the basic sram dump
functionality ready first. After that we can discuss how to handle
firmware crashes during driver initialisation, maybe coredump would be a
better approach?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
