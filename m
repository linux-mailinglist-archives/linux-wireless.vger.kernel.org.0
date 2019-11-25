Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5011092DB
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 18:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfKYRcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 12:32:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbfKYRcU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 12:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574703139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HuDRBPC56+3xBWkw3V6fbo/ygoJ85VXBh/ifc8c+60c=;
        b=CuGSa/pHefoMTe3++ybtI+M9RJxcflEsV45z7MNDyWx+RmKSwqtZzAPK5X5JTivPRwjNOp
        JQPIK+6n6TMyifmoSQs3HIT0IbezsekJZfEWz5BkRbaX54VHbqGYUXTtW36rFdLDkrOWqT
        yAot8Qv+OfGV1xsqRc+hxFHFc7wCuII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-FU5_n-INO_KXNuD17u2xAw-1; Mon, 25 Nov 2019 12:32:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B756E89A08B;
        Mon, 25 Nov 2019 17:32:14 +0000 (UTC)
Received: from localhost (ovpn-204-116.brq.redhat.com [10.40.204.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5322719C7F;
        Mon, 25 Nov 2019 17:32:11 +0000 (UTC)
Date:   Mon, 25 Nov 2019 18:32:10 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v8 2/6] mt76: mt76x02: split beaconing
Message-ID: <20191125173209.GA15755@redhat.com>
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-3-markus.theil@tu-ilmenau.de>
 <20191125130014.GB28102@redhat.com>
 <ec1b9623-2aa1-27c7-abcd-2b39e0d25a0c@tu-ilmenau.de>
 <20191125165932.GB14273@redhat.com>
 <40c52ae5-85d8-8a65-2b4b-1a52bf1b73ab@nbd.name>
MIME-Version: 1.0
In-Reply-To: <40c52ae5-85d8-8a65-2b4b-1a52bf1b73ab@nbd.name>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: FU5_n-INO_KXNuD17u2xAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 25, 2019 at 06:12:56PM +0100, Felix Fietkau wrote:
> On 2019-11-25 17:59, Stanislaw Gruszka wrote:
> > On Mon, Nov 25, 2019 at 03:07:59PM +0100, Markus Theil wrote:
> >> On 11/25/19 2:00 PM, Stanislaw Gruszka wrote:
> >> > On Thu, Nov 21, 2019 at 06:59:57PM +0100, Markus Theil wrote:
> >> >> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
> >> >> +{
> >> >> +=09mt76_wr(dev, MT_BCN_BYPASS_MASK,
> >> >> +=09=090xff00 | ~bitrev8(dev->beacon_data_mask));
> >> > Since you arrange beacon slots continues starting from 0
> >> > (i.e. 0,1,2 instead of "random" vif_idx values like 0,4,6),
> >> > I think it would make sense to keep
> >> > MT_MAC_BSSID_DW1_MBEACON_N =3D bcn_idx - 1 and set mask unchanged.
> >> >
> >> > But no strong opinion here, code with bitrev8 looks fine too.
> >> I'd like to keep the bitrev8 code, as it saves a copy over usb for usb
> >> devices, if MT_MAC_BSSID_DW_BEACON_N is kept constant.
> >> bitrev8 should be a rather cheap operation compared to a copy over som=
e
> >> form of bus.
> >=20
> > This make sense. I tested the code on MT7630E and after adding missed
> > write_txwi function, it works fine. So I think bitrev8 code is ok.
> I find the use of bitrev8/ffz a bit convoluted. If I understand the code
> right, wouldn't it be equivalent to keeping beacon_data_count instead of
> beacon_data_mask and doing:
> mt76_wr(dev, MT_BCN_BYPASS_MASK,
> =090xffff & ~((1 << dev->beacon_data_count) - 1));
> If so, I would strongly prefer the beacon_data_count variant. It's also
> cheaper to calculate, though that probably doesn't matter, since it's
> not really a hot path.

Yes, with new code simple count can be used instead of mask. I did not
pointed this, as it can be further optimization on top of Markus
patches.

Stanislaw=20

