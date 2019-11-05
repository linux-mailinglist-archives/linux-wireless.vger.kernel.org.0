Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA93EF7AA
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfKEJAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:00:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59052 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730620AbfKEJAv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572944450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A0dXHozc7tbGLLuPUdikDIKjr15ItbiTzvhW8Ikjjiw=;
        b=H3hxDYAI0445H7rG2VogeGsQNKH3uh58/0L2yI3KQeECJ1seMU+aHgzul2IvVnJeYrDA5E
        /v5Ybqku4M0mRQyYcd25feMwLdedUCAGd+le49+Iw6/m0As6GrpgKFf2dhSwANgFIfPLhL
        989ggegvj0AYdIEMFuH8GLPmibPCTsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ENwsYml4NDabjdzwI8DyHQ-1; Tue, 05 Nov 2019 04:00:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8475B477;
        Tue,  5 Nov 2019 09:00:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 156D01001B32;
        Tue,  5 Nov 2019 09:00:44 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:00:44 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for
 MT7630E"
Message-ID: <20191105090043.GB4422@redhat.com>
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
 <87eeymd98m.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
In-Reply-To: <87eeymd98m.fsf@tynnyri.adurom.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ENwsYml4NDabjdzwI8DyHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 05, 2019 at 10:21:13AM +0200, Kalle Valo wrote:
> Stanislaw Gruszka <sgruszka@redhat.com> writes:
>=20
> > This reverts commit 34b0e9b767bfa09ae233ca0d6ceb299bf2e24600.
> >
> > Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")
> > is no longer necessary to disable HW encryption for MT7630E.
> >
> > Disabling HW encryption helped previously because somehow fragmented
> > skb's are not created if mac80211 encrypt frames, so buffer unmap bug
> > of non-linear skbs was not triggered. Now since this bug if properly
> > fixed by 7bd0650be63c , we can enable HW encryption back.
>=20
> This should be:
>=20
> ... fixed by commit 7bd0650be63c ("mt76: dma: fix buffer unmap with
> non-linear skbs"), we can enable ...

I provided the topic in the first reference of the commit at the top.
Should I do this anytime in the chenglog when a commit is referenced,
even if it's done already ?

Stanislaw

