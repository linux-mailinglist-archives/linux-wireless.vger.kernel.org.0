Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733F52A460C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgKCNPy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 08:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgKCNPy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 08:15:54 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13FC0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 05:15:54 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kZwAB-000JQW-0T; Tue, 03 Nov 2020 14:15:51 +0100
Message-ID: <aba43fb268fe29aecf84bf7e68629dc0de28d0ad.camel@sipsolutions.net>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Carl Huang <cjhuang@codeaurora.org>,
        Abhishek Kumar <kuabhs@chromium.org>
Cc:     briannorris@chromium.org, linux-wireless@vger.kernel.org,
        dianders@chromium.org, ath10k@lists.infradead.org
Date:   Tue, 03 Nov 2020 14:15:34 +0100
In-Reply-To: <e5302eb0b20339d3f6544652e4034993@codeaurora.org>
References: <20201030205639.1452712-1-kuabhs@chromium.org>
         <20201031024631.1528113-1-kuabhs@chromium.org>
         <e5302eb0b20339d3f6544652e4034993@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-11-03 at 10:34 +0800, Carl Huang wrote:
> On 2020-10-31 10:46, Abhishek Kumar wrote:
> > From: kuabhs@chromium.org
> > 
> > There are few more additional comments here.
> > > + * @NL80211_CMD_SET_SAR_SPECS: SAR power limitation configuration is
> > > + *     passed using %NL80211_ATTR_SAR_SPEC.
> > > + *
> > 
> > This command requires NL80211_ATTR_IFINDEX, probably should be better 
> > to add
> > this in the comment ?
> > 
> Per Johannes's comments, this explicit index is not required. Are you 
> fine with it?
> 
> Instead, user-space application records the array index when querying 
> the SAR
> capability. When set, the nested array index will be used to set the 
> power.
> This requires user-space has a strict mapping of index. and 
> NL80211_ATTR_IFINDEX
> is to be removed.

Wait, what? The IFINDEX is still required, that identifies the interface
- though it probably shouldn't be required, this should be per wiphy, so
you could also use ATTR_WIPHY_IDX?

You're thinking of ... something
else. NL80211_SAR_ATTR_SPECS_FREQ_RANGE_INDEX perhaps?

johannes

