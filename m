Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27A8ED39F
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2019 15:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfKCOsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Nov 2019 09:48:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32789 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727541AbfKCOsw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Nov 2019 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572792531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dEApro5sP5wB+MyTac09JJfTVmTjYAsOlPQfu4eNumc=;
        b=HoLsCEPAwnogDTmGijk8vOqQQ3Wgbf5aAYcmVkbKRbr5DM9fuYZ03ptoMvCXBHRdCKIwvt
        zEhiPfM61babYBI5SBuWDJe2EtQHFhXTM6noXri8d6CZb5mQqupWcg1eZU2UAdiuQ+WJdj
        3FisWXHeL2mSkZDvv2VBSjHAHsL6wOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-eS1J5Sj6PBW3hQQQSPBA6A-1; Sun, 03 Nov 2019 09:48:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E83561005500;
        Sun,  3 Nov 2019 14:48:46 +0000 (UTC)
Received: from localhost (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9C35D6BE;
        Sun,  3 Nov 2019 14:48:46 +0000 (UTC)
Date:   Sun, 3 Nov 2019 15:48:45 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH v2] rt2800: remove errornous duplicate condition
Message-ID: <20191103144844.GB8889@redhat.com>
References: <20191102154639.GA4589@redhat.com>
 <20191102174701.GA1489@makrotopia.org>
MIME-Version: 1.0
In-Reply-To: <20191102174701.GA1489@makrotopia.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eS1J5Sj6PBW3hQQQSPBA6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Nov 02, 2019 at 06:47:01PM +0100, Daniel Golle wrote:
> On 2019-10-28 06:07, wbob wrote:
> > Hello Roman,
> >
> > while reading around drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> > I stumbled on what I think is an edit of yours made in error in march
> > 2017:
> >
> > https://github.com/torvalds/linux/commit/41977e86#diff-dae5dc10da180f3b=
055809a48118e18aR5281
> >
> > RT6352 in line 5281 should not have been introduced as the "else if"
> > below line 5291 can then not take effect for a RT6352 device. Another
> > possibility is for line 5291 to be not for RT6352, but this seems
> > very unlikely. Are you able to clarify still after this substantial tim=
e?
> >
> > 5277: static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
> > ...
> > 5279:  } else if (rt2x00_rt(rt2x00dev, RT5390) ||
> > 5280:         rt2x00_rt(rt2x00dev, RT5392) ||
> > 5281:         rt2x00_rt(rt2x00dev, RT6352)) {
> > ...
> > 5291:  } else if (rt2x00_rt(rt2x00dev, RT6352)) {
> > ...
>=20
> Hence remove errornous line 5281 to make the driver actually
> execute the correct initialization routine for MT7620 chips.
>=20
> As it was requested by Stanislaw Gruszka remove setting values of
> MIMO_PS_CFG and TX_PIN_CFG. MIMO_PS_CFG is responsible for MIMO
> power-safe mode (which is disabled), hence we can drop setting it.
> TX_PIN_CFG is set correctly in other functions, and as setting this
> value breaks some devices, rather don't set it here during init, but
> only modify it later on.
>=20
> Fixes: 41977e86c984 ("rt2x00: add support for MT7620")
> Reported-by: wbob <wbob@jify.de>
> Reported-by: Roman Yeryomin <roman@advem.lv>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

