Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFC26275A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 08:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgIIGuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 02:50:09 -0400
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:35008
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbgIIGuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 02:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599634208;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=vSJgaJRaAsXydZfZJ62ISl0QBspn52HIwcgRvfHjDz4=;
        b=AwCD7k+ai4WEAem407NVs08YTUR7qClVmXc6Kp4tIAYIOyZAaBTQw+cM/3CwfBaP
        r0z53uBCXrnOkOCHuHtou4jYVldeA+u9l9cvQjROyginQyKJgC49l0GVkH/eOdLedhE
        OypkKoom6nDKl1AoDiua4+MVmHhw3rwdDM37BU8I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599634208;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=vSJgaJRaAsXydZfZJ62ISl0QBspn52HIwcgRvfHjDz4=;
        b=VVKnIAOAb/SSWE578iGkMjXwANoKMMwtoKNJ54HLfUlAzH0xOxDuaDpK7gJRu7k3
        dOYvDjvDeOhn4FPfHpd+J8sgZIJz8TyLl7g7PSEAzFTi7J/f6e92Nvzqe75ZtiY0GoA
        N2PQOPdfdT9wpW+n1JQAZW9SmucNJt0ScjeT7NjI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29D40C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath11k: Add peer max mpdu parameter in peer assoc
 command
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588611900-21185-2-git-send-email-tamizhr@codeaurora.org>
References: <1588611900-21185-2-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath11k@lists.infradead.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <0101017471a0f4a6-8d9fe12a-065c-4757-a410-18fc7dc84a9f-000000@us-west-2.amazonses.com>
Date:   Wed, 9 Sep 2020 06:50:08 +0000
X-SES-Outgoing: 2020.09.09-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam <tamizhr@codeaurora.org> wrote:

> Add peer max mpdu length configuration support in peer_assoc_he
> parameters. Noticed low throughput for the STA which
> supports HE, HT and not VHT in MU-MIMO case without this
> configuration
> 
> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

af6d39db1b04 ath11k: Add peer max mpdu parameter in peer assoc command

-- 
https://patchwork.kernel.org/patch/11526769/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

