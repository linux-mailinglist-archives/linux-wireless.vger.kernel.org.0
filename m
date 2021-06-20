Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3B3ADDC5
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jun 2021 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhFTIqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Jun 2021 04:46:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:31005 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhFTIqo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Jun 2021 04:46:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624178671; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=ZlYN9ZqbA4FlSNCaICJ89aee7UP/9hKbVoA3Ymp9Y+I=; b=N2QO8Jq1KvfhMUc1TC5LU5Tu0qqHzGf+Ke4sZTBUGThHlgAq/D/57YTICOdiX7WW86fjvoui
 KyHHbd+FytbNUDvaRiC68VHLq/jrBlqQ5X6y/w91nSYF5S91ZC281YrmFyLAtjNhPuQsSTnt
 tkZ0W81Zo5E47LkNqrfgPrw6GLY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60ceffee5eaa81cb1e174bb2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Jun 2021 08:44:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1DFF1C433F1; Sun, 20 Jun 2021 08:44:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48E5DC433F1;
        Sun, 20 Jun 2021 08:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48E5DC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, sean.wang@mediatek.com
Subject: Re: [PATCH] mt76: mt7921: allow chip reset during device restart
In-Reply-To: <YM3k2dm2HcW/J+FJ@lore-desk> (Lorenzo Bianconi's message of "Sat,
        19 Jun 2021 14:36:41 +0200")
References: <96d84ef577cb558969a56ed42e68769eac0d3a1c.1624012209.git.lorenzo@kernel.org>
        <874kduktao.fsf@tynnyri.adurom.net> <YM3k2dm2HcW/J+FJ@lore-desk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sun, 20 Jun 2021 11:44:23 +0300
Message-ID: <87zgvlgc2g.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Disable chip full reset just during device probing but allow
>> > it during hw restart.
>> >
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> [...]
>> 
>> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>> > @@ -160,7 +160,8 @@ struct mt7921_dev {
>> >  	u16 chainmask;
>> >  
>> >  	struct work_struct reset_work;
>> > -	bool hw_full_reset;
>> > +	bool hw_full_reset:1;
>> > +	bool hw_init_done:1;
>> 
>> Is there a specific reason why you use bitfields in a boolean? Looks
>> strange to me.
>
> Hi Kalle,
>
> nope, there is no specific reason, I have just reused the same approach used in
> mt76_queue_entry for skip_buf{0,1}.

Ah, I checked now and saw other uses of boolean bitfields elsewhere in
kernel as well, but this is the first time I saw about this. So I guess
this is then ok and saves few bytes. Learned something new again :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
