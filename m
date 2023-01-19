Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97C6743E3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjASVEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 16:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjASVCQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 16:02:16 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8A9AA88
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 12:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LC39MpVaV8duXIaHo3qOPQtlG1WSCbIWeXkRzwUvhLM=;
        t=1674161878; x=1675371478; b=NYtGs9Xmm8lk1DPCWxSiClPOrcOXbVUIlJ7EJxRtmQ1HUuF
        AQ6RUzNDFTnOslAMRSzJsJfIasFawzk/B9srfEt7xyZ1KjD4WGIqXzpdPQ9g4FG2tQE3f/0q1J1Ly
        IyEvVZEMs7EcxzfLrq7kx2VTiiFAusx1yfIaStOGC/lE+LHyG2N7vWKpzp7/YqxzA9zfO3NWhWpmX
        SReaSNx5vl+u1Kttix++fLatmMxpWH8ZcvAK42YZEdKZRzMIyYwX88jhXyeKDH/et65fE3VInddLb
        n4H6hOKov46+O/IF4DXscj4PwQE0G9vcRDPC+FINHZu6nvvm4PBoxPSvzq9+ENmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIbyq-006fFp-0Z;
        Thu, 19 Jan 2023 21:57:52 +0100
Message-ID: <e7ed3ad587328dead597294fa4369ff0e3f0c775.camel@sipsolutions.net>
Subject: Re: [RFC 2/2] wifi: mac80211: use link_id from ieee80211_rx_status
 to retrieve rx link
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 19 Jan 2023 21:57:51 +0100
In-Reply-To: <124e5f40-04b4-21be-9e37-bc01633e8e7a@quicinc.com>
References: <20220802065019.20791-1-quic_vthiagar@quicinc.com>
         <20220802065019.20791-3-quic_vthiagar@quicinc.com>
         <103f62efc89d86773fbd07729326f3ba08f4ea23.camel@sipsolutions.net>
         <124e5f40-04b4-21be-9e37-bc01633e8e7a@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So I'm digging through old email before I declare myself bankrupt on
that ...

> >=20
> > OTOH, could there be races, e.g. while disabling a link?
>=20
> I assume this is for the packets where the received on a
> link which is disabled? May be driver sets that link but
> that link will not be valid in mac80211 while processing
> this packet and the packet will be dropped? Or may be
> a different race you are mentioning?
>=20

Yes that's what I was thinking of.

johannes
