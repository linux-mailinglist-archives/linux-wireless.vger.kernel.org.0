Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91946529FC7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbiEQKwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 06:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiEQKud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 06:50:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E342EFD
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CZKbvyuo9jMSxGCEvHVocW/LbxZNQg7LeMHvamwIiG0=;
        t=1652784632; x=1653994232; b=C8YqUqGqwJ2sitT4cyM7MIfktf/0X3kVk/g0hFL3Jt7AaAR
        5HqNt/B9l1xxkoCukd7V5fVOZCMBl4hOAo6f1IXQb4rOltHfNUQrxfrhTEGBaY2HhtVFiUnfTir58
        HCoXt84LnPhJ/D3Axzrv8nheB/R/tVK4Yfb+I2R4MBp7WPMEgRNoJz9F+fvAoTp6FnZaSA9RdlZ8c
        TYUEXkcjmPsp7tuEiPL4Q9tvVuqR1Ma5StKkMQYiuzZn7LTyZUCbdmMemeZBdXkxCe2tYgU5Gz8bB
        GnQFrZrQu7bkdxqyIDH2kbJARxz2z39Qe6C8lY3iZm1JozTPaxFgakC1z+vi4q2w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nqumW-00ELXJ-U3;
        Tue, 17 May 2022 12:50:25 +0200
Message-ID: <c41731aea4fc043bad1ab6db724c2283df0a3d42.camel@sipsolutions.net>
Subject: Re: [PATCH v5 1/3] cfg80211: additional processing in
 NL80211_CMD_SET_BEACON
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 17 May 2022 12:50:24 +0200
In-Reply-To: <87v8u4wyw4.fsf@kernel.org>
References: <20220516202454.4925-1-quic_alokad@quicinc.com>
         <20220516202454.4925-2-quic_alokad@quicinc.com> <87v8u4wyw4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
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

On Tue, 2022-05-17 at 07:45 +0300, Kalle Valo wrote:
>=20
> > +++ b/include/net/cfg80211.h
> > @@ -4200,7 +4200,7 @@ struct cfg80211_ops {
> >  	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
> >  			    struct cfg80211_ap_settings *settings);
> >  	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
> > -				 struct cfg80211_beacon_data *info);
> > +				 struct cfg80211_ap_settings *info);
>=20
> Shouldn't patch 3 folded into patch 1? I don't see how patch 1 as is
> would compile without warnings.
>=20
Yes, and parts of patch 2 as well.

johannes
