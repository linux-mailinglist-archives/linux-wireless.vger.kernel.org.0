Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D79ED1CD
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2019 06:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfKCFR1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Nov 2019 01:17:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35807 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfKCFR1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Nov 2019 01:17:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id n16so11457821oig.2
        for <linux-wireless@vger.kernel.org>; Sat, 02 Nov 2019 22:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CRUVqyTAw4fkZeTKmFIztChsoYaZvQ7hYqeavYZs9NA=;
        b=ieD4bkrK7EEKYypVcurTf2kC5/+Z+F7TuEsZ7O9jC3bFYDSPceupi2b+36loCJlv1b
         mE1T4Al3ODpjef+ElwEQEQwHsoQKPrKZHpzZRFnjtLpkLrj7FqmzSXmbH7r+HK1N0USc
         ZJBlPR1VkhG11XttnQCUJbq0XiWoKN6toAzMXQNcS0usSY9S6OMQzlVqvJPlkJkDSlhP
         YpESVxP4wor+kuMS29AAqG24XgcW1yGA5rhU29CHBZUr+XI5IeFOHXNffVcbOFcQRokI
         WcwL9WcnmMP9creruiyN+gvMKRUWc4spwxg0lbdgOuRUpNLcgypLXqGu/M/nL6Tyb4Ev
         iK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRUVqyTAw4fkZeTKmFIztChsoYaZvQ7hYqeavYZs9NA=;
        b=V5SORdTHYWN5Lk9croiG9F45sBPfI9FQGW/7Btu0B7keANMniHf2vkAnLHqWl7RV2U
         ObfFG+063mLvydO0HdgjkdpAaQ4lDPWuMt2TggRIMTTZX594Ea9nkgNFKFC24A+4PTbw
         sZeGYgyU09eCmAmwYttBoRvGOpQpSwPFv5hAO7IJTmzZS1eHaRf+O8IBc15sz+7sGOMn
         l1tAKxLzEUkq46SkPvuI4ZBFH7Dx17tKNiTmK9NgQAaMUccVWtJZNaZE+V2z4o0Fv9vf
         R8Rm6pC/82D6HdcGH/PAqQaQLlkdlVuf5Cu7ryE/dMAffMVs52G2IxsRyYPGti799WYn
         QrZg==
X-Gm-Message-State: APjAAAUDhTd7Q5tJ6bTL+fRFSxwQwzYKTELuTzox4ZLu9iScKNnNQVSl
        tzEIMWVn95hJIS0ZV3j6d0w=
X-Google-Smtp-Source: APXvYqzgNWg5O06JVT3vU4i9HOUYgwVXAXTla/li2adTtDb/gGfP7GcWjEDU7bWjvvS+xCX4+qragA==
X-Received: by 2002:aca:d1a:: with SMTP id 26mr1226830oin.136.1572758245541;
        Sat, 02 Nov 2019 22:17:25 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id a3sm650326oto.15.2019.11.02.22.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Nov 2019 22:17:24 -0700 (PDT)
Date:   Sat, 2 Nov 2019 22:17:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCHv7 5/6] nl80211: Add netlink attribute to configure TID
 specific tx rate
Message-ID: <20191103051722.GA55266@ubuntu-m2-xlarge-x86>
References: <1572674870-23517-1-git-send-email-tamizhr@codeaurora.org>
 <1572674870-23517-6-git-send-email-tamizhr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572674870-23517-6-git-send-email-tamizhr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tamizh,

On Sat, Nov 02, 2019 at 11:37:49AM +0530, Tamizh chelvam wrote:
> Introduce NL80211_TID_CONFIG_ATTR_TX_RATES in nl80211_tid_attr_config
> to accept data TID specific TX bitrate configuration
> through NL80211_CMD_SET_TID_CONFIG command. TID for which the
> this configuration is to be applied is passed in
> NL80211_TID_CONFIG_ATTR_TID attribute. TX bitrate mask values passed
> in NL80211_ATTR_TX_RATES attribute and NL80211_TID_CONFIG_ATTR_TX_RATES
> attribute will have types of the TX rate should be applied. This uses
> nl80211_parse_tx_bitrate_mask to validate and calculate the bitrate
> mask. When the user-space wants this configuration peer specific
> rather than being applied for all the connected stations,
> MAC address of the peer can be passed in NL80211_ATTR_MAC attribute.
> 
> Driver supporting this feature should advertise
> NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK and supporting per-STA data TID
> TX bitrate configuration should advertise
> NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK.
> 
> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>

Below is a report from the 0day team doing clang builds for us, please
take a look at it when you get a chance. Mixing enums like this usually
means the code is not using the enums properly; if it is intentional,
consider explicitly casting the enum to eliminate the warning.

Cheers,
Nathan

