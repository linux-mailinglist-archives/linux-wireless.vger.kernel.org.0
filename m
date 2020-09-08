Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A417260AF6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 08:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgIHG3K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 02:29:10 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:37214
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728881AbgIHG3F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 02:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599546545;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=ncMo5uU6IAdcdHHKfMvs4lVqU2E9Msj22aLGl9N7Aqg=;
        b=BrW3/Og8FjFaZAtjYkz3jqLD2Fw7MisT+BL0sfaM4yBuHiGMOAYugjKE5ej55LaC
        KIPKqR3+ZBVJQKOfjRcqYHMT23WlAhNEiV1VJYDtCWjgzp6T6ONmLUEZ9oGHGz2MhVx
        LtQgeJluiH9s5XSkheAznGBw6fZwV933AcxOnNkY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599546545;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=ncMo5uU6IAdcdHHKfMvs4lVqU2E9Msj22aLGl9N7Aqg=;
        b=LHIQySClakuxdS36zBof83l2ws08+/hEEaJRLqbGXXinXf1j+v5gh4PaWna28JRv
        9C4hGl/GRC5t+jO2BPMEbrk1XtppLej/YWfv8OA2cgHW3G23vudyarl3jiOi+Pqzpm3
        7Sv6TiZMwQakm9xaRQdf2fI9VgTgPQJ4A5P1Gjac=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D36E6C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH] cfg80211: add more comments for ap_isolate in bss_parameters
References: <20200908060157.98846-1-wright.feng@cypress.com>
Date:   Tue, 8 Sep 2020 06:29:04 +0000
In-Reply-To: <20200908060157.98846-1-wright.feng@cypress.com> (Wright Feng's
        message of "Tue, 8 Sep 2020 01:01:57 -0500")
Message-ID: <010101746c6752a4-b549f3e6-4aef-4d46-84db-e41d70b7a25b-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.08-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> writes:

> The value of struct bss_parameters::ap_isolate will be -1, 0 or 1.
> The value -1 means not to change. To prevent developers from thinking
> ap_isolate is only 0 or 1, I add more comments on it.
>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>

Reviewed-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
