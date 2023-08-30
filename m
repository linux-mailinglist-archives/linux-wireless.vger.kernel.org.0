Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BE78D9D3
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbjH3SeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbjH3Hod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 03:44:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7292FCD8
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iIU473aemSOOSvWHNnwFvm4J2x7SJiBJnFURVTAZcAg=;
        t=1693381470; x=1694591070; b=egrT3CksO7DkRTp7Asg5OmtmFWgw36kRXqTSDia9M9rtotC
        DemikK+VfqOtbepNA5TarOHjvYgR9fUt9+sDADX1lfRDpWJX9sZ99N8nvh+zJrWOqkJd4Kym42k7r
        PAh68CEZVZcrUM38Us2CqRL+q2jpmgYgIpq+3lfseBnIy0MZXEDANnieHbxuSWO/JEXsT5rT30oPD
        svmgE2IUX3y+HFc5hGEZnVqKAOMPN+G1ADdGxAlvpn1oontLvoOz03RFyVNa/XrOqKbyZM2puxIy0
        y/f1vVjAmolvRJMZoTdRb1NFlXc0JCzvd6zdTmRF7+QqDdmIsdjm0hGhEYajTptQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qbFsK-002oEb-0H;
        Wed, 30 Aug 2023 09:44:28 +0200
Message-ID: <6390d2b539b7da5fe2e0d891de26917654a6aa1a.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/9] wifi: cfg80211/mac80211: extend 6 GHz support
 for all power modes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Aug 2023 09:44:27 +0200
In-Reply-To: <afd7a85c-e1ce-6a6e-a29e-74ccc0d8bd08@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
         <319ecb67faac8a2e50408f2bfa28f2431a6e6b9a.camel@sipsolutions.net>
         <afd7a85c-e1ce-6a6e-a29e-74ccc0d8bd08@quicinc.com>
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

On Wed, 2023-08-30 at 10:43 +0530, Aditya Kumar Singh wrote:
> >=20
> > Why do you even need to set *from userspace* the power mode for a
> > client? That ... doesn't make that much sense?

Oh so you addressed that here, sorry.

> Because there are two possibilities? Default client and also connect to=
=20
> Low Power Indoor AP as well as sub-ordinate client. So to let the kernel=
=20
> know which mode originally the client is in, the command was introduced.
>=20
> I do understand the concern here about possible misuse for the command=
=20
> from the user space, I would re-visit this area and try to cover the=20
> loop holes if any. But don't you think it should be the case? Basically=
=20
> same like how we tell via user space the SSID, keys/suite info. freq=20
> list and all for a client, in a similar way tell the power mode.

I just don't understand how userspace would possibly know what to do.
You can't really expect the _user_ to select this. So how does
wpa_supplicant know what to do? How does it know better than the driver?
Where does it get the information from?

johannes
