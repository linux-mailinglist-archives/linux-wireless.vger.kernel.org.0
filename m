Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A341022EB
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfKSLTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 06:19:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40366 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727511AbfKSLTf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 06:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574162374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6hjEFoU1PUvWgG3fQa/+U3s39SSVMM6lhtBG3FWoZ0=;
        b=CCHh8oJBorHtaJHUmzOE9suH70gi4iOhTvcZWD6PyQdEIII0WBtugBH2Zjn8TR6IpXIpfI
        xSZ2g9Z15nd4xaNOYzNZZVdl+uj5Udac5kP8V7yO+IQVV1eM1BV807NzbUzEIaUrekJUbG
        V7BlnSPE8x7wv98QvacqxOB2ZSL+Wuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-BEX-vkyrOM6kebh7al_qqQ-1; Tue, 19 Nov 2019 06:19:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00F92800A02;
        Tue, 19 Nov 2019 11:19:32 +0000 (UTC)
Received: from localhost (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA08D10375D4;
        Tue, 19 Nov 2019 11:19:28 +0000 (UTC)
Date:   Tue, 19 Nov 2019 12:19:27 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH v4 4/4] mt76: mt76x02: add channel switch support for usb
 interfaces
Message-ID: <20191119111927.GB22415@redhat.com>
References: <20191118221540.14886-1-markus.theil@tu-ilmenau.de>
 <20191118221540.14886-5-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191118221540.14886-5-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: BEX-vkyrOM6kebh7al_qqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 18, 2019 at 11:15:40PM +0100, Markus Theil wrote:
> +static void mt76x2u_channel_switch_beacon(struct ieee80211_hw *hw,
> +=09=09=09=09=09  struct ieee80211_vif *vif,
> +=09=09=09=09=09  struct cfg80211_chan_def *chandef)
> +{
> +}
> +
>  const struct ieee80211_ops mt76x2u_ops =3D {
>  =09.tx =3D mt76x02_tx,
>  =09.start =3D mt76x2u_start,
> @@ -121,4 +127,5 @@ const struct ieee80211_ops mt76x2u_ops =3D {
>  =09.get_survey =3D mt76_get_survey,
>  =09.set_tim =3D mt76_set_tim,
>  =09.release_buffered_frames =3D mt76_release_buffered_frames,
> +=09.channel_switch_beacon =3D mt76x2u_channel_switch_beacon,

Is this needed ? Seems mac80211 check against this op being NULL
in drv_channel_switch_beacon() and it is not used otherwise.
=20
Stanislaw

