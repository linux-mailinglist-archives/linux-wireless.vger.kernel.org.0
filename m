Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93E476012C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjGXV20 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXV2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 17:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA6D8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690234060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTHtCxiaw+G+3cPIEefGlFo0mE2+5VAcxjsU3N0qfQ0=;
        b=ScBHTAMGNvoHyf59L0DESCohgin7vhZxMNwUSgyh6Tur0rb2T8hrngcpkR7RHSJJKujxlj
        oD2AA1pMK/CqI1tiVJnCT4oO0y24VrH1mLSXUH+ODFnnqii3vIGeqQciC7jpFSCsm8rZy0
        WRxYpTldU1pBXQAspk3MkyWSe8mTJzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-dz3VVKzsOiu2lqeFlIjifQ-1; Mon, 24 Jul 2023 17:27:38 -0400
X-MC-Unique: dz3VVKzsOiu2lqeFlIjifQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCC4B185A792;
        Mon, 24 Jul 2023 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.50.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB3A492C13;
        Mon, 24 Jul 2023 21:27:36 +0000 (UTC)
Message-ID: <d7262341b0d3b635403f9d19ff2d381f7a543c2a.camel@redhat.com>
Subject: Re: [PATCH 1/4] wifi: libertas: add missing calls to
 cancel_work_sync()
From:   Dan Williams <dcbw@redhat.com>
To:     Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Doug Brown <doug@schmorgal.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Date:   Mon, 24 Jul 2023 16:27:35 -0500
In-Reply-To: <87cz0h3d1q.fsf@kernel.org>
References: <20230724084457.64995-1-dmantipov@yandex.ru>
         <87cz0h3d1q.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-07-24 at 11:54 +0300, Kalle Valo wrote:
> Dmitry Antipov <dmantipov@yandex.ru> writes:
>=20
> > Add missing 'cancel_work_sync()' in 'if_sdio_remove()'
> > and on error handling path in 'if_sdio_probe()'.
> >=20
> > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>=20
> How have you tested these patches?
>=20

I can try to give the SDIO bits a run this week on an 8686. I don't
have a SPI setup to test though.

Dan

