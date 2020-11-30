Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D562C877D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 16:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgK3POd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 10:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725899AbgK3POc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 10:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606749186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSgsALnn89SoeLg5KHbRiN2TxKnPTyQgE8nZh0h1p1Q=;
        b=IzefBwU90xjL52REmVBvm+P8vSs28xKuZ2V8JfOfYTvrFs2LEougJz1M72W/6fYQki7sq8
        19SeV64JNNNjeGFmX96QGyjxYt9x180Mh8I5L0jQdVvvlaUPeESfrFbzGTmhJ/iw9fDN73
        2OGPehYYLmGv9PVMO+RvvOavkN8V6/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-LCuDNikEN1mVE1EB6-20xw-1; Mon, 30 Nov 2020 10:13:03 -0500
X-MC-Unique: LCuDNikEN1mVE1EB6-20xw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 949CA8799E0;
        Mon, 30 Nov 2020 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.10.110.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0225960C62;
        Mon, 30 Nov 2020 15:13:01 +0000 (UTC)
Message-ID: <b73c22b0e972cac799ccab0d5ea39a273e464676.camel@redhat.com>
Subject: Re: MT7612U WiFi USB dongle that start ad CDROM (contain Windows
 driver)
From:   Dan Williams <dcbw@redhat.com>
To:     Menion <menion@gmail.com>, linux-wireless@vger.kernel.org
Date:   Mon, 30 Nov 2020 09:13:01 -0600
In-Reply-To: <CAJVZm6foDkE=Y2gxjYrjd-Rk3mkANUC95S0ND2s41uwEhvtf=w@mail.gmail.com>
References: <CAJVZm6foDkE=Y2gxjYrjd-Rk3mkANUC95S0ND2s41uwEhvtf=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-11-30 at 13:57 +0100, Menion wrote:
> Hi all
> 
> I have just received a chinese USB dongle based on Mediatek MT7612U
> that is quite particular...
> 
> When plugged in it starts with VID_0E8D&PID_2870 showing itself as a
> SCSI CDROM, which can be mounted and contains the windows driver. In
> windows, once you install such driver, it switches to the well known
> VID_0E8D&PID_7612 detected as a Mediatek adapter and working ok.
> 
> In Linux of course it remains stuck at the "CDROM mode".
> 
> Is it something known at mt76 development and that can be managed?

This is usually handled by the usb_modeswitch utility. Do you have it
installed? If you do, you may need to add the USB IDs to it.

Dan

