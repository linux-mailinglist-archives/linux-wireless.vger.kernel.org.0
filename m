Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0763493B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 22:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbiKVV0p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 16:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiKVV0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 16:26:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BBBAFE65
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JJNvVTKTT/JhZLdK/PTxKn69J5i7SnKTEfCOxoKDQrU=;
        t=1669152401; x=1670362001; b=sU/LVTlcwqGbw2fPkhRz8wD8oVoeMdxnOeP8//1OG1dK6rh
        DID+AuV+i72aFM75ljL2OhraTdPjOPXAbdvk8vHQVJLvARCRKDF8e98CSNgt2PZdo1yKlwB73iQe7
        S8OE2rjnEbaun49/9Hnwj4QxAe7LS4/PuKfZIAMzpSVCxXKXlnT2+sjl3SOcXLuNmZQZBuPVU2158
        ACrwtRxY0r4LWjWVJPkBtlqyT53NpQG3Jllji4B1xMGh//98BQdCpK6ZBPwwAeffU/2QsavMwsxS8
        Fy4nFlPbGiTKRx4jpqUO8nhsEVV1tt8xi7bfuSqsNkq7Wjdk2l/V6KVhdLe2bqSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oxamo-006Trn-0O;
        Tue, 22 Nov 2022 22:26:34 +0100
Message-ID: <b5765f802e836641f41ff45f778d6901f4054050.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: Add 802.11h CSA support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <quic_wgong@quicinc.com>,
        Sujith <Sujith.Manoharan@atheros.com>, linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, Jouni.Malinen@Atheros.com,
        ath11k@lists.infradead.org
Date:   Tue, 22 Nov 2022 22:26:33 +0100
In-Reply-To: <04ad44c0-4012-50a4-f24a-64723a1c0a4f@quicinc.com>
References: <18786.55021.734826.472061@gargle.gargle.HOWL>
         <04ad44c0-4012-50a4-f24a-64723a1c0a4f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Wed, 2022-11-02 at 11:26 +0800, Wen Gong wrote:
> On 1/6/2009 11:58 AM, Sujith wrote:
> > Move to the advertised channel on reception of
> > a CSA element. This is needed for 802.11h compliance.
> >=20
> > Signed-off-by: Sujith <Sujith.Manoharan@atheros.com>
> > ---
> > v2
> > --
> > * Add a new variable to hold the CSA channel
> > * Use msecs_to_jiffies for calculating expiration time
> > * Add a check to drop beacons in case of a frequency mismatch
> >=20
> > v3
> > --
> > * Add a BSSID check when handling CSA action frame
> >=20
> >   net/mac80211/ieee80211_i.h |   11 ++++++-
> >   net/mac80211/iface.c       |    2 +
> >   net/mac80211/mlme.c        |   13 +++++++
> >   net/mac80211/rx.c          |   20 +++++++++++
> >   net/mac80211/spectmgmt.c   |   77 +++++++++++++++++++++++++++++++++++=
+++++++++
> >   5 files changed, 122 insertions(+), 1 deletions(-)
> >=20
> > ...
> > +void ieee80211_process_chanswitch(struct ieee80211_sub_if_data *sdata,
> > +				  struct ieee80211_channel_sw_ie *sw_elem,
> > +				  struct ieee80211_bss *bss)
> > +{
> > +	struct ieee80211_channel *new_ch;
> > +	struct ieee80211_if_sta *ifsta =3D &sdata->u.sta;
> > +	int new_freq =3D ieee80211_channel_to_frequency(sw_elem->new_ch_num);
> > +
> > +	/* FIXME: Handle ADHOC later */
> > +	if (sdata->vif.type !=3D NL80211_IFTYPE_STATION)
> > +		return;
> > +
> > +	if (ifsta->state !=3D IEEE80211_STA_MLME_ASSOCIATED)
> > +		return;
> > +
> > +	if (sdata->local->sw_scanning || sdata->local->hw_scanning)
> > +		return;
> > +
> May I know why channel switch should not go ahead while it is doing scan?

I don't remember, sorry.

johannes

