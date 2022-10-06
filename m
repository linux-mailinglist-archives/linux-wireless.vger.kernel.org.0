Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A225F64EE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJFLL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJFLLZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:11:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4309B87E
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=nDUZU0hKVylk78SBYhe/ZFpPBKWlJpNFtJsV7EK+OG0=;
        t=1665054672; x=1666264272; b=gWI2ggPtxPR7rq2fjsmaEpsA4nsA9E/WBPW18G65/82bjLe
        cjN5b6NcwZd4AqTdedAvOPIqqkkqHjNRP+rh/BnpMd6z9jBM3OBWdlz448UtmNIO6xhAcJmAWY+S0
        uTKr6Jxr7lUxkW2HOK5KPKQtsIdb/q02MsOcibb5GWJfbVhNo/0VEmiKGWdbFWAOOY+8B0dEcktyA
        7RByqr6InkS2sxps/61WjZwBIaRE+8MA4kJZFQhiNkDIPJPPvFOmx4sTr6jHcnQ0nmr5X69OU1tyj
        ruqTPZM1y/Xk9cbGdmf8xW6ktlfFLK+9sxTMoqLex9KoPLzhggifkrFgo5ezlUjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ogOmS-00GtDY-0v;
        Thu, 06 Oct 2022 13:11:08 +0200
Message-ID: <6d0333ef30624ef285c01dc2dd27da76450d613e.camel@sipsolutions.net>
Subject: Re: [PATCH 05/28] wifi: cfg80211: support reporting failed links
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 06 Oct 2022 13:11:07 +0200
In-Reply-To: <13b44ce9-e000-cdcf-c057-b176edb6d31f@quicinc.com>
References: <20221005145226.2224328320e7.I53966b9c7572fe1a08a7dc02ed29be9e1b0467fc@changeid>
         <0e354734-6f6b-8170-b453-e699fc9962e5@quicinc.com>
         <0fd2932c29adcc6be5fe5528d297b7deb0e0617b.camel@sipsolutions.net>
         <13b44ce9-e000-cdcf-c057-b176edb6d31f@quicinc.com>
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

On Thu, 2022-10-06 at 16:39 +0530, Veerendranath Jakkam wrote:
> On 10/6/2022 4:21 PM, Johannes Berg wrote:
> > On Thu, 2022-10-06 at 16:19 +0530, Veerendranath Jakkam wrote:
> > > I think similar enhancement needed for cfg80211_roamed/NL80211_CMD_RO=
AM
> > > also to know accepted and rejected links info during roaming.
> > >=20
> > Not sure, in that case we might care only about the successful links
> > since wpa_s didn't request the others, so maybe it doesn't matter?
>=20
> Drivers can offload EAPOL 4WHS to wpa_supplicant during roaming with=20
> non-FT AKMs. In that case supplicant needs to know rejected links info=
=20
> to validate AP's MLO Link KDEs in 3/4 frame.
>=20
> Ex: Driver handles only re-association request and response frames while=
=20
> doing roaming with non-FT AKM then offload 4WHS to wpa_supplicant
>=20

Right, but is there a fundamental difference between

 "hey I roamed to this AP MLD with links 1, 2 and 5"
 (with the right BSSIDs for the links etc.)

and

 "hey I roamed to this AP MLD and I tried links 1, 2, 3, 4, 5 but only
1, 2 and 5 were established"

?

johannes
