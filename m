Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67489769790
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jul 2023 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGaN1b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 09:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGaN12 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 09:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0719A1
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690809960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IH7SMZze3utYMvftQj0mT7yLGA+sjq/nHuemyu4/gKg=;
        b=hoILqnxDEshXyTT03NKnjt5QCioFHZJSmjMtXqTSNKlJayP4UwG+TwhLDVl9QkocOdBaMP
        jirLGM5yQArZJ1t9xImsVqMScSCP76YbZwxOSIAmvQvZIdH2VtLLUqaPlZ+klYefs1p0pD
        xhfKlwr6MFgVNY6gI+3G7bKrm8bio3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-x0swh82JOgm8NNfGY7ReQQ-1; Mon, 31 Jul 2023 09:25:55 -0400
X-MC-Unique: x0swh82JOgm8NNfGY7ReQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DFE81DB6C;
        Mon, 31 Jul 2023 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.48.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46D552017DC6;
        Mon, 31 Jul 2023 13:25:54 +0000 (UTC)
Message-ID: <71b912376301abf0cc56ac572a693b4c7adb5660.camel@redhat.com>
Subject: Re: [PATCH 1/6] [v2] wifi: libertas: add missing calls to
 cancel_work_sync()
From:   Dan Williams <dcbw@redhat.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Mon, 31 Jul 2023 08:25:53 -0500
In-Reply-To: <20230725060531.72968-1-dmantipov@yandex.ru>
References: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
         <20230725060531.72968-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-07-25 at 09:04 +0300, Dmitry Antipov wrote:
> Add missing 'cancel_work_sync()' in 'if_sdio_remove()'
> and on error handling path in 'if_sdio_probe()'.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

For the v2 series:

Tested-by: Dan Williams <dcbw@redhat.com>

> ---
> =C2=A0drivers/net/wireless/marvell/libertas/if_sdio.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c
> b/drivers/net/wireless/marvell/libertas/if_sdio.c
> index a63c5e622ee3..a35b33e84670 100644
> --- a/drivers/net/wireless/marvell/libertas/if_sdio.c
> +++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
> @@ -1233,6 +1233,7 @@ static int if_sdio_probe(struct sdio_func
> *func,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flush_workqueue(card->wor=
kqueue);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lbs_remove_card(priv);
> =C2=A0free:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_work_sync(&card->packet=
_worker);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0destroy_workqueue(card->w=
orkqueue);
> =C2=A0err_queue:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (card->packets) {
> @@ -1277,6 +1278,7 @@ static void if_sdio_remove(struct sdio_func
> *func)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lbs_stop_card(card->priv)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lbs_remove_card(card->pri=
v);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cancel_work_sync(&card->packet=
_worker);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0destroy_workqueue(card->w=
orkqueue);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (card->packets) {

