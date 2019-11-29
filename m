Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233E510D5FA
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Nov 2019 14:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2NGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Nov 2019 08:06:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58420 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfK2NGj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Nov 2019 08:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575032797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R/wziVUSrBOxmIM8PBrx+WhYxbipUu9ohrnHOyo9ENU=;
        b=c2WceZ7NPCkqomDzBR0yXbCktbNKUAilatyRQwgkAa3Waj4zWBFjbvhmSEzxUb6XDyn+lq
        3TQqRuVRTeiagxhTMOPcDDHqYdQiZZndjtjA7qGJij0wxj19F1eF+E1YJ/UJLlTmhXRYzy
        ORDk+YZn3w1p4fRzwfUncOaXQGMqVoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-hPnf9BaWOZOAWHKVnT7eQw-1; Fri, 29 Nov 2019 08:06:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F110B64A91;
        Fri, 29 Nov 2019 13:06:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 990485D9E1;
        Fri, 29 Nov 2019 13:06:32 +0000 (UTC)
Date:   Fri, 29 Nov 2019 14:06:30 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: Re: [PATCH 1/3] mt76: usb: use max packet length for m76u_copy
Message-ID: <20191129130630.GA2497@redhat.com>
References: <1575030748-2218-1-git-send-email-sgruszka@redhat.com>
 <1575030748-2218-2-git-send-email-sgruszka@redhat.com>
 <20191129124744.GE32696@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191129124744.GE32696@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: hPnf9BaWOZOAWHKVnT7eQw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 29, 2019 at 02:47:44PM +0200, Lorenzo Bianconi wrote:
> > +=09usb->data_len =3D usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1);
> > +=09if (usb->data_len < 32)
> > +=09=09usb->data_len =3D 32;
>=20
> Hi Stanislaw,
>=20
> =09usb->data_len =3D max_t(u16, 32,
> =09=09=09      usb_maxpacket(udev, usb_sndctrlpipe(udev, 0), 1));
>=20

Why this is better ?

> Moreover are you sure using ctrl endpoint 0 is fine for all devices?

usb_sndctrlpipe(udev, 0) is used in __mt76u_vendor_request() for all=20
out requests i.e. on all cases were usb->data is used.

Stanislaw=20

