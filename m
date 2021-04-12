Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1035C55C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbhDLLf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:35:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22468 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240584AbhDLLf6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:35:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618227341; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GRKqjyIZZGHudyXi5NZdkY5+iSijHqxJ00muCi8rgaM=; b=PrV5OOzx+9nGMUs5HNVce3XS9FzH3CZWbGj/uJ0q6zX8+Xxp7RVkOxD7ktASvMrlCCKcLwZ2
 eJHVGdwEWfJ8Ey9XsKWL5t3vf/rdOqbIfaNhyJTWIkgawVZnF6lRK5ljWhr6vCBX3X0UxKdr
 cLhvrQHJCdmAAmTjTVIER05ARQE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607430848166b7eff7432df8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 12 Apr 2021 11:35:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F169BC43464; Mon, 12 Apr 2021 11:35:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 153E8C433ED;
        Mon, 12 Apr 2021 11:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 153E8C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-04-12
References: <b5b4820b-f0be-3e9c-25f7-b45c60b66c3c@nbd.name>
Date:   Mon, 12 Apr 2021 14:35:27 +0300
In-Reply-To: <b5b4820b-f0be-3e9c-25f7-b45c60b66c3c@nbd.name> (Felix Fietkau's
        message of "Mon, 12 Apr 2021 00:08:25 +0200")
Message-ID: <87zgy3loqo.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my my updated pull request for 5.13.
> It replaces the previous ones and fixes a few more regressions.
>
> - Felix
>
> The following changes since commit fa9f5d0e0b45a06802f7cb3afed237be6066821e:
>
>   iwlegacy: avoid -Wempty-body warning (2021-04-11 12:31:01 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-04-12
>
> for you to fetch changes up to 0751f8b9394c8d957b269c41ee278ebd8074f015:
>
>   mt76: mt7921: introduce MCU_EVENT_LP_INFO event parsing (2021-04-12 00:04:23 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.13
>
> * code cleanup
> * mt7915/mt7615 decap offload support
> * driver fixes
> * mt7613 eeprom support
> * MCU code unification
> * threaded NAPI support
> * new device IDs
> * mt7921 device reset support
> * rx timestamp support
>
> ----------------------------------------------------------------

Still problems:

In commit

  68b49712c107 ("mt76: mt7921: fix kernel crash when the firmware fails to download")

Fixes tag

  Fixes: 5c14a5f944b (""mt76: mt7921: introduce mt7921e support)

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
        git log -1 --format='Fixes: %h ("%s")'

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
