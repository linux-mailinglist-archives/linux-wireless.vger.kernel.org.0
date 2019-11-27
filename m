Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B89F10B2A6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 16:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfK0Pre (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 10:47:34 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:37570
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfK0Pre (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 10:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574869653;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=zAWjFND4bUxYP+3nn/tL6BHpxz2j09KjvvMtaeoctXA=;
        b=NlDiyedg9zrk+5kyRkFewZHYEkXN1BJe7w0SQkBN6YVPq91et2JfYvB7BRV02+JG
        3ELSeZaAivRhdMraW9PHCgDyqnxKpszVnbMBHlF0RrFhu51Izmd8nvkgF6ijLPX+urr
        RL7QkbKDy1wdW5ziO8PKuqNbGS3f3Px6pPzKKr+E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574869653;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=zAWjFND4bUxYP+3nn/tL6BHpxz2j09KjvvMtaeoctXA=;
        b=BQErKQMz3AEzz3s4HD22WCk4a54QQ/RJ9cZHCtB02Vp7CMZKgbTy4Ezo/xW4j/hg
        oHWnxVtNjNKvwEtZovlU8sie+aOTeW8ooeHlA23aSwO8Q8oD3BELQTKEmJ9mB/rYIc2
        1RDMZ5yk6ht2c5FrRmxkjukkRscSEBxqTy1RBgao=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7A11C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] ath11k: add RX stats support for radiotap
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016ea36bc1e7-b9c8f0c1-9781-4920-afa0-45684e8754cc-000000@us-west-2.amazonses.com>
References: <0101016ea36bc1e7-b9c8f0c1-9781-4920-afa0-45684e8754cc-000000@us-west-2.amazonses.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ead8bd789-e5926c92-4c68-4dc4-af55-20b3021607db-000000@us-west-2.amazonses.com>
Date:   Wed, 27 Nov 2019 15:47:33 +0000
X-SES-Outgoing: 2019.11.27-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> mac80211 expects the definition of what HE rate info is available inside a
> struct prepended to the skb.
> 
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

8 patches applied to ath-next branch of ath.git, thanks.

e4eb7b5c335c ath11k: add RX stats support for radiotap
9cfbae4632fa ath11k: ignore event 0x6017
2dab7d221e88 ath11k: convert message from info to dbg
39e81c6a2907 ath11k: fix missed bw conversion in tx completion
33782a3c379e ath11k: Remove dead code while handling amsdu packets
9f056ed8ee01 ath11k: add HE support
6d293d447670 ath11k: add TWT support
3f8be640077a ath11k: add spatial reuse support

-- 
https://patchwork.kernel.org/patch/11260591/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

