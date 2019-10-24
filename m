Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACC6E2ADA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 09:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437893AbfJXHOa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 03:14:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48986 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437885AbfJXHOa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 03:14:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D2C0460C8E; Thu, 24 Oct 2019 07:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571901269;
        bh=HBgNraiFOUCK7ajELVpoAmoJgwcwJoB3sLpyKprO/zQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ER3nX0nwxtosPqZBXU9N0ItU7FIDxbQNPMS5u+zxoM/nWeEnmhX3GoDEpCDc9FkPq
         FW3ZJHnGhkszCIeoMVCG1ybXYkdSIlf26hrc9o+t5M9KjIoDe82bzISyIHJG5Al444
         CyYspwai9ZHL3fzZf9eHiQsyHVdT92kdtcd3pl+0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F59D602DF;
        Thu, 24 Oct 2019 07:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571901269;
        bh=HBgNraiFOUCK7ajELVpoAmoJgwcwJoB3sLpyKprO/zQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ER3nX0nwxtosPqZBXU9N0ItU7FIDxbQNPMS5u+zxoM/nWeEnmhX3GoDEpCDc9FkPq
         FW3ZJHnGhkszCIeoMVCG1ybXYkdSIlf26hrc9o+t5M9KjIoDe82bzISyIHJG5Al444
         CyYspwai9ZHL3fzZf9eHiQsyHVdT92kdtcd3pl+0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F59D602DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: add dt entry flag to skip SCM call for msa region
References: <20191023094014.28683-1-govinds@codeaurora.org>
        <20191023094014.28683-2-govinds@codeaurora.org>
Date:   Thu, 24 Oct 2019 10:14:26 +0300
In-Reply-To: <20191023094014.28683-2-govinds@codeaurora.org> (Govind Singh's
        message of "Wed, 23 Oct 2019 15:10:13 +0530")
Message-ID: <87a79qk431.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> writes:

> Add boolean context flag to disable SCM call for statically
> mapped msa region.
>
> Signed-off-by: Govind Singh <govinds@codeaurora.org>

Oddly this didn't apply, but 3-way merge did work. Please double check
the result in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=6f308524cf602ed9a0dbb0b0b50ba625b9091879

-- 
Kalle Valo
