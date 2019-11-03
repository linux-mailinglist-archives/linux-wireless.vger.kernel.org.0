Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B514ED39C
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2019 15:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfKCOr7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Nov 2019 09:47:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727425AbfKCOr7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Nov 2019 09:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572792478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCOHtz6wgUop435yEkW55CbTp67ZnD/d/h2ap1cDigc=;
        b=QvHCcQ+1BJNZ1sQclcVmvDn3BH5XfmBjzEYH8l14zZcdoobAWd+bXJKraGPuDxrWsnjwfB
        0GXzypOgS8KdyG+6kBzrP9N7MVlXiOlg9BUFvuYmA/qsOvSFIYnnnxR0HmMLDUbxqI708u
        RL5RKRmbOCoNNhPkSXscjyTxnX/nuEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-HPnmqdT2OVmJiZLu2Kzi6g-1; Sun, 03 Nov 2019 09:47:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1B91005500;
        Sun,  3 Nov 2019 14:47:52 +0000 (UTC)
Received: from localhost (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6540C5D6BE;
        Sun,  3 Nov 2019 14:47:51 +0000 (UTC)
Date:   Sun, 3 Nov 2019 15:47:50 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191103144749.GA8889@redhat.com>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
 <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org>
MIME-Version: 1.0
In-Reply-To: <20191102174227.GA1250@makrotopia.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HPnmqdT2OVmJiZLu2Kzi6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Nov 02, 2019 at 06:42:27PM +0100, Daniel Golle wrote:
> > This was changed by:
> >=20
> > commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
> > Author: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
> > Date:   Thu Dec 27 15:05:25 2018 +0100
> >=20
> >     rt2x00: reduce tx power to nominal level on RT6352
> >=20
> > and I think it is correct.
>=20
> Ah, ok, that's a bit funny, because it means that this change actually
> never made any difference, because the codepath wasn't executed.

Yes, this was used/tested on patched rt2x00 driver that switch to this
different codepath. Now it will be used by default :-)

Stanislaw

