Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57077573AFB
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiGMQQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiGMQQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 12:16:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195A50062
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HNZsipPkFCinkV6SSp03xjvZKbBwg17sSyflofmky0w=;
        t=1657728984; x=1658938584; b=A7B1zLQmZ3VCurq0iA0ZPj2zEx9jRJvHyCDyKM3vpx8xoKE
        stV9ZfL8U+HD47mH2y5OmxGLvbzvNE0MuIN44YUOCdpxOh4D2S/q5TgqqkyladzkDk7h91p5ozqHi
        GqVONUeD44CPAHjWh4Cr5DAGw+ookKSVJRCzP99GVAC3KIghZyXQhJyJ/was+4H09TuNteZzUBCXZ
        0oJWXmq03xg9SrER6GooZ6BxXRdUKSP3ssHATwqiy0zMgdWlz+OvsQCPfT5+EyrRLClHBrDHiaPdK
        3P5+uxQ8I4dwQmibR63ogZtJPnIvmeqMQn+Rdq3mK/qqxEwnK03p+3b9e8Y2pv6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBf2E-00EoX6-DS;
        Wed, 13 Jul 2022 18:16:22 +0200
Message-ID: <d2f68ad4dbe7157fcd5b405a0f12176e03dafe70.camel@sipsolutions.net>
Subject: Re: [PATCH 03/76] wifi: mac80211: rx: accept link-addressed frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 13 Jul 2022 18:16:21 +0200
In-Reply-To: <bc928f09-cdbc-b5e5-c2f2-0c13ba3ebadb@quicinc.com>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
         <20220713114425.bf1302a63e1c.Idcd337705a4d1737a89bf9247ba73f82a0fc8b61@changeid>
         <bc928f09-cdbc-b5e5-c2f2-0c13ba3ebadb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
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

On Wed, 2022-07-13 at 09:14 -0700, Jeff Johnson wrote:
> On 7/13/2022 2:43 AM, Johannes Berg wrote:
> >    * This structure is the "EHT Operation Element" fields as
> > - * described in P802.11be_D1.4 section 9.4.2.311
> > + * described in P802.11be_D1.5 section 9.4.2.311
>=20
> In D2.0 this has changed to add the fixed 4-octet Basic EHT-MCS
> And Nss Set before the variable-length EHT Operation
> Information
>=20
> Do you have a timeline to incorporate D2.0 changes?
>=20

Erm. I don't know what happened with this patch - it shouldn't have had
this contents ...

But yes we also have D2.0 changes prepared somewhere.

johannes
