Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81C71EFA21
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfKEJwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:52:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730571AbfKEJwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572947553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMQ5r665JIFQUDd+bQ9cJKc8gwfocbbvK3FCDNguKuU=;
        b=RmnuhTcnyCKxClgS995G1Dh5CQEzT0/AJrw7SSffetb70K9q0WpHu1PduQZhGP6yMr9IQv
        5qE5/nBp7Z9QgifU4C8XDnLsC1MLvHh/iRwWJkMA6YLhT3mnr5wMVP2XkCY3pExXRthnWw
        GHqM0BwQyLzOWro4l2nsATrMELI6Vuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-R0TR4rFAMM2ey_RaywhCIw-1; Tue, 05 Nov 2019 04:52:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4341477;
        Tue,  5 Nov 2019 09:52:28 +0000 (UTC)
Received: from localhost (unknown [10.40.205.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32E115C28D;
        Tue,  5 Nov 2019 09:52:28 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:52:27 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for
 MT7630E"
Message-ID: <20191105095226.GC4422@redhat.com>
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
 <87eeymd98m.fsf@tynnyri.adurom.net>
 <20191105090043.GB4422@redhat.com>
 <20191105090845.GP22393@meh.true.cz>
MIME-Version: 1.0
In-Reply-To: <20191105090845.GP22393@meh.true.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: R0TR4rFAMM2ey_RaywhCIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 05, 2019 at 10:08:45AM +0100, Petr =C5=A0tetiar wrote:
> Stanislaw Gruszka <sgruszka@redhat.com> [2019-11-05 10:00:44]:
>=20
> Hi,
>=20
> > I provided the topic in the first reference of the commit at the top.
> > Should I do this anytime in the chenglog when a commit is referenced,
> > even if it's done already ?
>=20
>  ./scripts/checkpatch.pl 0001-Revert-mt76-mt76x0e-don-t-use-hw-encryption=
-for-MT76.patch
>  ERROR: Please use git commit description style 'commit <12+ chars of sha=
1> ("<title line>")' - ie: 'commit 7bd0650be63c ("mt76: dma: fix buffer unm=
ap with non-linear skbs")'
>  #8:=20
>  Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")

Okay, so I should add word 'commit' before HASH.

>  ERROR: Please use git commit description style 'commit <12+ chars of sha=
1> ("<title line>")' - ie: 'commit 7bd0650be63c ("mt76: dma: fix buffer unm=
ap with non-linear skbs")'
>  #14:=20
>  fixed by 7bd0650be63c , we can enable HW encryption back.

It's not clear if topic is need, but I can change it on the way.
BTW I hate checkpath.pl .

Stanislaw

