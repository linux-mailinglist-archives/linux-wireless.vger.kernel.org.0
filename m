Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB2FFB60
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfD3OZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 10:25:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3OZf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 10:25:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47F2C608BA; Tue, 30 Apr 2019 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556634334;
        bh=ru4uFJBDXnWgbZnRESyuHYjpWU71nRsW2ZydZO2/mAA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YDhAr6vHVf6QoAZn/LvN4tg/wYbclLl5S/W8f1r6267vp0MumXD4PGO6aPDzq3zT+
         xzRKIJYSwPmGebXnx5yoQHKV1qOBVcbJExhL8PpM9Bzoch6fmnsi2eMKe1U7hxgupc
         R8d8cK+HmZ07PvD+35pZo/RrFKT2DMTZZng59kF8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 628A1601D4;
        Tue, 30 Apr 2019 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556634333;
        bh=ru4uFJBDXnWgbZnRESyuHYjpWU71nRsW2ZydZO2/mAA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SKgWvb1L5guw3OnQ9w3LPN0xgaSisWG+/bgnm1Bm2Eb7pkxeHmmxsaHWiLgXLtwfw
         hHdfXhdb8FaKQ6pOa19R4tMuIZ3j0/Bg/IvHVYYZxzM5xOD+DbdEmD18kgIjpTVbWE
         XTrKLeYoSwHaw5CxYKSMt6ZYy4NNWZd8uUC1g/jQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 628A1601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Claire Chang <tientzu@chromium.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>,
        Wen Gong <wgong@codeaurora.org>
Subject: Re: [PATCH] ath10k: add peer id check in ath10k_peer_find_by_id
References: <1554260478-4161-1-git-send-email-wgong@codeaurora.org>
        <CANMq1KAU1B4Bweq3O6O8HOMwT7fHjj9tDyxqMsn_vn4gwxXL=Q@mail.gmail.com>
        <87wojbrg0m.fsf@kamboji.qca.qualcomm.com>
        <7d528d143ae14de2a489c6986f71ac45@aptaiexm02f.ap.qualcomm.com>
Date:   Tue, 30 Apr 2019 17:25:30 +0300
In-Reply-To: <7d528d143ae14de2a489c6986f71ac45@aptaiexm02f.ap.qualcomm.com>
        (Wen Gong's message of "Tue, 30 Apr 2019 10:12:09 +0000")
Message-ID: <877ebbpo2t.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@qti.qualcomm.com> writes:

>> -----Original Message-----
>> From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Kalle Valo
>> Sent: Tuesday, April 30, 2019 5:37 PM
>> To: Nicolas Boichat <drinkcat@chromium.org>
>> Cc: Claire Chang <tientzu@chromium.org>; linux-wireless@vger.kernel.org;
>> ath10k@lists.infradead.org; Wen Gong <wgong@codeaurora.org>
>> Subject: [EXT] Re: [PATCH] ath10k: add peer id check in
>> ath10k_peer_find_by_id
>> >> --- a/drivers/net/wireless/ath/ath10k/txrx.c
>> >> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
>> >> @@ -157,6 +157,9 @@ struct ath10k_peer
>> *ath10k_peer_find_by_id(struct ath10k *ar, int peer_id)
>> >>  {
>> >>         struct ath10k_peer *peer;
>> >>
>> >> +       if (peer_id >= sizeof(peer->peer_ids) * BITS_PER_BYTE)
>> >
>> > I'd use >= BITS_PER_TYPE(peer->peer_ids).
>> 
>> Nice, I didn't know about that. Wen, please submit v2 using this.
>> 
>> --
>> Kalle Valo
> Yes, 
> I have send v2 yesterday:
> [PATCH v2] ath10k: add peer id check in ath10k_peer_find_by_id

Ok, I didn't notice that yet. But in general it's good practise to reply
to review comments and let the reviewer (and others) know if you agree
with the comment or not. For example, in this case you could have said
to Nicolas: "Ok, I'll send v2".

-- 
Kalle Valo
