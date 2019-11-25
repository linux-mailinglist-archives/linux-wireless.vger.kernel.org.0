Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C7108E30
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 13:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKYMuM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 07:50:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbfKYMuM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 07:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574686211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qST0caj82BgWm5tFez550laNhaMPsMmhQKJADufJpJg=;
        b=Oad227wX2p4qed/s5Iss7Ew2szmb7YkSpE/amv3tec0qu6TCTRKJ22E8N0PwRCkqHjs3yJ
        5RFMxvV+JNfjO+7jAC1Pbgpz9Etd6WQbdUsx39mT3BOyFTakMB5QizmbRHfAXOHyfG9krg
        0xEqO28NdyOd8UWQz6dYp2+MT+qal+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-YMgoHMZSOl-Z0UOyBdsHmA-1; Mon, 25 Nov 2019 07:50:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E68BC800EBA;
        Mon, 25 Nov 2019 12:50:07 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BAA85D9E1;
        Mon, 25 Nov 2019 12:49:58 +0000 (UTC)
Date:   Mon, 25 Nov 2019 13:49:57 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v8 4/6] mt76: mt76x02: remove a copy call for usb speedup
Message-ID: <20191125124956.GA28102@redhat.com>
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-5-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191121180001.22451-5-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YMgoHMZSOl-Z0UOyBdsHmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 21, 2019 at 06:59:59PM +0100, Markus Theil wrote:
> +=09if (mt76_is_usb(&dev->mt76)) {
> +=09=09struct mt76x02_txwi *txwi;
> +
> +=09=09mt76_insert_hdr_pad(skb);
> +=09=09txwi =3D (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
> +=09=09mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
> +=09=09skb_push(skb, sizeof(*txwi));
> +=09} else {
> +=09=09struct mt76x02_txwi txwi;

Here lack mt76x02_mac_write_txwi()

> =20
> -=09mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> -=09offset +=3D sizeof(txwi);
> +=09=09mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> +=09=09offset +=3D sizeof(txwi);

> +=09}

Stanislaw

