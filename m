Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF073075B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjFNScz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNScy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 14:32:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B6F1BF9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=VIVempwRAnUTae1kulh+NMBkImnt8hqihQQr0dy+2EM=;
        t=1686767572; x=1687977172; b=G1y98azXTSd36fgzZwyp7fMRwfK3oNOZbCLCUl6HG++FOrw
        P2AlhbmyLEtY6EBaTYA9BpOlr9Y7/4iM5qg9sXfcwwQ+BtovLCgztPM/0JR/YSDiHoTQKXuvnA6gr
        RSz18DeI9Kl2XMXJ1SYOZPzvt8uUYHQb1h/BhqUDgcWTz3owJZ9GCkKGknNsuy/FR8niVY9uT1H4/
        uoSCCNdxEDxBczGjMYU18Eg18Dh/B/X7mu59by0aqCQMZbX9jAx/8rcRW2y9SQ3evrz4ClUawjx2n
        naIrWE7nzz9T/lJWUZA3UfB42i+28DG4i+5FEV49FtXoA1U+mjId7NNK0morIiVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9VIX-006Ix5-00;
        Wed, 14 Jun 2023 20:32:49 +0200
Message-ID: <6f8db032286923845202c7d658f1d39db79a758c.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Wed, 14 Jun 2023 20:32:48 +0200
In-Reply-To: <1c26c205-0240-7670-117d-02a7af068724@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.5ce3dad3be7c.I92e9f7a6c120cd4a3631baf486ad8b6aafcd796f@changeid>
         <5d82e564-86bf-c26b-077a-d0bc14e2d3c3@quicinc.com>
         <74f3eb848326607b15336c31a02bdd861ccafb47.camel@sipsolutions.net>
         <d10b88b4-0bd7-a38c-e8d7-8982a281c4b3@quicinc.com>
         <e5adbed1524b27228c152ba14f78c550c8730baa.camel@sipsolutions.net>
         <c15e368e-2fea-a1d8-9c0d-db9278ded5e5@quicinc.com>
         <113761966918b2f390d3c9304307b42a0b4a829b.camel@sipsolutions.net>
         <76863dec-1b2f-b933-7c5e-21c732de4bc6@quicinc.com>
         <2cc79101249548f2a92c14af6aff6121143907d6.camel@sipsolutions.net>
         <1c26c205-0240-7670-117d-02a7af068724@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-05-24 at 15:41 +0800, Wen Gong wrote:
>=20
> May I add a new ops in struct ieee80211_ops? like this:
>=20
> u16 active_links(struct ieee80211_hw *hw, struct ieee80211_vif vif, u16=
=20
> new_links)"
>=20
> then ieee80211_set_vif_links_bitmaps() call the ops to get the links for=
=20
> station and set the sdata->vif.active_links with the return value from=
=20
> lower driver,
> it means lower driver will dynamic select the links count at this moment.
>=20
> If lower driver not register ops active_links, then keep current logic.
>=20

I guess you can can send patches for whatever you want :)

But I have no idea what you're trying to do? Why would you need to have
a callback?

Was this for link selection in the driver? We should have a patch
somewhere that adds a BSS_CHANGE flag for when the valid links change,
so the driver can select others.

johannes
