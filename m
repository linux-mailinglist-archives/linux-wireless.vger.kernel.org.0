Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEF768E988
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Feb 2023 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjBHIHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Feb 2023 03:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBHIHf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Feb 2023 03:07:35 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A973E055
        for <linux-wireless@vger.kernel.org>; Wed,  8 Feb 2023 00:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UXsFNx/TspZNOUIRJkJSEhRTnREiv60GHWNNgIyY++8=;
        t=1675843654; x=1677053254; b=qff0+i5bV8o2W10eVw4Y3kENyV50H2bohoe4Fy48qnhqw/v
        aO5nyYV5KcB5gEIscWZ3FwQiNcFPjT9tqiQYZLGVZoVqjR+MLKlwOaOExelN3W2M/Bu/69WYXIzaV
        fEaHB+gx+Z20nxp2TsFs7b92wD/p2DBIS7LU471PTsW254TZgt4eoAffKEkMBYMAnSq449QijlOMD
        LjMPbTR+e8wxw9S+fIAi/cs1221zDkpWcnfTi0xdmpmpuNwoLyjfNpyIObJDiOx54W3Xy89QJ1f5Y
        /Ua1QSBAMsvJG++JWgB4sjqsyCKTWiL2eS6XgYUiG9RBndXiXFtVy4nGCMAah8Rw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pPfUH-006Pyw-25;
        Wed, 08 Feb 2023 09:07:29 +0100
Message-ID: <1b8fa31dd27ddd8a6eb867c7179da46b0f9b77f6.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: mlme: handle EHT channel puncturing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Date:   Wed, 08 Feb 2023 09:07:27 +0100
In-Reply-To: <87h6vw7jc9.fsf@kernel.org>
References: <20230127123930.4fbc74582331.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
         <87h6vw7jc9.fsf@kernel.org>
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

On Wed, 2023-02-08 at 08:38 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Handle the Puncturing info received from the AP in the
> > EHT Operation element in beacons.
> >=20
> > If the info is invalid:
> >  - during association: disable EHT connection for the AP
> >  - after association: disconnect
> >=20
> > This commit includes many (internal) bugfixes and spec
> > updates various people.
> >=20
> > Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Miri's s-o-b missing.
>=20
Good point. I had it, of course, but forgot it when combining all the
changes. I'll add it.

johannes
