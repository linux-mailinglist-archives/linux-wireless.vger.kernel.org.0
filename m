Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB706969C0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 17:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBNQgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 11:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjBNQgP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 11:36:15 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA611E86
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 08:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=sHUUSGZfkEFa/biFWJwU/sN+xOVTYgGQV0WhlKWkUnk=;
        t=1676392563; x=1677602163; b=QBWIaB3ofUE47/Yc/rY2tiaK0PGgZGcl70lBvd8DWHdY1kN
        auqcn8qdyFcicVODPdh2eQYE0+ChIU9I0AQcM1t3oBeNeI0AZtvT/BJU9of85TssH3x7cZuRoqtjl
        Ntx/G/MVEFFro7On77EFFlQYkf+Sf30O+sZGavmHfhcW9JAkgoLH1tnyQqpyQw5ULuOpxDyjH4c6H
        La0ec8pVaMsqtTUTSi06Y5gE7kLdTHJoZh027A7gWdDlfU1pv6jky5MBD2lY6wZeDtXuYwpBoMO0y
        iKYgYF7I6/UwRuneNywc15PRuMQAcJ8MVolPdDmYXLdZU0YIeCPNUrLg6XEKeHxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pRyHg-00CEBn-0X;
        Tue, 14 Feb 2023 17:36:00 +0100
Message-ID: <ebda77c69f22c442573a461602800e2980a9e139.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: support poll sta for ML clients
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 14 Feb 2023 17:35:59 +0100
In-Reply-To: <121cef28d9b74613adb0ea1b8e072458@quicinc.com>
References: <20230119221240.24441-1-quic_srirrama@quicinc.com>
         <8512c5c275dbbb9f3f9d5e946905c3a3fc35457b.camel@sipsolutions.net>
         <121cef28d9b74613adb0ea1b8e072458@quicinc.com>
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

On Tue, 2023-02-14 at 16:34 +0000, Sriram R (QUIC) wrote:
> >=20
> > After all, we want to know the MLD is still there, not a specific
> > STA, right?
> Exactly. It is enough to check if the MLD is active and not specific
> to any link.
> But, as you mentioned above its hard to know if polling on the default
> link
> is good enough to check MLD is alive.. So the suggestion is to use the
> link id as UNSPECIFIED and let
> driver decide to send the null data in any of the active links?

Yes, put all the MLD addresses into the frame if we don't already do
that anyway, and that should be good enough for the device to do the
translation?

johannes
