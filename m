Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2627A1D8
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 18:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0Q1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 12:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgI0Q1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 12:27:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601224040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TTOLWWVvZH3dnHKx/GOq2MeUgR/99UfYnDNEc8Vmf/4=;
        b=e1ITxvK7NFLDqiM/g2qkuUBLau1UsNSTQ9Tblc0TOn5i5AiRYx4BrVEg+Vj7r8KZO2dq+C
        +hmGfIqAxiWBFRCocNT5dPoW32m92ZK10RHbB8OHAA1acHtIsCp5M89S0Y+B8x4AtHV33n
        RZZLPNSoYruEZsimQoZBVorMR2UQz/c=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-iGTGVaPXN--RDsVu2ThoAg-1; Sun, 27 Sep 2020 12:27:18 -0400
X-MC-Unique: iGTGVaPXN--RDsVu2ThoAg-1
Received: by mail-vs1-f70.google.com with SMTP id f2so3125020vsp.8
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 09:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTOLWWVvZH3dnHKx/GOq2MeUgR/99UfYnDNEc8Vmf/4=;
        b=gDsJ9qUFMQJI0RLRHl9DJUpZT5QqehgcnLM20s3woEDii0Cl6pDKEGBtxYVPedIp5P
         3Yasniuda4EQoXujUAIIO5TnNEsKrL//Deksr3jU9LbJCmeHO7k0id95qE9uPrwlVN9U
         oNQtu9AfSkSS5C0b1FD2DjrLUM1KKZ0DFC4emiML3Hn6uTV+JUDh6BrVdi3lWYA5oY7w
         6PcnMSqvA3Ud5uJIEQPB/+MBbPAeQJpuAyhiBDwxntWLlhQrg43T5B9VNl2Jkx2bqtwm
         BfP12lh4CteD90oGq/67m9qhACZWGtMc3J1rZ9RKJIy5GEpNsR8uv7NzbpbKNaI2pk3p
         30zQ==
X-Gm-Message-State: AOAM531DICMsGizl+BeKQtvXQcf6O5Xtk+tq4N1c54y+GRLjrMJq8J4k
        LcvLBiVIOVlgAAeHvgb6VkD57Aq+302diko0pHcqpn+Dj6lu4j3vqvDoAdBhJU+JdA6dC6q+uf3
        3KLKrPHbaxgGsjIYk0QDx1LFZ39ZB/J+QSx9QcG3xzQY=
X-Received: by 2002:a67:e197:: with SMTP id e23mr3290258vsl.7.1601224037889;
        Sun, 27 Sep 2020 09:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPsTrNOLlw7uV972JgOWJ975sFjEzTU4bW2X/qqzh5nzEIozaEQ3N8g/cpnEGZL9KoQwk7zjhS2eEsLLeNAiw=
X-Received: by 2002:a67:e197:: with SMTP id e23mr3290254vsl.7.1601224037628;
 Sun, 27 Sep 2020 09:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <bfe45686ca8d8b5db2b27e33859bea7450f7b920.1601133687.git.lorenzo@kernel.org>
 <a4e15f9f-a296-f862-6216-ed3b40423aa7@nbd.name>
In-Reply-To: <a4e15f9f-a296-f862-6216-ed3b40423aa7@nbd.name>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 27 Sep 2020 18:27:06 +0200
Message-ID: <CAJ0CqmU7TwUuuSJLVMM-ymgRigM-YuNDBrSOgzHi1R-wcFjr=g@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7615: enable beacon filtering by default for
 offload fw
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 2020-09-26 17:22, Lorenzo Bianconi wrote:
> > In order to reduce cpu cycles, enable hw beacon filter by default if the
> > device is running offload fw
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> The beacon filtering part and runtime pm needs to take into account that
> there could be more than one vif and we might be running an AP as well.
>
> - Felix
>

Do you mean we should run mt7615_mcu_set_bss_pm() for other vif types, e.g. AP?
IIUC the fw can manage the rx beacon offload even for other modes.

@Sean: do we need to send any other message to mcu for rx beacon
offload for AP mode? Can the fw properly manage it?

Regards,
Lorenzo

