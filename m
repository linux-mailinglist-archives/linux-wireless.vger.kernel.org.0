Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E446D13C6
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 01:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjC3Xzc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 19:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjC3Xzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 19:55:31 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F302CA2E
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 16:55:25 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AF01D34005E;
        Thu, 30 Mar 2023 23:55:23 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1A40013C2B0;
        Thu, 30 Mar 2023 16:55:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1A40013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1680220523;
        bh=ywHUaUbuwgP4wrE9pYhMTZA+mviSzcybWECklGAgqnQ=;
        h=Date:To:From:Subject:From;
        b=d9K8v2WKAwJ7zsPtklGp4dhfL0j86GJ5Wvf7NKq/qk8+I4O4km4MbrKDWiOxvH6WL
         n/4BFuTx9kxlnwmodLgWCknqocufacX8iWkvJ4cOBb+FViG3YLmLV2Xh+b+4zbUzu6
         4VpNkEDy4BoZ3ksho6Ug5nGZ7cMRN1mzXexZjnO4=
Message-ID: <451c423b-4d0b-c2e6-7f39-0dc7da3e8080@candelatech.com>
Date:   Thu, 30 Mar 2023 16:55:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Subject: Question on why ieee80211_prep_channel clears the
 IEEE80211_CONN_DISABLE_160MHZ flag.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1680220524-0TGbN52qV2Tg
X-MDID-O: us5;ut7;1680220524;0TGbN52qV2Tg;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I'm trying to have supplicant tell the STA to not allow 160Mhz.

In the method below, in my setup, *conn_flags has IEEE80211_CONN_DISABLE_160MHZ
set when entering the method, but this method clears that and some related flags.
The clear logic dates back to 2012, effectively, but I guess in 5.19 kernel era somehow my hacks worked.

So question is, should it still be clearing the flags here?  I can add more
hack-around logic, but possibly those lines should just be removed for everyone?

static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
				  struct ieee80211_link_data *link,
				  struct cfg80211_bss *cbss,
				  ieee80211_conn_flags_t *conn_flags)
{
	struct ieee80211_local *local = sdata->local;
	const struct ieee80211_ht_cap *ht_cap = NULL;
	const struct ieee80211_ht_operation *ht_oper = NULL;
	const struct ieee80211_vht_operation *vht_oper = NULL;
	const struct ieee80211_he_operation *he_oper = NULL;
	const struct ieee80211_eht_operation *eht_oper = NULL;
	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
	struct ieee80211_supported_band *sband;
	struct cfg80211_chan_def chandef;
	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
	struct ieee80211_bss *bss = (void *)cbss->priv;
	struct ieee80211_elems_parse_params parse_params = {
		.bss = cbss,
		.link_id = -1,
		.from_ap = true,
	};
	struct ieee802_11_elems *elems;
	const struct cfg80211_bss_ies *ies;
	int ret;
	u32 i;

	pr_info("prep-channel-0, CONN_DISABLE_160MHZ: %d\n",
		!!(*conn_flags & IEEE80211_CONN_DISABLE_160MHZ));

	rcu_read_lock();

	ies = rcu_dereference(cbss->ies);
	parse_params.start = ies->data;
	parse_params.len = ies->len;
	elems = ieee802_11_parse_elems_full(&parse_params);
	if (!elems) {
		rcu_read_unlock();
		return -ENOMEM;
	}

	sband = local->hw.wiphy->bands[cbss->channel->band];

	*conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
			 IEEE80211_CONN_DISABLE_80P80MHZ |
			 IEEE80211_CONN_DISABLE_160MHZ);

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

