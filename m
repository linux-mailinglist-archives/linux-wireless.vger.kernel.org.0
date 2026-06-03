Return-Path: <linux-wireless+bounces-37367-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cMegEk6OIGof5AAAu9opvQ
	(envelope-from <linux-wireless+bounces-37367-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 22:27:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D694263B1E1
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 22:27:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DlOeSIyI;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37367-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37367-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B803058A17
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C694014A0;
	Wed,  3 Jun 2026 20:27:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E2C383C84
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 20:27:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780518473; cv=none; b=gfGfNgBjSxKOsu0bCKj4VVkLHL1aYW4cRHRU+EU8wONEL/1ggBnmwc1EjMipd5577FlNgour9tP8uh7oAmVXV14kXfAgy83NMsJvPU+WaHN/MrqE/8vKO7uAsheab1xshfOW8na6INb9FMnZePpbgK//OkJu0Sn2fSqMKUT8+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780518473; c=relaxed/simple;
	bh=YwTGPsjBah6GvaY4EYLSGeDs8Fkv/GZQKN8WfKQMncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dptNIogoYwdlJl/coX1IA7Bn8MIb1gsXsVKeP4aRuMe7928iv4WR0o4ce3tQEM6FjNMNfoB5saeFb0pWdL01S0nB0vniWPFpfLV2JO9hvmCWOdRMDBfSVHZrwvU1TN0ZSeGmTsSKU0SNqzLOfqLVQn2rvfN845jpbj3VTwNCFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlOeSIyI; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780518473; x=1812054473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwTGPsjBah6GvaY4EYLSGeDs8Fkv/GZQKN8WfKQMncQ=;
  b=DlOeSIyI37/Jfk17BtzO2WHU1lQD+EdK/h3kZMtAESd5eBth/Kmi10iL
   +kZix/4gCCFa0hkUI4K+A1rKIeSN4e6tEI9Lpa4v2mM25NbtUMAeHrCMB
   58dJnymvv1xL26uFPM+ImC4toEFozozqf4+faeVa8Cjh6QDJE/mS0b2ew
   KC5QWhn5FP4TSAFtxfMLubT9SIF5ChY2Uf9S+Ox8E/uq/SNaOTRscCWuK
   P2B9ndI7eTFtUmi6/GYe3mE1KND5RmgyIH8ZCWBhd/7bFdFObMv7CrTS5
   UOnWV2eL67K85i46z+npEa5CC6IujMVDGfRiMTdcdwVxH1FI3lzplm78F
   A==;
X-CSE-ConnectionGUID: 2XnOxi8WTfSP9+ZZKUOBNQ==
X-CSE-MsgGUID: JowZjQV5QB6TUj3IUxi7hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="106789447"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="106789447"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 13:27:52 -0700
X-CSE-ConnectionGUID: 6vV8yUgjQ4iGVwtO1bkXVg==
X-CSE-MsgGUID: xi91RExKRIWPluvF9+SKDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249263061"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 03 Jun 2026 13:27:48 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUsBl-0000000029B-3dO4;
	Wed, 03 Jun 2026 20:27:45 +0000
Date: Wed, 3 Jun 2026 22:27:39 +0200
From: kernel test robot <lkp@intel.com>
To: JB Tsai <jb.tsai@mediatek.com>, nbd@nbd.name, lorenzo@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Deren.Wu@mediatek.com, Sean.Wang@mediatek.com,
	Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com,
	Leon.Yen@mediatek.com, litien.chang@mediatek.com,
	Charlie-cy.Wu@mediatek.com, jb.tsai@mediatek.com
Subject: Re: [PATCH] wifi: mt76: mt7925: add regulatory wiphy self manager
 support
Message-ID: <202606032205.iaSDVq2Z-lkp@intel.com>
References: <20260603075331.1234691-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603075331.1234691-1-jb.tsai@mediatek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-37367-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jb.tsai@mediatek.com,m:nbd@nbd.name,m:lorenzo@kernel.org,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:Charlie-cy.Wu@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D694263B1E1

Hi JB,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v7.1-rc6 next-20260602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JB-Tsai/wifi-mt76-mt7925-add-regulatory-wiphy-self-manager-support/20260603-155908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20260603075331.1234691-1-jb.tsai%40mediatek.com
patch subject: [PATCH] wifi: mt76: mt7925: add regulatory wiphy self manager support
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260603/202606032205.iaSDVq2Z-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606032205.iaSDVq2Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606032205.iaSDVq2Z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/mediatek/mt76/mt7925/regd.c:361:43: error: passing 'const struct ieee80211_regdomain *' to parameter of type 'struct ieee80211_regdomain *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     361 |                 return regulatory_set_wiphy_regd(wiphy, &mt7925_regd_ww);
         |                                                         ^~~~~~~~~~~~~~~
   include/net/cfg80211.h:8082:38: note: passing argument to parameter 'rd' here
    8082 |                               struct ieee80211_regdomain *rd);
         |                                                           ^
   1 error generated.


