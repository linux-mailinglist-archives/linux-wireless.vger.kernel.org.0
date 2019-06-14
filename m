Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4360446050
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfFNOOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:14:33 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42756 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfFNOOd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:14:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbmyE-0002D9-2s; Fri, 14 Jun 2019 16:14:22 +0200
Message-ID: <bd02c49411759bcbb5305d0f361791ecaf0281b6.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] mac80211: implement HE support for mesh
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Fri, 14 Jun 2019 16:14:20 +0200
In-Reply-To: <2194147.kqlnQF7k4C@bentobox>
References: <20190612193510.29489-1-sven@narfation.org>
         <20190612193510.29489-3-sven@narfation.org>
         <8d0d11ca39b6216b24cf4e9e3a1522072db5c0d2.camel@sipsolutions.net>
         <2194147.kqlnQF7k4C@bentobox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 16:13 +0200, Sven Eckelmann wrote:
> On Friday, 14 June 2019 16:11:15 CEST Johannes Berg wrote:
> > > +       ie_len = 2 + 1 +
> > > +                sizeof(he_cap->he_cap_elem) + n +
> > > +                ieee80211_he_ppe_size(he_cap->ppe_thres[0],
> > > +                                      he_cap->he_cap_elem.phy_cap_info);
> > > +
> > > +       return ie_len;
> > 
> > There's no value in the "ie_len" variable here.
> 
> Sorry, my parser just broke. Why is there no value in ie_len? Was just 
> assigned a line before. Or are you talking about something else?

Heh, sorry. I mean, there's no value in having the variable, you could
just
	return 2 + 1 + ...

johannes

