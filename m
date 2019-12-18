Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEBF1252F1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 21:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLRUOf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 15:14:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32899 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLRUOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 15:14:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id v140so1847763oie.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 12:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ak4IdTSq0yrRUmmZNdJtmrrHyp40e8oWD/CHPhAwXvw=;
        b=TcBS08aVmpDwrjilD2Hfl2W4EuyALoxKCbi0uwSfm9uW42Ua+FZwLV1Xi3xO1XVHCf
         ltGJAIyt+tpifIEzauz2+mJ7DjB/ovGRqMoETMGNgzb4zMPg7j4BJ2UyJ9GOx/j8qZgp
         60bMGWFIhChv/5ynScY/X1TdQwXrHAlUqKFjP8j9ezPzGCafi/8h0vQsiR3G9JMz74BW
         JV3HoAZVp7GOArlhjPsXnRR2s+6bNFvmC1WDsS7VIiUUUQutRN65fz12BRhKATLy50zC
         qrIPBG82QpaBE5vT7Y8uasTDx227MBenXRMayYvj/BtY0R/lpiDi3X/cXTf3jc+ItzAl
         2ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ak4IdTSq0yrRUmmZNdJtmrrHyp40e8oWD/CHPhAwXvw=;
        b=BBoDWUTsSCHR+ik806U51ercZllk6erwM/PN0AbTIeccqvEhI/pcq72je5Y6IjYkyS
         R/VDszC7shdBQMUJFX6Fco9YdXHLI5ZNr7Xnh34F2k/1KkEUehUxfGXQWB18trpObi1p
         ykH4EEeeKu9PLed2Mg3ExDIWs7Wgn53sU71Rw4fm2mreSjIBbXdZSOJnDYMOC/Ght8MS
         Wz77FcPFuf9nkKZICDdaA3DRd6Yqn9w8CuIDqEdFvClitWH3X6viJyLGbNITqnY51vDj
         Qv5iSc6ox+MjI5gMgY4IUapiHsGooZaXIzJzS8EFXO499Dnf/wU6Pdmpws8Ui7JVAsti
         6M5g==
X-Gm-Message-State: APjAAAXU45wg3mYux6EbUenuQvPG7qHBO1AIAq3LI89tJl7CULfATo8j
        BlayMaV/Ysaak0QsoESsRo/3DFE+IQjjbOdV+9TWTQ==
X-Google-Smtp-Source: APXvYqxcJq+FRaKbA1sazXdbynHRsoWhPOzQwa624odcO6H869EYMu+ka6tsC30WQqoO737vodHwt093EwkPhtN3DlE=
X-Received: by 2002:aca:7244:: with SMTP id p65mr1293671oic.50.1576700074510;
 Wed, 18 Dec 2019 12:14:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Wed, 18 Dec 2019 12:14:34 -0800 (PST)
In-Reply-To: <20191217153000.76AB1C4479C@smtp.codeaurora.org>
References: <20191216092207.31032-1-john@phrozen.org> <20191217153000.76AB1C4479C@smtp.codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Dec 2019 21:14:34 +0100
Message-ID: <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading support
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     John Crispin <john@phrozen.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 17/12/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
> John Crispin <john@phrozen.org> wrote:
>
>> This patch adds support for ethernet rxtx mode to the driver. The feature
>> is enabled via a new module parameter. If enabled to driver will enable
>> the feature on a per vif basis if all other requirements were met.
>>
>> Testing on a IPQ4019 based hardware shows a increase in TCP throughput
>> of ~20% when the feature is enabled.
>>
>> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
>> Signed-off-by: John Crispin <john@phrozen.org>
>
> Depends on:
>
> 50ff477a8639 mac80211: add 802.11 encapsulation offloading support
>
> Currently in mac80211-next.
>
> Patch set to Awaiting Upstream.
>
> --
> https://patchwork.kernel.org/patch/11293627/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

the changeset is missing support for 64bit targets in htt_tx.c