vim +361 drivers/net/wireless/mediatek/mt76/mt7925/regd.c

   286	
   287	int mt7925_regd_update(struct mt792x_phy *phy, char *alpha2)
   288	{
   289		struct wiphy *wiphy = phy->mt76->hw->wiphy;
   290		struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
   291		struct mt792x_dev *dev = mt792x_hw_dev(hw);
   292		struct mt7925_regd_rule *mt7925_rule;
   293		struct mt76_dev *mdev = &dev->mt76;
   294		struct ieee80211_regdomain *regd;
   295		struct ieee80211_reg_rule *rule;
   296		struct mt7925_regd_rule_ev *ev;
   297		int i, num_of_rules = 0;
   298		struct sk_buff *skb;
   299		int ret = 0;
   300	
   301		if (dev->hw_full_reset)
   302			return 0;
   303	
   304		if (!MT7925_REGD_SUPPORTED(phy))
   305			return -EOPNOTSUPP;
   306	
   307		mt792x_mutex_acquire(dev);
   308		skb = mt7925_regd_query_regdb(phy, alpha2);
   309		mt792x_mutex_release(dev);
   310	
   311		if (!skb)
   312			return -EINVAL;
   313	
   314		ev = (struct mt7925_regd_rule_ev *)(skb->data + 4);
   315		num_of_rules = le32_to_cpu(ev->n_reg_rules);
   316	
   317		if (!num_of_rules ||
   318			WARN_ON_ONCE(num_of_rules > NL80211_MAX_SUPP_REG_RULES)) {
   319			ret = -EINVAL;
   320			goto err;
   321		}
   322	
   323		regd = kzalloc(struct_size(regd, reg_rules, num_of_rules), GFP_KERNEL);
   324		if (!regd) {
   325			ret = -ENOMEM;
   326			goto err;
   327		}
   328	
   329		for (i = 0; i < num_of_rules; i++) {
   330			mt7925_rule = &ev->reg_rule[i];
   331			rule = &regd->reg_rules[i];
   332	
   333			rule->freq_range.start_freq_khz =
   334						MHZ_TO_KHZ(mt7925_rule->start_freq);
   335			rule->freq_range.end_freq_khz =
   336						MHZ_TO_KHZ(mt7925_rule->end_freq);
   337			rule->freq_range.max_bandwidth_khz =
   338						MHZ_TO_KHZ(mt7925_rule->max_bw);
   339			/* not used by fw */
   340			rule->power_rule.max_antenna_gain = DBI_TO_MBI(6);
   341			rule->power_rule.max_eirp = DBM_TO_MBM(22);
   342			rule->flags = mt7925_rule->flags;
   343		}
   344	
   345		regd->n_reg_rules = num_of_rules;
   346		regd->dfs_region = ev->dfs_region;
   347	
   348		memcpy(regd->alpha2, alpha2, 2);
   349		memcpy(mdev->alpha2, alpha2, 2);
   350	
   351		dev->regd_change = true;
   352		mt7925_mcu_regd_update(dev, alpha2, ENVIRON_ANY);
   353	
   354		ret = regulatory_set_wiphy_regd(wiphy, regd);
   355	
   356		kfree(regd);
   357	err:
   358		dev_kfree_skb(skb);
   359	
   360		if (ret < 0)
 > 361			return regulatory_set_wiphy_regd(wiphy, &mt7925_regd_ww);
   362	
   363		return ret;
   364	}
   365	EXPORT_SYMBOL_GPL(mt7925_regd_update);
   366	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

