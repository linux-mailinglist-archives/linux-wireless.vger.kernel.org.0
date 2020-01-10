Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31E11368F0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgAJI1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 03:27:18 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:54585 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgAJI1S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 03:27:18 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578644837; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=RFglwGsXPDlyaOSXE2V8lhwJ2MtbOXd9UIr6HVMzKt8=; b=d5k90R86sZ75isu8AFx7qT13uwM4O6hUIdEQcCdNZ+zE7IPJX2RvVs0Yvc0UQquedl5gjwpJ
 y11e+Vf6t+7AVz/5JsBnCd+WtoZ7sg5MwI87kp+AjJ3zK3Fs4VVm25OUh3Di6o85nR7dW7F/
 VSrLWSxePs4fyMX8CMljiCJdaaY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e183564.7fcc5af4f3e8-smtp-out-n02;
 Fri, 10 Jan 2020 08:27:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFBF3C43383; Fri, 10 Jan 2020 08:27:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8759C433A2;
        Fri, 10 Jan 2020 08:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8759C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Denis Kalashnikov <denis281089@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] ath9k: fix firmware bug in some of Mikrotik R11e-2HPnD cards
References: <CAKoLU8M+QU-96vnfet-759nnXyxxJmsf1Csba4FgNas8ZVOnOQ@mail.gmail.com>
Date:   Fri, 10 Jan 2020 10:27:12 +0200
In-Reply-To: <CAKoLU8M+QU-96vnfet-759nnXyxxJmsf1Csba4FgNas8ZVOnOQ@mail.gmail.com>
        (Denis Kalashnikov's message of "Fri, 27 Dec 2019 10:18:05 +0300")
Message-ID: <87v9pjsom7.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Denis Kalashnikov <denis281089@gmail.com> writes:

> Some of the Mikrotik R11e-2HPnD cards have EEPROM where is
> flashed that a card has 3 chains, but actually all this cards
> have only 2. This leads ath9k to write periodically into the logs:
> 'ath: phy0: Unable to reset channel, reset status -5' and
> stations don't see that AP.
>
> Mikrotik R11e-2HPnD is based on AR9582 chip.
>
> Signed-off-by: Denis Kalashnikov <denis281089@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/ar9003_eeprom.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> index b4885a700296..554a81400648 100644
> --- a/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> +++ b/drivers/net/wireless/ath/ath9k/ar9003_eeprom.c
> @@ -3373,6 +3373,15 @@ static int
> ar9300_eeprom_restore_internal(struct ath_hw *ah,
>                 cptr -= (COMP_HDR_LEN + osize + COMP_CKSUM_LEN);
>         }
>
> +       /**
> +        * Fix firmware bug of some Mikrotik R11e-2HPnD cards (based on AR9582)
> +        * that claim that they have 3 chains, but actually have only 2.
> +        */
> +       if (AR_SREV_9580(ah)) {
> +               eep = (struct ar9300_eeprom *)mptr;
> +               eep->baseEepHeader.txrxMask &= 0x33;
> +       }

What about 9580 devices which really have 3 chains, doesn't this broke
those? Or is such setup impossible?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
