Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAE778980
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Aug 2023 11:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHKJM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Aug 2023 05:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjHKJM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Aug 2023 05:12:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B812D5B
        for <linux-wireless@vger.kernel.org>; Fri, 11 Aug 2023 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/ytU6EgPAmUElPGDZBkGbafKdEySmXPGy+xB53zVEEc=;
        t=1691745145; x=1692954745; b=DmfxyddKP7GebXjN2Qap9KgP8wwDd5Fiagbk9a8oGTUT5VZ
        nYo1z8y2RB2BSsQ6xfCRa71FbrWktG2BF6Cy62RRNh9PD3mUdIrab62uTQv4qL2By57B0HpuPwu5f
        gBdslxqa5FyEBO9fU0K0ICzNBcdZNtSlQk3zv/X/KFRaW4Dx55L3+jA357rzwLUUG+IBOOv9eb/zv
        PMAutFJQUAe1ePm3rJOyH3TLagEXfIOY4GuCG2zJ9lwxoMjWNjhhSXB5qgqXDJEZLIl0Q6UOK0IsY
        nZdnVBPyN5SQZspVHapAvumzSCrNEfTb8TLKf2KM246EdpXJjoJrdKeyhPaNDunQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qUOBv-000ofx-1D;
        Fri, 11 Aug 2023 11:12:19 +0200
Message-ID: <6604842b607f7e2000c53aa52970c29480fd54b6.camel@sipsolutions.net>
Subject: Re: [PATCH 06/14] wifi: iwlwifi: mvm: add support for Extra EHT LTF
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>, gregory.greenman@intel.com
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Aug 2023 11:12:18 +0200
In-Reply-To: <2027bcac-cfd9-3858-3438-9a7297600350@quicinc.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
         <20230613155501.de019d7cc174.I806f0f6042b89274192701a60b4f7900822db666@changeid>
         <2027bcac-cfd9-3858-3438-9a7297600350@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-07-20 at 12:02 +0800, Wen Gong wrote:
> On 6/13/2023 8:57 PM, gregory.greenman@intel.com wrote:
> > From: Gregory Greenman <gregory.greenman@intel.com>
> >=20
> > Add support for Extra EHT LTF defined in 9.4.2.313
> > EHT Capabilities element.
> >=20
> > Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> > ---
> >   drivers/net/wireless/intel/iwlwifi/fw/api/rs.h    |  2 ++
> >   .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 ++
> >   drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 15 ++++++++++++++=
+
> >   include/linux/ieee80211.h                         |  1 +
> >   4 files changed, 20 insertions(+)
> >=20
> This patch changed both ieee80211.h and iwlwifi, if separate the change=
=20
> of ieee80211.h
> to another patch such as commit 4fdeb8471302(wifi: ieee80211: clean up=
=20
> public action codes),

Well, we've not always been so picky about that, and this is literally a
single line addition. So there have always been changes like that, and I
don't think we'll ever stop.

> then it will be easy for someone to pick the patch if he/she only need=
=20
> the change of ieee80211.h.

No. Don't even go there. I don't care about non-upstream stuff you do
the slightest.

johannes
