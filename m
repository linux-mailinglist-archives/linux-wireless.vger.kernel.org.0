Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B62052293
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfFYFJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 01:09:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFYFJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 01:09:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1E884607C3; Tue, 25 Jun 2019 05:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439397;
        bh=buvfTxNrYKZL23+pOovVZBS7iLSbdZo/QokUS8Y3+ZU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LUgGXoWvG2n8/Xdbh277EqkIYj0MwGpwahrScip3xROLwl9sDy4wPhoGeOyK0B6wj
         ucvy/kiedRoJY7vCM23a01MD/paCBVb6svfrGwj/zLNYs96zzJZ+i1E2qODNOyeA1F
         DFVKwQLkzzNk2jwzlVBj8cebcOtehE+ytZ4SsCyQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48E2C60117;
        Tue, 25 Jun 2019 05:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439396;
        bh=buvfTxNrYKZL23+pOovVZBS7iLSbdZo/QokUS8Y3+ZU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=HXqNXsFvQnNE9Vgc+v0N8ZsSqCScy4gJpZmri00xgO2INKIvVj/fshPommeHinqwX
         pTIr9tgWU3cIZ4wXoLW/OwYQUi+KUtf6SU/qiFDe4LgmwSrIn2NtRCNjEeMANT1jHB
         PHiQhaJ9P7bcKCK9MRaUF62EFWiKft2/f6heZ4Fw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48E2C60117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] p54: remove dead branch in op_conf_tx callback
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190615100009.14654-2-chunkeey@gmail.com>
References: <20190615100009.14654-2-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625050957.1E884607C3@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 05:09:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch removes the error branch for (queue > dev->queues).
> It is no longer needed anymore as the "queue" value is validated by
> cfg80211's parse_txq_params() before the driver code gets called.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

12e66ffbd534 p54: remove dead branch in op_conf_tx callback

-- 
https://patchwork.kernel.org/patch/10997025/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

