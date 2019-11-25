Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39211108E5A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKYNAx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 08:00:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32263 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727193AbfKYNAx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 08:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574686852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ei2CrnbESd5GSxM6GttcVO/Q52SW6tsUqi7p6nfmnqM=;
        b=NXm3Ea7Nw1QB5L7tES+Cr2Ut7CgvWMrLBHYPQwrQRwStNMxK6SIwu8u3TjW2JdXyDP0BHW
        zb5sJUAdg1L6jItEcf9/HcL6A1VPUsdSeUh6p9SEwG/EV3qWK62ez22SsBsiWQbEkJBt9s
        VbjHNclnBuoDCnmmuZrNCqj0Izv9uyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ym38DaT6PHW1usoSAWY3IQ-1; Mon, 25 Nov 2019 08:00:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 414AE184CAD7;
        Mon, 25 Nov 2019 13:00:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2C22608D2;
        Mon, 25 Nov 2019 13:00:16 +0000 (UTC)
Date:   Mon, 25 Nov 2019 14:00:15 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v8 2/6] mt76: mt76x02: split beaconing
Message-ID: <20191125130014.GB28102@redhat.com>
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-3-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191121180001.22451-3-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ym38DaT6PHW1usoSAWY3IQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Nov 21, 2019 at 06:59:57PM +0100, Markus Theil wrote:
> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
> +{
> +=09mt76_wr(dev, MT_BCN_BYPASS_MASK,
> +=09=090xff00 | ~bitrev8(dev->beacon_data_mask));

Since you arrange beacon slots continues starting from 0
(i.e. 0,1,2 instead of "random" vif_idx values like 0,4,6),
I think it would make sense to keep
MT_MAC_BSSID_DW1_MBEACON_N =3D bcn_idx - 1 and set mask unchanged.

But no strong opinion here, code with bitrev8 looks fine too.

>  static void mt76x02u_beacon_enable(struct mt76x02_dev *dev, bool en)
>  {
> -=09int i;
> -
>  =09if (WARN_ON_ONCE(!dev->mt76.beacon_int))
>  =09=09return;
> =20
>  =09if (en) {
>  =09=09mt76x02u_start_pre_tbtt_timer(dev);
> -=09} else {
> -=09=09/* Timer is already stopped, only clean up
> -=09=09 * PS buffered frames if any.
> -=09=09 */

Please keep comment that timer is already disabled and
nothing else is needed.

Stanislaw

