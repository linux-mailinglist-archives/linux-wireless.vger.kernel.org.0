Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19FC3C9178
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhGNUCE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbhGNT5y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 15:57:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D478C0613EF
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=X3NTtRZZfavq8tUwtnJa4YEwGxb8+reN+LzCH02gIG4=;
        t=1626292100; x=1627501700; b=hF1sD1lkdCk+cSPKmcTK72vDnnWXu22oU3ISiCiRP+mDedJ
        7Er5GcwVr2Jgpowed3kDqxs/4+lK7icIzBTvh/dbJNTV1Vi4jpmu7VGXFVkHp/pWMdYHjafrtJaW+
        fy5DORwUjaxgceBEw11P7aqVAcgq1FGI75tOavWSY/1A9dUeN5B/J4VX8xaaXZnlayaemf0wboDxX
        PhQTe+kuJClHmr1OFS9Cj8e32TsDOfNaF4S9RLL0InebA77czwawBcg7RO1cfAWKrwEHEybwVyYHi
        IhTojMw1h65zTgu2g5s1yHQlOG/nlfuw4XWw1arrJ+LvXVUkgnjIZssfs151j7VA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m3krd-002Jd6-EI; Wed, 14 Jul 2021 21:48:13 +0200
Message-ID: <bf14b6de4229f18ab2dc7fa6a971f77638fc50c0.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7915: fix endianness warnings in mu radiotap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 14 Jul 2021 21:48:12 +0200
In-Reply-To: <042666b307b7a424680bd20b6ac3bd3a74e3a1f7.1626291427.git.ryder.lee@mediatek.com>
References: <042666b307b7a424680bd20b6ac3bd3a74e3a1f7.1626291427.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> 
> -	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, cpu_to_le32(rxv[3]));
> +	he_mu->ru_ch1[0] = FIELD_GET(MT_CRXV_HE_RU0, le32_to_cpu(rxv[3]));

Instead of

	FIELD_GET(MASK, le32_to_cpu(value))

you should probably consider

	le32_get_bits(value, MASK)

(not really sure why the order of arguments got inverted though ...)

We might even consider doing an spatch to get rid of all the FIELD_GET()
I guess.

johannes

