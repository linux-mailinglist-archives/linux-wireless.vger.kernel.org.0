Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AD59C93
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfF1NHh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 09:07:37 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50282 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfF1NHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 09:07:36 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgqbG-0001VB-SO; Fri, 28 Jun 2019 15:07:35 +0200
Message-ID: <43145d452ad33bfa39e5bdb5e522cc82140de23b.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Fri, 28 Jun 2019 15:07:33 +0200
In-Reply-To: <40d70ed94b1d79d481511031e8f4ea45@codeaurora.org>
References: <1558364020-11064-1-git-send-email-ailizaro@codeaurora.org>
         <1558364020-11064-2-git-send-email-ailizaro@codeaurora.org>
         <d1c2fd8d99d8f8420ba265f31709da9326ad38f1.camel@sipsolutions.net>
         <40d70ed94b1d79d481511031e8f4ea45@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-25 at 13:21 +0300, Alexei Lazar wrote:
> 
> > >   * @NL80211_BAND_ATTR_VHT_CAPA: VHT capabilities, as in the HT 
> > > information IE
> > >   * @NL80211_BAND_ATTR_IFTYPE_DATA: nested array attribute, with each 
> > > entry using
> > >   *	attributes from &enum nl80211_band_iftype_attr
> > > + * @NL80211_BAND_ATTR_EDMG_CHANNELS: bitmap that indicates the 2.16 
> > > GHz
> > > + *	channel(s) that are allowed to be used for EDMG transmissions in 
> > > the
> > > + *	BSS as defined by IEEE 802.11 section 9.4.2.251.
> > > + * @NL80211_BAND_ATTR_EDMG_BW_CONFIG: Channel BW Configuration 
> > > subfield
> > > + *	encodes the allowed channel bandwidth configurations as defined by
> > > + *	IEEE 802.11 section 9.4.2.251, Table 13.
> > >   * @NL80211_BAND_ATTR_MAX: highest band attribute currently defined
> > >   * @__NL80211_BAND_ATTR_AFTER_LAST: internal use
> > 
> > And ... that makes more sense than the global attribute I guess?
> 
> We feel it belongs to the BAND attributes because for example also VHT
> capability is there. There are however 2 other options:
> 1. Move the attribute to the NL80211_FREQUENCY_ATTR
> 2. Move them to the global attributes
> Any preference?

I think I just got confused. Is this used for capability reporting then?
I guess that'd make sense here, yeah.

johannes

