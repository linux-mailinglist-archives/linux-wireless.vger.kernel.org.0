Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315261EC84
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 09:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKGIAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 03:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiKGIAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 03:00:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A510A13EA2
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 00:00:21 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v7so6358948wmn.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 00:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VU351BXvMWXjq2K/i0yKp41Rbk0oveSHyI5Ky9W+js=;
        b=MN0wf+iHEhP9uo6/TWbXRu2l2hTq+Hljh4m1YsgarQwlLg95IzNFl5EET8uAVfYVzq
         9VsXmEyGE1vXh9fpKQIKk3DGecy6hxsnGWs8luO0rKKgLOcFeRa+RCVx3riZVzrQctVy
         LpArVGb9jfPCICqjlqntAS5F0Ol32En6cpm/sEAZH1g3EDtQBPpAhVBAWEMFAtdQgsuK
         OZnHt/zcsOMFUeV1OQCmAaryD52ybjZTRutRAXyzjbt3pIadEWbDeZKAiEqQ/x4e4YIh
         KgoKUBieY7SOfgJCXRP+DL4rNje+Z6H9IzqFbm+1ucDIgo+oReVLMWdhxz8g/bvb58+X
         Yu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VU351BXvMWXjq2K/i0yKp41Rbk0oveSHyI5Ky9W+js=;
        b=VW6lId4PLr5WTG4wzRqzxHVfmWJO2stUooSFCi0uQ4U5e1D3ygHpmyf0EAl+sq5VyR
         zVr3TrtgVoGoDBhNkDu4HsRPY4nPs/w+6pZGBKrD9UrZJaE5vziQmZ1runDy/egPbNG7
         Xvo3pkwprJfembkM/8MPDrQDj2+a7eZYm5CsJwvxRzKHslOptldOJlBe+svWJpNSnfXA
         +wNrBX3XgZPPty2z9GmwVpXcWA1iNwxPTE3pxj/VqBGIFqYz1FtyD/VGfemNSGtmQBqf
         xEfLJET9hQcA2zkI3csr9p6o/Csa8EKtZ70nZrDo6BQI9W4PTwWuvwWkIZq1daR49oqu
         NSKg==
X-Gm-Message-State: ACrzQf2cG8FQONWn1Titxa6vDDIm4/IZrfnkLMWceWOp6xG34MTw5Bfz
        DB62mJwQqpXaADdsILEoDD1tewLuby4=
X-Google-Smtp-Source: AMsMyM5N9wxfPSmBomZPgyoXFFqQP1wCcgaoDis+wplwT7/rsf4xHskXNSqN0784GCxu4BIPRIPxcA==
X-Received: by 2002:a05:600c:4313:b0:3cf:894d:1d05 with SMTP id p19-20020a05600c431300b003cf894d1d05mr17047692wme.32.1667808020103;
        Mon, 07 Nov 2022 00:00:20 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c2ca800b003b4a699ce8esm11365925wmc.6.2022.11.07.00.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 00:00:19 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:00:17 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH] wifi: mac80211: convert PS buffering into iTXQ
Message-ID: <202211060817.mqDPz8T7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031211815.6666-1-alexander@wetzel-home.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexander,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Wetzel/wifi-mac80211-convert-PS-buffering-into-iTXQ/20221101-100832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20221031211815.6666-1-alexander%40wetzel-home.de
patch subject: [PATCH] wifi: mac80211: convert PS buffering into iTXQ
config: openrisc-randconfig-m041-20221106
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
net/mac80211/tx.c:1145 ieee80211_get_txq() warn: variable dereferenced before check 'vif' (see line 1112)

Old smatch warnings:
net/mac80211/tx.c:1689 invoke_tx_handlers_late() warn: variable dereferenced before check 'tx->skb' (see line 1664)
net/mac80211/tx.c:3365 ieee80211_xmit_fast_finish() error: we previously assumed 'key' could be null (see line 3333)

vim +/vif +1145 net/mac80211/tx.c

