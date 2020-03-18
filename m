Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F80189B84
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2020 13:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgCRMDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Mar 2020 08:03:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61562 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRMDA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Mar 2020 08:03:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584532980; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8YXEx/M9tgj715b9K7Jb9BvuLuxD4SNsxI+t+d3T3fs=; b=R1yEwe6dJN0JMAmUDUtJChYGlwgmBdWGLdHP2RRza/hgXf9zlvYkHpYo1eXhoTnsyIXGUo2G
 empHeJSNd/YezNaXNZvrKp5INOcpVkNQdQSmlUFAECN8k4Tn9E7lxYy4Gm88DiBR4Xq/puQG
 8EFJl1UXNx91wr4DhnVOGxJsRK0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e720def.7f35cb9bef48-smtp-out-n01;
 Wed, 18 Mar 2020 12:02:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5B5AC433D2; Wed, 18 Mar 2020 12:02:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 946ABC433CB;
        Wed, 18 Mar 2020 12:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 946ABC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2019-03-17
References: <91c846f1-8cd1-d460-663b-add7a439028f@nbd.name>
Date:   Wed, 18 Mar 2020 14:02:52 +0200
In-Reply-To: <91c846f1-8cd1-d460-663b-add7a439028f@nbd.name> (Felix Fietkau's
        message of "Tue, 17 Mar 2020 18:20:34 +0100")
Message-ID: <87wo7hkh03.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my second pull request for 5.7.
>
> - Felix
>
> The following changes since commit 377c0a94ad1cf005c47d7a502d1f8e46fbcf747a:
>
>   Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-03-16 07:29:55 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-03-17
>
> for you to fetch changes up to f40ac0f3d3c0e2b17185e1707a3b4552e5187dd5:
>
>   mt76: mt7615: introduce mt7663e support (2020-03-17 17:48:00 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.7
>
> * MT7663 support for the MT7615 driver
> * USB fixes
> * DBDC fixes for MT7615
> * MT76x02 watchdog fixes
> * Injection fix for MT7615
> * Sensitivity fix for MT7615
> * MCU support code cleanup
>
> ----------------------------------------------------------------

Pulled, thanks Felix.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
