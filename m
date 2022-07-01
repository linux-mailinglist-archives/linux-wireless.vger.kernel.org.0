Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C214A5630D4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiGAJ7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGAJ7h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:59:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E858FC8
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ESyQ150/21RTnN1Ep3hDYc2dkrqCm4BjcpkOwDYlfkk=;
        t=1656669576; x=1657879176; b=IMvtNn+cf4uLS496M62wmLJny7qa7sR8uJ/1FaP5uaWrCw0
        UEFLMaiv4jP2gnFJUgL0fFHL/uXkkCcUEazJZJbiImxJXo6wvl+6W0OgY5Byo8nVWxdGbShNCIA35
        HKHz6YQnv2RKv9N+FDxdZg+5x+o0dPwe3/UuiIvcXWP+mIlJcdIPtq7RriqjEgc9vIeh4Ue460cbj
        c2QurW4ocvYgYZw9gRZn+OawFY+RroN471AlmMcJt7ZkACnvV6pQ64VxTk7VBQrx49bBqFfHdRMBK
        RlF1ZJ8sYLgEQ7QlsLCgbkiaOs6v8tm09Ei6Mr/n+78kHbNcnbTbDFV/99j4GVkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7DR0-003R1X-NS;
        Fri, 01 Jul 2022 11:59:34 +0200
Message-ID: <940aa2fe0f2497e9fab9a5118001034b5de18d64.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] Mesh Fast xmit support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "nbd@nbd.name" <nbd@nbd.name>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 01 Jul 2022 11:59:33 +0200
In-Reply-To: <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
         <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
         <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
         <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
         <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
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

Hi,

> =C2=A0=C2=A0=C2=A0The only concern/reason is to not silently increase the=
 memory
> requirement of Mesh
> support with this patch.

OK.

>   So was skeptical on having a higher cache size(like 250 or 500 max).
> Hence had a value of 50 and left the configuration part for devices
> which needed higher
> cache.=20
> But as you mentioned, this is only runtime max memory and not default.
> =C2=A0So we should be fine to set some high limit, If above is not a
> concern could we stick to
> an upper limit of ~150-200 ?

Right, I'm fine with that. I was just throwing out 500 as a random
number to show that it's not really a huge memory requirement.

> Apart from that, though the points you mentioned are quite possible,
> the cache
> Management logic will ensure to cleanup stale entries and in worst
> case will
> use regular header generation process if cache is full. So I feel that
> should ensure
> things work as normal even under attack.

Right.

johannes
