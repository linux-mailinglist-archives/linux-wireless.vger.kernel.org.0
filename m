Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9079E6028C3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJRJwB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 05:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJRJwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 05:52:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9238517A86
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3wbT9fC4VXzzYQ3W/AWIk9fua5zDcBDlenKizE7+J/k=;
        t=1666086719; x=1667296319; b=q6GypChdsl9SD8Po+hNCGFhlh2ZS8wWepR9Wf5XL9zn5C5c
        PW0pUktUify5UlO6x/FRZXRDAkfiX+R3nv1jPkd0uQpYvQAeUch83hpqX5SRj4X3/TxVIro9pfj49
        afunYs1HvvIbhQnATRn84ZgLoE3JioneQ6FoFo88qPviGqH9vn6webOqZToBWZvLfTsQ8Vo/iwlti
        4stBBNIuecIBmeQT0C/sET4ByEnaB2VfHzUBSKUmzuIcqJhwe6c3juExLVXHCSCNkY8nXTN8LoJPM
        +3SXvRtYOkJc4GShwZ16mBNLwihawleVRVqBFkrLvFtVEnp2I4XeFcy+Rcw0m2Sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1okjGO-00A7HN-2M;
        Tue, 18 Oct 2022 11:51:56 +0200
Message-ID: <f210cf2a6e3f62156ae6a9d6c7de20e16bd4d6e6.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] mac80211: split bss_info_changed method
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, ath12k@lists.infradead.org
Date:   Tue, 18 Oct 2022 11:51:55 +0200
In-Reply-To: <7e72034a-497a-000c-d7bf-3ec974af9e1c@quicinc.com>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
         <20220601093922.347d47c279fe.I15937cfe8405999084f164ddf57390f8b8d2bc61@changeid>
         <c38b4da8-488b-2d09-631a-1bb6c07440a6@quicinc.com>
         <3483d05c1d5a39b9243b54d9f28450344a897655.camel@sipsolutions.net>
         <bd6545a8-57a3-5849-52d5-c1a449ab1712@quicinc.com>
         <d0994456d3a9ea00b5cc472df7822d53d189399e.camel@sipsolutions.net>
         <7e72034a-497a-000c-d7bf-3ec974af9e1c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Tue, 2022-10-18 at 17:50 +0800, Wen Gong wrote:
> >=20
> > https://p.sipsolutions.net/0652bbbbe350b126.txt
>=20
> Conflict happened while run "git am" the patch.
>=20
> Because missing the=C2=A0 "changed |=3D BSS_CHANGED_EHT_PUNCTURING;" in m=
y=20
> local code,
>=20
> also it is missing in=20
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.gi=
t/tree/net/mac80211/util.c
>=20
> Maybe "changed |=3D BSS_CHANGED_EHT_PUNCTURING;" is only existed in your=
=20
> local code?
>=20

Ah yes, we didn't upstream that because there's still this discussion
about handling puncturing. But you can probably apply around that.

johannes
