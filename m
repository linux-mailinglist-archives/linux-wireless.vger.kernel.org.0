Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9082B30960
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2019 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEaHdv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 May 2019 03:33:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57058 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHdv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 May 2019 03:33:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D44386087B; Fri, 31 May 2019 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559288030;
        bh=sxj2/mlXQWznyBn1Q3Q66juZzAS2qLqrh4X4psVzrVE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TDTJXZMiqJuol2L3+2nFDrydIj4glGLEGLHnwwk6qeGY51d9kTydVy/667bVLOrlj
         pFz3wYa+64wGPrSsarpaV30/bTf/b0Z1UlTcyLaVlZd6dps6bxVzAg8O5ajjOeb1c3
         axFlahIM4/vcKPHQ6CjuRtrQsi+f5Fy3XbiJBwdQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64EFD604D4;
        Fri, 31 May 2019 07:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559288030;
        bh=sxj2/mlXQWznyBn1Q3Q66juZzAS2qLqrh4X4psVzrVE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TDTJXZMiqJuol2L3+2nFDrydIj4glGLEGLHnwwk6qeGY51d9kTydVy/667bVLOrlj
         pFz3wYa+64wGPrSsarpaV30/bTf/b0Z1UlTcyLaVlZd6dps6bxVzAg8O5ajjOeb1c3
         axFlahIM4/vcKPHQ6CjuRtrQsi+f5Fy3XbiJBwdQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64EFD604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: Re: [PATCH 1/2] mwifiex: add support for host wakeup via PCIE wake#
References: <1559209955-10089-1-git-send-email-gbhat@marvell.com>
        <MN2PR18MB26379DF16EADA38F72A87412A0180@MN2PR18MB2637.namprd18.prod.outlook.com>
Date:   Fri, 31 May 2019 10:33:45 +0300
In-Reply-To: <MN2PR18MB26379DF16EADA38F72A87412A0180@MN2PR18MB2637.namprd18.prod.outlook.com>
        (Ganapathi Bhat's message of "Thu, 30 May 2019 10:01:35 +0000")
Message-ID: <87r28ft6w6.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ganapathi Bhat <gbhat@marvell.com> writes:

> I have pushed two patches usingn 'git send-mail' and below patch is the first one; 
>
> I could not see the patches in patchwork page(https://patchwork.kernel.org/project/linux-wireless/list/); Did you get this patch? 

I take patches directly from patchwork and if it's not there I don't see
it. So you need to resend.

-- 
Kalle Valo
