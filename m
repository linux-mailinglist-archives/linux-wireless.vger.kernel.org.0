Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB8263D83
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJGlI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 02:41:08 -0400
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:52536
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbgIJGiy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 02:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599719934;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=rAnqbJR4gQc48/BZ98bP5A/Ei86xv5QEUTdF4wMsejQ=;
        b=FVuy5KY2CTEQGbo/a8iANHJiHjzPoMDIHUFksvTeoX/g5L53rGEHBCvSDXTGuJJa
        sgHwsBCwuIlVYWh+IBaNLWlflM/pd70cSyjF8eX6q6di1ZvEI1NNzmMKEeB8XlQ5gv4
        9HhGfeFT6mmCEb4QRl3rXIThHId/wnOSVltHCCuE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599719934;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=rAnqbJR4gQc48/BZ98bP5A/Ei86xv5QEUTdF4wMsejQ=;
        b=U8+FK4pNQR2w85GBKZXilRxYqafAThsaLBVx0kXMSctR5MidGieh+3hNNAanO7XP
        Ks43B7qD63xnNhWwSOsCDBfl/Rf85ctCltO1g2vNbmb/aevjD/Eq7kJi2l/QB1fdQsQ
        Uq/9d8UG+jSL2ZU+OKv5sgsIFfFGk8JksdYLylK4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FB45C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath11k@lists.infradead.org
Subject: Re: linux-next: Tree for Sep 9 (ath11k)
References: <20200909202624.2cc6c3d1@canb.auug.org.au>
        <3f8649d7-c64a-4b0a-a2db-69f1b11e31e5@infradead.org>
Date:   Thu, 10 Sep 2020 06:38:53 +0000
In-Reply-To: <3f8649d7-c64a-4b0a-a2db-69f1b11e31e5@infradead.org> (Randy
        Dunlap's message of "Wed, 9 Sep 2020 10:48:53 -0700")
Message-ID: <0101017476bd075b-b36e0959-994e-4237-a73f-3e014b2abaa7-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.10-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 9/9/20 3:26 AM, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20200908:
>> 
>
> on x86_64:
>
> ld: drivers/net/wireless/ath/ath11k/core.o: in function `ath11k_core_init':
> core.c:(.text+0x121f): undefined reference to `rproc_get_by_phandle'

This is because CONFIG_REMOTEPROC is not, I'll fix the dependency in
ath11k. Thanks for the report.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
