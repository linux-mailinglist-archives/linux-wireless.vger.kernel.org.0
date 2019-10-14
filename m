Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E93D5E7C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbfJNJSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:18:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfJNJSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:18:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 167056090F; Mon, 14 Oct 2019 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044682;
        bh=xWPMAfpasfvcEkCxq0neoBkNgijerFVLWrwPPnfTl1Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NYcI/rHd9v5Mb9F/7FUqFrHbL8jMhIK38O5yvjhMEYPsW05yjvaNxjN95aGxJYE/m
         Yw5gwMf9hU7iXevZNf12YiEsbPBUw1N5A0fEuTTqyosGnxCF3meZUcGj6yvpE7AbII
         6SdfCGx/QcMcDPgHKKlqs9kTH8sn/XQMgR70wWxQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2CB26039D;
        Mon, 14 Oct 2019 09:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044674;
        bh=xWPMAfpasfvcEkCxq0neoBkNgijerFVLWrwPPnfTl1Q=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TTCegHPn9rCDWVam+XByMwuDjG0DgX0SL9pL0tgFGV+DdtesJOP8mmi5nXdoOYbCu
         1VB+y408FXavtOu55Co2sK29wa5TdJyeTjOwOaQLpE1deWynWl+Ky7zUsV32O/rpCn
         SqiysO+1QhOfWRxE6HnV1ZxN12UafFXE1lFCuSoo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2CB26039D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        yiboz@codeaurora.org, johannes@sipsolutions.net, nbd@nbd.name
Subject: Re: [PATCH v4 0/2] Implement Airtime-based Queue Limit (AQL)
References: <20191011022413.176208-1-kyan@google.com>
        <87wod7y9ui.fsf@kamboji.qca.qualcomm.com>
Date:   Mon, 14 Oct 2019 12:17:49 +0300
In-Reply-To: <87wod7y9ui.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Mon, 14 Oct 2019 12:06:45 +0300")
Message-ID: <87sgnvy9c2.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Kan Yan <kyan@google.com> writes:
>
>> This patch series implements Airtime-based Queue Limit (AQL) in the
>> mac80211 and Ath10k driver. It is based on an earlier version from
>> the ChromiumOS tree[0].
>>
>> This version has been tested with QCA9884 platform with 4.14 kernel.
>> Tests show AQL is able to reduce latency by an order of magnitude in
>> a congested environment without negative impact on the throughput.
>>
>> [0]
>> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1703105/7
>>
>> Kan Yan (2):
>>   mac80211: Implement Airtime-based Queue Limit (AQL)
>>   ath10k: Enable Airtime-based Queue Limit (AQL)
>
> Please always include a change log so that people know what has changed
> since the previous version:
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

Never mind, you actually had the changelog after the signature separator
("-- \n" line) and I automatically skip the signature :) So instead I
recommend moving the change log up and above the signature separator.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
