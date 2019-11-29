Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7B10D1FF
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 08:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfK2HqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 02:46:08 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:52050
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbfK2HqI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 02:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575013567;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=MfRCxzI4f7H6zs3Yw3n9nDTzabGXNV+6BrfKy40Wsns=;
        b=PH16paN1fjdNxn44J9LGn0//NQj1WuZ6uRNjPlMBitt2K2pCV6ytCC7ETDgX5EWk
        Nl6YSupQUmxIj5E5nWhFZNGA74E7dxgx2QyBIawAdGXfni6z8gaaMxoKYNkbhrmJnd2
        5P1JtTd+5bOOVc7MbTL22wlfkO3mNBTlHS37naKg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575013567;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=MfRCxzI4f7H6zs3Yw3n9nDTzabGXNV+6BrfKy40Wsns=;
        b=Bydj/Lr4I6QASSrCwgcLN1tTUn8Wqi3tU+i9ujWS0YBNIzl9TPUMc+s7jcu0m4rf
        UEGLfnaT0IgrTD0z5bLNUM7q2tOTQSP9mHZOhIx42rsERuuPowRZQiNo6MXGm118jgR
        OSF2n2lSbrmoPfz5xBwKPsLEjTs/5fKJRQSgh8aY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DA4CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: enable wow feature for sdio chip
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016eab75c9ce-0fc306b4-0804-4829-bf57-85d803251a00-000000@us-west-2.amazonses.com>
References: <0101016eab75c9ce-0fc306b4-0804-4829-bf57-85d803251a00-000000@us-west-2.amazonses.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016eb61fcb78-8211d755-ce13-4fcd-9fc2-bcff0fb571fa-000000@us-west-2.amazonses.com>
Date:   Fri, 29 Nov 2019 07:46:07 +0000
X-SES-Outgoing: 2019.11.29-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> sdio does not support wow, this patch is to enable it. When system enter
> sleep state, if wowlan is enabled, then sdio chip will keep power if
> platform support keep power, after resume, it will not need to re-load
> firmware again.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7321095ca39c ath10k: enable wow feature for sdio chip

-- 
https://patchwork.kernel.org/patch/11263485/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

