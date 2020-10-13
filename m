Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C492428D1B7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgJMQG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 12:06:26 -0400
Received: from l5m.de ([84.200.74.160]:60950 "EHLO l5m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgJMQG0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 12:06:26 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 12:06:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by l5m.de (Postfix) with ESMTP id 68B82104AFA;
        Tue, 13 Oct 2020 18:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        andreas-ziegler.de; h=content-transfer-encoding:content-language
        :content-type:content-type:in-reply-to:mime-version:date:date
        :message-id:from:from:references:subject:subject:received
        :received; s=default; t=1602604812; bh=QM+U5rhQpQ9AXtviwxP4YFpof
        RfivibJe4rCMuhgMHE=; b=OcTbfHh4mwUC8hC34FFKv4UVrEhK8JcriCyQa1jDw
        qLnB6tUIzD8FjAUq7SEzGXLQ3HWN9Auce/wmh5QNulD6w+9dQcAGjCvbdtEMTzFR
        96Jlibb0cSbtgN8l/ia2U1UaQAW32LMAnmSGEuH8BeLJLKItOmFjEb8xfEpoJO+t
        EQ=
X-Virus-Scanned: Debian amavisd-new at l5m.de
Received: from l5m.de ([127.0.0.1])
        by localhost (l5m.de [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
        id HfiPzgA4cHDG; Tue, 13 Oct 2020 18:00:12 +0200 (CEST)
Received: from [IPv6:2a01:c23:b823:2400:bd08:591:edf5:a080] (dynamic-2a01-0c23-b823-2400-bd08-0591-edf5-a080.c23.pool.telefonica.de [IPv6:2a01:c23:b823:2400:bd08:591:edf5:a080])
        by l5m.de (Postfix) with ESMTPSA id 64667104AB7;
        Tue, 13 Oct 2020 18:00:10 +0200 (CEST)
Subject: Re: [PATCH] mt76: mt7603: add additional EEPROM chip ID
To:     David Bauer <mail@david-bauer.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        Ron Asimi <ron.asimi@gmail.com>
References: <20201013142326.8361-1-mail@david-bauer.net>
 <20201013143219.GA2854@lore-desk>
 <cbd2ecce-09c8-15ec-e6b3-6e0913d09da4@david-bauer.net>
From:   Andreas Ziegler <dev@andreas-ziegler.de>
Autocrypt: addr=dev@andreas-ziegler.de; prefer-encrypt=mutual; keydata=
 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
 qIYRjN7uoQ==
Message-ID: <1dae1d32-8cf5-75f3-8bdc-32ec058faba5@andreas-ziegler.de>
Date:   Tue, 13 Oct 2020 18:00:09 +0200
MIME-Version: 1.0
In-Reply-To: <cbd2ecce-09c8-15ec-e6b3-6e0913d09da4@david-bauer.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

David Bauer wrote on 13.10.20 16:42:
>>
>> is it a hw bug or does this part-number really exist?
> 
> I assume it's a bug on TP-Links side. However, there's already quite some units with
> this chip-id in their EEPROM around.


to my knowledge, all devices of this specific model (Archer C50 v4) have
this chip-id in their EEPROM, not only some.

Regards

Andreas
