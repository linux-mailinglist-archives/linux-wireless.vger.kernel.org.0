Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3565F10599D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUSes (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 13:34:48 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:51852
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfKUSer (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 13:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574361287;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=Frohz/AbQwAOVdIcS06A8gGsV2S6XhzrXZZUGyf/TLg=;
        b=k+315jPcmO7qCTpseHtfh/wU2EiQwt65uCEsNUhUatcH6QdS82Gq1DXhU4+S7MGl
        HMujRrMqve7QOwXqCWCWWlMcoxqTIwX/JOCzBWHw9S0omnk5GdtwO+Zo1b0fZiQP0kB
        g0BYPXNbVDc/zHhErmynV/sBT1zdkacE2RlnW+x4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574361287;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=Frohz/AbQwAOVdIcS06A8gGsV2S6XhzrXZZUGyf/TLg=;
        b=BjE7HSmPaOoetbMdv3XnzgSsjrcxZpnUyGlnIRQWWiPj3Wmm1pMYilxv4y3dBihc
        TL+zlLTqnkfT6Zfnni6zbntNBRrOILySn5GeML5jyyGMTKQppCA4Q86Nul1PVR/QAoW
        hSdoltcHngGFCWcGotKV5aHsYpcuOAVIpa6hjQT8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6CBEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: fix ampdu locking
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191120200531.11344-1-markus.theil@tu-ilmenau.de>
References: <20191120200531.11344-1-markus.theil@tu-ilmenau.de>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016e8f3ec7ca-c8443d20-4cae-48f6-b3fd-a7b91be56ea4-000000@us-west-2.amazonses.com>
Date:   Thu, 21 Nov 2019 18:34:46 +0000
X-SES-Outgoing: 2019.11.21-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Markus Theil <markus.theil@tu-ilmenau.de> wrote:

> The current ampdu locking code does not unlock its mutex in the early
> return case. This patch fixes it.
> 
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> Acked-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers-next.git, thanks.

3e870c205d66 mt76: fix ampdu locking

-- 
https://patchwork.kernel.org/patch/11254757/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

