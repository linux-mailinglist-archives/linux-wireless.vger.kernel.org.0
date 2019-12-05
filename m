Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF92113C42
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 08:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfLEHYL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 02:24:11 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:53602
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfLEHYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 02:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575530650;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=YvHv2rQuZhCxiYugQZfdChPHWBQ40vbZEq3TjWabN4w=;
        b=YrcQIBDG/7YKCk0/HFYcU3IPpbcgY8RZ8PPLtkNJW3WwttZ8ApoVaw6+/msuM2rX
        Ds7jeNpbqGottiQFUY1lMGH+j9fyBpsV7Bbh77M1iXCJrb+LvulI3R+eGAAE/7edEPi
        TrgecyCPD/SMKnG9vLclkHO6N8Pg1TvM+oUwWuMk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575530650;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=YvHv2rQuZhCxiYugQZfdChPHWBQ40vbZEq3TjWabN4w=;
        b=UfHWYtGLUgyWDOEooimtgM966+k+SsZtbGSf8Ftb5q3LO9k6SBCzXizF0kPUNzAm
        U4moOQPEz2xhpAH047YpeiLczZQilbFfsM2OeXFvaSO93XaP8EfBbJ4RHwsPdl2AQl/
        YQk4lnjLfko1X95r3KiIAFGscmHcsVEOAu9EEL20=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78FC3C447AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Eduardo Abinader <eduardoabinader@gmail.com>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: disconnect timeout
References: <20191205061922.1801-1-eduardoabinader@gmail.com>
Date:   Thu, 5 Dec 2019 07:24:10 +0000
In-Reply-To: <20191205061922.1801-1-eduardoabinader@gmail.com> (Eduardo
        Abinader's message of "Thu, 5 Dec 2019 07:19:22 +0100")
Message-ID: <0101016ed4f1db83-1f877afd-836b-4ba5-9190-4e71846e0853-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.05-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Eduardo Abinader <eduardoabinader@gmail.com> writes:

> Whenever the signal stregth decays smoothly and physical connnection
> is already gone and no deauth has arrived, the qcom soc is not
> able to indicate neither WCN36XX_HAL_MISSED_BEACON_IND nor
> WCN36XX_HAL_MISSED_BEACON_IND. It was noticed that such situation gets
> even more reproducible, when the driver fails to enter bmps mode - which is
> highly likely to occur. Thus, in order to provide proper disconnection
> of the connected STA, a disconnection timeout based on last time seen
> bss beacon is here given.
>
> Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>

Wouldn't it be better to disable IEEE80211_HW_CONNECTION_MONITOR and let
mac80211 handle it entirely?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
