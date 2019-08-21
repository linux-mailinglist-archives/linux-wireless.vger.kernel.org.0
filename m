Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED90297155
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfHUFCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 01:02:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfHUFCE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 01:02:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 619C6608CE; Wed, 21 Aug 2019 05:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566363723;
        bh=OAXHvSPcASypt4knp+um/R3qsvrj0A8AZ+xVOBmayO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=diz8aflHFUW35YLB3+JlPG8vBzsU+wtkBV/QOXz10ckS1qFvNqsplp5U6i1J0Wn0m
         0CHQlOIoFJlZFYybPKKYRB1pMejwIoElVladHPFGglq6/bt/9cmUGoACPV5k9ZFKt3
         EWedm0beHRnPNK437+Io7AdNIkgXvLt1jRCpqGn4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B83E8608CE;
        Wed, 21 Aug 2019 05:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566363722;
        bh=OAXHvSPcASypt4knp+um/R3qsvrj0A8AZ+xVOBmayO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=khAQESoRJxq3DRAgV9aOv3HjhPETvHXCJA9Qou7aN9WdS/GR4PwlQRtbIBB6kOBmH
         QjKlQkRgQwFjuI4bNX49J7EeK0zr8/anSOSoFJtEQkSdmJ6KTmAZiQod3GmZMZ1+mu
         qHjmfiWfz4rJ9cYhV7ZjYyPRWqlGJp7Ov/vy+xBs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 21 Aug 2019 10:32:02 +0530
From:   Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
To:     =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 31/49] ath11k: add mac.c
In-Reply-To: <8736hvu6e6.fsf@toke.dk>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
 <1566316095-27507-32-git-send-email-kvalo@codeaurora.org>
 <8736hvu6e6.fsf@toke.dk>
Message-ID: <ac6e7dbbd53e7ba9e82e49baca22b73c@codeaurora.org>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-08-20 22:21, Toke Høiland-Jørgensen wrote:
> [... snip ... ]
> 
>> +static const struct ieee80211_ops ath11k_ops = {
>> +	.tx				= ath11k_mac_op_tx,
> 
> No wake_tx_queue? :(

Yes, packet queueing is handled in firmware. This makes sense especially 
when we enable 802.11 encap
offload support where most of the data path processing in mac80211 will 
be skipped and packet is given
to driver/firmware in 802.3 format itself. Then firmware would take care 
of all the classification,
queueing and encapsulation operations.

Vasanth
