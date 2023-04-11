Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325AF6DD7BA
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Apr 2023 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjDKKSd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDKKSb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 06:18:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF23A90
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=g37lg8wxChlnTFd5lG/0A02V1vDlQ8YaEb0RUigmtow=;
        t=1681208301; x=1682417901; b=LAtQT3cDvcEEpgqxDidmd6A46+E4ZhZxg2R9UoNTqtxO7QA
        Gt4oYucGu1TIbRyC61sTtJdlErQtCDTSjQVwiQ8kFtMxH8YuJHZER8vNvI5zlUfsb36xwVpi7SIBR
        tKiY5XK0DO69ZmL8LXVYfU/4TGIeF/z+m38c3b8M7Tw9iB6723nx39wAfyumcHXoElKqVBmfdM7Tu
        ud863+Lx2rwEhnUCq2bdkOHWctZlFyFNEFSDqkIGMK+YcykB+wzDIrgts0PC9AQKftZEiB+ASaOVX
        jpdA8enBZbsXAfBpp1oqppNXh0+ss4aojixLt864fEa9epaMz3CNMZr7tdJAKiNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pmB4t-00CgIS-1p;
        Tue, 11 Apr 2023 12:18:19 +0200
Message-ID: <b352dc03e5b404e4caa7e836a6ee3efde7e17ba6.camel@sipsolutions.net>
Subject: Re: [PATCH 24/27] wifi: mac80211: implement link switching
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Tue, 11 Apr 2023 12:18:18 +0200
In-Reply-To: <955cf0b5-8973-86b5-109e-268917d70904@quicinc.com>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
         <20220902161143.d99dfbe65c90.I92385ba882ec984a9a2ad18293173436657e82aa@changeid>
         <ca5177fe-3b9f-2309-9afd-1d5e827540f7@quicinc.com>
         <50719d34bc48d816d00b56d3d9efdb59e3e51a16.camel@sipsolutions.net>
         <955cf0b5-8973-86b5-109e-268917d70904@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-04-03 at 22:21 +0800, Wen Gong wrote:
>=20
> Also it does not have BSS_CHANGED_ASSOC(exists in=20
> ieee80211_set_associated()) for
>=20
> ieee80211_link_info_change_notify()/ieee80211_vif_cfg_change_notify().

Well, that's clearly intentional though, since the assoc state is at the
MLD level, so changing a link doesn't affect the assoc state, right?
This is also done through _vif_cfg_change_notify().

> So I think low-level driver also need to auto add BSS_CHANGED_ASSOC=20
> logic for the added link as well as the pairwise key you said, right?
>=20

That doesn't make a lot of sense as written, IMHO, but yes if you have
something you need to do on links during assoc, then you'd have to take
care of that as well, just like the keys.

johannes
