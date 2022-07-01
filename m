Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED2563023
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiGAJbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiGAJbG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:31:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58E4882C
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=5+6uSfNrB5MmlUrZcyQBSdS5AzXGnKPJWPeRaxv3bjc=;
        t=1656667865; x=1657877465; b=ZRaOj0z8u7dCcxcteYJx2G9cZXSSAsLRc7iRubD/3oMB/i5
        PGYgkyGoYGR630NG3KsxVcw/DI273UowZBoj+Ym1o8yJSC4xCOAlAIcacz3hyoiGsw4TSMjh1Y/DP
        RkpLP9tIETLR3kK+uGXlrNbT4Q/7dl4DwC6Js039kfQR8lf6FNNcWWpl9XMuClBc2yBHw2B/96nFA
        8FzlGLMF99YQ19Wgn9J0tjkO7Ac9ZZNeFrkDUCXaxJhXRzu6pNg0lxfA+u0H6ZXsGcu/gvoFkKWIi
        mg158tLfMYWJtztFQILaJtc/KzzNoNvGW2/FWF3AskupUttYgmF2ILXo4go8qupQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7CzQ-003QNc-2P;
        Fri, 01 Jul 2022 11:31:04 +0200
Message-ID: <83e4ceafddc3227934b520368dcc2cdca680171d.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix mesh airtime link metric estimating
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 01 Jul 2022 11:31:03 +0200
In-Reply-To: <20220601070115.24340-1-quic_adisi@quicinc.com>
References: <20220601070115.24340-1-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-06-01 at 12:31 +0530, Aditya Kumar Singh wrote:
>=20
> +	/* use rate info set by the driver directly if present */
> +	if (st->rate)
> +		rinfo =3D sta->tx_stats.last_rate_info;
>=20

This doesn't apply anymore due to 44fa75f207d8 ("mac80211: extend
current rate control tx status API") and the MLO work.

johannes
