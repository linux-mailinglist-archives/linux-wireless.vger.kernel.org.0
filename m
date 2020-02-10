Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA141157C25
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 14:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgBJNfT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 08:35:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728003AbgBJNfT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 08:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581341718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Li8O8E0AA9IarmXHuPcayPz2Oq6NZuJ7v3a3dOOjY+E=;
        b=UsLUjtEzwK6xJBkghtO8kt8p3+WluZcM7atMll1WfuP1bWWEh8M0WciFXr01EBMKpUNhio
        ZYz+5b4R0u68S+2Gkdl00QpjJDGNPnrZfGVcA1hoATz8hY6adQXqaG4z8GWNwAQQCTOA70
        DCdWOxEeQQ2uEFN3q2CvVHtog50tTmo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-wIcCJDDyP-uk6woAA4sKqw-1; Mon, 10 Feb 2020 08:35:13 -0500
X-MC-Unique: wIcCJDDyP-uk6woAA4sKqw-1
Received: by mail-vk1-f200.google.com with SMTP id a20so2193681vkm.22
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2020 05:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li8O8E0AA9IarmXHuPcayPz2Oq6NZuJ7v3a3dOOjY+E=;
        b=R/gXUYGXbQ10Y9BXtsREvHRtFWf2SWvZ8PstO2HCuitU121yxfM6f9q7ntvnY+b3v0
         prtyUbOfaxEZ1ktDfmW9IyHm/NYgM7VLN31AeFOPG/JYdCH+8AziuumBpfA3kmr0MwJV
         0Jqut+8dC3vSaYEvipn0B3SizKLaLx90l4pgaMaCnaEAS0jsI+OqneDeuYldi0X7TDfR
         l/7ifU9OYnWSofnxrxTxw2iwwQSuj1KHkYbf1r+iLLRa9V3xe/s/hTVxW/dyfUaDZaqt
         sQsOKQ4yuyCPEAHEI0cznzrYHBp4vArHPOhFNz2UAx0w/4NGWHZHpkd6wKFbE4yK3Wyw
         o8Uw==
X-Gm-Message-State: APjAAAVSaDioMg8os7NoCUEex4BaLpxXr27hFjZC5j9Udc6yfl0sis0c
        KmmC3HyI73hXyZJFCaVyxf2HschvqGn3KchtBHusonU/mOVCkaNVBZ8JPyaDxRVV+op067wXdfe
        PK+eJAYaCk+/lyc9dSlk+Gk9UYHY2LPk4aN8cxQWsWvY=
X-Received: by 2002:a67:af15:: with SMTP id v21mr6125325vsl.161.1581341713014;
        Mon, 10 Feb 2020 05:35:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwunxTs+H78SxNAbJ55o3IgCpw98jkDXvEjQAvQ7nCgWVAjJUEWS6LVwBRLGbpaJq65gzfsfFi3XzWbEdyun2E=
X-Received: by 2002:a67:af15:: with SMTP id v21mr6125315vsl.161.1581341712802;
 Mon, 10 Feb 2020 05:35:12 -0800 (PST)
MIME-Version: 1.0
References: <42e3b88414f473af278b4584b2f1d76b06ddd82a.1581328358.git.lorenzo@kernel.org>
 <87pnemwovp.fsf@tynnyri.adurom.net>
In-Reply-To: <87pnemwovp.fsf@tynnyri.adurom.net>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 10 Feb 2020 14:35:01 +0100
Message-ID: <CAJ0CqmWhmUiv5O_eHckMnY0rFcmHMBit+QOaj09dt1VMK87Bug@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt76u: extend RX scatter gather number
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > From: Sean Wang <sean.wang@mediatek.com>
>
> The From line is twice.

Yes, I figured it out later. Sorry for the noise.

Regards,
Lorenzo

>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