On Sun, Nov 03, 2019 at 11:14:10AM +0800, kbuild test robot wrote:
> CC: kbuild-all@lists.01.org
> In-Reply-To: <1572674870-23517-6-git-send-email-tamizhr@codeaurora.org>
> References: <1572674870-23517-6-git-send-email-tamizhr@codeaurora.org>
> TO: Tamizh chelvam <tamizhr@codeaurora.org>
> CC: johannes@sipsolutions.net
> CC: linux-wireless@vger.kernel.org, Tamizh chelvam <tamizhr@codeaurora.org>
> 
> Hi Tamizh,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mac80211-next/master]
> [also build test WARNING on v5.4-rc5 next-20191031]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Tamizh-chelvam/nl80211-New-netlink-command-for-TID-specific-configuration/20191103-092741
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
> config: arm64-defconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project 97725707f488d3f00f94d4c4f2d9e193c302b23c)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> net/wireless/nl80211.c:13912:11: warning: implicit conversion from enumeration type 'enum nl80211_tid_config_attr' to different enumeration type 'enum nl80211_attrs' [-Wenum-conversion]
>                            attr = NL80211_TID_CONFIG_ATTR_TX_RATES;
>                                 ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> vim +13912 net/wireless/nl80211.c
> 
>  13805	
>  13806	static int parse_tid_conf(struct cfg80211_registered_device *rdev,
>  13807				  struct nlattr *attrs[],
>  13808				  struct ieee80211_tid_cfg *tid_conf,
>  13809				  struct genl_info *info, const u8 *peer)
>  13810	{
>  13811		struct netlink_ext_ack *extack = info->extack;
>  13812		int err;
>  13813	
>  13814		tid_conf->tid = nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_TID]);
>  13815		if (attrs[NL80211_TID_CONFIG_ATTR_NOACK]) {
>  13816			err = nl80211_check_tid_config_support(rdev, extack, peer,
>  13817					attrs[NL80211_TID_CONFIG_ATTR_NOACK],
>  13818					NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG,
>  13819					NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG);
>  13820			if (err)
>  13821				return err;
>  13822	
>  13823			tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_NOACK;
>  13824			tid_conf->noack =
>  13825				nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_NOACK]);
>  13826		}
>  13827	
>  13828		if (nla_get_flag(attrs[NL80211_TID_CONFIG_ATTR_RETRY])) {
>  13829			err = nl80211_check_tid_config_support(rdev, extack, peer,
>  13830					attrs[NL80211_TID_CONFIG_ATTR_RETRY],
>  13831					NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG,
>  13832					NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG);
>  13833			if (err)
>  13834				return err;
>  13835	
>  13836			tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RETRY;
>  13837			if (attrs[NL80211_TID_CONFIG_ATTR_RETRY_SHORT]) {
>  13838				tid_conf->retry_short =
>  13839				nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RETRY_SHORT]);
>  13840				if (tid_conf->retry_short >
>  13841						rdev->wiphy.max_data_retry_count)
>  13842					return -EINVAL;
>  13843			} else {
>  13844				/* Use driver default retry count or VIF specific
>  13845				 * retry count
>  13846				 */
>  13847				tid_conf->retry_short = -1;
>  13848			}
>  13849	
>  13850			if (attrs[NL80211_TID_CONFIG_ATTR_RETRY_LONG]) {
>  13851				tid_conf->retry_long =
>  13852				nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RETRY_LONG]);
>  13853				if (tid_conf->retry_long >
>  13854						rdev->wiphy.max_data_retry_count)
>  13855					return -EINVAL;
>  13856			} else {
>  13857				/* Use driver default retry count or VIF specific
>  13858				 * retry count
>  13859				 */
>  13860				tid_conf->retry_long = -1;
>  13861			}
>  13862		}
>  13863	
>  13864		if (attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]) {
>  13865			err = nl80211_check_tid_config_support(rdev, extack, peer,
>  13866					attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL],
>  13867					NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
>  13868					NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL);
>  13869			if (err)
>  13870				return err;
>  13871	
>  13872			tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_AMPDU;
>  13873			tid_conf->ampdu =
>  13874				nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_AMPDU_CTRL]);
>  13875		}
>  13876	
>  13877		if (attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]) {
>  13878			err = nl80211_check_tid_config_support(rdev, extack, peer,
>  13879					attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL],
>  13880					NL80211_EXT_FEATURE_PER_TID_RTSCTS_CTRL,
>  13881					NL80211_EXT_FEATURE_PER_STA_RTSCTS_CTRL);
>  13882			if (err)
>  13883				return err;
>  13884	
>  13885			tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RTSCTS;
>  13886			tid_conf->rtscts =
>  13887				nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
>  13888		}
>  13889	
>  13890		if (attrs[NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE]) {
>  13891			int idx;
>  13892			enum nl80211_attrs attr;
>  13893	
>  13894			err = nl80211_check_tid_config_support(rdev, extack, peer,
>  13895					attrs[NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE],
>  13896					NL80211_EXT_FEATURE_PER_TID_TX_BITRATE_MASK,
>  13897					NL80211_EXT_FEATURE_PER_STA_TX_BITRATE_MASK);
>  13898			if (err)
>  13899				return err;
>  13900	
>  13901			idx = NL80211_TID_CONFIG_ATTR_TX_RATES_TYPE;
>  13902			tid_conf->txrate_type = nla_get_u8(attrs[idx]);
>  13903	
>  13904			tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_TX_BITRATE;
>  13905			if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
>  13906				tid_conf->mask =
>  13907					kzalloc(sizeof(struct cfg80211_bitrate_mask),
>  13908						GFP_KERNEL);
>  13909				if (!tid_conf->mask)
>  13910					return -ENOMEM;
>  13911	
>  13912				attr = NL80211_TID_CONFIG_ATTR_TX_RATES;
>  13913				err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
>  13914								    tid_conf->mask);
>  13915				if (err) {
>  13916					kfree(tid_conf->mask);
>  13917					return err;
>  13918				}
>  13919			} else {
>  13920				tid_conf->mask = NULL;
>  13921			}
>  13922		}
>  13923	
>  13924		return 0;
>  13925	}
>  13926	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
