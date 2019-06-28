Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FAF5A4EA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfF1TLk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 15:11:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1TLk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 15:11:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35958608BA; Fri, 28 Jun 2019 19:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561749099;
        bh=ddt8Rhhf568xP/qGFkl2nTNQ1Jq4FVEQ6cpM76H63AQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Z0m7q+OirlXfY9yZB9p3g0IuHFY/sK7tVHHkCxoDGE6M1i6E3E/R3OAzMTNDeFfOP
         taNJ6FFZsJcRtyUUJb+IFQWyemiQAKWkT1VaTn2SLhyvwt3rjhscjLlHAM0sONt4CB
         yJ/HgTA7MqHOywjq9+ivZ+RcovIJPVu+OeiJil5s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C21F0604BE;
        Fri, 28 Jun 2019 19:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561749098;
        bh=ddt8Rhhf568xP/qGFkl2nTNQ1Jq4FVEQ6cpM76H63AQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=BmlWLChMo7PPNPArfzwZ/CXAYBvIx/8hezYAXqFDTb+WNiM9XRHDjfdbwQJ/rliyb
         Xs+gCHdNdJEfndx/qpDDS6q3N7UHjwm5589rpHArsYsg3jhcZco4kVjEeEAj0UfAAd
         n72mCuZOSWoJBRGn0JCFUF8LXgtmiBvl95eQjvW8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C21F0604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Fix memory leak in qmi
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1561472748-28467-1-git-send-email-dundi@codeaurora.org>
References: <1561472748-28467-1-git-send-email-dundi@codeaurora.org>
To:     Dundi Raviteja <dundi@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dundi Raviteja <dundi@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190628191139.35958608BA@smtp.codeaurora.org>
Date:   Fri, 28 Jun 2019 19:11:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dundi Raviteja <dundi@codeaurora.org> wrote:

> Currently the memory allocated for qmi handle is
> not being freed during de-init which leads to memory leak.
> 
> Free the allocated qmi memory in qmi deinit
> to avoid memory leak.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> 
> Fixes: fda6fee0001e ("ath10k: add QMI message handshake for wcn3990 client")
> Signed-off-by: Dundi Raviteja <dundi@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c709df58832c ath10k: Fix memory leak in qmi

-- 
https://patchwork.kernel.org/patch/11015647/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

