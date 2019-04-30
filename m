Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5F5F31E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfD3Jgs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 05:36:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfD3Jgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 05:36:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 67C2660DB3; Tue, 30 Apr 2019 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556617007;
        bh=lN4glXMpqtmRgarltcSpOuqbmL55CZP7DhJ20iLDeNM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hFw6RRH9cvRt6Mgnppf7kwcJr8CMjQgPNIH9WlC52jE99oi7GXm+zi7XYhVj+U4zW
         eFOh8bowIsduSiWs5//plfUwEkEiz9gRq1R3zeVgRcK6CdOKtGgvxmQ4iSJ3PpFLJ1
         zbivu1qdUIimguEFaY74h8kYvZTiiWCOw1R724Io=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1E50608D4;
        Tue, 30 Apr 2019 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556617005;
        bh=lN4glXMpqtmRgarltcSpOuqbmL55CZP7DhJ20iLDeNM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cPb/0Xp27oPqXfjD1tlSaJTTsy6F58/8EO6bRU1ekuW8GnALHqwmpY8d+xKTmDRRw
         PgZhSXwiyGf5/kTqiHuD96Uf1jdz1KBoMD0z0d+iVdAMr+khoQRmyhfDmIFJDvW7sH
         g0T/P8/dsOsTj3KuCGkRVe9lCffLc7deL7nRuWTc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1E50608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        Claire Chang <tientzu@chromium.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: add peer id check in ath10k_peer_find_by_id
References: <1554260478-4161-1-git-send-email-wgong@codeaurora.org>
        <CANMq1KAU1B4Bweq3O6O8HOMwT7fHjj9tDyxqMsn_vn4gwxXL=Q@mail.gmail.com>
Date:   Tue, 30 Apr 2019 12:36:41 +0300
In-Reply-To: <CANMq1KAU1B4Bweq3O6O8HOMwT7fHjj9tDyxqMsn_vn4gwxXL=Q@mail.gmail.com>
        (Nicolas Boichat's message of "Mon, 29 Apr 2019 18:30:00 +0800")
Message-ID: <87wojbrg0m.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nicolas Boichat <drinkcat@chromium.org> writes:

> On Wed, Apr 3, 2019 at 3:01 AM Wen Gong <wgong@codeaurora.org> wrote:
>>
>> For some SDIO chip, the peer id is 65535 for MPDU with error status,
>> then test_bit will trigger buffer overflow for peer's memory, if kasan
>> enabled, it will report error.
>>
>> Add check for overflow the size of peer's peer_ids will avoid the buffer
>> overflow access.
>>

[...]

>> --- a/drivers/net/wireless/ath/ath10k/txrx.c
>> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
>> @@ -157,6 +157,9 @@ struct ath10k_peer *ath10k_peer_find_by_id(struct ath10k *ar, int peer_id)
>>  {
>>         struct ath10k_peer *peer;
>>
>> +       if (peer_id >= sizeof(peer->peer_ids) * BITS_PER_BYTE)
>
> I'd use >= BITS_PER_TYPE(peer->peer_ids).

Nice, I didn't know about that. Wen, please submit v2 using this.

-- 
Kalle Valo
