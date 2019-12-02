Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7610E77D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 10:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfLBJQh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 04:16:37 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:45546
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfLBJQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 04:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575278196;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=COnbxftEBWLk/YjBffS2u4ngrMnfsfjWsp0rQXcb4eg=;
        b=Sal8jl5JMfVdbvza1QRNmonAhNrRKjrbuie7N6UwV0x1tQ7dACrYfIs6p/h9JFjV
        LpfV4/Pyiwj9xaoxxEoCnDjSs81SZ1VWdPcsk1/fK+kMmfYNUUnNnCga/WYQZGjoXf/
        pKiyCEbZe/q/S4UYBuqRQC92IEAcgQHlAE/SACN0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575278196;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=COnbxftEBWLk/YjBffS2u4ngrMnfsfjWsp0rQXcb4eg=;
        b=Jq48NeSTBBg1AnZf5vZjhmOBAqQCjbMUpWv4tJ+ybuJorvJnAH/AwDoNRZAfjwZW
        xIdEHsereUGSyLUK8J/4k1NByz8gmUZUbRGbEy6YFJ8QXV1fjTOrWEk3ImpwbQhU6EC
        HO7xGz0xLgAvosNDG6Aueil2A+HEmEfLU+ipNq4c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8759DC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        kevin.patrick.schmidt@googlemail.com, paweldembicki@gmail.com,
        freifunk@adrianschmutzler.de, nbd@nbd.name
Subject: Re: [PATCH] mt76: mt76x0: fix default mac address overwrite
References: <567a7cda15f641acb6eab5970370c9bfac96793e.1574548832.git.lorenzo@kernel.org>
        <20191201091439.GA5150@localhost.localdomain>
Date:   Mon, 2 Dec 2019 09:16:35 +0000
In-Reply-To: <20191201091439.GA5150@localhost.localdomain> (Lorenzo Bianconi's
        message of "Sun, 1 Dec 2019 11:14:39 +0200")
Message-ID: <0101016ec5e5b2cf-d96b3980-ed21-44e7-998f-05d3ff7bfc74-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.02-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Current implementation always use default eeprom mac address to
>> configure device registers even if it is updated using
>> mt76_eeprom_override. Fix it initializing macaddr filed of mt76_dev data
>> structure with eeprom mac address and running mt76_eeprom_override
>> before mt76x02_mac_setaddr
>> 
>> Fixes: d1bc9bf2072c ("mt76: mt76x0: eeprom: add support for MAC address from OF")
>> Tested-by: Kevin Schmidt <kevin.patrick.schmidt@googlemail.com>
>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> Hi Kalle,
>
> since the commit d1bc9bf2072c is already in Linus's tree and multiple users
> reported regression due this commit, could you please apply this patch in
> wireless-drivers tree?

Ok, I assigned this to me in patchwork and I'll queue this for v5.5.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
