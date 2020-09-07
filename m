Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85C25F6F1
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgIGJ5x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:57:53 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:52134
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbgIGJ5x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599472672;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=YMgIhecsBWUSIrB5r/fRQO/5iu47zoGnW4xAX0f9hc4=;
        b=Lo/xj8dJH8aw86vkLuoagIn+G8RopDFzQEppwCe8MHv6bvm5trVjOEPg34kP4riG
        5SMMgxPM0okyU8jXh9VYm5D4guLerjm98/kM+cRGZWbMOGm+6z5qAsXV75CI8Mo2JQ6
        JL5hC2nT10fkjsTn5gGPq33D5iinfyIwAHOZ1TRw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599472672;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=YMgIhecsBWUSIrB5r/fRQO/5iu47zoGnW4xAX0f9hc4=;
        b=S/5q9ViQ7pgqPNa08XuQJWlY38RCY4Zy95BsuTx7ycgXNzKbmg0GwDeujaLVKiRc
        1hcHN44i9JKzGzSBbX6yVDQpWRHtd7CgXF+INhpqL2LnZuMPgYHyWW57pG2MTgFOapV
        f2nGsz7MO8JbGnkY+CxFf3kkhmOZmpiAhjyL47Xk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41B71C43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 0/3] ath11k: Add IPQ6018 support
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
Date:   Mon, 7 Sep 2020 09:57:52 +0000
In-Reply-To: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
        (Anilkumar Kolli's message of "Mon, 24 Aug 2020 22:14:27 +0530")
Message-ID: <0101017468001f6b-3fffd8c1-fd7b-467b-abb1-5a12309c37ed-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> IPQ6018 has a 5G radio and 2G radio with 2x2
> and shares IPQ8074 configuration.
>
> Tested on: IPQ6018 WLAN.HK.2.2-02134-QCAHKSWPL_SILICONZ-1
> Tested on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1 

I don't store the cover letters to git, so please move the Tested-on
tags to actual patches so that they are properly archived.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
