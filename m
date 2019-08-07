Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2B848EC
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfHGJxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 05:53:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33685 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfHGJxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 05:53:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so101773281otl.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2019 02:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMxxaYMNhsVkHAwjLsRQ+Va5Bl8WBpCpGQ5RJ5DRFdc=;
        b=nVNn14aeBsr84P8VlBygCnRDd9tbiq8xDn3GcnpEPdlpVTjoRHAsqxFJLGmZG4H9eV
         RdDdG8AAQlVimQZk8ir0YKK1Oi4bjcSxWRl+VfziHCmFAQ1X/dPJPCuTdCcTqZV4pQ0S
         Jv5I7URx56zYVgF4jewHxFERQ94pN3Aw9r+E1pgBUDbYnCvw0yodGf/9KHE2/bw74oy2
         Sr5DzfwiRd99jVL5WU/uPujmvya00Q/tHFl8T3VSzzfDZTVrlGalaIiVcH+0xok1Xtia
         x5GQXWA6IdrwQACtHAnx/AJdfLAfRlj+aBQm1DUvduFjK2YLBU4B3YuAuFZwQUuQaJHh
         c7fA==
X-Gm-Message-State: APjAAAXVWr7Hk4Nv+xcpDOLZjUqCRtjr6GZgfj8OWy7vfXUWgoMaedr8
        lPrv0KDOBYGZsfDP/bJ2IEZWtXSby5onJ/2lpoePmg==
X-Google-Smtp-Source: APXvYqx6FNc0tHnFd7hSHmvUIak80hYS9tFGF369OJ1VN4WJfFucgAFgTXI/OcRaF3O0lb/ihwrIDV9qtxG5xKDj2lY=
X-Received: by 2002:a5d:885a:: with SMTP id t26mr7859669ios.218.1565171597543;
 Wed, 07 Aug 2019 02:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <527fdc4e453cbc1408500625c0080d9c59d9e1dd.1565112514.git.lorenzo@kernel.org>
 <e83840e9-06cf-bab9-ed3e-954e3f03c083@nbd.name>
In-Reply-To: <e83840e9-06cf-bab9-ed3e-954e3f03c083@nbd.name>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Wed, 7 Aug 2019 11:53:05 +0200
Message-ID: <CAJ0CqmWOh+oQ3_1mdpoKkDeiRCd5pOCrfk-GfL1qRYEyX1zRjQ@mail.gmail.com>
Subject: Re: [PATCH] mt76: move mt76_tx_tasklet in mt76 module
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 2019-08-06 19:31, Lorenzo Bianconi wrote:
> > Move mt76{15,03}_tx_tasklet in mt76 module since it is shared between
> > mt7615 and mt7603 drivers
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I think it would be nice to get rid of the EXPORT_SYMBOL_GPL for
> mt76_tx_tasklet by moving the tasklet_init call to mt76_alloc_device().
>
> That way, dev->mt76.tx_tasklet will be set to mt76_tx_tasklet by
> default, but automatically overwritten for drivers that have custom
> implementations (76x02 / usb).
>
> - Felix

ack, I agree. I will fix it in v2. Thanks.

Regards,
Lorenzo
