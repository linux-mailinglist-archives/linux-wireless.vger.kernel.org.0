Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788DC6E5D67
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDRJbK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDRJbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:31:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35534216
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RKCPiQ8s8a40opzsPjb7+5NDfVGuNLfOkCTKeMQ2G24=;
        t=1681810264; x=1683019864; b=YsYpbzRkLB3bm6noW/SLG4BTFVpttWRQ1IRjRLNtqTzbVAQ
        0qX982JtEhqpr3ikO3YNEdQN2tuGhMXorbqqtCcrL3QZ/uNxqHwTZPwYw3HscdPJBcNcIyLz4s+S0
        dlNrmsno9xPF3xm6ET/uFixCATSgiH96SlY6zGTt28L+IIxTnmatuW0fPUxSsfBwwdVzSnrWnDasK
        xBMWj4uu6yIyhtdO64YCiZcXuWa17LzxrJG+UOXhtMpv8WA1I6CEK0KqMq2MuSgnTX8veZETVbxN9
        IIG5yuQz5xloaSxQt5NL96i6VGOHoIFpn9Yj1zGJPig8XdyoRVxJafub5hxFU6YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pohfx-001Z6k-29;
        Tue, 18 Apr 2023 11:31:01 +0200
Message-ID: <09b156b1ef05377ca7fa0db35e8e13beb5c60e2c.camel@sipsolutions.net>
Subject: Re: [PATCH 10/27] wifi: mac80211: isolate driver from inactive links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Date:   Tue, 18 Apr 2023 11:31:00 +0200
In-Reply-To: <34212873-0b71-7f39-b064-6b50d8e514b4@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <2de44394-cb93-7be4-481f-2d92788b8d28@quicinc.com>
         <351f74e0e1cd6e9724f97dbd042bdc5e04c44842.camel@sipsolutions.net>
         <c05780bc-864c-9323-499d-a8b1ba1c2ef2@quicinc.com>
         <545227cf18baac94ea8aa24dc08b250c47949541.camel@sipsolutions.net>
         <c7fd18fa-531f-a90d-a8fb-442a5aa66d7d@quicinc.com>
         <d1fda46a-2481-8e05-e0a5-9f2bd3850ff4@quicinc.com>
         <868131d13ed7c4c8b5d4938adcd71cf1ff8e9677.camel@sipsolutions.net>
         <5765e3c5-46d4-e92b-a93b-4a2649acff2a@quicinc.com>
         <37958ca93039114b98909d730ff57dd1d10bb68d.camel@sipsolutions.net>
         <b9c6d022-12c3-a696-c4b9-cb14a6d30a45@quicinc.com>
         <91577d586475d290e08dee9e535cb6b4896e06d4.camel@sipsolutions.net>
         <edfc26b5-f6d1-2ab7-f3cc-60a74c8c334d@quicinc.com>
         <61268d31f8a6dd4eea10fcb6048d39244bc584e2.camel@sipsolutions.net>
         <870ce439-85b1-f02c-70e5-2d424fd73372@quicinc.com>
         <34ed0938b69ead648da1aa250a2e081054fb49d4.camel@sipsolutions.net>
         <34212873-0b71-7f39-b064-6b50d8e514b4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Tue, 2023-04-18 at 17:22 +0800, Wen Gong wrote:
>=20
> It should work, I will test it later.
>=20
> For the 1st assoc link, the data->u.mgd.assoc_data is empty in=20
> ieee80211_mgd_setup_link(),

Yeah for the first link it should work.

> because ieee80211_mgd_setup_link() is called from nl80211_authenticate()=
=20
> for the 1st assoc link.
>=20
> So ieee80211_mgd_setup_link() use eth_random_addr() for the 1st assoc lin=
k.

Right.

> For the 2nd link, ieee80211_mgd_setup_link() is called from=20
> nl80211_associate()

I don't think so, it should only be called from
ieee80211_assoc_success()?

> the sdata->u.mgd.assoc_data is NOT empty,
>=20
> and the sdata->u.mgd.assoc_data->link[link_id].addr is valid,
>=20
> it is addr by eth_random_addr(assoc_data->link[i].addr) in=20
> ieee80211_mgd_assoc().
>=20

Exactly, so we've already decided on the address long before we actually
add the link data structure, so your callback would be much too late.
We'd need to have it called from ieee80211_mgd_assoc() already?

johannes
