Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF47D126629
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 16:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSPxv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 10:53:51 -0500
Received: from mail.w1.fi ([212.71.239.96]:51646 "EHLO
        li674-96.members.linode.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbfLSPxv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 10:53:51 -0500
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 10:53:51 EST
Received: from localhost (localhost [127.0.0.1])
        by li674-96.members.linode.com (Postfix) with ESMTP id EB48C11A09;
        Thu, 19 Dec 2019 15:48:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from li674-96.members.linode.com ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cNJ-ZTqMTVck; Thu, 19 Dec 2019 15:48:31 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Thu, 19 Dec 2019 17:48:28 +0200
Date:   Thu, 19 Dec 2019 17:48:28 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Pkshih <pkshih@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add dynamic SAR power
 limits
Message-ID: <20191219154828.GA12287@w1.fi>
References: <1576684108-30177-1-git-send-email-kvalo@codeaurora.org>
 <1576684108-30177-2-git-send-email-kvalo@codeaurora.org>
 <1576748692.7758.17.camel@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576748692.7758.17.camel@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 19, 2019 at 09:44:52AM +0000, Pkshih wrote:
> On Wed, 2019-12-18 at 17:48 +0200, Kalle Valo wrote:
> > diff --git a/include/uapi/nl80211-vnd-qca.h b/include/uapi/nl80211-vnd-qca.h
> > + * NOTE: The authoritative place for definition of QCA_NL80211_VENDOR_ID,
> > + * vendor subcmd definitions prefixed with QCA_NL80211_VENDOR_SUBCMD, and
> > + * qca_wlan_vendor_attr is open source file src/common/qca-vendor.h in
> > + * git://w1.fi/srv/git/hostap.git; the values here are just a copy of that

> > + * @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND: Optional (u32) value to
> > + *	indicate for which band this specification applies. Valid
> > + *	values are enumerated in enum %nl80211_band (although not all
> > + *	bands may be supported by a given device). If the attribute is
> 
> Can we define separated enum to address four 5G sub-bands, likes
> 
> enum nl80211_sar_band {
> 	NL80211_SAR_BAND_2G,
> 	NL80211_SAR_BAND_5G_BAND1,
> 	NL80211_SAR_BAND_5G_BAND2,
> 	NL80211_SAR_BAND_5G_BAND3,
> 	NL80211_SAR_BAND_5G_BAND4,
> };

Please note that the vendor subcmd and attributes used here are already
deployed and in use as a kernel interface. As such, the existing
attributes cannot really be modified; if anything else would be needed,
that would need to be defined as a new attribute and/or command.

> I think this vendor command can be a generic nl80211 command, because
> we need SAR
> power limit as well.

This was discussed during the 2019 wireless workshop. The conclusion
from that discussion was that while there is clear need for SAR power
limits for various devices and multiple vendors/drivers, it did not look
clear that a single common interface could be defined cleanly taken into
account the differences in the ways vendors have designed the mechanism
in driver and firmware implementations. As such, vendor specific
commands were identified as the approach.

> > + * @QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT: Required (u32)
> > + *	value to specify the actual power limit value in units of 0.5
> > + *	dBm (i.e., a value of 11 represents 5.5 dBm).
> 
> Can we have higher precision, in unit of 0.125?

This existing attribute cannot be modified, i.e., a new one would need
to be added if a different precision is needed. As far as the specific
need for the vendor command defined here is concerned, 0.5 dB unit is
sufficient.

> > + * These attributes are used with %QCA_NL80211_VENDOR_SUBCMD_SET_SAR_LIMITS
> > + * and %QCA_NL80211_VENDOR_SUBCMD_GET_SAR_LIMITS.
> > + */
> > +enum qca_vendor_attr_sar_limits {
> > +	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_INVALID = 0,
> > +	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC = 3,
> > +	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_BAND = 4,
> > +	QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SPEC_POWER_LIMIT = 7,
> 
> Why these enum aren't continual?
> The reason may be because QCA_WLAN_VENDOR_ATTR_SAR_LIMITS_SELECT and something
> me
> ntioned in above paragraph but missing in this enum?

This patch does not include all the assigned values (see hostap.git for
full details if desired), i.e., all the values are actually assigned,
but the proposed use case for ath10k does not need the values that were
left out from this header file that is a copy of the authoritative
definition of the vendor attributes.

-- 
Jouni Malinen                                            PGP id EFC895FA
