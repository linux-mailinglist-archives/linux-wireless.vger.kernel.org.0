Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36905429F6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiFHIxm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiFHIwu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:52:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7D37DDB5
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=ooljqvKu8YfWBa0CL23mUSYO7OyivDRUhmoqMH4e7Y8=;
        t=1654675877; x=1655885477; b=mLOFqViRDoMfkQ7RXi66KFjS60ytj0fn5LZPvSx3xHUK4IA
        ZJIYU+SlGdJJB8MDrf1ul1I9Jr/OzDLfG1Qph570cQuv4WMqR03ugmKRsC0DCBnk6TJ7FDM/5CPrn
        5RElBnnnD5wAclMMAWL5+iY39gPW7YAPll705aCWK92rqUQmffrUZ+7zAGPuqW36+nqyG0t/ARzkJ
        h42nqQC4QODm54C++1m4Vqy3Gcx+8z5fGMsdCEy0+Lf0a0KGuLIRlM1/eIdC52vPk7SxnHvSBJCRd
        aIY9qy0j7pyqoTnPapigs75Oz8lu+4ngTUwPjFftKjR6Gy5VdhflpHPaJAzqDNtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nyqmZ-00Gqf7-Mn;
        Wed, 08 Jun 2022 10:11:15 +0200
Message-ID: <f51343d5add4f25582d1ead3346435db960eaecf.camel@sipsolutions.net>
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 08 Jun 2022 10:11:14 +0200
In-Reply-To: <2a8e08b3-4c93-4a29-a2ac-8f7c122e1aaa@quicinc.com>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
         <a2cc93f959394a3430755d4664d9f2abeabb3ab7.camel@sipsolutions.net>
         <e75ddf50-348b-eaf2-4033-6a32ef65a41c@quicinc.com>
         <3fa8911111ff380615ca5b3ffcd61644fae5e8ea.camel@sipsolutions.net>
         <2a8e08b3-4c93-4a29-a2ac-8f7c122e1aaa@quicinc.com>
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

On Wed, 2022-06-08 at 13:40 +0530, Veerendranath Jakkam wrote:
>=20
> Now I am thinking we can simply do like this. Sorry,=C2=A0 somehow I made=
 it=20
> complex earlier.. :)
>=20
> +	if (cr->status =3D=3D WLAN_STATUS_SUCCESS) {
> +		for_each_valid_link(cr, link) {
> +			if (WARN_ON_ONCE(!cr->links[link].bss))
> +				break;
> +		}
>=20

Huh, yeah, nice!

johannes
