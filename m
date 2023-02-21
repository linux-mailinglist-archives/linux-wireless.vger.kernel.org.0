Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DF669DD7E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 10:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjBUJ5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 04:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjBUJ5n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 04:57:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4941BF5
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 01:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jLyDkkCJVTxe9e+wCAF7kAPYPDh+jvwGVi3AdFN6hFI=;
        t=1676973461; x=1678183061; b=m6zBnqrj/vYzfbcREUpYJGjs4ANjwNznv6fXB2EXntyTNB2
        0dde1A19eit+yXavdAw9iWJsp2NxjuhiH1FW7n/YMbRTKHlqBJANVj/E15ssp/vwudJ4ZUGCJqTep
        udUbPx9fdOmLLWd7UMvXTZIe9Vhq0+wdY0G9WD0/nU4Ve43FbBVDSyXWUygen/ffAw3U/NDvJ7no6
        8TQzqGwyrue81HlKOnhIiJqR7OwMLk7pc2ZmamkOA5k7R//gSgG50NTfm+RcQiIJCsYy5MESZTpW1
        F41oa/KmS3Zr+7veEZIuavGf9Nk8ywHga7kPMuGS6yJS30afiC1Sv7x560I7kRTw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pUPOz-001Axm-0o;
        Tue, 21 Feb 2023 10:57:37 +0100
Message-ID: <a3f50c4b4e75ff53a5611c3ef2d6345d4324cedb.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: introduce
 ieee80211_refresh_tx_agg_session_timer()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ryder Lee <Ryder.Lee@mediatek.com>
Cc:     Shayne Chen =?UTF-8?Q?=28=E9=99=B3=E8=BB=92=E4=B8=9E=29?= 
        <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?= 
        <Evelyn.Tsai@mediatek.com>
Date:   Tue, 21 Feb 2023 10:57:36 +0100
In-Reply-To: <ed37dd9cfba8d0ec7b50f932742156aaa57843e9.camel@mediatek.com>
References: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
         <44f956b493e33bf394b2947b77e7c86f394b28ed.camel@sipsolutions.net>
         <fea6defb05d0f39d99bce96ea22e8c92d1a939ab.camel@mediatek.com>
         <fb3ab2d925fdeae2e7cc778419c1476102b9f85f.camel@sipsolutions.net>
         <56190740441a6740e9edf761ab2167edc51f20c3.camel@mediatek.com>
         <c05a8b20b5d4429b1c42ef2398ff2bf760bd7eae.camel@mediatek.com>
         <ed37dd9cfba8d0ec7b50f932742156aaa57843e9.camel@mediatek.com>
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

Hi,

> > > Since there's no any keep alive packet being received by host
> > > stack, leads to mac80211 destrory BA sesion.
> > >=20
> >=20
> > More specifically, the BA session relies on client side's Tx data to
>=20
> Typo... I mean *our side*. Something like this

Sorry. I'm just totally confused - I thought the initiator only set the
timeout, but I see now that it's negotiated and the actual value used is
from the client.

Which explains basically everything.

johannes
