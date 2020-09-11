Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6B265DDA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 12:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKKbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 06:31:00 -0400
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:33830
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgIKKa7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 06:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599820258;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=lC73OTRphByApQnF9+nQFFQ02Rux9KQ6f0L8jMUEPwI=;
        b=DiyWwYH9XxniLbhg/bdeWJ8GRaY9FNnBxXWMGgXc3CbrLIreMRhddDTIbfXxT6W/
        3X2374HHdzaw8+/iA7a+S1VTsfHPb3mXWc8INQuvbT3iEbzu3h3/KSS3rU20/J1Xv+8
        QxIdBuu0m9Z3tK/RY+DXO0VXaFdaIgiXjIC12e0I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599820258;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=lC73OTRphByApQnF9+nQFFQ02Rux9KQ6f0L8jMUEPwI=;
        b=Vp2kjngxpq26ltYXYZQCATgZ34q8R1odf9Mzwc1MJcXXkfUJoQXwRzmE6pvHLyr0
        1m/47uoNrmDGyhNJ6LSAEeOfFnZUHTj0EgQfM+WSJxoyWdV4SaHaVJUSWXpdOK51ViJ
        COm7IfmCsrbqQSFWZOScCIK1XbbBhavSuowXdg78=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 10:30:58 +0000
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2 13/24] mac80211: determine chandef from HE 6 GHz
 operation
In-Reply-To: <e60a8168e11aa69a9778fae9a29b8735c5f737b5.camel@sipsolutions.net>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
 <20200528213443.25687d2695bc.I3f9747c1147480f65445f13eda5c4a5ed4e86757@changeid>
 <010101747c80076d-8dc8fdae-d89b-497f-81ac-77d2dd7d94b5-000000@us-west-2.amazonses.com>
 <e60a8168e11aa69a9778fae9a29b8735c5f737b5.camel@sipsolutions.net>
Message-ID: <010101747cb7dd81-063d4a61-67c4-4fb6-9594-0d33d436f02d-000000@us-west-2.amazonses.com>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-09-11 18:06, Johannes Berg wrote:
> On Fri, 2020-09-11 at 09:29 +0000, Wen Gong wrote:
>> On 2020-05-29 03:34, Johannes Berg wrote:
>> > From: Johannes Berg <johannes.berg@intel.com>
>> >
>> > Support connecting to HE 6 GHz APs and mesh networks on 6 GHz,
>> > where the HT/VHT information is missing but instead the HE 6 GHz
>> > band capability is present, and the 6 GHz Operation information
>> > field is used to encode the channel configuration instead of the
>> > HT/VHT operation elements.
>> >
>> > Also add some other bits needed to connect to 6 GHz networks.
>> >
>> > Link:
>> > https://lore.kernel.org/r/1589399105-25472-10-git-send-email-rmanohar@codeaurora.org
>> > Co-developed-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
>> > Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> > ---
>> >  net/mac80211/ieee80211_i.h |   3 ++
>> >  net/mac80211/mesh.c        |   1 +
>> >  net/mac80211/mlme.c        |  69 +++++++++++++++++-------
>> >  net/mac80211/util.c        | 106 +++++++++++++++++++++++++++++++++++++
>> >  4 files changed, 160 insertions(+), 19 deletions(-)
>> >
>> [...]
>> > @@ -4838,21 +4860,23 @@ static int ieee80211_prep_channel(struct
>> > ieee80211_sub_if_data *sdata,
>> >  			  IEEE80211_STA_DISABLE_160MHZ);
>> >
>> >  	/* disable HT/VHT/HE if we don't support them */
>> > -	if (!sband->ht_cap.ht_supported) {
>> > +	if (!sband->ht_cap.ht_supported && !is_6ghz) {
>> >  		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
>> >  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>> >  		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>> >  	}
>> >
>> > -	if (!sband->vht_cap.vht_supported)
>> > +	if (!sband->vht_cap.vht_supported && !is_6ghz) {
>> >  		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
>> > +		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
>> > +	}
>> when connec to NL80211_BAND_2GHZ, it does not support vht, then it
>> failed for HE and connected with HT mode.
>> I tesed with below change, it fix the issue, it connected with HE mode
>> for NL80211_BAND_2GHZ with an HE mode 11AX AP.
> 
> Hmm. Yeah, that seems reasonable. I wonder why/how we never saw this,
> hm.
> 
> Can you send a real patch?
> 
yes, patch sent:
https://lore.kernel.org/linux-wireless/010101747cb617f2-593c5410-1648-4a42-97a0-f3646a5a6dd1-000000@us-west-2.amazonses.com/
> johannes
