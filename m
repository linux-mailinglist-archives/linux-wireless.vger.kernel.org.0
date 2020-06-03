Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86B1ECC2D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgFCJKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:10:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgFCJKU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:10:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05392WUE040228;
        Wed, 3 Jun 2020 09:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=8MaRnlAontAgmwzWRUwBKctZOthLlkW+6XAdEI7+xFA=;
 b=R+1PP5HLVWZ2VTYxzYvt+Fuf99XZRm2Fdf6nFlK0FvBP9KW5V4HFJh9u9+acET45vxuk
 wQxJifCbcdEb0nsljrcSIyd0SCuuBry4d5M56XIGtiEoaytuhD/azTc/FfjrzqnNJoFR
 b8mYs4qCrZjwendXGXOlOCSfcwfrqnozgA+btRK5f8itFJKJElnsAVuQnUoL2iB6hGZq
 00Ld/lxSZoce3HlEvzc00zBVIU2EczPcH5uW8t78hNXGYN7o8Q4qhbszisNbKtdxPww5
 /qz7D6MM27X7l1y9kv46b4MPQ72XnF7LXjonzcGMjIjSichmnZMfMwpb82GYuyLHUw1+ qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31bfem85hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 09:10:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05398bJe059708;
        Wed, 3 Jun 2020 09:10:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31c12qktcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 09:10:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0539AHh1031505;
        Wed, 3 Jun 2020 09:10:17 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 02:10:16 -0700
Date:   Wed, 3 Jun 2020 12:10:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     johannes.berg@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] mac80211: determine chandef from HE 6 GHz operation
Message-ID: <20200603091011.GA1763982@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030071
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Johannes Berg,

The patch 57fa5e85d53c: "mac80211: determine chandef from HE 6 GHz
operation" from May 28, 2020, leads to the following static checker
warning:

	net/mac80211/mlme.c:302 ieee80211_determine_chantype()
	error: uninitialized symbol 'ret'.

net/mac80211/mlme.c
   144  static u32
   145  ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
   146                               struct ieee80211_supported_band *sband,
   147                               struct ieee80211_channel *channel,
   148                               u32 vht_cap_info,
   149                               const struct ieee80211_ht_operation *ht_oper,
   150                               const struct ieee80211_vht_operation *vht_oper,
   151                               const struct ieee80211_he_operation *he_oper,
   152                               struct cfg80211_chan_def *chandef, bool tracking)
   153  {
   154          struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
   155          struct cfg80211_chan_def vht_chandef;
   156          struct ieee80211_sta_ht_cap sta_ht_cap;
   157          u32 ht_cfreq, ret;
   158  
   159          memset(chandef, 0, sizeof(struct cfg80211_chan_def));
   160          chandef->chan = channel;
   161          chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
   162          chandef->center_freq1 = channel->center_freq;
   163          chandef->freq1_offset = channel->freq_offset;
   164  
   165          if (channel->band == NL80211_BAND_6GHZ) {
   166                  if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef))
   167                          ret = IEEE80211_STA_DISABLE_HT |
   168                                IEEE80211_STA_DISABLE_VHT |
   169                                IEEE80211_STA_DISABLE_HE;

ret not initialized on else path.

   170                  vht_chandef = *chandef;
   171                  goto out;
                        ^^^^^^^^

   172          }
   173  
   174          memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
   175          ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);

[ snip ]

   279          ret = 0;
   280  
   281  out:
   282          /*
   283           * When tracking the current AP, don't do any further checks if the
   284           * new chandef is identical to the one we're currently using for the
   285           * connection. This keeps us from playing ping-pong with regulatory,
   286           * without it the following can happen (for example):
   287           *  - connect to an AP with 80 MHz, world regdom allows 80 MHz
   288           *  - AP advertises regdom US
   289           *  - CRDA loads regdom US with 80 MHz prohibited (old database)
   290           *  - the code below detects an unsupported channel, downgrades, and
   291           *    we disconnect from the AP in the caller
   292           *  - disconnect causes CRDA to reload world regdomain and the game
   293           *    starts anew.
   294           * (see https://bugzilla.kernel.org/show_bug.cgi?id=70881)
   295           *
   296           * It seems possible that there are still scenarios with CSA or real
   297           * bandwidth changes where a this could happen, but those cases are
   298           * less common and wouldn't completely prevent using the AP.
   299           */
   300          if (tracking &&
   301              cfg80211_chandef_identical(chandef, &sdata->vif.bss_conf.chandef))
   302                  return ret;
                        ^^^^^^^^^^

   303  
   304          /* don't print the message below for VHT mismatch if VHT is disabled */
   305          if (ret & IEEE80211_STA_DISABLE_VHT)
   306                  vht_chandef = *chandef;

regards,
dan carpenter
