Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A171310D0D9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 06:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfK2FVF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 00:21:05 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:38170
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfK2FVF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 00:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575004864;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=2viHmJdfYcfYFMYSdfmf/HZfkSnX4p3XqkM1nDVHMIs=;
        b=bF7KuFGfb5BzbGKtLu4jk02KNfHbJOBjLm92r8WMn8L/OVBfV4go/EYXCxkL/+Pt
        gLqnERQrMaPsVvOlpvISNSkt+LT1IesGacVfc/woTh2eG2Z7WCLmTnwI5XXokGgHaYb
        dNJG1Y3kP5EPSs+P0RPCRuj2elrow9YYVLeAa/4c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575004864;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=2viHmJdfYcfYFMYSdfmf/HZfkSnX4p3XqkM1nDVHMIs=;
        b=Xac8idBw/csYpYJACT2A2hlYfm0pWXivZPOGSJjp8c2w/zZfbsFlaAD207pMSVV3
        661u/cGMW7jedRF115OMCBZv1Hx4AlweyNyrhIKF/iqLjuV8wCHBiw+yiWX6EbWA+OD
        UfBjJWhY1lj+WCORgHYbm/6GxTkGnVRBRchiz3Lc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E615FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     qize wang <wangqize888888888@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()
References: <E40E893E-D9B4-4C63-8139-1DD5E1C2CECB@gmail.com>
        <0101016eb10adf1b-06d87453-6fe9-414b-9114-23b8e50c5c3e-000000@us-west-2.amazonses.com>
        <CAGftXBH+s3HaWzoX8hsBdukv0NJsXZc7XZCT=mH5ejeiV9gFrQ@mail.gmail.com>
Date:   Fri, 29 Nov 2019 05:21:04 +0000
In-Reply-To: <CAGftXBH+s3HaWzoX8hsBdukv0NJsXZc7XZCT=mH5ejeiV9gFrQ@mail.gmail.com>
        (qize wang's message of "Fri, 29 Nov 2019 07:49:13 +0800")
Message-ID: <0101016eb59afe7f-a99d9b1d-03b0-4d02-95a4-e9d0af74d4e6-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.29-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding back linux-wireless)

Hi qize,

qize wang <wangqize888888888@gmail.com> writes:

> sorry, I am a new guy.

Welcome to the Linux community!

But most important thing first: please don't send email privately,
instead post any questions you have to the list. Normally I don't reply
to private email (I get way too much mail), but making an exception this
time as you are new.

> I have some question: Should I need to submit a new version patch to
> linux-wireless( like [patch v2]....) or reply a comment in the old
> patch path. (https://patchwork.kernel.org/patch/11257535/) ?

Yes, please submit v2 and include a change log what you changed. More
info in the link below.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
