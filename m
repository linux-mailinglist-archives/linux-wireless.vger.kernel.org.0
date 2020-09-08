Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4674B260A94
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 08:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgIHGHq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 02:07:46 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:59866
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbgIHGHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 02:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599545263;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=TwgrCedCYdMNcQY5JDkO5WQ3X/4F0OQt5hqve+St7no=;
        b=Htqd5qVGSMxvx3WwxovzRcriBWnk8FKQijN2oVpC5y2HWBJQYEOgN1izm1fMPvS9
        EG0czcRnmAEqoQ/Yxljcw8mWt/D2ozCPurU7MR0Txptb81eu1GGcDKEAmjFi2o1iMdi
        oUYHl0XQAy6zW23dCe8Tj219T6PBemDBSbZeUC+8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599545263;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=TwgrCedCYdMNcQY5JDkO5WQ3X/4F0OQt5hqve+St7no=;
        b=nRSI83tG+v7f/JI6/jTskii1HgoYIFScrSh29eNjT0Mv7ZxcJSn6Df8ARJ8O1bNX
        behYL9vnKfyVnhtF40JASnJNSM5vyAhSQnUImcrAx20jVhHFCSNO2OPln7KaSQzja9i
        YcK4Sh8cnPdZ2boeHyvTP7GKsp6CAw7XgAyKpM0s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7C90C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V6 2/2] ath11k: add support for setting fixed HE
 rate/gi/ltf
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200804081630.2013619-2-john@phrozen.org>
References: <20200804081630.2013619-2-john@phrozen.org>
To:     John Crispin <john@phrozen.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <010101746c53c3fc-6b47ad5d-f740-4029-9a89-2ba9bef427f3-000000@us-west-2.amazonses.com>
Date:   Tue, 8 Sep 2020 06:07:43 +0000
X-SES-Outgoing: 2020.09.08-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> wrote:

> From: Miles Hu <milehu@codeaurora.org>
> 
> This patch adds ath11k support for setting fixed HE rate/gi/ltf values that
> we are now able to send to the kernel using nl80211. The added code is
> reusing parts of the existing code path already used for HT/VHT. The new
> helpers are symmetric to how we do it for HT/VHT.
> 
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: John Crispin <john@phrozen.org>

Depends on:

eb89a6a6b7a1 nl80211: add support for setting fixed HE rate/gi/ltf

Currently in net-next.

-- 
https://patchwork.kernel.org/patch/11699949/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