80a83cfc434b1e Michal Kazior    2016-05-19  1104  static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1105  					  struct ieee80211_vif *vif,
dbef5362111647 Michal Kazior    2017-01-13  1106  					  struct sta_info *sta,
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1107  					  struct sk_buff *skb)
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1108  {
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1109  	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1110  	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1111  	struct ieee80211_txq *txq = NULL;
df0e3c1e66212b Alexander Wetzel 2022-10-31 @1112  	bool is_ap_or_mesh = (vif->type == NL80211_IFTYPE_AP ||
                                                                              ^^^^^^^^^
New unchecked dereference.

df0e3c1e66212b Alexander Wetzel 2022-10-31  1113  			      ieee80211_vif_is_mesh(vif));
df0e3c1e66212b Alexander Wetzel 2022-10-31  1114  
df0e3c1e66212b Alexander Wetzel 2022-10-31  1115  	if (unlikely(is_ap_or_mesh &&
df0e3c1e66212b Alexander Wetzel 2022-10-31  1116  		     ieee80211_is_mgmt(hdr->frame_control) &&
df0e3c1e66212b Alexander Wetzel 2022-10-31  1117  		     !ieee80211_is_bufferable_mmpdu(hdr->frame_control)))
df0e3c1e66212b Alexander Wetzel 2022-10-31  1118  		info->flags |= IEEE80211_TX_CTL_NO_PS_BUFFER;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1119  
df0e3c1e66212b Alexander Wetzel 2022-10-31  1120  	if (unlikely((info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER) ||
df0e3c1e66212b Alexander Wetzel 2022-10-31  1121  		     info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE ||
df0e3c1e66212b Alexander Wetzel 2022-10-31  1122  		     ieee80211_has_order(hdr->frame_control) ||
df0e3c1e66212b Alexander Wetzel 2022-10-31  1123  		     ieee80211_is_probe_req(hdr->frame_control)))
80a83cfc434b1e Michal Kazior    2016-05-19  1124  		return NULL;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1125  
cc20ff2c6b5d3e Felix Fietkau    2020-09-08  1126  	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
50ff477a8639fa John Crispin     2019-11-25  1127  	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1128  		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
0eeb2b674f05cc Sara Sharon      2018-09-05  1129  		     ieee80211_is_bufferable_mmpdu(hdr->frame_control) ||
0eeb2b674f05cc Sara Sharon      2018-09-05  1130  		     vif->type == NL80211_IFTYPE_STATION) &&
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1131  		    sta && sta->uploaded) {
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1132  			/*
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1133  			 * This will be NULL if the driver didn't set the
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1134  			 * opt-in hardware flag.
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1135  			 */
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1136  			txq = sta->sta.txq[IEEE80211_NUM_TIDS];
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1137  		}
adf8ed01e4fdd2 Johannes Berg    2018-08-31  1138  	} else if (sta) {
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1139  		u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1140  
dbef5362111647 Michal Kazior    2017-01-13  1141  		if (!sta->uploaded)
dbef5362111647 Michal Kazior    2017-01-13  1142  			return NULL;
dbef5362111647 Michal Kazior    2017-01-13  1143  
dbef5362111647 Michal Kazior    2017-01-13  1144  		txq = sta->sta.txq[tid];
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27 @1145  	} else if (vif) {

Old code checked for NULL.

df0e3c1e66212b Alexander Wetzel 2022-10-31  1146  		if (is_ap_or_mesh &&
df0e3c1e66212b Alexander Wetzel 2022-10-31  1147  		    ieee80211_hw_check(&local->hw, QUEUE_CONTROL))
df0e3c1e66212b Alexander Wetzel 2022-10-31  1148  			info->hw_queue = vif->cab_queue;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1149  		txq = vif->txq;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1150  	}
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1151  
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1152  	if (!txq)
80a83cfc434b1e Michal Kazior    2016-05-19  1153  		return NULL;
ba8c3d6f16a1f9 Felix Fietkau    2015-03-27  1154  
80a83cfc434b1e Michal Kazior    2016-05-19  1155  	return to_txq_info(txq);
80a83cfc434b1e Michal Kazior    2016-05-19  1156  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
