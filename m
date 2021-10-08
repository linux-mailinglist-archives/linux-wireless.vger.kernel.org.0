Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B75426FB4
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhJHRrS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 13:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhJHRrR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 13:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633715121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0suhflFBkWX+ROdsQZsJ0FUFlsRFs43TIcGHOoe9WpM=;
        b=Gu3Q6rQEBtkqDjHK2kQSpt70UOdDKkzC8ZsJFT4Ym4D1uf6r3behmHsTUMaRpHMzbLK4Pe
        PiAsltiq8mDzr8JoUAA1vXfjvCBGjtfk7YShqNXFOHRIbrAKJ2AZDKXXCZkZ1dbEzGOtfi
        Rjf0wKPgmaUylSu0wMN3ZXA53dO0fH8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-qR-ZxMfFN2SvxyFLMm5kbg-1; Fri, 08 Oct 2021 13:45:20 -0400
X-MC-Unique: qR-ZxMfFN2SvxyFLMm5kbg-1
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso9840803edj.20
        for <linux-wireless@vger.kernel.org>; Fri, 08 Oct 2021 10:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0suhflFBkWX+ROdsQZsJ0FUFlsRFs43TIcGHOoe9WpM=;
        b=s3vAxZgD046xWUaAQxKeL70x73E8HRDluUaYexBPyMG4AMlg6z9mS3M+OShZWYImVU
         2W0HWqIk+e0jfHLKvV7UjbC/5Hrzu4zg3P2zAnf83C381Ad7pF1nPB5q+MEmQJq2HiCp
         vSz5Q/PI9kLtz5piVqSkoEdmLJQ8PIZ9iymGAsDmdYTnWUJnP4bYwPDC/bhLBCTSSsIm
         9PapVNRp9lox7CnZ/EhphcvcNDGwEbc0UHLWHEYvgVK0V0jOaLhIKEXaC750uGZ9r5lt
         uca1AyaQiDB9dAFSBk/dqhYb8gJIKHskgmFssMSMP3atiw/DTI7W3dvRm0nKYapuKXEI
         +tTQ==
X-Gm-Message-State: AOAM533W7FCUdoklP+YBklfck8xf6WWUd6hwLzf7R/RBBVlVlkthl25h
        +ghWu2ttl8iu6zgabRSQl8BDToakgUAZKG95xToA/K6Wic3TIXFAENa32qhspHHRpIcGyI/iYvZ
        PM1XYdLmkHE1mTaNW1w2DEQRPO44=
X-Received: by 2002:a17:907:76e1:: with SMTP id kg1mr5817811ejc.329.1633715117173;
        Fri, 08 Oct 2021 10:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhfsZrMklIBWSv3Hf9rVrM9jDqfpTkNGV8r2F/JPDAA1QI3yF5L1XpjbWrH4X6fBDDSc3cqw==
X-Received: by 2002:a17:907:76e1:: with SMTP id kg1mr5817686ejc.329.1633715116108;
        Fri, 08 Oct 2021 10:45:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g9sm1175560ejo.60.2021.10.08.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 10:45:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CA95C180151; Fri,  8 Oct 2021 19:45:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7 08/24] rtw89: implement mac80211 ops
In-Reply-To: <20211008035627.19463-9-pkshih@realtek.com>
References: <20211008035627.19463-1-pkshih@realtek.com>
 <20211008035627.19463-9-pkshih@realtek.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 08 Oct 2021 19:45:14 +0200
Message-ID: <87h7drl8b9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> To yield better TX performance, wake TX queue is implemented.

I went looking for this, and was happy to find it! :)

Do you also support airtime reporting and/or AQL? And if not, any plans
to do so?

One small nit below:

> +static void rtw89_ops_wake_tx_queue(struct ieee80211_hw *hw,
> +				    struct ieee80211_txq *txq)
> +{
> +	struct rtw89_dev *rtwdev = hw->priv;
> +
> +	ieee80211_schedule_txq(hw, txq);
> +	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);

Why the call to ieee80211_schedule_txq()? mac80211 calls that before
calling wake_tx_queue() (through the schedule_and_wake_txq() helper), so
it seems a bit superfluous here?

-Toke

