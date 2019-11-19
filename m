Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA74102270
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKSK6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 05:58:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60881 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfKSK6s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 05:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574161127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9RRQaqApybirBVwaqlV8LsiP6BMNbnhSNOvj3A37lSs=;
        b=eBTmnV6B/FSYm9bGcJVjVnJCSOhq7zNCBOY61OLhO4ZzxIzNXMQtV0wMkaRTRIE/eZmBQw
        4d4t6OUzstnavEysqjJ8hOAiBcZs0IswYcHZI0LaKuXoZGsP1HcaYvQgvczfAqYF/Jx30W
        PuWQRlsojn8RQRNDPW7zNobsD8MXmf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-6XZef543MHmwSUPCuBUgsg-1; Tue, 19 Nov 2019 05:58:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 195841005514;
        Tue, 19 Nov 2019 10:58:42 +0000 (UTC)
Received: from localhost (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFC8A10002B8;
        Tue, 19 Nov 2019 10:58:38 +0000 (UTC)
Date:   Tue, 19 Nov 2019 11:58:37 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>, nbd@nbd.name,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 3/4] mt76: speed up usb bulk copy
Message-ID: <20191119105832.GA22415@redhat.com>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
 <20191116111709.4686-4-markus.theil@tu-ilmenau.de>
 <20191116114312.GC20820@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191116114312.GC20820@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6XZef543MHmwSUPCuBUgsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Nov 16, 2019 at 01:43:12PM +0200, Lorenzo Bianconi wrote:
> > +=09=09memcpy(usb->data, val + i, current_batch_size);
> >  =09=09ret =3D __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
> >  =09=09=09=09=09     USB_DIR_OUT | USB_TYPE_VENDOR,
> > -=09=09=09=09=09     0, offset + i * 4, usb->data,
> > -=09=09=09=09=09     sizeof(u32));
> > +=09=09=09=09=09     0, offset + i, usb->data,
> > +=09=09=09=09=09     current_batch_size);
>=20
> @Stanislaw: I vaguely remember you reported some issues if the burst size=
=20
> is greater than 4B (but I can be wrong)

It didn't work as usb vendor requests which were not multiple of 4
were not transferred to the device on some usb host. But this is
properly handled by the latest version of this patch set.
=20
Stanislaw


