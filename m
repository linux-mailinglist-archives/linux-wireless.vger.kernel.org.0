Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3037AD8F0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjIYNVl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjIYNVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 09:21:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E010C
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8FTubTo95ecTE3O8mI6xsTp9mvBJJbU1Q1t/M+xnGrA=;
        t=1695648093; x=1696857693; b=asNZIR/TJXxwgzTs/nrs6HzZm1r/N3KUbWzrbgyri3n0IkE
        hhXvSWt0o81/Gv9b5Y2vq+LPZP7acTiNuLzZxKUAM5U458lnlhvHqZREKwlBGJFD3DsLqmKD7AvDL
        xHd6miT/ssrFba/U5p1tbhmh/08JhodHKDAHIzArIgFNRCuw2nVMwwsfNgt2BYX0ETnQj40DEIBHd
        O3RUPQYRTuj8Cd+Q6aSC1+vBpP5ZYROiJAcb3E+DJQ2n/zPSoIeSAqylDQT4d/wAPGlpaO4TCZwGm
        9lBfAdIKVLGbJQGGGaDo99pIbmNvHM2VVRDGlXJkTm9ZyDU7oQ77FQwuGRSIVPHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qklWk-003dNJ-1T;
        Mon, 25 Sep 2023 15:21:30 +0200
Message-ID: <36c2d107bf8dd2d32d6864ba929db026e9b8091d.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: add support for AP
 channel switch with MLO
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 25 Sep 2023 15:21:29 +0200
In-Reply-To: <1d8e7395-61c1-4fba-9d83-8cebfb557b33@quicinc.com>
References: <20230925115822.12131-1-quic_adisi@quicinc.com>
         <20230925115822.12131-2-quic_adisi@quicinc.com>
         <af4a763b624363543a37140c2106fb7a05800977.camel@sipsolutions.net>
         <1d8e7395-61c1-4fba-9d83-8cebfb557b33@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2023-09-25 at 18:49 +0530, Aditya Kumar Singh wrote:
> >=20
> > Perhaps we should just get rid of sdata_dereference() entirely, after
> > all, it's the same now, just the arguments are switched for no good
> > reason.
> Yup agreed. Are you already aware of any WIP in this regards? If not, I=
=20
> can take care for the CSA part at least in same series (in a different=
=20
> patch obviously :) )

No, I was just thinking out loud now :)

It'd be a trivial spatch, but I guess it'd be nicer to not have all that
"sdata->local->hw.wiphy" in there if there's already another local or
even wiphy variable in the function. And then while that's probably
still possible in spatch, it's no longer trivial ;-)

johannes
