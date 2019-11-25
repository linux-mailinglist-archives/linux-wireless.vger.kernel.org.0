Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5110926D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfKYQ7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:59:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728976AbfKYQ7o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574701183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hAA0sawVzh/zjEVh6owwytHkLmg4SFOKa07zp/0Dsw=;
        b=PiNgLzAv4NZhVoOIn939pDbPO8jmXRjm0tWaiIr68ivnFjV86ddovSZcci885UtdrH8Q7V
        9opneIuMcRGZOl3+0BM/tAzhSFSedmb9jEN1mD8VaVqnt2Jc4LfFOhlqZFInyBb/mBedTW
        fB8Hmjb5Uh1yVYur8MMyrXwvomOmWDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-mT98KPTiPbS82050OmZH1A-1; Mon, 25 Nov 2019 11:59:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C985E108595B;
        Mon, 25 Nov 2019 16:59:38 +0000 (UTC)
Received: from localhost (ovpn-204-116.brq.redhat.com [10.40.204.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7847C60C18;
        Mon, 25 Nov 2019 16:59:34 +0000 (UTC)
Date:   Mon, 25 Nov 2019 17:59:33 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v8 2/6] mt76: mt76x02: split beaconing
Message-ID: <20191125165932.GB14273@redhat.com>
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-3-markus.theil@tu-ilmenau.de>
 <20191125130014.GB28102@redhat.com>
 <ec1b9623-2aa1-27c7-abcd-2b39e0d25a0c@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <ec1b9623-2aa1-27c7-abcd-2b39e0d25a0c@tu-ilmenau.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: mT98KPTiPbS82050OmZH1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 25, 2019 at 03:07:59PM +0100, Markus Theil wrote:
> On 11/25/19 2:00 PM, Stanislaw Gruszka wrote:
> > On Thu, Nov 21, 2019 at 06:59:57PM +0100, Markus Theil wrote:
> >> +void mt76x02_mac_set_beacon_finish(struct mt76x02_dev *dev)
> >> +{
> >> +=09mt76_wr(dev, MT_BCN_BYPASS_MASK,
> >> +=09=090xff00 | ~bitrev8(dev->beacon_data_mask));
> > Since you arrange beacon slots continues starting from 0
> > (i.e. 0,1,2 instead of "random" vif_idx values like 0,4,6),
> > I think it would make sense to keep
> > MT_MAC_BSSID_DW1_MBEACON_N =3D bcn_idx - 1 and set mask unchanged.
> >
> > But no strong opinion here, code with bitrev8 looks fine too.
> I'd like to keep the bitrev8 code, as it saves a copy over usb for usb
> devices, if MT_MAC_BSSID_DW_BEACON_N is kept constant.
> bitrev8 should be a rather cheap operation compared to a copy over some
> form of bus.

This make sense. I tested the code on MT7630E and after adding missed
write_txwi function, it works fine. So I think bitrev8 code is ok.

Stanislaw

