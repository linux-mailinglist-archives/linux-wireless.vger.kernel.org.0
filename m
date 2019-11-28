Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E309C10C83A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfK1LyN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 06:54:13 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:54426
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfK1LyN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 06:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574942052;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=6GEjRHiymZz2qpzisceFU6do1VPZDdWVVzA6Rg/sl3c=;
        b=DneEo8zpCjBV50PSIpqjkEBp6Dn/OYjJqbVSpvE/qUdRHYeengZHKodXE2znQnd5
        WlXZfOM8bIBhG6CtGvglBFhPOkVD2jvzTBfS1HF7nkzNbRRfc0vVO3qvJLwHiXG2COp
        W44HLcRmlKrpVoZEkJTEvXL88A0iNIClxVk6H+Nk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574942052;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=6GEjRHiymZz2qpzisceFU6do1VPZDdWVVzA6Rg/sl3c=;
        b=hejAHu4DsD5bxBxAXRLLU45ttCuFLLdL9fv+97NWwbNU9dD/+n2W1yKUESF1EI9D
        yEIkhzRBBo3S/Z5m/+9atuk6u9krFlCOiYiWD47ZJ3vutxRVoiNX6767C2BykhbtgwF
        pGlhM55vZpslUix2zCx06k4PRxRR2tLYfL9TwZsU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CD2CC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Huang <huangwenabc@gmail.com>
Cc:     linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org
Subject: Re: [PATCH] libertas: Fix two buffer overflows at parsing bss descriptor
References: <20191122052917.11309-1-huangwenabc@gmail.com>
        <0101016eb106d678-62ccf480-a650-47f2-87b3-cb5a03deb013-000000@us-west-2.amazonses.com>
        <CADt2dQfbnk5WgDk=oeWjE1tziCEem-3fhhA68Pmr_fo0pZ_V=g@mail.gmail.com>
Date:   Thu, 28 Nov 2019 11:54:12 +0000
In-Reply-To: <CADt2dQfbnk5WgDk=oeWjE1tziCEem-3fhhA68Pmr_fo0pZ_V=g@mail.gmail.com>
        (Wen Huang's message of "Thu, 28 Nov 2019 19:03:27 +0800")
Message-ID: <0101016eb1dc90c4-7d66fb28-a830-4ce7-97a4-cf38262aff44-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.28-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Huang <huangwenabc@gmail.com> writes:

> I have modified the patch and submmit:
> https://patchwork.kernel.org/patch/11265751/ 

Thanks, but few tips for the future (no need to resend because of
these):

* don't use HTML in email

* use v2, v3 and so on to identify the version of the patch

* do not top post

More info in the link below, I suggest to carefully study that. Better
chances of getting your patches accepted that way.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
